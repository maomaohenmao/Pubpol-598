# getting package library(tidyverse)
library(tidyverse)



foo <- c(1,2,4) #creat a vector
foo
foo %>% min()  #use pump operator to put the vector into thr function behind
foo %>% mean()  #it is tidy to do it this way, it is in the tidyverse library
foo %>% max()
foo %>% sd()



help('lm')



cat_function <- function(love=TRUE){ #general example of function
  if(love==TRUE){
    print('I love cats!')
  }
  else {
    print('I am not a cool person.')
  }
}
cat_function(TRUE)



foo1 <- c(1,2,3,NA)
foo1 %>% min ()
foo1 %>% min (foo1, na.rm = TRUE)
min123 <- function(vector_of_values, na.rm=TRUE)  #remove missing data in a vector
  
  
  
char <- c('foo', 'moo', 'boo')
char %>% class()  #show the type of 'char'
char %>% is.character()  # is 'char' a character?
char %>% is.factor()
char %>% as.factor()  #coerce data type, but didn't change the type. factor type is either string or number
char %>% as.factor() %>% class()
char_2 <- char %>% as.factor() #only save again can really make the change of type
char_2 %>% class()


#dataframe
df <- data_frame(
  x = c(1:3)
  , y = c(4:6)
  , z = c('foo', 'boo', 'moo')
)
cars %>% head() # a inbuilding dataframe in R studio
cars$speed
cars[,1]  #first as row, second as column. Call as needed.


#matrix
matrix(data = 1:6, nrow = 3, ncol = 2)


# Vectors
1:10
rep(1:2, times = 2)
rep(c(1,2), times = 2)
seq(from = 0, to = 100, by = 10)
seq(0, 100, 10)
#you can use the location to call the element in the vector
seq(from = 0, to = 100, by = 10)[2]
rep(1:2, times = 2)[4]


#read data from web
donor <- read_csv('https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/small_donations_data.csv')
donor
#get the default working directory
getwd()
#change it
setwd('C:/Users/win/Documents/GitHub/Pubpol 598')
#save the data locally
write_csv(donor, 'small_donations_data.csv')



#exercise
donor %>% class()
donor$amount %>% min()
donor$amount %>% mean()
max(donor$legislative_district, na.rm = TRUE)



donor %>% head(1) %>% as.data.frame()
donor %>% summary()
donor %>% ls()
donor %>% str()
donor %>% dim()
donor %>% nrow()


donor %>% nrow()
donor$amount %>% median()
donor %>% dim()
donor$amount %>% summary()


donor$contributor_name %>% unique()
donor$contributor_name %>% length()
donor$contributor_zip %>% table()


donor$party %>% table()
donor$contributor_employer_state %>% table()
donor$type %>% unique()
firstname <- donor$first_name %>% unique()
firstname %>% length()   #length(unique(donor$first_name))


police <- read_csv('https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/small_police_data.csv')
write_csv(police, 'small_police_data.csv')
police %>% dim()
police$district_sector %>% table()
police$event_clearance_subgroup %>% table()
police$census_tract %>% as.integer() %>% min123() %>% min(na.rm = TRUE)

donor %>% ls()
donor %>% select(id, amount, receipt_date)
donor %>% select(id, contributor_name, contributor_state)
#everything is used to put all other columns after selected columns
donor %>% select(id, amount, receipt_date, everything())

norm <- function(x, y){ z <- x^2 + y^2; x+y+z }
norm(2,3)
norm <- function(x) sqrt(x%*%x)
