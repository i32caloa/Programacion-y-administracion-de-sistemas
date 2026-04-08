#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
	echo "USO: $0 <longitud de la cadena> [tipo de cadena]"
	exit 1
fi

tam=$1
opcion=$2

#SAM AL BANQUILLO
#Si las opciones son las q necesitamos actua si no pasa y pide una cadena valida antes de cerrar

if [ $opcion == "alfa" ] || [ $opcion == "num" ] || [ $opcion == "alfanum" ]; then
	
	#Alfa
	
	if [ $opcion == "alfa" ]; then
		comando="tr -dc 'A-Za-z' < /dev/urandom"
		
	#Numerico
	
	elif [ $opcion == "num" ]; then
		comando="tr -dc '0-9' < /dev/urandom"
		
	#Alfanum
	
	elif [ $opcion == "alfanum" ]; then
		comando="tr -dc 'A-Za-z0-9' < /dev/urandom"
	fi
	
else

	read -p "Introduce un tipo de cadena válido (alfa, num, alfanum): " opcion
	
	if [ $opcion == "alfa" ]; then
		comando="tr -dc 'A-Za-z' < /dev/urandom" #Archivo especial que genera datos aleatotios
		break
		
	#Numerico
	
	elif [ $opcion == "num" ]; then
		comanfo="tr -dc '0-9' < /dev/urandom"
		break
		
	#Alfanum
	
	elif [ $opcion == "alfanum" ]; then
		comando="tr -dc 'A-Za-z0-9' < /dev/urandom"
		break
	fi
fi

#eval para q Bash interprete e¡bien las comillas y redirecciones de comando
#ejecuta el comando y le ponemos tam para el tamaño

eval "$comando | head -c $tam"
echo " "
