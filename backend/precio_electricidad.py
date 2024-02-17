
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
import requests
from datetime import datetime

class Electricity_price:
    def __init__(self):
        self._prices_list = []

    def __price_per_hours__(self): 
        date = datetime.now().strftime("%Y-%m-%d")

        request = requests.get("https://api.esios.ree.es/archives/70/download_json?date=" + date)
        request.raise_for_status()
        json_price_list = request.json()["PVPC"]

        for day in json_price_list:
            self._prices_list.append(round(float(day["PCB"].replace(",",".")) / 1000, 3))

    def __get_prices_list__(self) -> list:
        if self._prices_list ==  []:
            self.__price_per_hours__()
        return self._prices_list
    
    def get_prices_list(self) -> list:
        return list(map(str, self._prices_list))
    
    def get_min_max_price(self):
        prices = self.__get_prices_list__()
        min =  max = (0, prices[0])
        index = 0
        for hour in prices:
            if hour < min[1]:
                min = (index, hour)
            elif hour > max[1]:
                max = (index, hour)
            index += 1
        return {"min": {"range":str(min[0]) + ":00 - " + str(min[0]+1) + ":00" , "price": str(min[1])},
                "max": {"range": str(max[0]) + ":00 - " + str(max[0]+1) + ":00" , "price": str(max[1])}}
    
    def avg_price(self):
        return str(round(sum(self.__get_prices_list__()) / 24, 3))


