#' @title make_directories_by_family
#' @description This function uses make_directories_by_taxa function and uses in
#' a list of lineage names.
#' @usage make_directories_all_taxas(list_of_families,inputdir)
#' @param list_of_families is a vector that contains a list, taken out from a
#' column of taxonomy_table.
#' @param inputdir is the input file directory
#' @details This function uses lapply to makes all directories for all lineages
#' in the input sample with make_directories_by_taxa function.
#' @import readr dplyr
#' @examples make_directories_all_taxas(list_of_families,inputdir)
#' @noRd

make_directories_all_taxas<-function(list_of_families,inputdir){
  # makes all directories---------------------------------------------------####
  output<-lapply(list_of_families,function(x)make_directories_by_taxa(inputdir,
                                                                 x))
  if (!is.null(output)) {
    print(message("done"))
  }
}

