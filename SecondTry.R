library(tidyverse)
library(lubridate)
getwd()
setwd('C:/Users/win/Documents/Github/Pubpol 598')
donor <- read.csv('small_donations_data.csv') %>% 
  mutate(receipt_year = receipt_date %>% mdy() %>% year())
police <- read.csv('small_police_data.csv')

##  donor <- read.csv('https://raw.githubusercontent.com/maomaohenmao/r_course_evans_school/master/data/small_donations_data.csv')
##  police <- read.csv('https://raw.githubusercontent.com/maomaohenmao/r_course_evans_school/master/data/small_police_data.csv')

donor %>% head(1)
donor_2 %>% head(1) %>% as.data.frame()

donor_2 <- donor %>% select(id, amount, type, party, receipt_date)
donor_2 %>% select(-id)
donor_2 %>% head()
donor %>% select(id, receipt_date, everything()) 

x <- c(1, 2, 3)
y <- c(4, 5, 1)
ifelse(x > y, 'yes', 'no')

donor %>% 
  mutate(
    amount_per_day = (amount / 365) %>% round(2)
    , amount_perc_max = (amount / max(amount, na.rm = TRUE)) %>% round(2)
    , amount_candidate = ifelse(type %in% 'Candidate', amount, NA) 
    , amount_committee = ifelse(type %in% 'Political Committee', amount, NA) 
  )

police %>% mutate(parking_violation = ifelse(event_clearance_subgroup %in% 'PARKING VIOLATIONS', 1, 0)
                  , incident_location = ifelse(parking_violation %in% 1, incident_location, NA))


donor %>% 
  transmute(
    amount_per_day = (amount / 365)
    , amount_candidate = ifelse(type %in% 'Candidate', amount, NA) 
    , amount_committee = ifelse(type %in% 'Political Committee', amount, NA) 
  )


donor %>% 
  rename (donor_id = id,
          donor_f_name = first_name,
          donor_l_name = last_name
          ) %>%
  as.data.frame() %>%
  head(1)

donor %>% 
  transmute(
    donor_id = id
    , donor_f_name = first_name
    , donor_l_name = last_name
  )

donor %>% 
  mutate(
    donor_id = id
    , donor_f_name = first_name
    , donor_l_name = last_name
  )


police_2 <- police %>% 
  transmute (
    general_offense_number
    , initial_type_group = ifelse (initial_type_group %in% NA, 'Unknown', as.character(initial_type_group))
    , event_location = incident_location
  )

donor %>% filter(amount > 100) %>% select(id, amount) %>% head(15)
donor %>% filter(type != 'Candidate') %>% select(id, type) %>% head(15)


donor %>% 
  filter(amount > 100 & type %in% 'Candidate') %>% 
  select(id, amount, type) %>% 
  head(15)


#same thing below
donor %>% 
  filter(contributor_name %in% c('BEZOS JACKIE', 'COSTCO')) %>% 
  select(contributor_name, amount, type)
donor %>% 
  filter(contributor_name == 'BEZOS JACKIE' |  contributor_name == 'COSTCO') %>% 
  select(contributor_name, amount, type)


donor %>% sample_n(3) %>% select(contributor_name, type, amount)


donor$receipt_date %>% class()
donor$receipt_date %>% lubridate::mdy()
donor %>%
  transmute(id
            ,candidate_flag = ifelse(type %in% 'Candidate', 1, 0)
            ,party
            ,receipt_date = receipt_date %>% mdy()
            ) %>%
  filter(!party %in% c('REPUBLICAN', 'DEMOCRAT') & receipt_date >= '2017-01-01')

donor %>% 
  mutate(receipt_date = receipt_date %>% mdy()) %>%
  filter(
    ! party %in% c('REPUBLICAN', 'DEMOCRAT') & 
      receipt_date >= '2017-01-01'
  ) %>%
  nrow()


donor %>% gather(column_name, year, c(receipt_year, election_year))
donor %>% spread(receipt_year, amount) 

police %>% gather(column_name, grouptype, c(event_clearance_group, event_clearance_subgroup, initial_type_group, initial_type_subgroup))
donor$type %>% summary()
donor %>% spread(type, amount) %>% select(id, 'Political Committee', 'Candidate')

#aggregate data
donor %>% group_by(type, party) %>% summarise(dollars = sum(amount, na.rm = TRUE))
