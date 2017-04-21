eset <- gse48091[fData(gse48091)$entrezid %in% Nielsen10CCRTabS1$entrezid, ] %>%
  genefilter::featureFilter()
gse48091$PAM50PROLIF  <- colMeans(exprs(eset))

stopifnot(validObject(gse48091))
