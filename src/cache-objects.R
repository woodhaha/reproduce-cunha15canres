unlink(list.files(path = "cache", pattern = "*", full.names = TRUE))
ProjectTemplate::reload.project(list(data_loading = TRUE, munging = TRUE))

ProjectTemplate::cache("Nielsen10CCRTabS1")

ProjectTemplate::cache("gse48091")
ProjectTemplate::cache("gse81954")

ProjectTemplate::cache("casecontstudy_design")
ProjectTemplate::cache("casecontstudy")

ProjectTemplate::cache("qcsubstudy_exprs")
ProjectTemplate::cache("qcsubstudy")
