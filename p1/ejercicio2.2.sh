#!/bin/bash

if [ $# -ne 4 ]; then
	echo "Uso: $0 <directorio origen> <directorio destino> <0 archi y comp, 1 archivar> <0 o 1 sobreescribir>"
	exit 1
fi

origen=$1
destino=$2
comprimir=$3
sobreescribir=$4

if [ ! -d "$origen" ]; then
	echo "Error: el directorio $directorio no existe"
	exit 1
fi

if [ ! -d "$destino" ]; then
	echo "Creando el directorio de destion $destino"
	
	mkdir -p $destino
fi

nombreBase=$(basename "$origen")
fecha=$(date +%Y%m%d)
nombre="${nombreBase}_${USER}_${fecha}"

if [ "$comprimir" -eq 0 ];then

	nombre="${nombre}.tar"
	
else

	nombre="${nombre}.tar.gz"

fi

rutaFinal="$destino/$nombre"

if [ -e "$rutaFinal" ]; then
	echo "Ya se ha realizado una copia en $rutaFinal"
	
	if [ "$sobreescribir" -eq 1 ]; then
		
		echo "Sobreescribir copia"
		
		if [ "$comprimir" -eq 0 ]; then
			
			tar -cf "$rutaFinal" "$origen"
			
		else
		
			tar -czf "$rutaFinal" "$origen"
			
		fi
		
		echo "Copia sobreescrita"
		
	fi

else 

	if [ "$comprimir" -eq 0 ]; then
		
		tar -cf "$rutaFinal" "$origen"
		
	else
	
		tar -czf "$rutaFinal" "$origen"
		
	fi
	
	echo "Copia realizada correctamente en $rutaFinal"

fi

