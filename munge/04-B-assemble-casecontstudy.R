## Assemble nested case-control study eset
tmp_exprs <- exprs(gse48091)[, casecontstudy_design$geo_accession]
colnames(tmp_exprs) <- casecontstudy_design$subjid

casecontstudy <- ExpressionSet(tmp_exprs)

pData(casecontstudy) <- casecontstudy_design

## Append additional phenotypic data
casecontstudy$subtypecd <- pData(gse48091)[casecontstudy$geo_accession, "subtypecd"]
casecontstudy$subtype <- pData(gse48091)[casecontstudy$geo_accession, "subtype"]
casecontstudy$PAM50PROLIF <- pData(gse48091)[casecontstudy$geo_accession, "PAM50PROLIF"]

## Annotation data
annotation(casecontstudy) <- "HuRSTA2a520709"
fData(casecontstudy) <- fData(casecontstudy) %>%
  mutate(
    probeid = featureNames(casecontstudy),
    entrezid = unlist(mget(probeid, HuRSTA2a520709ENTREZID, ifnotfound = NA)),
    symbol = unlist(mget(probeid, HuRSTA2a520709SYMBOL, ifnotfound = NA))
  ) %>%
  data.frame(row.names = featureNames(casecontstudy))

stopifnot(validObject(casecontstudy))
