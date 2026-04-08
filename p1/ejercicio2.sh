#!/bin/bash

#Comprobar linea de argumentos

if [ $# -ne 4 ]; then
	echo "Error: Mas o menos de 4 argumentos"
	exit 1
fi

#asignamos cada argumento a cada variable

origen=$1
destino=$2
comprimir=$3
sobreescribir=$4

#Si origen no existe o no es un directorio (-d) no se puede trabajar asi q sale

if [ ! -d "$origen" ]; then
	echo "Error: no existe el fichero a copiar ($origen)"
	exit 1
fi

#Si no existe el destino lo crea

if [ ! -d "$destino" ]; then
	echo "Creando el directorio destino: $destino"
	# El parámetro -p de mkdir crea el directorio y todos los subdirectorios intermedios necesarios sin dar error si ya existían.
	mkdir -p "$destino"
fi

#para crear el nombre que se pide guardamos avriables y luego lo unimos

nombre_base=$(basename "$origen")
fecha=$(date +%Y%m%d)
nombre="${nombre_base}_${USER}_${fecha}"



if [ "$comprimir" -eq 0 ]; then
	nombre="${nombre}.tar" #empaquetar
	
	else
	
	nombre="${nombre}.tar.gz" #empaquetar y comprimir
	
fi

#guardamos la ruta relativa

ruta_final="$destino/$nombre"

# -e comprueba que exista el archivo

if [ -e "$ruta_final" ]; then
	echo "Ya se ha realizado una copia hoy en: $ruta_final"
	
	#si existe y sobreescribir = 1, sobreescribe
	
	if [ "$sobreescribir" -eq 1 ]; then
	
		echo "Sobreescibiendo copia"
	
		if [ "$comprimir" -eq 0 ]; then
		
			# -c(create) f(file) Crea el tar
			
			tar -cf "$ruta_final" "$origen"
			
		else 
		
			# -c(create) z(gzip compress) f(file) crea y comprime
			
			tar -czf "$ruta_final" "$origen"
		fi
	
		echo "Copia sobreescrita"
	
	else
		
		#Si no hay que sobreescribir sale
		
		echo "No se sobreescribio la copia"
		exit 0
		
	fi	
	
else 
	if [ "$comprimir" -eq 0 ]; then
		
		tar -cf "$ruta_final" "$origen"
		
	else
		
		tar -czf "$ruta_final" "$origen"
	
	fi
	
	echo "Copia realizada correctamente en $ruta_final"
	
fi
