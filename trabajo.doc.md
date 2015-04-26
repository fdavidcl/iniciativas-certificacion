---
title: "Nuevas iniciativas de certificación para la web: HTTP/2, Let's Encrypt y Convergence"
author: Ingeniería de Servidores
date: Universidad de Granada
lang: spanish
abstract: "Blablablabla"
mainfont: Arial
monofont: Source Code Pro
fontsize: 10pt
geometry: "a4paper, top=2.5cm, bottom=2.5cm, left=3cm, right=3cm"

bibliography: references.bib
csl: ieee.csl
---

# Introducción

Desde hace unos años, Internet se ha convertido en el instrumento de comunicación más grande y que más rápida
difusión permite del mundo. El comportamiento de los usuarios en la web de la actualidad difiere enormemente de 
aquel de los inicios de la web. Hoy se pasa gran parte del tiempo de navegación en aplicaciones web, en lugar de 
simples sitios web estáticos, basta observar un ranking de sitios web reputado como el de Alexa [@alexa500] para
comprobarlo. Estas aplicaciones interactúan con el usuario, en el sentido de que intercambian datos 
con él más allá de la simple carga de una página web: el usuario puede enviar mensajes, subir archivos, jugar, y
realizar cualquier otro tipo de intercambio de información. Esto implica mayor flujo de datos durante la comunicación y mayor
necesidad de procesamiento en el servidor.

Además, la comunicación en Internet no supone únicamente navegación web, sino también prácticamente cualquier
servicio remoto que utilice una arquitectura cliente-servidor. Esto es, las aplicaciones móviles que permiten
el acceso a servicios sociales, de búsqueda, de mensajería, de mapas, etc. utilizan los mismos protocolos básicos
que un navegador web para transmitir y recibir los datos necesarios. 

## Seguridad en la red

El protocolo de aplicación más extendido para la comunicación en Internet, tanto para la web como para aplicaciones nativas, es
HTTP (*HyperText Transfer Protocol*). Se trata de un protocolo orientado a texto basado en el intercambio de
mensajes entre cliente y servidor con palabras clave que simbolizan métodos y estados [@tanenbaum]. Este protocolo
no incluye por defecto ninguna medida de seguridad en cuanto a confidencialidad y autenticación. Para ello, necesitamos
utilizar un protocolo de cifrado, TLS (*Transport Layer Security*), en la capa de aplicación, por debajo de HTTP.

TLS está definido en [@tlsrfc], y proporciona la posibilidad de autenticar la comunicación: por ejemplo, si entramos
a `https://github.com` se verifica que quien está respondiendo es efectivamente GitHub, como observamos en la Figura 
\ref{httpsgithub}. TLS también ofrece la capacidad de cifrar la transmisión,
de forma que ningún posible atacante pueda visualizar la información que se está enviando y recibiendo.

![La identidad de `https://github.com` está verificada\label{httpsgithub}](img/httpsgithub.png)

Para que TLS se pueda utilizar en una comunicación, es necesario que el servidor cuente con un certificado de tipo
X.509v3. Esta especificación define varios estándares [@x509rfc], entre ellos dicho formato de certificado.

## Problemas actuales

En general, la autenticación y cifrado mediante TLS se reserva a pocos sitios web, normalmente a las aplicaciones
web que requieren que el usuario inicie y mantenga una sesión (por lo que transmitirá datos como nombres de usuario,
email y contraseñas). Este hecho implica que los usuarios mantienen conexiones seguras con un número muy limitado
de sitios, y que en general podrán transmitir datos de cualquier tipo sin tener noción del nivel de seguridad que
están utilizando en cada momento.

Además, los certificados necesarios para realizar una conexión válida, que el navegador del usuario no detecte como 
fraudulenta, han de ser expedidos por agencias denominadas *Certificate Authorities* (CA). La propia especificación
de X.509 [@x509rfc] describe el algoritmo de verificación del camino de certificación: cuando un cliente encuentra
un certificado para el que no sabe si confiar, debe seguir el "camino" de certificados hasta uno que pertenezca a 
una CA que sí esté registrada como confiable. Este mecanismo puede restar dinamismo a la utilización de certificados,
ya que para contar con uno confiable hay que seguir la jerarquía establecida.

A continuación se estudian varios nuevos desarrollos que pretenden resolver algunos de estos problemas y se describe
su instalación y uso. El resto de este texto se organiza como sigue: en la sección \ref{http2} se introduce el protocolo
HTTP/2 y se detallan las funcionalidades que afectan a las comunicaciones seguras; en la sección \ref{letsencrypt} se
analiza la iniciativa Let's Encrypt y cómo puede colaborar a la difusión de la certificación web; finalmente en la sección
\ref{convergence} se explica la propuesta denominada Convergence para sustituir a la certificación tradicional.

# HTTP/2
\label{http2}

La versión actual de HTTP, a día de la redacción de este texto, es 1.1 [@h11rfc]. HTTP/2 es una nueva versión de este
protocolo que añade funcionalidad en lugar de reemplazarla. HTTP/2 está terminando su proceso de estandarización,
está aprobado por la IETF [@ietfh2] y cuenta con un borrador de RFC en espera de aceptación [@h2rfc]. Este protocolo
se basa en SPDY, una propuesta de los desarrolladores de Chromium [@spdychr], y continúa incluyendo la mayoría de
funcionalidades, habiendo añadido nuevas mejoras.

En el ámbito de la seguridad, lo interesante de HTTP/2 es que pretende fomentar el uso de TLS, tratando de compensar
la latencia provocada por el cifrado y el *handshake* mediante técnicas como la compresión, *Server Push* y similares.

## Negociación de protocolo

Para mantener compatibilidad con los clientes que aún no implementen HTTP/2, se incluye una negociación del protocolo
a utilizar previa a cualquier solicitud HTTP, es decir, esto se realiza durante el *handshake* TLS, mediante una 
extensión de dicho protocolo denominada ALPN [@alpnrfc] (*Application Layer Protocol Negotiation*), que permite que el 
cliente ofrezca una lista de protocolos soportados, codificados como `http/1.1`, `spdy/3.1`, `h2-14`, etc. y el 
servidor responda con su elección de protocolo.

Puesto que esta negociación se realiza como parte del *handshake* TLS, es razonable pensar que el uso principal de HTTP/2
debería ser sobre TLS, es decir, en HTTP/2 se prefieren las conexiones cifradas sobre las no cifradas. Asimismo, existe
en la especificación [@h2rfc] una opción para utilizar HTTP/2 en texto plano, sin usar TLS ni ALPN, mediante el valor `h2c`
en el campo *Upgrade* de las cabeceras HTTP de la solicitud. Sin embargo, los desarrolladores de los principales navegadores
web no implementarán esta variante de HTTP/2 [@mozillah2] [@chromiumh2], forzando a utilizar siempre la conexión segura.

## Técnicas para mejora de la velocidad

HTTP/2 incorpora varias estrategias para reducir la cantidad de datos enviados en cada transmisión, de forma que aunque
se utilice el cifrado, la comunicación sea más rápida que en HTTP/1.1. Uno de los puntos principales que se ha trabajado
en SPDY y HTTP/2 es el de los *streams* o flujos, que permiten varias comunicaciones concurrentes entre un cliente y un 
servidor. Estos flujos pueden ser abiertos y cerrados por cualquiera de los dos extremos de la comunicación.

Otra de estas técnicas es la compresión HPACK
para las cabeceras de HTTP, definida de forma separada en [@hpackrfc]. Este tipo de compresión corrige además una vulnerabilidad
provocada por el uso de TLS y la compresión DEFLATE, que permitía que un atacante robase información cifrada, por ejemplo
*cookies* de sesión [@crime].



## HTTP/2 en Apache

<!-- Mostrar un ejemplo con nghttp2 (tal vez un anexo?) -->

<!-- Algo sobre HTTPS obligatorio, HTTPS y el rendimiento o HTTPS y compensar la latencia -->

<!-- Indicaciones para probar un servidor apache+mod_h2 -->

# Let's Encrypt
\label{letsencrypt}

<!-- Parte de CA: Boulder -->

<!-- Parte de cliente de CA: lets-encrypt-preview -->

# Convergence
\label{convergence}

<!-- Análisis de la estructura dinámica de notarios -->

<!-- Comentario sobre extensión de navegador -->

# Bibliografía
