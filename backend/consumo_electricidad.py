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
