
knn2 <- function() {
	load("C://Users//posingh3//Desktop//419//myfile.RData")
	library(tm)
	library(plyr)
	library(class)
	library(tcltk)

	start.timeT = Sys.time()
	cateT = "Test"

	pathT = "C://Users//posingh3//Desktop//419//Test"

	#clean data

	cleanCorpusT <-function(corpusT) {
	  corpus.tmpT = tm_map(corpusT,removePunctuation)
	  corpus.tmpT = tm_map(corpus.tmpT,stripWhitespace)
	  corpus.tmpT = tm_map(corpus.tmpT,PlainTextDocument)
	  corpus.tmpT = tm_map(corpus.tmpT,removeWords,stopwords("english"))
	  corpus.tmpT = tm_map(corpus.tmpT,stemDocument)
	  return(corpus.tmpT)
	}

	#build TDM

	generateTDMT <- function(cateT,pathT) {
	  s.dirT =  sprintf("%s\\%s",pathT,cateT)
	  s.corT = Corpus(DirSource(directory = s.dirT,encoding = 'UTF-8'))
	  s.cor.clT = cleanCorpusT(s.corT)
	  s.tdmT= TermDocumentMatrix(s.cor.clT)
	  #s.tdmT = removeSparseTerms(s.tdmT,0.4)
	  resultT <-list(name= cateT,tdmT = s.tdmT)
	}
	tdmT = lapply(cateT,generateTDMT,path = pathT)

	# attach name
	bindCategoryTDMT <- function(tdmT) {
	  s.matT = t(data.matrix(tdmT[["tdmT"]]))
	  s.dfT = as.data.frame(s.matT,stringsAsFactors = F)
	  s.dfT = cbind(s.dfT,rep(tdmT[["name"]],nrow(s.dfT)))
	  colnames(s.dfT)[ncol(s.dfT)] <- "targetCat"
	  return(s.dfT)
	  
	}
	catTDMT = lapply(tdmT,bindCategoryTDMT)

	#Stack 
	tdm.stackT = do.call(rbind.fill,catTDMT)
	tdm.stackT[is.na(tdm.stackT)] = 0
	tdm.stack.nlT = tdm.stackT[,!colnames(tdm.stackT) %in% "targetCat"]

	#add
	mat1 = tdm.stack.nl
	mat2 = tdm.stack.nlT
	xx <- (mat2[,intersect(colnames(mat2),colnames(mat1))])
	#xx = as.data.frame(xx)
	#xx = t(xx)
	xx = as.data.frame(xx)
	yy <- read.table(textConnection(""), col.names = colnames(mat1),check.names = FALSE, colClasses = "integer")
	zz <- rbind.fill(xx, yy)
	zz[is.na(zz)] = 0
	pp = data.frame(zz[,intersect(colnames(zz),colnames(tdm.stack.nl))], check.names = FALSE)
	tdm.stack.nl = tdm.stack.nl[,order(names(tdm.stack.nl))]
	pp = pp[,order(names(pp))]

	len = dim(zz)
	lengt = len[1]
	#till here
	text.idxT = matrix(0,nrow = 1, ncol= lengt)
	for(i in 1:lengt){
	  text.idxT[i]=i
	}
	text.idxT=as.integer(text.idxT)
	#model
	tdm.catT = tdm.stackT[,"targetCat"]



	knn.pred = knn(tdm.stack.nl[train.idx,],pp[text.idxT,],tdm.cat[train.idx], prob =TRUE)

	end.timeT = Sys.time()
	timeT = end.timeT -start.timeT

	knn.pred = as.data.frame(knn.pred)

	# txt <- capture.output(print.data.frame(knn.pred))
	# 
	# tt <- tktoplevel()
	# txtWidget <- tktext(tt)
	# tkpack(txtWidget)
	# tkinsert(txtWidget,"end",paste(txt,collapse="\n"))

	knn.pred = as.matrix(knn.pred)
	list(
		message = paste(knn.pred)
	)
	save.image(file = "C://Users//posingh3//Desktop//419//myfile1.RData" )
	#write.csv(knn.pred,"C://Users/posingh3//Desktop//results.csv", append = FALSE)
}