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
ReadPkg("qaos/gap/helper.gi");
ReadPkg("qaos/gap/qaos.gi");
