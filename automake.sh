#!/bin/bash

while true; do
    inotifywait -e close_write,moved_to,create .
     
    make
done