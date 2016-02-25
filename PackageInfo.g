## Hey Emacs, this is -*- kash -*- code!
#############################################################################
##
##  PackageInfo.g  QaoS - Interfacing the QaoS database     Sebastian Freundt
##

SetPackageInfo( rec(

PackageName := "qaos",
Subtitle := "Interfacing the QaoS database from GAP",
Version := ".",
Date := "",

ArchiveURL := "http://www.math.tu-berlin.de/~kant/download/gap/qaos-.",
ArchiveFormats := ".tar.bz2",


Persons := [

  rec(
      LastName      := "Freundt",
      FirstNames    := "Sebastian",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "freundt@math.tu-berlin.de",
      WWWHome       := "http://www.math.tu-berlin.de/~freundt",
      PostalAddress := Concatenation( [
            "Fakult\"at II - Institut f\"ur Mathematik\n",
            "TU Berlin\n",
            "Stra{\ss}e des 17. Juni 136\n",
	    "D-10623 Berlin\n",
            "Germany" ] ),
      Place         := "Berlin",
      Institution   := "TU Berlin"),

  rec(
      LastName      := "Pauli",
      FirstNames    := "Sebastian",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "pauli@math.tu-berlin.de",
      WWWHome       := "http://www.math.tu-berlin.de/~pauli",
      PostalAddress := Concatenation( [
            "Fakult\"at II - Institut f\"ur Mathematik\n",
            "TU Berlin\n",
            "Stra{\ss}e des 17. Juni 136\n",
	    "D-10623 Berlin\n",
            "Germany" ] ),
      Place         := "Berlin",
      Institution   := "TU Berlin"),

],

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "deposited"     for packages for which the GAP developers agreed 
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages 
##    "other"         for all other packages
##
Status := "deposited",

README_URL := "http://www.math.tu-berlin.de/~kant/download/gap/qaos.README",
PackageInfoURL := "http://www.math.tu-berlin.de/~kant/download/gap/qaos.PackageInfo.g",

AbstractHTML :=
  "The <span class=\"pkgname\">QaoS</span> package provides gateway functions to access the QaoS databases of algebraic objects in Berlin. <span class=\"pkgname\">QaoS</span> is primarily intended to query for transitive groups or algebraic number fields and turn retrieved results into GAP objects for further computing.",

PackageWWWHome := "http://qaos.math.tu-berlin.de/qaos/qaos.scm",

PackageDoc := rec(          
  BookName  := "QaoS",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/qaos.html",
  PDFFile   := "doc/qaos.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "QaoS - Querying Algebraic Objects System",
  Autoload  := true),

Dependencies := rec(
  GAP := ">= 4.3",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [], 
  ExternalConditions := ["needs cURL (http://curl.haxx.se)"] ), 

AvailabilityTest := ReturnTrue,             
Autoload := false,
TestFile := "tst/testall.g",
Keywords := ["algebraic structure theory", "database"]

));


#############################################################################
##
#E
