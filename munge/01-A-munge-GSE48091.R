## Extract characteristics and append
for (i in 1:2) {
  tmp <- pData(gse48091)[, paste0("characteristics_ch1.", i)]
  varnam <- unique(unlist(lapply(strsplit(tmp, ": "), function(x) x[1])))
  varval <- unlist(lapply(strsplit(tmp, ": "), function(x) x[2]))
  pData(gse48091)[, varnam] <- varval
}
varLabels(gse48091)[varLabels(gse48091) == "case-control status"] <- "casecontstat"
gse48091$tumorid <- gsub("Primary tumor breast - ", "", gse48091$title)
gse48091$piece <- 1

## Annotation data
annotation(gse48091) <- "HuRSTA2a520709"
fData(gse48091) <- fData(gse48091) %>%
  mutate(
    probeid = featureNames(gse48091),
    entrezid = unlist(mget(probeid, HuRSTA2a520709ENTREZID, ifnotfound = NA)),
    symbol = unlist(mget(probeid, HuRSTA2a520709SYMBOL, ifnotfound = NA))
  ) %>%
  data.frame(row.names = featureNames(gse48091))

stopifnot(validObject(gse48091))
