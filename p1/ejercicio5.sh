#!/bin/bash

if [ $# -ne 1 ] || [ ! -d "$1" ]; then
	echo "USO: $0 [diretorio]"
	exit 1
fi

directorio=$1

salidaFind=$(find $directorio -type f)

for x in $salidaFind; do
	
	soloNombre=$(basename $x) #extrae el nombre del fichero (archivo.txt)
	soloRuta=$(dirname $x)  #ruta relativa
	rutaAbsoluta=$(realpath $x) #rutacompleta
	ultModif=$(stat -c %Y "$x") #fecha de modificacion en segundos
	tam=$(stat -c %s "$x") #tamaño en bytes
	permisos=$(stat -c %A "$x") #eprmisos del archivo
	
	echo -e "$soloNombre\t$rutaAbsoluta\t$ultModif\t$tam bytes\t$permisos"
    
# Ordena por la tercera columna (-k 3) de forma numérica (-n)
done | sort -k 3 -n #ordena segun fecha de modificcacion ya q es el tercer elemento de la cadena
