#Esta funcion consiste en mezclar los archivo rast.IDs de la base de datos de NCBI y la generada 
#por la funcion group_sametax_ids
library(dplyr)
#data_all <- list.files(path = "/Datos",  # Identify all CSV files
#                      pattern = "*.IDs", full.names = TRUE) %>% 
#  lapply(read_csv) %>%                              # Store all files in list
#  bind_rows                                       # Combine data sets into one data set 
#data_all    
one<-readLines("Corason_Alcanivoracaceae_Rast.IDs")#colClasses = "character")
two<-readLines("Datos/ids_by_family/Alcanivoracaceae_bins.IDs")#,colClasses = "character")

one
class(two)
dput(two$V2)
dput(one$V2)


v<-c(one,two)
v


writeLines(v, "Datos/Merged_id_files/Alcanivoracaceae_bins_merged.IDs")
#write.table(v , file =  "Datos/Alpha_merged0.IDs", sep = "\t", dec = ".",
#            row.names = FALSE, col.names = FALSE, quote=FALSE)
