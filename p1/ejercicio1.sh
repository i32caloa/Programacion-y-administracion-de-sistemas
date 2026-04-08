#!/bin/bash

# $# parametro que recoge el numero de argumentos que se pasa por comandos
# -ne NOT EQUAL (!=)
#funcion para ver si hay mas o menos de un argumento en linea de comandos

if [ $# -ne 1 ]; then
	echo "Error distinto numero de argumentos"
	exit 1
fi

#variable directorio con primer argumento

directorio=$1

#solo archivos regulares en la ruta del argumento guardado en salidaFind

salidaFind=$(find "$directorio" -type f)

#tuberia que pasa la lista generada por find y solo se queda con head -n 1

primerFichero=$(find "$directorio" -type f | head -n 1) #head -n 1 devuelve la primera linea del comando

#cat lee el contenidoo del fichero y guarda en n el numero de lineas con wc -l

n=$(cat "$primerFichero" | wc -l)

#for para cada dia de sesion teniendo en cuenta el tamaño de fichero n = wc -l 

for((i=1; $i<=$n; i=$i+1)); do
	suma=0 #suma de personas que fueron a cada sesion, se reinicia a 0 cada vez q empieza el bucle
	
	for fichero in $salidaFind; do #crea variable fichero que lee salidaFind y hace bucle
		
		dato=$(cat "$fichero" | head -n $i | tail -n 1) #varibale dato que lee el fichero y muestra las n primeras lineas y coge la ultima con tail
		
		let suma=$suma+$dato #suma el dato (1 o 0) para el control de la sesion
	done
	
	echo "Asistieron $suma personas a las sesion $i"
done

