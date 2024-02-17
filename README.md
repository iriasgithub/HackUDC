
# VoltCare

**VoltCare** es una aplicación móvil para análisis de facturas eléctricas, cuyo propósito es la recomendación de buenas prácticas para el ahorro de energía, reducción del impacto medioambiental y gastos económicos asociados a ella.

## Características
Las principales funcionalidades que nos ofrece la aplicación son las siguientes:
 - Consulta del precio actual en € por Kwh de la energía eléctrica en el intervalo horario actual.
 - Información sobre el precio mínimo y máximo de la energía eléctrica en un día y en qué intervalos se sitúan estos valores.
 - Visualización del precio de la energía en intervalos de una hora durante todo el día actual.
 - Previsión del gasto total en € en el intervalo horario actual basado en datos anteriores.
 - Consejos diarios sobre cuándo escatimar más en el uso de la energía.
 - Cálculo de la huella de carbono de una determinada vivienda y comparación en base a la media española.
## Dependencias
**VoltCare** está disponible para su uso en sistemas operativos Android e IOS.
## Multimedia


https://github.com/iriasgithub/HackUDC/assets/114592933/6884314a-fe67-4f90-8c2a-427eeb021f25



## Tecnologías 
El desarollo Frontend de VoltCare está exclusivamente desarollado en lenguaje dart, haciendo uso de la librería Flutter. Por otro lado, la parte referida al Backend emplea fundamentalmente Python y la librería Pandas para el análisis de datos.
## Backend

Se trata de un conjunto de tres archivos .py y un archivo .csv empleado como datos base para la web.
- **consumo_electricidad.py** se encarga de extraer los datos del documneto csv y calcular métricas tales como la media de consumo para cada hora durante todo un mes, el consumo mensual total o la huella de carbono mensual.
- **precio_electricidad.py** utiliza el API api.esios.ree.es para la generación de queries para la obtención de precios por kwh en los distintos intervalos horarios.
- **server.py** implentación de un servidor HTTP en Python que usa ek API anteriormente citado y devuelve los datos necesarios para ser usados en Frontend.
- **electrodatos.csv** contiene los datos de consumo energético de distintas viviendas usados como ejemplo y que serán analizados por el sistema.
Se trata de una aproximación de Backend sencilla, pensada para ser implementada de forma concurrente en el futuro, incluyendo con posterioridad la funcionalidad de que el propio usario pueda introducir sus propios datos de facturas energéticas.
## Frontend
Constituída por un proyecto Flutter dividido fundamentalmente en dos archivos .dart (**main.dart** y **model.dart**).
Se hace uso del patrón arquitectónico Provider que permite observar cambios sobre el modelo y proyectarlos sobre la vista mediante la reconstrucción automática de los Widgets suscritos.
La razón de uso de esta aproximación es que es necesario escuchar el cambio de hora y día para actualizar la información de los precios de la energía eléctrica.
## Instalación
Para poner en marcha VoltCare será necesario inicar el servidor Python HTTP mediante la ejecución del siguiente comando desde la carpeta *HackUDC/backend*
```
python3 server.py
```
Luego se ejecutará la aplicación móvil de Flutter que empezará a enviar peticiones a nuestro servidor.
## Licencia
/*Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License. */

## Opciones de mejora
Ampliacón de funcionalidades tales como:
- El usuario tendrá la posibilidad de introducir un gasto deseado por mes y el sistema le proporcionará recomendaciones sobre cuándo usar determinados electrodomésticos, dependiendo del tiempo de duración de la tarea y de las horas más caras de energía eléctrica.
- Comparación con datos de viviendas geofráficamente cercanas.
- Índice de eficiencia energética personalizada para el usuario dependiendo de las etiquetas de sus electrodomésticos.
- Recomendaciones sobre el uso de energías renovables.
En cuanto al Backend, se pretende desarrollar uno más completo que permita al usuario introducir la información sobre sus facturas.
## Autoría
Usuarios de GitHub - Correos UDC
pablodiazcoira - pablo.coira@udc.es
santiago2699 - s.a.castro.rampersad@udc.es
iriasgithub - iria.pardo.neira@udc.es
