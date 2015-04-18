---
title: "Nuevas tendencias en certificación para la web: HTTP/2, Let's Encrypt y Convergence"
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
con él más allá de la simple carga de una página web: el usuario podrá enviar mensajes, subir archivos, jugar, y
realizar cualquier otro tipo de interacción. Esto implica mayor flujo de datos durante la comunicación y mayor
necesidad de procesamiento en el servidor.

Además, la comunicación en Internet no supone únicamente navegación web, sino también prácticamente cualquier
servicio remoto que utilice una arquitectura cliente-servidor. Esto es, las aplicaciones móviles que permiten
el acceso a servicios sociales, de búsqueda, de mensajería, de mapas, etc. utilizan los mismos protocolos básicos
que un navegador web para transmitir los datos necesarios. 

## Seguridad en la red

El protocolo de aplicación más extendido para la comunicación en Internet, tanto para la web como para aplicaciones nativas, es
HTTP (*HyperText Transfer Protocol*). Se trata de un protocolo orientado a texto basado en el intercambio de
mensajes entre cliente y servidor con palabras clave que simbolizan métodos y estados [@tanenbaum]. Este protocolo
no incluye por defecto ninguna medida de seguridad en cuanto a confidencialidad y autenticación. Para ello, necesitamos
utilizar un protocolo de cifrado, TLS (*Transport Layer Security*), en la capa de aplicación, por debajo de HTTP.

# HTTP/2

# Let's Encrypt

# Convergence

# Bibliografía
