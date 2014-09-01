mothurToCytoscape
=================

This script will take microbial abundance data in the form of an OTU table and convert into a bipartite network suitable for viewing in cytoscape. The bipartite network will have both sites and OTUs as nodes, and edges will be created between OTUs and the sites in which they were detected. 

A .shared file should be created in mothur (www.mothur.org) using the make.shared command

The shared file columns should be 'label', 'group', 'numOTUs', then OTU count data. If not, some modification to the script will be required

To automate this analysis, place this script and the .shared file in the same folder and navigate to the folder in terminal, type R to start R, then type source('mothurToCytoscape.R') to run the script
