
comment <- function() {

	load("C://Users//posingh3//Desktop//419//myfile2.RData")

	base4 = "C:\\Users\\posingh3\\Desktop\\419\\Icomment"
	temp4 = knn.pred[1]
	exact4 = as.character(temp4)

	location3 = sprintf("%s\\%s",base4,exact4)
	setwd(location3)

	files3 = list.files(pattern="*.txt")

	if(length(files3)<5)
	{
	  for(x in files3){
		temp10 = x
		location4 = sprintf("%s\\%s",location3,temp10)
		file.show(location4)
	  }
	}

	files4 = intersect(matrixtop, files3)

	if(length(files4)>0)
	{
	  for(y in files3){
		temp11 = y
		location5 = sprintf("%s\\%s",location3,temp11)
		file.show(location5)
	  }
	}
	if(length(files4)<=0)
	{
	  temp12 = files3[1]
	  location6 = sprintf("%s\\%s",location3,temp12)
	  file.show(location6)
	}

}