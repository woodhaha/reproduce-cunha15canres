averageExprsByFDataVar <- function(eset, fvarnam="entrezid") {
  tmpExprs <- do.call(rbind,
    by(exprs(eset), fData(eset)[, fvarnam], colMeans, simplify = FALSE))
  eset2 <- ExpressionSet(tmpExprs)
  pData(eset2) <- pData(eset)
  fData(eset2) <- data.frame(
    featureNames(eset2),
    row.names = featureNames(eset2),
    check.names = FALSE, stringsAsFactors = FALSE)
  fvarLabels(eset2) <- fvarnam
  annotation(eset2) <- fvarnam
  stopifnot(validObject(eset2))
  eset2
}
