# imports
import os
import datetime
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
import matplotlib.patches as mpatches
from mpl_toolkits.basemap import Basemap
import matplotlib.cm as cm
import geopandas as gpd
from shapely.geometry import Point
#%% Carpeta de trabajo
workdir = os.path.join('D:/', 'Programacion', 'python','tempanos', 'NRC_Python_Iceberg_Drift_Model-IIL_size', 'shapefile_py')
os.chdir(workdir)
path_to_bergout = os.path.join('../', 'tests', '1-berg-no-ensemble', 'Berg.out')
#%% Manejo archivos con pandas
bergout = pd.read_csv(path_to_bergout, header=None, sep = r'\s{1,}', engine='python')
ref = np.load('referencias.npy', allow_pickle=True) #archivo referencias.npy traido de la ejecucion de shapefile.py
iceberg_names = [str('A'+str(i)) for i in range(0,len(ref))]  # 3220 nro de centroides = len(ref)
#%%###################################Solo para pruebas########################################
# test_folder = '20220621' #se va cambiando segun la prueba
# backup_dir = os.path.join('D:/', 'Programacion', 'python', 'tempanos', 'pruebas', test_folder)
# os.chdir(backup_dir)
# bergout = pd.read_csv('Berg.out', header=None, sep= r'\s{1,}', engine='python')
# ref = np.load('referencias.npy', allow_pickle=True)
# iceberg_names = [str('A'+str(i)) for i in range(0,len(ref))]  # 3220 nro de centroides = len(ref)
################################################################################################
#%% Separamos de bergout los datos de tempanos singulares
bergout_singu = bergout[bergout.iloc[:,1].str.startswith('IIL')].reset_index(drop=True)
bergout = bergout[~bergout.iloc[:,1].str.startswith('IIL')].reset_index(drop=True)
#%% Anexamos la data de cantidad de icebergs al Berg.out con el archivo 'referencias.npy'
bergout['berg_ref'] = 1 # inicializo la columna con las ref de cant de icebergs
dic_ref = {k:v for k,v in zip(iceberg_names,ref)}
for i in range(len(bergout)):
    bergout['berg_ref'][i] = dic_ref[str(bergout.iloc[i,1])]

bergout_singu.columns = ['Id', 'Name', 'Branch', 'Start_Date', 'Latitude', 'Longitude', 'Size', 'Shape', 'Mobility', 'Length', 'a', 'b', 'c', 'd', 'e', 'f', 'g']
#%% Referencias para los colores
def referenciar(data, refs, colors):
    '''
    Esta funcion sirve para colorizar las
    referencias de icebergs para posteriormente
    tener una columna con los colores para plotear
    Parametros:
    - data: (Df)Dataframe al cual vamos a agregarle una
    columna con referencias de colores ('r', 'g' o 'y')
    - refs: (str)columna de data que tiene las referencias del
    shape de la carta de tempanos. Solo puede ser 'FEW'
    'ISOLATED' o 'MANY'
    - colors: (str)nombre que desearias que tuviese la columna
    de data que va a tener las referencias de colores.
    '''
    data[colors] = 1
    for j in range(len(data)):
        if data[refs][j] == 'ISOLATED':
            data[colors][j] = 'g'
        elif data[refs][j] == 'FEW':
            data[colors][j] = 'y'
        elif data[refs][j] == 'MANY':
            data[colors][j] = 'r'
        else:
            pass
referenciar(bergout, 'berg_ref', 'color_ref')
#%% Nos quedamos con los puntos que si figuran en el Berg.out (que fueron modelados)
outs = {}
for name in iceberg_names:
    if name in bergout[1].values:
        outs[name] = bergout[bergout[1] == name]

# Lectura de archivo shape para utilizar la grilla de la carta

# EN CASO DE PRUEBAS:
fecha_dtime= datetime.datetime(2023,8,18)# dia de hoy


#fecha_dtime = datetime.datetime.today()
# if fecha_dtime.weekday() in [0,1,2,3]: # fecha puesta en lunes o viernes, cuando tenemos carta.
#     fecha_dtime = fecha_dtime - datetime.timedelta(days=fecha_dtime.weekday())
# else:
#     fecha_dtime = fecha_dtime - datetime.timedelta(days=fecha_dtime.weekday() - 4)
url_date = "{0}{1}{2}".format(str(fecha_dtime.year), str(fecha_dtime.month).zfill(2), str(fecha_dtime.day ).zfill(2))

def new_grid_and_centroids():
    # Lectura archivo shape de carta
    file_iceshape = str("ICEBERGRISK_"+url_date+".shp")
    data_shape = gpd.read_file(file_iceshape)
    carta_temp = data_shape.geometry.copy()
    geo_grilla = gpd.GeoDataFrame(carta_temp.to_crs(4326))

    # Arreglo de la grilla
    geo_grilla['colores'] = 1
    for j in range(len(geo_grilla)):
        if geo_grilla['geometry'][j] is None:
            geo_grilla['colores'][j] = 'w'
        else:
            pass

    # Obtengo los centroides para más tarde
    geo_centroid = geo_grilla.to_crs(epsg=3031)
    geo_centroid['centroides'] = geo_centroid.centroid
    centroids = geo_centroid['centroides'].to_crs(epsg=4326)
    gpd_centroids = gpd.GeoDataFrame(centroids, geometry='centroides')

    return geo_grilla, gpd_centroids

def read_icelimit():
    file_icelimit = str("ICELIMIT_"+url_date+".shp")
    data_shape = gpd.read_file(file_icelimit)
    carta_limit = data_shape.geometry.copy()
    geo_limit = gpd.GeoDataFrame(carta_limit.to_crs(4326))

    limit_coords = list(geo_limit.geometry.exterior.iloc[0].coords)
    limit_lats = [lat_coord[1] for lat_coord in limit_coords]
    limit_lons = [lon_coord[0] for lon_coord in limit_coords]
    return limit_lons, limit_lats
#%% Graficado post 24hs
# Un poco de Data Wrangling
col_names = ['Id', 'Name', 'Branch', 'Start_Date', 'Latitude', 'Longitude', 'Size', 'Shape', 'Mobility', 'Length', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'Ref', 'Col']

ronda_0 = pd.DataFrame([outs.get(i_names).iloc[0,:] for i_names in outs.keys()])
new_names = {u:v for u,v in zip(ronda_0.columns.values.tolist(), col_names)}
ronda_0 = ronda_0.rename(columns = new_names, inplace = False)
geo_0 = gpd.GeoDataFrame(ronda_0, geometry=gpd.points_from_xy(ronda_0.Longitude, ronda_0.Latitude))
df_0 = geo_0.reset_index(drop=True, inplace=False)
referenciar(df_0, 'Ref', 'Col')

ronda_24 = pd.DataFrame([outs.get(i_names).iloc[25,:] for i_names in outs.keys()])
new_names = {u:v for u,v in zip(ronda_24.columns.values.tolist(), col_names)}
ronda_24 = ronda_24.rename(columns = new_names, inplace = False)
geo_24 = gpd.GeoDataFrame(ronda_24, geometry=gpd.points_from_xy(ronda_24.Longitude, ronda_24.Latitude))
df_24 = geo_24.reset_index(drop=True, inplace=False)
referenciar(df_24, 'Ref', 'Col')

ronda_48 = pd.DataFrame([outs.get(i_names).iloc[49,:] for i_names in outs.keys()])
new_names = {u:v for u,v in zip(ronda_48.columns.values.tolist(), col_names)}
ronda_48 = ronda_48.rename(columns = new_names, inplace = False)
geo_48 = gpd.GeoDataFrame(ronda_48, geometry=gpd.points_from_xy(ronda_48.Longitude, ronda_48.Latitude))
df_48 = geo_48.reset_index(drop=True, inplace=False)
referenciar(df_48, 'Ref', 'Col')

ronda_72 = pd.DataFrame([outs.get(i_names).iloc[73,:] for i_names in outs.keys()])
new_names = {u:v for u,v in zip(ronda_72.columns.values.tolist(), col_names)}
ronda_72 = ronda_72.rename(columns = new_names, inplace = False)
geo_72 = gpd.GeoDataFrame(ronda_72, geometry=gpd.points_from_xy(ronda_72.Longitude, ronda_72.Latitude))
df_72 = geo_72.reset_index(drop=True, inplace=False)
referenciar(df_72, 'Ref', 'Col')

ronda_96 = pd.DataFrame([outs.get(i_names).iloc[96,:] for i_names in outs.keys()])
new_names = {u:v for u,v in zip(ronda_96.columns.values.tolist(), col_names)}
ronda_96 = ronda_96.rename(columns = new_names, inplace = False)
geo_96 = gpd.GeoDataFrame(ronda_96, geometry=gpd.points_from_xy(ronda_96.Longitude, ronda_96.Latitude))
df_96 = geo_96.reset_index(drop=True, inplace=False)
referenciar(df_96, 'Ref', 'Col')
#%%
# Defino clase Tempano
class Tempano(object):
    def __init__(self, name, latitude, longitude, reference, color):
        self.name = name
        self.latitude= latitude
        self.longitude = longitude
        self.reference = reference
        self.color = color

    def posicion(self):
        return Point(self.longitude, self.latitude)

    def cercanos(self, other):
        if abs(self.latitude - other.latitude) < 0.1 and abs(self.longitude - other.longitude) < 0.1:
            return True
        else:
            return False

    def __repr__(self):
        return f'Tempano({self.name})'

def redef_color(grid_color, temp_color):
    '''
    Funcion para establecer colores en casos de
    convergencias de témpanos en determinada celda (grid)
    Parámetros:
    - grid_color: color que tenia la celda previamente
    - temp_color: color asignado al grupo de témpanos que llega
    a esa celda
    Ámbos colores deben ser únicamente 'r' 'g' 'y' o 'w'
    '''

    grilla = str(grid_color)
    tempano = str(temp_color)
    if grilla == 'w':
        return tempano
    else:
        if grilla == 'g' and tempano == 'g':
            return 'y'
        elif grilla == 'g' and tempano == 'y':
            return 'y'
        elif grilla == 'g' and tempano == 'r':
            return 'r'
        elif grilla == 'y' and tempano == 'g':
            return 'y'
        elif grilla == 'y' and tempano == 'y':
            return 'r'
        elif grilla == 'y' and tempano == 'r':
            return 'r'
        else:
            return 'r'

def temp_to_grid(temp_list, grid_shape):
    '''
    Toma lista con objetos Tempano, y grilla de la
    carta de tempanos, y reubica cada tempano en la
    celda que le corresponda, junto con su color asociado.
    - temp_list: lista con objetos clase Tempano
    - grid_shape: shapefile con poligonos (celdas de la
    carta de tempanos)
    '''
    i = 0
    while i<len(grid_shape):
        if grid_shape['geometry'][i] is None:
            pass
        else:
            for tpano in temp_list:
                if tpano.posicion().within(grid_shape['geometry'][i]):
                    if grid_shape['colores'][i] is 1:
                        grid_shape['colores'][i] = tpano.color
                        temp_list.pop(temp_list.index(tpano))
                    else:
                        grid_shape['colores'][i] = redef_color(grid_shape['colores'][i], tpano.color)
                        temp_list.pop(temp_list.index(tpano))
                else:
                    continue
        i += 1

def run_temp_to_grid(ice_round, geo_grid):
    temp_to_grid(ice_round, geo_grid)
    icelist_len_tmp = len(ice_round)
    temp_to_grid(ice_round, geo_grid)
    while len(ice_round) < icelist_len_tmp:
        icelist_len_tmp = len(ice_round)
        temp_to_grid(ice_round, geo_grid)

def remaining_icebergs(temp_list, centroids_gpd, grid_shape):
    i = 0
    while i<len(grid_shape):
        if grid_shape['geometry'][i] is None:
            pass
        else:
            for tpano in temp_list:
                if (abs(tpano.latitude - centroids_gpd['centroides'][i].y) < 0.8) and (abs(tpano.longitude - centroids_gpd['centroides'][i].x) < 0.8):
                    if grid_shape['colores'][i] is 1:
                        grid_shape['colores'][i] = tpano.color
                        temp_list.pop(temp_list.index(tpano))
                    else:
                        grid_shape['colores'][i] = redef_color(grid_shape['colores'][i], tpano.color)
                        temp_list.pop(temp_list.index(tpano))
                else:
                    continue
        i += 1


def ones_to_white(grid_shape):
    for i in range(len(grid_shape)):
        if grid_shape['colores'][i] == 1:
            grid_shape['colores'][i] = 'w'

def draw_screen_poly(lats, lons, m, color, alp):
    x, y = m( lons, lats )
    xy = zip(x,y)
    poly = Polygon( list(xy), facecolor=color, alpha=alp, zorder = 0)
    plt.gca().add_patch(poly)

def get_latlon_list(coords_list):
    lons = [lon_coord[0] for lon_coord in coords_list]
    lats = [lat_coord[1] for lat_coord in coords_list]
    return lons, lats

def coord_lister(shape):
    lats = []
    lons = []
    colo = []
    geom = shape.geometry
    for row_id in range(geom.shape[0]):
        if geom.iloc[row_id] != None:
            try:
                todas_coords = list(geom.exterior.iloc[row_id].coords)
                temp_coords = list(geom.exterior.iloc[row_id].coords)
                longi, lati = get_latlon_list(temp_coords)
                lats.append(lati)
                lons.append(longi)
                colo.append(str(shape['colores'][row_id]))
                del temp_coords
            except AttributeError:
                continue
    return (todas_coords), lats, lons, colo

def suavizado_grilla(current_grid_shape, previous_grid_shape):
    for i in range(len(current_grid_shape)):
        if previous_grid_shape['colores'][i] == 'r' and current_grid_shape['colores'][i] == 'w':
            current_grid_shape['colores'][i] = 'y'
        elif previous_grid_shape['colores'][i] == 'y' and current_grid_shape['colores'][i] == 'w':
            current_grid_shape['colores'][i] = 'g'
        else:
            pass
    return current_grid_shape

def run_and_graf(ice_rounds):
    backup_geo_grillas = {}
    date = datetime.datetime.strptime(url_date, '%Y%m%d')
    date_start = date.strftime("%Y/%m/%d")
    for ronda, i in zip(ice_rounds, [0,24,48,72,96]):
        name = 'ronda_{}'.format(i)
        if i>0:
            date = date + datetime.timedelta(hours=24)
        date_title = date.strftime("%Y/%m/%d")
        geo_grilla, gpd_centroids = new_grid_and_centroids()
        #temp_to_grid(ronda, geo_grilla)
        run_temp_to_grid(ronda, geo_grilla)
        remaining_icebergs(ronda, gpd_centroids, geo_grilla)
        ones_to_white(geo_grilla)

        # Suavizado
        k = int(int(i)/24)

        backup_geo_grillas[k] = geo_grilla

        if k>0:
            geo_grilla = suavizado_grilla(backup_geo_grillas[k], backup_geo_grillas[k-1])

        coordinates, all_lats, all_lons, all_colors = coord_lister(shape=geo_grilla)
        icelon, icelat = read_icelimit()

        plt.figure(figsize=(15,10)) # ancho, alto
        #ax = Basemap(projection='stere',llcrnrlon=-100,llcrnrlat=-70,urcrnrlon=-10,urcrnrlat=-30.,lat_0=-55, lon_0 = -40, resolution='h')
        ax = Basemap(projection='stere',llcrnrlon=-110,llcrnrlat=-70,urcrnrlon=-10,urcrnrlat=-45.,lat_0=-55, lon_0 = -40, resolution='h')

        llon, llat, uplon, uplat = geo_grilla.total_bounds
        parallels = np.arange(-90,-30,5.)
        ax.drawparallels(parallels,labels=[True,False,False,False]) # labels = [left,right,top,bottom]
        parallels_fino = np.arange(-90,-30,1.)
        ax.drawparallels(parallels_fino,labels=[False,False,False,False], color = "grey", zorder = 0) # labels = [left,right,top,bottom]
        meridians = np.arange(-100,20,5.)
        ax.drawmeridians(meridians,labels=[False,False,True,False])
        meridians_fino = np.arange(-100,20,1.)
        ax.drawmeridians(meridians_fino,labels=[False,False,False,False], color = "grey", zorder = 0)
        ax.drawcoastlines()
        ax.fillcontinents(color="coral")
        for k in range(len(all_colors)):
            draw_screen_poly( all_lats[k], all_lons[k], ax, all_colors[k], alp=1)
        ax.plot(icelon, icelat, color="k", linewidth=1.5, latlon=True, zorder = 0)
        colores = cm.rainbow(np.linspace(0, 1, len(bergout_singu.iloc[:,1].unique())))
        for idx, singu in enumerate(bergout_singu.iloc[:,1].unique().tolist()):
            name_singu = str(singu)
            singu_data = bergout_singu[bergout_singu['Name'] == name_singu].reset_index(drop=True)
            ax.scatter(singu_data.iloc[i,5].tolist(), singu_data.iloc[i,4].tolist(), latlon = True, s = 25, marker = "^", color = colores[idx], label= name_singu, zorder = 5)
        plt.legend()
        handles, labels = plt.gca().get_legend_handles_labels()
        green_patch = mpatches.Patch(color='green')
        yellow_patch = mpatches.Patch(color='yellow')
        red_patch = mpatches.Patch(color='red')
        handles.extend([green_patch, yellow_patch, red_patch])
        labels.extend(['Aislados', 'Escasos', 'Numerosos'])
        plt.legend(handles = handles, labels = labels, fontsize = 'x-large', loc = 'lower right', markerscale = 3.0)
        plt.title(f'Pronóstico de deriva y derretimiento de témpanos NAVAREA VI\nInicializado {date_start}, válido para {date_title}', fontsize = 14, pad=20.0, fontweight = 'bold')
        plt.savefig(name+'.png', format='png', bbox_inches = 'tight', pad_inches = 0.5, edgecolor='k')

# Inicializo las clases
ice_0 = [Tempano(a,b,c,d,e) for a, b, c, d, e in zip(
    df_0['Name'], df_0['geometry'].y, df_0['geometry'].x, df_0['Ref'], df_0['Col'])]

ice_24 = [Tempano(a,b,c,d,e) for a, b, c, d, e in zip(
    df_24['Name'], df_24['geometry'].y, df_24['geometry'].x, df_24['Ref'], df_24['Col'])]

ice_48 = [Tempano(a,b,c,d,e) for a, b, c, d, e in zip(
    df_48['Name'], df_48['geometry'].y, df_48['geometry'].x, df_48['Ref'], df_48['Col'])]

ice_72 = [Tempano(a,b,c,d,e) for a, b, c, d, e in zip(
    df_72['Name'], df_72['geometry'].y, df_72['geometry'].x, df_72['Ref'], df_72['Col'])]

ice_96 = [Tempano(a,b,c,d,e) for a, b, c, d, e in zip(
    df_96['Name'], df_96['geometry'].y, df_96['geometry'].x, df_96['Ref'], df_96['Col'])]

run_and_graf([ice_0, ice_24, ice_48, ice_72, ice_96])
