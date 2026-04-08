#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "USO: $0 <fichero>"
	exit 1
fi

fichero=$1

if [ ! -f "$fichero" ]; then
	echo "$fichero no es un fichero"
	exit 1
fi

#E habilita las expresiones regulares y usaar |
# busca los años entre 1950 y 2000

echo "1. Año de publicacion entre 1950 y 2000"
cat $fichero | grep -E "Año: [19[5-9][0-9]|2000]" | sed 's/Año: //'
echo " "

#E habilita lsa expresiones regulares 
#o para solo poner la coincidencia y elimiar lo demas
#sed añade € al final de la cadena
##s comando de sustitucion
##$ coge el final de la cadena

echo "2. Precios que superan los 20€"
cat $fichero | grep -Eo "(2[1-9]|[3-9][0-9]),[0-9]{2}|20,(0[1-9][0-9])" | sed 's/$/€/'
echo ""

#E habilita las expresiones regulares
#o para obtener la parte q queremos y no toda la cadena
#sort ordena alfabeticamente
#uniq elimina lineas repetidas
#-c cuenta cuantas lineas se repiten

echo "3. Libros por genero"
cat $fichero | grep -Eo "\[[^]]+\]" | sort | uniq -c
echo " "

#E habilita las expresiones regulares y |
#o coge solo la parte de la cadena que qqueremos
#i da igual que sean mayuscula o minuscula
#\b para limitar la palabra
#{6} coge especificamente 6 caracteres de los dados anteriormente

echo "4. Palabras con 8 caracteres que empiecen por consonante y termine en vocal"
cat $1 | grep -Eoi "\b[b-df-hj-np-tv-zñ][a-zñáéíóú]{6}[aeiouáéíóú]\b"
echo""

#E habilita las expresiones regulares
#i da igual mayuscula o minuscula
# busca "Autor:"
#.*ll cualquier cadena de caracteres que tenga ll

echo "5. Autor con ll en su nombre o apellido"
cat $1 | grep -Ei "Autor: .*ll"
echo ""

#E habilita expersiones regulares
#[^ ]+ significa cualquier palabra sin espacios
#+([^ ]+ +){3} busca exactamente que tenga 3 palabras

echo "6. Titulos con mas de 3 palabras"
cat $1 | grep -E "Título: +([^ ]+ +){3}[^ ]+"
echo ""

#B 3 busca en precio que exista ,99€ y coge el elemento 3 lineas arriba (titulo)
#^Titulo aisla solo a titulo
# sed 's/Título: //' elimina a titulo y deja el nombre

echo "7. Precios acabados en .99€"
cat $1 | grep -B 3 "Precio: .*,99€" | grep "^Título:" | sed 's/Título: //'
echo ""

#E habilita las expresiones regulares 
#wc -l cuenta el numero de lineas que deja el grep

echo "8. Libros publicados antes de los 2000"
cat $1 | grep -E "Año: 1[0-9]{3}" | wc -l
echo ""

#E habilita las expresiones regulares
#[A-ZÁÉÍÓÚ][a-záéíóú]* busca una palabra de x distancia (lo volvemos a poner con espacio entre ellos para buscar la segunda palabra)

echo "9. Palabras encadenadas con 2 o mas mayusculas"
cat $1 | grep -Eo "\b[A-ZÁÉÍÓÚ][a-záéíóú]* [A-ZÁÉÍÓÚ][a-záéíóú]*\b"
echo""

#Ehabilita las expresiones regulares y |
#o coge solo lo q se le pide
#\[ corechete de apertura
#[^]]+ cualquier cosa que nosea un corchete
#sort ordena alfabeticamente
#uniq elimmina los duplicados

echo "10. generos con una palabra compuesta"
cat $1 | grep -Eo "\[Género: [^]]+-[^]]+\]" | sort | uniq
echo ""
