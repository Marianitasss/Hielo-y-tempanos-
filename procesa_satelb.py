# -*- coding: utf-8 -*-
"""
Created on Fri Mar  3 16:25:27 2023

@author: SHN
"""


############## PROCESAR DATOS DE SATELITE ##########################################

# abre los archivos NC y descarga solo los datos del satelite 18
# la tierra son los datos -8888.00
# la costa son los datos -7777  
# paraprocesar nuevamente, borrar los arvchivos creados por que no se reescriben 
#cambiar el directorio y salida dependiendo la carpeta de trabajo. Cambiar satelite

#carpeta con datos NC a abrir
directory = 'C:/Proyectos/Hielo_Marino/Datos/2022_b' 

#capeta donde se guardan los procesados
salida='C:/Proyectos/Hielo_Marino/Datos/2022_b'

satelite='F18_ICECON' 


#-6666 polehole, no aparecen aca
#-9999 missingdata, no aparecen aca
#-7777 costline (253 en binario, 1.0120001 en decimal)
#-8888 land (254 en binario, 1.016 en decimal)
#conversion:
#	concentración(decimal)=concentración(binario)/250

#####################################################################################

import xarray as xr
import numpy as np  
from pathlib import Path
import re
import pandas as pd

listasumnan=[]
listadia=[]
def procesa_hielos18(hielos):
    #for satell in hielos.variables.keys():
     #   if satell==satelite:
      #      continue
            satel18 =hielos[satelite]
            satel18a=satel18.to_dataframe()
            satel18b=satel18a*100
            satel18c=satel18b.round(2)
            satel18d=satel18c.replace([101.60,101.20],[-8888.0,-7777.0])
            sumnan=(satel18d==-8888.0).sum()+(satel18d==-7777.0).sum()
        #else:
       #         print('no hay datos')
                
                
         

    #listasumnan.append(sumnan)
    

            return (satel18d,sumnan) #extrae los datos concentracion y la cantidad de repericiones de un valor dado
    #sirve para ver la cantidad de datos nulos, cero, tierra)
     
# files in that directory
files = Path(directory).glob('*.nc')

for file in files:
    print(file)
    file2=str(file)
    res = re.findall("S25km_(\d+)_v2.0.nc", file2)
    print (res) 
    for ress in res:
        hielos=xr.open_dataset(file)
        solosatel18=procesa_hielos18(hielos)[0] 
        listadia.append(ress)
        np.savetxt(salida+'/'+ress,solosatel18,fmt='%8.2f')
        sumnann=procesa_hielos18(hielos)[1].values
        print(sumnann)
        for v in sumnann:
            listasumnan.append(v)
         
d={'dias':listadia, 'cantidad de valores NaN':listasumnan}
sumalistas=pd.DataFrame(d)
print(sumalistas)
sumalistas.to_csv(salida+'/'+'sumalistas3',sep='\t')

