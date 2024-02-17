'''Licensed to the Apache Software Foundation (ASF) under one
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
under the License. 
'''
from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from precio_electricidad import *
from consumo_electricidad import *


electricity = Electricity_price()
consume = Electricity_consume()

def basic_data():
    min_max = electricity.get_min_max_price()
    return {"prices": electricity.get_prices_list(),
            "max_price": min_max["max"],
            "min_price": min_max["min"],
            "avg_price": electricity.avg_price(),
            "consumption_list": consume.hour_consumption_avg(),
            "monthly_carbon_footprint": consume.monthly_carbon_footprint(),
            }



rutas = {
    "/basicdata": basic_data
}



class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Obtener la función asociada a la ruta
        funcion = rutas.get(self.path)
        if funcion:
            # Ejecutar la función y obtener el resultado
            resultado = funcion()

            # Enviar la respuesta al cliente
            self.send_response(200)
            self.send_header("Content-type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(resultado).encode())
        else:
            # Si la ruta no está mapeada, enviar un error 404
            self.send_error(404, "Ruta no encontrada")

# Configurar y ejecutar el servidor
puerto = 8080
direccion_servidor = ('10.20.36.108', puerto)

try:
    with HTTPServer(direccion_servidor, Handler) as servidor:
        print(f"Servidor en ejecución en el puerto {puerto}")
        servidor.serve_forever()
except KeyboardInterrupt:
    print("Servidor detenido manualmente")