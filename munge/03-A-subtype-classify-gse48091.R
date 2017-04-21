data("pam50", package = "genefu")
# sum(pam50$centroids.map$EntrezGene.ID %in% fData(gse48091)$entrezid)

pam50centroids <- pam50$centroids
rownames(pam50centroids) <- as.character(pam50$centroids.map$EntrezGene.ID)
lkup <- c(
  "LumA" = "LA",
  "LumB" = "LB",
  "Her2" = "H2",
  "Basal" = "BL",
  "Normal" = "NBL")
colnames(pam50centroids) <- lkup[colnames(pam50$centroids)]

eset <- gse48091[fData(gse48091)$entrezid %in% rownames(pam50centroids), ]
eset <- genefilter::featureFilter(eset)
featureNames(eset) <- fData(eset)$entrezid
annotation(eset) <- "org.Hs.eg"

ids <- intersect(rownames(pam50centroids), featureNames(eset))
rel_exprs <- sweep(exprs(eset)[ids, ], 1, apply(exprs(eset)[ids, ], 1, "median", na.rm = TRUE))
correlations <- cor(rel_exprs, pam50centroids[ids, ], method = "spearman")
subtype_idx <- unlist(apply(correlations[sampleNames(eset), ], 1, which.max))

subtype_lkup <- c(
  "LA" = "Luminal A",
  "LB" = "Luminal B",
  "H2" = "HER2-enriched",
  "BL" = "Basal-like",
  "NBL" = "Normal breast-like")
eset$subtypecd <- factor(
  colnames(pam50centroids)[subtype_idx],
  levels = names(subtype_lkup))
eset$subtype <- factor(
  subtype_lkup[as.character(eset$subtypecd)],
  levels = subtype_lkup)

gse48091$subtypecd <- pData(eset)[sampleNames(gse48091), "subtypecd"]
gse48091$subtype <- pData(eset)[sampleNames(gse48091), "subtype"]
