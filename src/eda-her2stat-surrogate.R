ProjectTemplate::reload.project()

ggplot2::theme_set(theme_classic() +
    theme(axis.line.x = element_blank()) +
    theme(axis.line.y = element_blank()))

sel_symbols <- c("ERBB2", "GRB7")
eset <- casecontstudy[fData(casecontstudy)$symbol %in% sel_symbols, ] %>%
  genefilter::featureFilter()
featureNames(eset) <- as.character(fData(eset)$symbol)
pData(eset) <- cbind(pData(eset), t(exprs(eset)))
eset$HER2_amplicon_metagene <- colMeans(exprs(eset))

library(mixtools)
fit <- normalmixEM(eset$HER2_amplicon_metagene, mu = c(6, 12))

pData(eset) <- cbind(pData(eset), fit$posterior) %>%
  rowwise() %>%
  mutate(
    HER2_amplicon_metagene_dich_ = factor(comp.2 > comp.1,
      levels = c(FALSE, TRUE), labels = c("low", "high"))
  ) %>%
  (function(x) data.frame(x, row.names = x$subjid))
stopifnot(validObject(eset))

table(pData(eset)[, c("subtypecd", "HER2_amplicon_metagene_dich_")])

gg <- pData(eset) %>%
  ggplot(aes(x = ERBB2, y = GRB7, col = subtypecd,
    shape = HER2_amplicon_metagene_dich_)) +
  geom_point() +
  coord_fixed() +
  scale_colour_manual(values = colsubtypecd) +
  scale_shape_manual(values = c("low" = 1, "high" = 16))
plot(gg)
