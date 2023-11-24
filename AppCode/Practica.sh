1) Crear un proceso
a) Crear un proceso en jenkins (Manual), que ejecute el siguiente comando: 

'''
#!/bin/bash
echo $RANDOM > ${BUILD_NUMBER}.txt
'''

Y guarde el output en un path específico (${BUILD_NUMBER}.txt)

b) Llamar al archivo con el output del proceso anterior y mostrarlo

'''
#!/bin/bash
echo "File: ${BUILD_NUMBER} - Code: $(cat ${BUILD_NUMBER}.txt)"
'''

#Ejemplos

####### Concatenación de comandos
## printf "Code: "; cat 9.txt // Se ejecuta el primer comando y luego el segundo, sin importar el resultado de cada uno
## printf "Code: " && cat 9.txt // Se ejecuta el primer comando y sólo si funcionó correctamente se ejecuta el segundo
## printf "Code: " || cat 9.txt // Se ejecuta el primer comando y sólo si falló se ejecuta el segundo
#######

####### Echo con ejecución dentro del comando
## echo "Code: $(cat 9.txt)"
#######

####### Loop example
## for code in $(cat 9.txt)
##     do echo "Code: $code"
## done
#######

c) Crear un hash del valor que está dentro del archivo creado en el paso a

'''
# Ejemplo recomendado
#!/bin/bash
HASH_de_10=$(cat ${BUILD_NUMBER}.txt | md5sum | head -c 10)
HASH_de_20=$(cat ${BUILD_NUMBER}.txt | md5sum | head -c 20)
HASH_de_30=$(cat ${BUILD_NUMBER}.txt | md5sum | head -c 30)
printf "Hash de 10: $HASH_de_10\nHash de 20: $HASH_de_20\nHash de 30: $HASH_de_30" 
'''


'''
# Ejemplo de lo que no se tiene que hacer
#!/bin/bash
printf "Hash de 10: $(cat ${BUILD_NUMBER}.txt | md5sum | head -c 10)\nHash de 20: $(cat ${BUILD_NUMBER}.txt | md5sum | head -c 20)\nHash de 30: $(cat ${BUILD_NUMBER}.txt | md5sum | head -c 30)"
'''

'''
# Ejemplo hecho con un for loop
#!/bin/bash
for hash_number in $(seq 1 30);
    do HASH=$(cat 10.txt | md5sum | head -c $hash_number)
    printf "Hash de $hash_number: $HASH\n"
done
'''

#============================================================#
#============================================================#

2) Crear un proceso de CI/CD
a) Crear un pipeline con las siguientes etapas: Init, Build, Test, Push, Deploy

Init: Tiene que ejecutar un comando para loguearse a dockerhub
Build: Tiene que ejecutar en paralelo los comandos necesarios para compilar las imágenes
Test: Tiene que ejecutar en paralelo los comandos necesarios para probar las imágenes
Push: Tiene que ejecutar en paralelo los comandos necesarios para pushear las imágenes
Deploy: Se ejecuta un comando para iniciar un docker-compose