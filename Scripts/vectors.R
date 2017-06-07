#Vectors

x <-  5 * 6

is.vector(x)
length(x)
x[2] <- 31
x

x[5] <- 44
x[0]
x <- 1:4
y <- x^2

x <- 1:5
y <- 3:7
x + y

#[]spesifiserer posisjonen i vektoren
z <- y[-5]
#når vektorene ikke er like lange, resirkuleres den korteste vektoren (begynner fra posisjon 1 igjen)
#ved multipler som går opp (5-10), ser man ikke advarsel ved resirkulering
#only think that makes it possible to multiply a vector with a single number
x + z

z^x


#str = structure

#Combination, coortion
#integer, ingen desimaltall (L tvinger tallene til å bli integer)
str(c("Hello", "work", "people"))
str(c(2L:4L, pi >3))
c(9:11, 200, x)


w <- rnorm(10)
seq_along(w)
which(w < 0)
w[which(w < 0)]
#numeric subsetting
w[w < 0]
#logical subsetting
w < 0 

#subsette, fjerner posisjon 2 og 5
w[-c(2,5)]

str(list("something", 2:4, pi >3))

x <- list(vegetable = "cabbage",
     number = pi,
     series = 2:4,
     telling = pi > 3)

str(x)

#[] returns a list
x[1]
x$vegetable

#[[]] removes the "packaging", returns what the values really are
x[[3]]
str(x[[3]])

x <- list(vegetable = c("cabbage", "carrot", "spinage"),
          number = list(c(pi, 0, 2.14, NA)),
          series = list(list(2:4, 3:5)),
          telling = pi > 3)
str(x)
x$vegetable