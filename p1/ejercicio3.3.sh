#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Error al ejecutar"
	exit 1
fi

dirHome=$1 #metemos la direccion del home

if [ ! -d "$dirHome" ]; then
	echo "El directorio '$dirHome' no existe"
	exit 1
fi

#obligamos a ver solamente las carpetas de los usuarios y guardamos la lista en salidaFind

salidaFind=$(find "$dirHome" -maxdepth 1 -mindepth 1)

#for sobre la lista salidaFind con variable home

for home in $salidaFind; do

	if [ -f "$home/.ssh/id_rsa" ]; then
		
		permisos_fich=$(stat -c %a "$home/.ssh/id_rsa")
		permisos_dir=$(stat -c %a "$home/.ssh")
		
		#miramos en octal si los permisos estan bien, si no error
		
		if [ "$permisos_dir" -ne 700 ] || [ "$permisos_fich" -ne 600 ]; then
		
			usuario=$(basename "$home")
			
			echo "El usuario $usuario tiene una clave privada de ssh no protegida"
			
			mkdir -p "$home/Desktop"
			
			#!!  < leer |||| > escribir
			
			echo "Clave privada ssh expuesta" > "$home/Desktop/ADVERTENCIA.txt"
			
		fi
	fi
done
