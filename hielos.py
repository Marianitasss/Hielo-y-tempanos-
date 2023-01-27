# -*- coding: utf-8 -*-
"""
Created on Fri Jan 27 16:03:30 2023

@author: Mariam
"""
import xarray as xr
hielos=xr.open_dataset('C:/Users/Mariam/Documents/HIELOS/NSIDC0081_SEAICE_PS_S25km_20220101_v2.0.nc')


hielos.values
hielos.data_vars
hielos.variables["F16_ICECON"]
hielos.variables["crs"]
hielos.coords
hielos["F16_ICECON"]
hielos.attrs
hielos.F16_ICECON
a=hielos['x'].to_index()
df = hielos.to_dataframe()
df = hielos.to_dataframe()