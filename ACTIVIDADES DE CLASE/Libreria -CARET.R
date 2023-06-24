##PAQUETERIA CARET

##El paquete caret (classification and regression training) incluye una serie de funciones que 
#facilitan el uso de decenas de métodos complejos de clasificación y regresión. 
#Utilizar este paquete en lugar de las funciones originales de los métodos presenta dos ventajas:
  
#Permite utilizar un código unificado para aplicar reglas de clasificación muy distintas, implementadas en diferentes paquetes.
#Es más fácil poner en práctica algunos procedimientos usuales en problemas de clasificación. Por ejemplo, hay funciones específicas para dividir la muestra en datos de entrenamiento y datos de test o para ajustar parámetros mediante validación cruzada.
#Mucha información y ayuda sobre uso del paquete se puede encontrar en la página web http://topepo.github.io/caret/index.html, que ha sido la fuente de información básica para elaborar esta introducción. Aquí nos centraremos en el uso de caret en problemas 
#de clasificación. Las aplicaciones en problemas de regresión son similares.


#Los datos
#Comenzamos cargando los paquetes y datos:
  
library(dplyr)
library(caret)


head(iris)

datos <-iris
set.seed(100)  # Para reproducir los mismos resultados
IndicesEntrenamiento <- createDataPartition(y = datos$y,
                                            p = 0.6,
                                            list = FALSE)
Entrenamiento <- datos[IndicesEntrenamiento,]
Test <- datos[-IndicesEntrenamiento,]



#Análisis discriminante lineal
#Los tres primeros argumentos van a ser necesarios siempre que utilicemos el comando train:
#1. El primer argumento especifica la variable que queremos predecir (en clasificación, la variable que contiene la clase) y qué variables vamos a utilizar para hacerlo. Para ello, se usa la sintaxis habitual en R para definir un modelo.
#2. El segundo argumento especifica el data frame en el que se encuentran los datos.
#3.El tercer argumento especifica el método de clasificación que queremos usar. En este primer ejemplo usamos lda, que corresponde a la regla lineal de Fisher.
#4. En este ejemplo concreto se ha utilizado adicionalmente el argumento prior para fijar las mismas probabilidades a priori para las dos clases (por defecto son las proporciones muestrales de cada clase).

lda.datos <- train(y ~ .,data = datos,
                   method = "lda",
                   prior = c(0.5, 0.5))

#Dentro de la lista de resultados generados, el elemento llamado finalModel
#contiene los resultados básicos finales. Para el caso de la regla de Fisher se obtiene:

lda.datos$finalModel

#A continuación llevamos a cabo los mismos cálculos, pero usando únicamente la muestra de test:

lda.entrenamiento <- train(y ~ .,
                           data = Entrenamiento,
                           method = "lda",
                           prior = c(0.5, 0.5))

lda.entrenamiento$finalModel


#Vemos que los resultados no son muy diferentes a los obtenidos cuando usamos la muestra completa.

A# continuación clasificamos los datos de test con esta regla de clasificación (mediante el comando predict) y
#calculamos los porcentajes de errores cometidos. Para este último cálculo se aplica en comando confusionMatrix 
#usando como argumentos las predicciones y los valores verdaderos. Este comando calcula una lista larga de medidas. 
#Únicamente se presenta la tabla de errores y la tasa de error global:

# Tasas de error para datos de test
predicciones <- predict(lda.entrenamiento, Test)
confusionMatrix(predicciones, Test$y)$table


confusionMatrix(predicciones, Test$y)$overall[1]

# Tasas de error aparente
predicciones <- predict(lda.datos, datos)
confusionMatrix(predicciones, datos$y)$table

confusionMatrix(predicciones, datos$y)$overall[1]

#Regla de k
#vecinos más próximos
#Para tener un buen comportamiento en distintas situaciones muchas reglas de clasificación incroporan una serie de parámetros que les confieren una mayor flexibilidad. Normalmente se usan métodos de validación cruzada para determinar estos parámetros. 
#Veamos cómo hacerlo en caret usando un ejemplo sencillo: la regla de k
#vecinos más próximos, en la que hay que determinar el número k
#de vecinos que intervienen para clasificar cada punto.

#Primero hay que determinar el conjunto de valores entre los que vamos a seleccionar k
#mediante el comando expand.grid. En el ejemplo se han fijado los valores 3,5,7,…,15


#En segundo lugar hay que determinar el método que se va a usar para elegir el valor óptimo de k
#Se selecciona el valor que da el mejor resultado.
#Posteriormente, se usa el comando train de manera similar a como se hizo para calcular la regla de Fisher, pero añadiendo los ajustes anteriores mediante los nuevos parámetros tuneGrid y trControl respectivamente:


# Define el grid de parámetros a probar
valores <- expand.grid(k = seq(3, 15, 2)) 

# Define los detalles del método de validación cruzada o remuestreo a utilizar
ajustes <- trainControl(method='cv',  # validación cruzada
                        number = 10)  # diez submuestras

# Aplica el método seleccionando el valor óptimo de k
knn.datos <- train(y ~ .,
                   data = datos,
                   method = 'knn',
                   tuneGrid = valores,
                   trControl = ajustes)
knn.datos

plot(knn.datos)



predicciones <- predict(knn.datos, datos)
confusionMatrix(predicciones, datos$y)$table

confusionMatrix(predicciones, datos$y)$overall[1]

#Cuando se desea prefijar el valor de k,
#una posibilidad es definir un grid de un solo punto. En el siguiente ejemplo, fijamos k=3
#y estimamos el error de clasificación mediante el habitual método de validación cruzada dejando uno fuera



valores <- expand.grid(k = 3) 
ajustes <- trainControl(method='LOOCV')   # leave-one-out CV
knn3.datos <- train(y ~ .,
                    data = datos,
                    method = 'knn',
                    tuneGrid = valores,
                    trControl = ajustes)
knn3.datos


#Para knn es necesario usar validación cruzada, tal y como hemos hecho en el ejemplo anterior. 
#En otros casos puede ser conveniente fijar method='none' en trainControl.

#Observaciones finales
#Para otros métodos se recomienda usar el comando modelLookup para saber qué parámetros pueden optimizarse y cómo se llaman. Algunos ejemplos:

modelLookup('lda')

modelLookup('knn')
modelLookup('qda')
modelLookup('rpart')
