
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
