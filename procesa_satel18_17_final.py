# -*- coding: utf-8 -*-
"""
Created on Fri Mar  3 16:25:27 2023

@author: SHN
"""

############## ############## ############## ############## ############## 
############## PROCESAR DATOS DE SATELITE de concentración de hielo marino ############


# abre los archivos NC y descarga solo los datos de satelite. Usa el satelite F18,
# EXCEPTO cuando no hay datos de F18, y entonces busca el F17. En el caso que para
# un dia se tengan mas de 1000 datos faltantes del F18, ambién toma el F17. 
# Crea archivos diarios para ser utilizados por el programa del pronostico diario.
# Crea un archivo con la cantidad de valores nan (que pueden ser del F17 o el F18).


# los datos faltantes son nan
# la tierra son los datos -8888.00
# la costa son los datos -7777
# paraprocesar nuevamente, borrar los arvchivos creados por que no se reescriben
# cambiar el directorio y salida dependiendo la carpeta de trabajo. 


#####################################################################################

# carpeta con datos NC a abrir
directory = 'C:/Proyectos/Hielo_Marino/Datos/2022_b'

# capeta donde se guardan los procesados
salida = 'C:/Proyectos/Hielo_Marino/Datos/2022_b/prueba'


#####################################################################################
import numpy as np
import pandas as pd
import re
from pathlib import Path
import xarray as xr


def checkInt(hielos):
    try:
        hielos['F18_ICECON']
        print('tiene F18')
        sumanan = hielos['F18_ICECON'].isnull().sum()
        if sumanan<1000: 
            print('tiene menos de 1000 faltantes, usamos F18')
            return 1
        else:
            print ('tiene mas de 1000 faltantes, usamos F17')
            return 0
    except:
        print('no tiene F18, buscamos F17')
        return 0
        
        
def procesa_hielos18(hielos):
    satel18 = hielos[satelite]
    satel18a = satel18.to_dataframe()
    sumnan = satel18a.isnull().sum()
    satel18b = satel18a*100
    satel18c = satel18b.round(2)
    satel18d = satel18c.replace([101.60, 101.20], [-8888.0, -7777.0])
    return (satel18d, sumnan)

listasumnan = []
listadia = []    
# files in that directory
files = Path(directory).glob('*.nc')

for file in files:
    print(file)
    file2 = str(file)
    res = re.findall("S25km_(\d+)_v2.0.nc", file2)
    print(res) 
    hielos = xr.open_dataset(file)
    for ress in res:
        if checkInt(hielos)==1:
            satelite = 'F18_ICECON'
        else:
            satelite='F17_ICECON'    
        solosatel18 = procesa_hielos18(hielos)[0]
        listadia.append(ress)
        np.savetxt(salida+'/'+ress, solosatel18, fmt='%8.2f')
        sumnann = procesa_hielos18(hielos)[1].values
        print(sumnann)
        for v in sumnann:
            listasumnan.append(v)
             
d = {'dias': listadia, 'cantidad de valores NaN': listasumnan}
sumalistas = pd.DataFrame(d)
print(sumalistas)
sumalistas.to_csv(salida+'/'+'sumalistas3', sep='\t')



##############################################################################
# -6666 polehole, no aparecen aca
# -9999 missingdata, no aparecen aca######
# -7777 costline (253 en binario, 1.0120001 en decimal)
# -8888 land (254 en binario, 1.016 en decimal)
# conversion:
#	concentración(decimal)=concentración(binario)/250