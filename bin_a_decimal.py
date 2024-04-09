# -- coding: utf-8 --
"""
Created on Tue Apr  2 20:14:34 2024

@author: Mariam
"""

###########CODIGO PARA PROCESAR LAS CONCETRACIONES MENSUALES DE HIELO MARINO########################
###################### DE FORMATO BIN A FORMATO TXT ################################################
# Usando este código vamos a poder pasar las concentraciones mensuales de hielo marino
# en formato binario a archivos .txt, como requiere el modelo de Sandra 

####################################################################################################

#Ruta del archivo de entrada. 
ruta = 'C:/Proyectos/Hielo_Marino/codigo/'

#El nombre del archivo cambia mes a mes, agregar la extensión .bin
filebin='nt_202402_f18_nrt_s.bin'

#Nombre del archivo procesado con extensin .txt
procesado = '202402.txt'

####################################################################################################

#librerias
import numpy as np

# Escalar numeros binarios para pasar a decimales 
scalef_conc = 1 / 250  # The data are 250 times larger than they are supposed to be. And they
                       # are meant to be expressed in % [0-100]. Thus scale them by 1000.
scaling = 100.0  # convert fractional 

# Cantidad de bytes 
nbytes_sic = 1    # The data is stored as 4-byte int
nbytes_header = 300  # The number of bytes allocated to header
read_mode = "little"  # not endian convention

# Cantidad de puntos en la grilla 
ny = 316
nx = 332

# Leer el archivo binario
with open(ruta + filebin, 'rb') as f:
    # Salta los primeros nbytes_header bytes del archivo
    f.seek(nbytes_header)
    # Lee los datos como un array unidimensional de enteros sin signo de 1 byte
    sic1d = np.fromfile(f, dtype=np.uint8, count=ny * nx)

# Aplica la escala, el factor de conversión y crea la matriz 'sic' (sea ice concentration)
sic = sic * scalef_conc * scaling

# Reemplazar valores específicos
sic[sic == 101.2] = -7777
sic[sic == 101.6] = -8888

# Guardar los valores en un archivo de texto
np.savetxt(procesado, sic, fmt='%8.2f')

















