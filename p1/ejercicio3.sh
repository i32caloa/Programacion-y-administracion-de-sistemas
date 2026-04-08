#!/bin/bash

#ver q solo haya 1 argumento

if [ $# -ne 1 ]; then
	echo "Error al ejecutar el programa"
	exit 1
fi

dir=$1

#comprobar q exista el directorio con -d si es fichero -f

if [ ! -d "$dir" ]; then
	echo "El directorio '$dir' no existe"
	exit 1
fi

#funcion for con variable temporal user_dir y busca el directorio en cada ruta que vaya a haber

for user_dir in "$dir"/*; do

#si existe user_dir el user (nueva variable) es la ultima linea del directorio gracias a basename

	if [ -d "$user_dir" ]; then
		user=$(basename "$user_dir")
		
		#Preparar carpetas de los archivos a revisar
		
		ssh_dir="$user_dir/.ssh"
		key_file="$ssh_dir/id_rsa"
		desktop_dir="$user_dir/Desktop"
		
		#si existe buscamos que la clave no este desprotegida
		
		if [ -f "$key_file" ]; then
		
			protegida=1
			
			#stat -c "%A" devuelve los permisos en formato de texto "drwx------"
			# grep -q -e busca si lo dado por stats.... es igual a "------$"
				#-q devuelve verdadero o falso
				#-e busca q la cadena sea igual a "------$"
				
			#comprobamos carpeta de usuario (/home/eva)
			
			if ! stat -c "%A" "$user_dir" | grep -q -e "------$"; then
				protegida=0
			fi
			
			#comprobamos el archivo de la clave (.ssh/id_sra)
			
			if ! stat -c "%A" "$key_file" | grep -q -e "------$"; then
				protegida=0
			fi
			
			#comprobamos la carpeta oculta (.ssh)
			
			if ! stat -c "%A" "$ssh_dir" | grep -q -e "------$"; then
				protegida=0
			fi
			
			#si no esta protegida manda mensaje y crea una carpeta Desktop para añadir el fichero de advertencia 
			
			if [ $protegida -eq 0 ]; then
				echo "El usuario "$user" tiene claves desprotegidas"
				
				mkdir -p "$desktop_dir"
				echo "ATENCIÓN: Clave ssh desprotegida" > "$desktop_dir/ADVERTENCIA_SEGURIDAD.txt"
				
			else 
			
				echo "Claves protegidas"
			
			fi
		fi
	fi
done
