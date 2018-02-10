#############################################################################
##
##  testall.g                   Testing QaoS              Alexander Konovalov
##
LoadPackage("qaos");

# run the test displaying only the help information about main QaoS functions
name := Filename( Directory( Concatenation( PackageInfo("qaos")[1].InstallationPath, 
                             "/tst" ) ), "offline.tst" );
testresult := Test(name);
if not testresult then 
  Print( "offline.tst failed\n");
fi;

# Check that GAP and Kant agree about the number of transitive groups
# (except the trivial group, which Kant considers transitive, and GAP - not)	
if List( [2..30], i -> QaosResult(QaosTransitiveGroup( 
        Concatenation( "d",String(i) ), rec(Action:="count") ) ) ) <>
   List( [2..30], NrTransitiveGroups ) then
  Print( "Discrepancies in the number of transitive groups!\n");
  testresult := false; 
fi;

# Auxiliary functions to convert QaoS collections to lists of groups and fields

TransitiveGroupsFromQaoS := query -> 
	List( QaosResult( QaosTransitiveGroup( query ) ), AsGroup );

NumberFieldsFromQaoS := query -> 
	List( QaosResult( QaosNumberField( query ) ), AsField );

# Auxiliary function to check consistency of results of QaoS queries

CheckTransitiveGroupsQaoS := function( degree, opts... )
local query, grps, g;
query:=Concatenation( "d", String(degree) );
if IsBound(opts[1]) then
  Append( query, " ");
  Append( query, opts[1] );
fi;
grps := TransitiveGroupsFromQaoS( query );
if not ForAll( grps, IsTransitive ) then
  Print( "Error: Non-transitive group of degree ", degree, " is found\n");
  return false;
elif not ForAll( grps, g -> NrMovedPoints(g)=degree ) then
  Print( "Error: degree of transitive group is not ", degree, "\n");
  return false;
elif IsBound(opts[1]) and opts[1]="abelian" then
  if not ForAll( grps, IsAbelian ) then
    Print( "Error: transitive group is not abelian\n");
    return false;
  fi;
fi;
return true;  
end;

CheckNumberFieldsQaoS := function( degree, opts... )
local query, flds, f;
query:=Concatenation( "d", String(degree) );
if IsBound(opts[1]) then
  Append( query, " ");
  Append( query, opts[1] );
fi;
flds := NumberFieldsFromQaoS( query );
if not ForAll( flds, f -> DegreeOverPrimeField(f)=degree ) then
  Print( "Error: degree of transitive group is not ", degree, "\n");
  return false;
fi;
return true;  
end;

# consistency checks for selected collections of objects

for i in [2..30] do
  Print("Checking transitive group of degree ", i, "\n");
  testresult := testresult and CheckTransitiveGroupsQaoS(i);
od;

for i in [2..30] do
  Print("Checking abelian transitive group of degree ", i, "\n");
  testresult := testresult and CheckTransitiveGroupsQaoS(i,"abelian");
od;

for i in [2..10] do
  Print("Checking algebraic extensions over rationals of degree ", i, "\n");
  testresult := testresult and CheckNumberFieldsQaoS(i);
od;

testresult := testresult and CheckNumberFieldsQaoS(5,"|disc| >=100000 |disc| <=120000 cn>1");
  
if testresult then
  Print("#I  No errors detected while testing\n");
  QUIT_GAP(0);
else
  Print("#I  Errors detected while testing\n");
  QUIT_GAP(1);
fi;

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
