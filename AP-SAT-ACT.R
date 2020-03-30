

library(tidyverse)
library(here)
library(vroom)
library(fs)


vroom("data/ap*")


vroom("data/cohort5year1819.txt", .name_repair = ~ janitor::make_clean_names(., case = "upper_camel")) 

sat <- dir_ls( glob = "*/s*txt", recurse = TRUE) %>%
    vroom()




import_files <- function(dir,globy){
    setwd(dir)
    
    files <- fs::dir_ls(glob = globy)
    
    print(files)
    
    output <- map_df(files, ~vroom(.x, .name_repair = ~ janitor::make_clean_names(., case = "upper_camel")))
    
    setwd(here())
    
    output
}

sat <- import_files(here("data"),"sat*txt") 
#ap <- import_files(here("data"),"ap*txt") 


sat.mry <- sat %>% 
    filter(str_detect(Cname, "Monterey"))




ap19 <- vroom("data/ap19.txt", .name_repair = ~ janitor::make_clean_names(., case = "upper_camel"))


ap19.mry <- ap19 %>% 
    filter(str_detect(Cname, "Monterey"))
