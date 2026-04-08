#!/bin/bash

if [ $# -ne 1 ]; then
	echo "USO: $0 <fichero>"
	exit 1
fi

fichero=$1

#E Habilita las expresiones logicas
#q modo silencioso que no imprime nada por pantalla 
#\.txt$ busca exclusivamente .txt en el nombre del fichero

echo "$fichero" | grep -Eq "\.txt$"

#si la fucnion anterior funciona $? = 0

if [ $? -ne 0 ]; then
	echo "Se necesita un fichero .txt"
	exit 1
fi

if [ ! -f "$fichero" ]; then
	echo "Error $fichero no es un fichero"
	exit 1
fi

#sed transforma el texto 
# -r habilita expresiones regulares en sed
#\ nos permite hacer una funcion en varias lineas

sed -r \
	-e '/^$/d' \
	-e 's/_//g' \
	-e 's/^Autor:/-> Autor:/' \
	-e 's/^Año:/-> Año:/' \
	-e 's/^Precio:/-> Precio:/' \
	-e 's/^\[(Género:.*)\]$/-> \1/' \
	"$fichero"
	
#1. elimina lineas vacias ^$ (inicio y final juntos = vacia) y d borra
#2. s para sustituir (_) por espacio (//)
#3. Bsca Autor: y susituye por -> Autor: y lo que siga (/)
#ultima. \[ (escapa corchete, (Género:.*) guarda todo y los sustituimos por el primer elemento almacenado
