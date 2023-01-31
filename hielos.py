# -*- coding: utf-8 -*-
"""
Created on Fri Jan 27 16:03:30 2023

@author: Mariam
"""
import pandas as pd
import xarray as xr
hielos=xr.open_dataset('C:/Users/Mariam/Documents/HIELOS/NSIDC0081_SEAICE_PS_S25km_20230101_v2.0.nc')


hielos.values
hielos.data_vars
hielos.variables.keys()
hielos.variables.values()
hielos.variables["F16_ICECON"]
hielos.variables["crs"]
hielos.coords
hielos["F16_ICECON"]
hielos.attrs
hielos.F16_ICECON
a=hielos['x'].to_index()
satel_todos = hielos.to_dataframe()
satelite16 =satel_todos["F16_ICECON"]
satel_todos.to_csv('satelites.csv',sep='\t')