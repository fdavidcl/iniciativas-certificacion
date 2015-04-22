---
title: "Nuevas iniciativas de certificación para la web: HTTP/2, Let's Encrypt y Convergence"
author: Ingeniería de Servidores
date: Universidad de Granada
lang: spanish
abstract: "Blablablabla"
mainfont: Arial
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
a *https://github.com* se verifica que quien está respondiendo es efectivamente GitHub, como observamos en la Figura 
\ref{httpsgithub}. TLS también ofrece la capacidad de cifrar la transmisión,
de forma que ningún posible atacante pueda visualizar la información que se está enviando y recibiendo.

![La identidad de `https://github.com` está verificada\label{httpsgithub}](img/httpsgithub.png)

<!-- Explicar algo sobre certificados RSA -->

En general, la autenticación y cifrado mediante TLS se reserva a pocos sitios web, normalmente las aplicaciones
web que requieren que el usuario inicie y mantenga una sesión (por lo que transmitirá datos como nombres de usuario,
email y contraseñas). Además, los certificados necesarios para realizar una conexión válida, que el navegador del
usuario no detecte como fraudulenta, son expedidos por agencias denominadas *Certificate Authorities* (CA).

## Problemas actuales

# HTTP/2

## Negociación de protocolo

<!-- Algo sobre HTTPS obligatorio, HTTPS y el rendimiento o HTTPS y compensar la latencia -->

<!-- Indicaciones para probar un servidor nginx/(apache?) con HTTP/2 (o SPDY) -->

# Let's Encrypt

<!-- Parte de CA: Boulder -->

<!-- Parte de cliente de CA: lets-encrypt-preview -->

# Convergence

<!-- Análisis de la estructura dinámica de notarios -->

<!-- Comentario sobre extensión de navegador -->

# Bibliografía
