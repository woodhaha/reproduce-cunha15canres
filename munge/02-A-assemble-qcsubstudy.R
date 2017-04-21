tmpdf <- tibble(geo_accession = colnames(qcsubstudy_exprs)) %>%
  left_join(
    rbind(
      pData(gse48091)[, c("geo_accession", "tumorid", "piece")],
      pData(gse81954)[, c("geo_accession", "tumorid", "piece")]),
    by = "geo_accession") %>%
  left_join(
    pData(gse81954)[, c("tumorid", "setnr", "casecontstat")],
    by = "tumorid") %>%
  data.frame()
rownames(tmpdf) <- tmpdf$geo_accession

qcsubstudy <- ExpressionSet(qcsubstudy_exprs)
pData(qcsubstudy) <- tmpdf

## Annotation data
annotation(qcsubstudy) <- "HuRSTA2a520709"
fData(qcsubstudy) <- fData(qcsubstudy) %>%
  mutate(
    probeid = featureNames(qcsubstudy),
    entrezid = unlist(mget(probeid, HuRSTA2a520709ENTREZID, ifnotfound = NA)),
    symbol = unlist(mget(probeid, HuRSTA2a520709SYMBOL, ifnotfound = NA))
  ) %>%
  data.frame(row.names = featureNames(qcsubstudy))

stopifnot(validObject(qcsubstudy))
