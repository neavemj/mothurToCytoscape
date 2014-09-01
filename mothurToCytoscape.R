## import files from 'shared' mothur file and convert to a cytoscape network file ##
#
# Created by Matthew J Neave on 12/04/2014.
# Copyright (c) 2013 Matthew J Neave. All rights reserved.
# mneave@whoi.edu; matthewjneave1@gmail.com

# A .shared file should be created in mothur using the make.shared command
# the shared file columns should be 'label', 'group', 'numOTUs', then OTU count data. If not, some modification to the script will be required
# place this script and the .shared file in the same folder
# navigate to the folder in terminal, type R to start R, then type source('mothurToCytoscape.R') to run the script

# import the shared file

print("CYTOSCAPE LINKS FROM MOTHUR SHARED FILE", quote=F)
print("Import your '.shared' file", quote=F) 
print("This may take a few minutes depending on the file size", quote=F)
sharedFile <- read.table(file.choose(), header=TRUE, sep="\t", as.is=TRUE)

# ask how many OTUs to put into network graph
print("How many of the top OTUs do you want to include in the graph? About 5000 seems to look ok..", quote=F)
ans <- scan(what=integer(), nmax=1)
ans <- ans + 3
specificOTUs <- as.data.frame(sharedFile[,1:ans])

# create empty/starting variables

cytoscapeLinks <- NULL
cytoscapeLinksTemp <- NULL
otu <- 3
otuForCbind <- 0
analysisOTU <- NULL
analysisOTUnoO <- NULL

## LOOP 1 ## loops through each OTU. Imports each column and removes the 0s
# the length - 3 is to remove the initial columns that don't contain otu data

for (i in 1:(length(specificOTUs)-3)) {

otu <- otu + 1
analysisOTU <- specificOTUs[,c(2,otu)]

# remove singletons and possibly more to reduce information in plot
analysisOTU[analysisOTU==0] <- NA
analysisOTU[analysisOTU==1] <- NA
#analysisOTU[analysisOTU==2] <- NA
#analysisOTU[analysisOTU==3] <- NA
#analysisOTU[analysisOTU==4] <- NA
#analysisOTU[analysisOTU==5] <- NA
#analysisOTU[analysisOTU==6] <- NA
#analysisOTU[analysisOTU==7] <- NA
#analysisOTU[analysisOTU==8] <- NA
#analysisOTU[analysisOTU==9] <- NA
#analysisOTU[analysisOTU==10] <- NA

analysisOTUnoO <- na.omit(analysisOTU)

site = 0


      ## LOOP 2 ## loops a single anchor site through the other sites in the otu      
      # if statement 1 ensures the loop is only run if there is at least 1 OTU
        if (length(analysisOTUnoO[,2]) >0) {
        for (j in 1:(length(analysisOTUnoO[,2]))) {
      
            site <- site + 1
            cytoscapeLinksTemp <- NULL
            otuNumber <- colnames(analysisOTUnoO[2])
            cytoscapeLinksTemp <- cbind(cytoscapeLinksTemp, analysisOTUnoO[site,1])
            cytoscapeLinksTemp <- cbind(cytoscapeLinksTemp, otuNumber)
            cytoscapeLinksTemp <- cbind(cytoscapeLinksTemp, analysisOTUnoO[site,2])
                    
            cytoscapeLinks <- rbind(cytoscapeLinks, cytoscapeLinksTemp)
            } 
        }
}


#length(unique(cytoscapeLinks[,2])))

#tax <- read.table(file.choose(), header=FALSE, sep="\t", as.is=TRUE)
#colnames(tax) <- (c("otuNumber", "taxa"))
#colnames(cytoscapeLinks) <- (c('site', 'otuNumber', 'abund'))
#cytoscapeLinks <- (merge(tax, cytoscapeLinks, by = 'otuNumber'))

# count how many duplicates, ie. how abundant each bacterial group is
#library(plyr)
#ddply(tax,.(tax$taxa),nrow)

# write output table to file

write.table(cytoscapeLinks, file='cytoscapeLinks', sep='\t', row.names=F, col.names=F, quote=F)

print("Ok, your file should be saved as 'cytoscapeLinks' in the current working directory", quote=F)
print("The columns are site, OTU number then OTU abundance as required for a cytoscape bipartate network", quote=F)
print("Note: singleton reads were not inluded in the calculations", quote=F)



