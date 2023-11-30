####################
## Examen teórico ##
####################

## Consideraciones ##

A) Se debe crear un archivo llamado "Respuestas.txt" con las respuestas del examen teórico

#########################################################################################################################################

1) El proceso de CI/CD se separa en dos grandes partes (Continuous Integration & Continuous Deployment):

A) Explique a qué corresponde cada parte
B) Hay un estadío que se encuentra dentro del CI, que también puede ser abreviado como CD, cuál es y qué acciones se realizan en él?

2) Cuáles son algunas de las mejores prácticas a la hora de crear un proceso de CI/CD? En qué etapas lo dividiría y qué consideraciones tendría en cuenta para la ejecución del proceso?

#####################
## Examen práctico ##
#####################

## Consideraciones ##

A) Se debe crear una carpeta en jenkins con el nombre del alumno y dentro de la carpeta deben estar las resoluciones de los ejercicios
B) La branch a utilizar en gitlab tiene que tener el nombre del alumno
C) Para todos los comandos de docker se debe usar sudo adelante # Ejemplo: sudo docker ps -a

#########################################################################################################################################

Ejercicio 1: Ejecutar un proceso en jenkins

Crear un proceso en jenkins llamado "Ejercicio1", el mismo debe ejecutar el siguiente comando

'''
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 50K
'''

Y el output debe ser guardado en el archivo "Ejercicio_1_A.txt"

b) Llamar al archivo guardado en el proceso anterior y contar cuántos caracteres tiene el contenido, guardar el valor en una variable e imprimir esa variable en pantalla

## Tip: Para contar los caracteres se debe usar "| wc -c" al final de la ejecución

## Ejemplo en pseudocódigo:
## variable = ejecución de comando con | wc -c
## imprimo el valor de variable

#============================================================#

Ejercicio 1: Crear un pipeline de CI/CD por código

1) (LOCAL) Clonar el repositorio de gitlab (https://gitlab.com/Istea_devops/jenkins_practica), y crear una branch nueva partiendo de main, con el nombre del alumno

2) (Jenkins) Tomando como ejemplo las configuraciones del proyecto "Gitlab" (https://jenkins.devys.net/job/Gitlab/configure) en la raíz de jenkins, crear un proyecto llamado "Ejercicio2" del tipo "Multibranch pipeline" con la misma configuración, dentro de la carpeta creada para las resoluciones.
## Completar el "Filter by name" con el nombre de la branch que va a tener en Gitlab

3) (LOCAL) Modificar el archivo Jenkinsfile dentro de la carpeta AppCode con las siguientes configuraciones del pipeline: 

Agent: any
Parametros:
- Parámetro del tipo string llamado "imageName" en el que el valor por defecto sea el nombre del alumno (Sin espacios y sin caracteres especiales) # Ejemplo: NicolasDiaz
- Parámetro del tipo string llamado "repoAccount" en el que el valor por defecto sea "nrdiaz92"
- Parámetro del tipo string llamado "repoName" en el que el valor por defecto sea "istea-jenkins"

Stages:
- Init: Tiene que ejecutar un comando para loguearse a dockerhub utilizando variables (Ya completado)
- Build: Tiene que ejecutar en paralelo los comandos necesarios para compilar las imágenes, creando un tag que sea (Variable: RepoAccount)/(Variable: RepoName):(Nombre de la app que se compila)-(Variable: imageName)
- Push: Tiene que ejecutar en paralelo los comandos necesarios para pushear las imágenes buildeadas en el stage anterior
- Deploy: Se tiene que ejecutar de forma permanente un contenedor con el nombre "NombreDelAlumno-api", utilizando la imagen de la aplicación api compilada en el paso anterior

4) (LOCAL) Subir los cambios a Gitlab

5) (Jenkins) Realizar un "Scan Repository Now" para que refresque las branch, realizar la ejecución y revisar que sea exitosa