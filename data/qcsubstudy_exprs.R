message("Downloading GSE81954_full_data_matrix from GEO")
tmp_mat <- readr::read_tsv(
  "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81954/suppl/GSE81954%5Ffull%5Fdata%5Fmatrix.txt.gz",
  col_names = FALSE) %>%
  as.matrix()

qcsubstudy_exprs <- tmp_mat[4:nrow(tmp_mat), 2:ncol(tmp_mat)] %>%
  apply(MARGIN = 2, FUN = as.numeric)

rownames(qcsubstudy_exprs) <- tmp_mat[4:nrow(tmp_mat), 1]
colnames(qcsubstudy_exprs) <- tmp_mat[3, 2:ncol(tmp_mat)]
