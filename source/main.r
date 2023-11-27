library(RSiena)

#################################################
#                                               #
############## Срезы сети #######################
#                                               #
#################################################
co_authorship_before2016 <- as.matrix(read.table("../ParsingData/Data/before_2016.dat"))
co_authorship_2016_2019 <- as.matrix(read.table("../ParsingData/Data/2016_2019.dat"))
co_authorship_after2019 <- as.matrix(read.table("../ParsingData/Data/after_2019.dat"))

co_authorshipData <- array(c(co_authorship_before2016,co_authorship_2016_2019,co_authorship_after2019), dim = c( 2734, 2734, 3 ))
co_authorship <- sienaDependent(co_authorshipData)


#################################################
#                                               #
############### Ковариаты #######################
#                                               #
#################################################
experience_2016 <- as.vector(unlist(read.table("../ParsingData/Data/exp_2016.dat")))
experience_2019 <- as.vector(unlist(read.table("../ParsingData/Data/exp_2019.dat")))
experience_2023 <- as.vector(unlist(read.table("../ParsingData/Data/exp_2023.dat")))

scienceSubdivCategory <- as.matrix(read.table("..ParsingData/Data/SubdivCategory.dat"))

experience <- cbind(experience_2016, experience_2019,experience_2023)
exp_covar <- varCovar(experience)

subdivision_covar <- varCovar(scienceSubdivCategory)

#################################################
#                                               #
############### Описание модели #################
#                                               #
#################################################
mydata <- sienaDataCreate(co_authorship, exp_covar, subdivision_covar)

myeff <- getEffects(mydata)

# effectsDocumentation(myeff)

myalgorithm <- sienaAlgorithmCreate( projname = 'co_authorship_TSU' )

ans <- siena07(myalgorithm, data = mydata, effects = myeff,clusterType="FORK", useCluster=TRUE,nbrNodes=12)
ans
