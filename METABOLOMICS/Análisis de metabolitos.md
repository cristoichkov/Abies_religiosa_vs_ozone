# Análisis de metabolitos

Los datos del GC-MS se obtuvieron en listas para cada muestra.

![Lista metabolitos] (images/List-GC-MS.png) 

Cada dato pk (pico), RT (tiempo de retención), Area % (porcentaje de área) CAS# (número CAS) y Qual (valor) de todas las muestras se registro en una tabla en excel.

```
 	Tablas_datos/Metabolites_GC-MS_ALL.xls
```
![Lista metabolitos] (images/Tabla_GC-MS_ALL.png)

Posteriormente, se ordenó cada metabolito presente en las muestras de acuerdo al CAS#. La primer opción de CAS se tomó para ordenar los metabolitos.


```
 	Tablas_datos/Metabolitos_orderCAS.xlsx
```
![Lista metabolitos] (images/Tabla_orderCAS.png)

Una vez organizados por CAS se conviertió el número CAS al ID de cada metabolito según la página NSI y el nombre Library/ID dado por el equipo 

```
 	Tablas_datos/Metabolitos_GC-MS_orderbyCAS.xlsx
```
![Lista metabolitos] (images/Tabla_GC-MS_orderbyCAS.png)

Se generaron 2 Tablas: Una con los metabolitos presentes en al menos la mitad de las muestras/mas sus metabolitos relacionados y otro con presencias menores.

```
Tablas_datos/Metabolitos con menor presencia.xlsxs/Metabolitos_GC-MS_orderbyCAS.xlsx
```
En la de mayor presencia se hicieron varios filtros paradescartarmetabolitos con menores presencias 
```
Tablas_datos/Metabolitos_mayor_presencia_1.xlsx
```

Se mantuvieron los metabolitos con Qual mayor a 80 y se volvieron a descartar metabolitos con precencias menores.

La tabla final es: 
```
Tablas_datos/Metabolitos-Tesis-Vero.xlsx
```
![Lista metabolitos] (images/Tabla_final.png)

Se utilizó el siguiente script para calcular la cantidad de metabolitos y compararla entre temporada, condicion y año de exposicion

```
bin/ANOVA_TV1.R
```

![Lista metabolitos] (images/ANOVA_TV1.png)

Se utilizó el siguiente script para calcular la cantidad de metabolitos y graficarla en barplot de acuerdo a la temporada, condicion y año de exposicion

```
bin/Metabolitos.TV1.R
```

![Lista metabolitos] (images/Metabolitos.TV1.png)


Se utilizó el siguiente script para calcular la cantidad de metabolitos y buscar correlaciones entre los metabolitos y graficar un PCA de acuerdo a la temporada

```
bin/PCA.R
```

![Lista metabolitos] (images/PCA_1.png)
![Lista metabolitos] (images/PCA_2.png)


