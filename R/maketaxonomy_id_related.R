library(readr)

gtdbK_file <- read_tsv("inst/extdata/gtdbtk.bac120.summary.tsv")
gtdbK_file$`other_related_references(genome_id,species_name,radius,ANI,AF)`
make_taxonomy_id_Related <- function(table,
                             assembly_name){
  # search the row of id in gtdbk_file user_genome column-------------------####
  assembly_name_index<-table[table$user_genome == assembly_name,]

  # find the row on the gtdbk that corresponds to the classification--------####
  assembly_classification<-strsplit(assembly_name_index$classification, ";")

  # find the specie assigned or genus or family-----------------------------####
  specie<-lapply(assembly_classification,`[[`, 7)
  lineage<-specie
  if(specie == "s__"){
    lineage<-lapply(assembly_classification,`[[`, 6)
    if(specie=="g__"){
      lineage<-lapply(assembly_classification,`[[`, 5)
    }
  }

  # cut specie and separate by __-------------------------------------------####
  s<-strsplit(as.character(lineage), "__")
  sp<-s[[1]][2]
  g_sp<- gsub(" ", "_", sp)

  # change the - for _ on id which are in user_genome-----------------------####
  id_completo<-gsub("-", "_", assembly_name_index$user_genome)

  # correct the ID----------------------------------------------------------####
  id_split <-strsplit(id_completo, "_")
  bin_id<-paste(id_split[[1]][1], "_", id_split[[1]][3], sep = "")

  # add bin_id to the name of specie to differentiate-----------------------####
  sp_rast<-paste(g_sp,bin_id,sep = "")

  # assign a number id based on index--------------------------------------####
  xvalue<-which(table == assembly_name, arr.ind = TRUE)
  x_row<-xvalue[1]
  row_size<- nchar(x_row)
  if(nchar(x_row) == 1){
    row_size<- as.numeric(x_row)*100000
  } else {
    if(nchar(x_row) == 2){
      row_size<- as.numeric(x_row)*11000
    }
  }
  value_id<-format(row_size, scientific = FALSE)
  feature_id<-paste("666666.",value_id,sep = "")

  fam<-lapply(assembly_classification,`[[`, 5)

  other_relatedcol<-assembly_name_index$`other_related_references(genome_id,species_name,radius,ANI,AF)`


  # Utiliza expresiones regulares para extraer las cadenas que cumplen con el patrón
  patron <- "(GCF_\\d+\\.\\d+|GCA_\\d+\\.\\d+)"
  matches <- regmatches(other_relatedcol, gregexpr(patron, other_relatedcol))

  # Combina las coincidencias en una sola cadena separada por comas
  related_genomes <- paste(unlist(matches), collapse = ", ")

  # Imprime el resultado
  #cat(resultado)

  #other_relatedcol<-assembly_name_index$`other_related_references(genome_id,species_name,radius,ANI,AF)`
  #patron <- "(GCF|GCA)_\\d+\\.\\d+"
  #cadenas_encontradas <- grep(patron, unlist(strsplit(other_relatedcol, ", ")), value = TRUE)
  #cadenas_encontradas_ <- gsub(patron, "\\0; ", cadenas_encontradas)
  # Mostrar las cadenas encontradas
  #cat(cadenas_encontradas, sep = "; ")
  # make a row of taxonomy table--------------------------------------------####
  taxonomy_table_row <- data.frame(matrix(ncol = 6, nrow = 0))
  colnames(taxonomy_table_row) <- c("id_numero",
                                    "feature_id",
                                    "user_genome",
                                    "gtdbk",
                                    "family",
                                    "related_genomes")

  taxonomy_table_row[1,] <- c(value_id, feature_id, bin_id,	sp_rast,fam, related_genomes)
  return (taxonomy_table_row)
}

#make_taxonomy_id(gtdbK_file,"5mSIPHEX2-concot_16")
