---
title: "Nuevas iniciativas de cifrado y certificación para la web: HTTP/2, Let's Encrypt y Convergence"
shorttitle: "Cifrado y certificación para la web"
author: Ingeniería de Servidores
date: Universidad de Granada
theme: Dresden
colortheme: dolphin
---

# HTTP/2

## Negociación de protocolo

* Extensión ALPN de TLS

* Realizada durante el *handshake*

* Alternativa para texto plano: campo *Upgrade*

## Cifrado oportunista

* Cifrado para `http://`

* Sin autenticación

* Servidor anuncia `h2` como 'servicio alternativo'

## Mejoras de velocidad

* *Streams* concurrentes

* *Server Push*

* Compresión HPACK

# Let's encrypt

## ACME

* 