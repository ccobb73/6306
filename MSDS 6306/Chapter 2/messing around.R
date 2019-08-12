gpa.section.a <- c(3.13, 3.55, 2.92, 2.73, 3.00, 3.18, 2.66, 3.76)

#standard deviation
sd(gpa.section.a)

#agrgument in sd
args(sd) 

gpa.section.b <- c(3.14, 3.13, 3.25, 2.93, 2.73, 3.50, 2.70, 3.23)

#combine both gpa's with a cbind(concatenation)
all.gpa <- c(gpa.section.a,gpa.section.b)

all.gpa

pnorm(75,mean=85,sd=5)

#lookg at packages
library()

#making a function
sumdice <- function(n=2){
x <- sample(1:6,n,replace=TRUE)
dots <- sum(x)
dots
}

#will create a dir
dir.create