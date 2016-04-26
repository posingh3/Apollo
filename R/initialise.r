#init

initialise <- function() {

	library(tm)
	library(plyr)
	library(class)
	libs=c("tm","plyr","class")
	lapply(libs,require,character.only = T)
	options(stringsAsFactors= F)

	cate = c("3rd","acl_rules_gen","alerts","anti_spyware_integ","authentication","build_system","cli","configdefragd","dns","documentation","freebsd","hardware",
	"int_dev_tasks","logging","mcafee","merlin","miscellaneous","networking","os_upgrade","pages","proxy","reporting_integ","specs","sys_health","traffic_monitor","updates","wbnp","wbrs","wui","xml_config")

	path = "C:\\Users\\posingh3\\Desktop\\419\\Folder"

	#clean data

	cleanCorpus <-function(corpus) {
	corpus.tmp = tm_map(corpus,removePunctuation)
	corpus.tmp = tm_map(corpus.tmp,stripWhitespace)
	corpus.tmp = tm_map(corpus.tmp,PlainTextDocument)
	corpus.tmp = tm_map(corpus.tmp,removeWords,stopwords("english"))
	corpus.tmp = tm_map(corpus.tmp,stemDocument)
	return(corpus.tmp)
	}

	#build TDM

	generateTDM <- function(cate,path) {
	s.dir =  sprintf("%s\\%s",path,cate)
	s.cor = Corpus(DirSource(directory = s.dir,encoding = 'UTF-8'))
	s.cor.cl = cleanCorpus(s.cor)
	s.tdm= TermDocumentMatrix(s.cor.cl)
	s.tdm = removeSparseTerms(s.tdm,0.7)
	result <-list(name= cate,tdm = s.tdm)
	}
	tdm = lapply(cate,generateTDM,path = path)

	# attach name
	bindCategoryTDM <- function(tdm) {
	s.mat = t(data.matrix(tdm[["tdm"]]))
	s.df = as.data.frame(s.mat,stringsAsFactors = F)
	s.df = cbind(s.df,rep(tdm[["name"]],nrow(s.df)))
	colnames(s.df)[ncol(s.df)] <- "targetCat"
	return(s.df)

	}

	catTDM = lapply(tdm,bindCategoryTDM)
	#Stack 
	tdm.stack = do.call(rbind.fill,catTDM)
	tdm.stack[is.na(tdm.stack)] = 0

	#holdout
	train.idx <- sample(nrow(tdm.stack),ceiling(nrow(tdm.stack) * 1))
	
	tdm.cat = tdm.stack[,"targetCat"]
	tdm.stack.nl = tdm.stack[,!colnames(tdm.stack) %in% "targetCat"]

	save.image(file = "C://Users//posingh3//Desktop//419//myfile.RData" )
	 list(
    message = paste("hey")
  )
}