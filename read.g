#############################################################################
##
#W  read.g  QaoS - Interfacing the QaoS database from GAP   Sebastian Freundt
##

#############################################################################
##
#R QaoS global configuration
##
if not IsBound(QaosDefaultLimit) then
  QaosDefaultLimit:=25;
fi;

#############################################################################
##
#R read files
##
ReadPackage("qaos", "gap/helper.gi");
ReadPackage("qaos", "gap/qaos.gi");
