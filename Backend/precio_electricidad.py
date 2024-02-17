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
            self._prices_list.append(float(day["PCB"].replace(",",".")))

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
        return {"min": {"range":str(min[0]) + " - " + str(min[0]+1), "price": str(min[1])},
                "max": {"range": str(max[0]) + " - " + str(max[0]+1), "price": str(max[1])}}
    
    def avg_price(self):
        return str(sum(self.__get_prices_list__()) / 24)


