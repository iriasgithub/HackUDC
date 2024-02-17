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
import pandas as pd

class Electricity_consume:
    def __init__(self):
        data = pd.read_csv("electrodatos.csv")
        self.df = data[data["Código universal de punto de suministro"] == 0]
    
    def hour_consumption_avg(self):
        avg_list = []
        for i in range(24):
            avg = self.df[self.df["Hora"] == i+1]["Consumo"].mean()
            avg_list.append(str(round(avg, 3)))
        return avg_list

    def monthly_consumption(self):
        return round(self.df[(self.df["Código universal de punto de suministro"] == 0) 
                & (self.df['datetime'] >= '2023-01-01') 
                & (self.df['datetime'] <= '2023-01-31')]["Consumo"].sum(), 3)

    def monthly_carbon_footprint(self):
        return round(self.monthly_consumption() * 0.177, 3)
