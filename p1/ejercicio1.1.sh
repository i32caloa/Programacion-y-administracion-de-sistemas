#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Uso: $0 <directorio>"
	exit 1
fi

directorio=$1

if [ ! -d $directorio ]; then
	echo "Error, no existe el directorio"
	exit 1
fi

salidaFind=$(find "$directorio" -type f)
primerFichero=$(find "$directorio" -type f | head -n 1)

n=$(cat "$primerFichero" | wc -l)

for((i=1; $i<=$n; i=$i+1)); do
	
	suma=0;
	
	for fichero in $salidaFind; do
	
		dato=$(cat "$fichero" | head -n $i | tail -n 1)
		
		let suma=$suma+$dato
		
	done
	
	echo "Asistieron $suma a la sesion $i"
done
