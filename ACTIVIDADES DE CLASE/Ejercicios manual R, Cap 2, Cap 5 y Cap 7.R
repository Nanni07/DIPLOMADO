
#CAPITULO 2 
#eJERCICIO 1

x<-c(LETTERS[1:20])
x
#eJERCICIO 2

mimatriz <- matrix(1:100, nrow=10, ncol=10)
mimatriz

#EJERCICIO 3 
A<-diag(3)
A
#EJERCICO 4

LISTA<-list(x,mimatriz,id)
LISTA

#EJERCICIO 5
E<-c(25,58,55)
M<-c("rock", "pop", "baladas")
S<-c("si", "si", "si")
B<-data.frame(E,M,S)
B

#EJERCICIO 6
#El error esta en que no son del mismo tipo, al ser una matrix se requiere ser de la misma variable
edad <- c(15, 19, 13, NA, 20)
deporte <- c(TRUE, TRUE, NA, FALSE, TRUE)
comic_fav <- c(NA, 'Superman', 'Batman', NA, 'Batman')
matrix(edad, deporte, comic_fav)

#cAPITULO 5
#EJERCICIO 1

#¿Qué cantidad de dinero sobra al repartir 10000$ entre 3 personas?
D<-10000 %% 3
D

#EJERCICIO 2
#¿Es el número 4560 divisible por 3?
4560 %% 3==0


#EJERCICIO 3
z <- c(2:87)
z <- z[z%%7==0]
z
#EJERCICIO 4
#Construya dos vectores, el primero con los números enteros desde 7 hasta 3, el segundo vector con los primeros cinco números positivos divisibles por 5. Sea A la condición de ser par en el primer vector. Sea B la condición de ser mayor que 10 en el segundo vector. ¿En cuál de las 5 posiciones se cumple A y B simultáneamente?
a<-c(7:3)
a
b<-c(1:25)[c(1:25)%%5==0]
b
if(a %% 2==0){print(a)}

#EJERCICIO 5 GAUSS

sum(1:100)

#EJERCICIO 6 
#cONSTRUIR UN VECTOR

x <- (c(1,-4,5,9,-4))
which(x == min(x))

#EJERCICIO 7
factorial(8)

#EJERCICIO 8
#EVALUAR LA SUMATORIA DE EXP(i)
x <- 0
for(i in 3:7){
  x <- x + exp(i)
}
x

#EJERCICIO 9
#EVALUAR EL SIGUIENTE PRODUCTO
prod(log(sqrt(1:10)))

#EJERCICIO 10
v1 <- c(2:7)
v2 <- v1[length(v1):1]
str(v2)

#EJERCICIO 11
vec <- c(1:20)

#EJERCICIO 12
vec <- c(20:1)
str(vec)

#EJERCICIO 13
x <- c(1:20)
x <- ifelse(x%%2==0,x*(-1),x)

#EJERCICIO 14
s1 = c(seq(from = 3, to = 36, by = 3))
s2 = c(seq(from = 1, to = 34, by = 3))

l1 = length(s1)
l2 = length(s2)

v1 = c(seq(0.1,0.1, length.out = l1))
v2 = c(seq(0.2,0.2, length.out = l2))

v1_1 <- v1**s1
v2_1 <- v2**s2

#Combinar vectores
v_f <- c(as.numeric(rbind(v1_1, v2_1)))
length(v_f)
str(v_f)
#EJERCICIO 15

sum((10:100)**3,4*(10:100)**2)

#EJERCICIO 16
#https://raw.githubusercontent.com/fhernanb/datos/master/Paises.txt

url <- 'https://raw.githubusercontent.com/fhernanb/datos/master/Paises.txt'
dt1 <- read.table(url,header = TRUE)

#EJERCICIO 17
length(dt1[1,])

#EJERCICIO 18
length(dt1$Pais)
length(dt1[,1])
length(dt1[['Pais']])

#EJERCICIO 19
myframe <- data.frame(dt1)
subset(myframe, subset = poblacion == max(poblacion))
subset(myframe, subset = poblacion == max(poblacion), select = c('Pais','poblacion'))

#EJERCICIO 20 
subset(myframe, subset = alfabetizacion == min(alfabetizacion))

#EJERCICIO 21
#FALSO
floor(-1.1) == trunc(-1.1)

#BASE DE DATOS A USAR
mtcars


#EJERCICIO 22
# cilindraje menor a 18
mtcars[mtcars$mpg < 18,]


#EJERCICIO 23
#AUTOS QUE TENGAN 4 CILINDROS
mtcars[mtcars$cyl == 4,]

#EJERCICIO 24

# Total son:
print(sum((mtcars$wt > 2.5) & (mtcars$am == 1)))