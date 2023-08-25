# -*- coding: utf-8 -*-
"""
Created on Wed Jul 26 13:59:12 2023

@author: Mariana

Scrip para ver los archivos del ftp y descargarlos manualmente
"""


# https://www.thepythoncode.com/article/download-and-upload-files-in-ftp-server-using-python
# tambien sierve para ver la NAVAREA, tempanos singulares de los 
# ultimos 15 dias  

###########################################################
#carpeta de trabajo
workdir='C:/Users/Usuario/Documents/mariana/codigos'
# carpeta de descarga
outdir=workdir
###########################################################

# Ingresamos manualmente el dia del archivo zip que queremos descargar 
dia_zip=20230818
# Ingresamos el dia de la NAVAREA que necesitamos 
dia_navarea=20230818
#Ingresamos el dia del ICEBERGCHART
dia_chart=20230818

###########################################################
import patoolib
from ftplib import FTP
import os

ftp = FTP('sihn.ddns.net') 
ftp.login('meteorologia', 'Meteorologia-2019') 
files = ftp.dir()
print (files)

### descargamos el .zip del dia que necesitamos o las imagenes del dia en jpg
zip=str(dia_zip)+'.zip'

with open(zip, "wb") as file:
    # use FTP's RETR command to download the file
    ftp.retrbinary(f"RETR {zip}", file.write)
patoolib.extract_archive(zip, outdir = outdir)

chart='ICEBERGCHART_'+str(dia_chart)+'.jpg'
with open(chart, "wb") as file:
    # use FTP's RETR command to download the file
    ftp.retrbinary(f"RETR {chart}", file.write)


#Descargamos el archivo de la NAVAREA de tempanos singulares que necesitamos 

NAVAREA=ftp.dir('NAVAREA')
print(NAVAREA)
ftp.cwd('NAVAREA')
navareaa='NAVAREAVI_'+str(dia_navarea)+'.txt'
print(navareaa)
lf = open(navareaa, "wb")
ftp.retrbinary("RETR " + navareaa, lf.write)

lf.close()


ftp.quit()

#os.rename(navareaa, 'tempanos_singulares.txt')



# import datetime
# fecha_dtime = datetime.datetime(2023,7,31)
# url_date = "{0}{1}{2}".format(str(fecha_dtime.year), str(fecha_dtime.month).zfill(2), str(fecha_dtime.day ).zfill(2))

# print(fecha_dtime)
# print(url_date)
# zip=str(url_date)+'.zip'




