#############################################################################
##
#W  qaos.gd  QaoS - Interfacing the QaoS database           Sebastian Freundt
##

DeclareInfoClass( "InfoQaos" );

DeclareCategory("IsDatabaseCollection", IsCollection);
DeclareRepresentation("IsDatabaseCollRep", IsComponentObjectRep, []);
DeclareCategory("IsDatabaseAtom", IsObject);
DeclareRepresentation("IsDatabaseAtomRep", IsComponentObjectRep, []);
DeclareCategory("IsDatabaseObject", IsObject);
DeclareRepresentation("IsDatabaseObjRep", IsComponentObjectRep, []);


DeclareAttribute("QaosQuery",IsString);
DeclareAttribute("QaosFieldAlist",IsList);
DeclareAttribute("QaosResult",IsRecord);
DeclareAttribute("QaosResultLength",IsInt);
DeclareAttribute("QaosObjectID",IsInt);
DeclareAttribute("QaosObjectLabel",IsObject);
DeclareAttribute("QaosObjectType",IsString);
DeclareAttribute("QaosObjectTypeShort",IsString);

DeclareGlobalFunction("QaosGenericQueryResult");
DeclareGlobalFunction("QaosGenericQuery");

DeclareGlobalFunction("QaosTransitiveGroup");
DeclareGlobalFunction("QaosNumberField");


### qaos.gd ends here
