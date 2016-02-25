#############################################################################
##
#W  init.g  QaoS - Interfacing the QaoS database from GAP   Sebastian Freundt
##

DeclarePackage("qaos", "1.0", function() return true; end);
DeclarePackageDocumentation("qaos", "doc");


#############################################################################
##
#R  read .gd files
##
ReadPkg("qaos/gap/helper.gd");
ReadPkg("qaos/gap/qaos.gd");


### init.g ends here
