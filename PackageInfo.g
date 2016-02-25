#############################################################################
##
##  PackageInfo.g  QaoS - Interfacing the QaoS database     Sebastian Freundt
##

SetPackageInfo( rec(

PackageName := "qaos",
Subtitle := "Interfacing the QaoS database from GAP",
Version := "1.2",
Date := "25/02/2016",

SourceRepository := rec(
                         Type := "git",
                         URL := Concatenation("https://github.com/gap-packages/", ~.PackageName )
                        ),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://gap-packages.github.io/", ~.PackageName ),
README_URL      := Concatenation( ~.PackageWWWHome, "/README" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName ,"-", ~.Version ),
ArchiveFormats := ".tar.gz .tar.bz2",

Persons := [
  rec(
      LastName      := "Freundt",
      FirstNames    := "Sebastian",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "freundt@math.tu-berlin.de",
      WWWHome       := "http://www.math.tu-berlin.de/~freundt",
      PostalAddress := Concatenation( [
            "Fakultät II - Institut für Mathematik\n",
            "TU Berlin\n",
            "Straße des 17. Juni 136\n",
            "D-10623 Berlin\n",
            "Germany" ] ),
      Place         := "Berlin",
      Institution   := "TU Berlin"),

  rec(
      LastName      := "Pauli",
      FirstNames    := "Sebastian",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "pauli@math.tu-berlin.de",
      WWWHome       := "http://www.math.tu-berlin.de/~pauli",
      PostalAddress := Concatenation( [
            "Fakultät II - Institut für Mathematik\n",
            "TU Berlin\n",
            "Straße des 17. Juni 136\n",
            "D-10623 Berlin\n",
            "Germany" ] ),
      Place         := "Berlin",
      Institution   := "TU Berlin"),
  rec(
       IsAuthor := false,
       IsMaintainer := true,
       FirstNames := "Markus",
       LastName := "Pfeiffer",
       WWWHome := "http://www.morphism.de/~markusp/",
       Email := "markus.pfeiffer@st-andrews.ac.uk",
       PostalAddress := Concatenation( [
                                         "School of Computer Science\n",
                                         "North HaughSt Andrews\n",
                                         "Fife\n",
                                         "KY16 9SX\n",
                                         "United Kingdom" ] ),
       Place := "St Andrews",
       Institution := "University of St Andrews",
  ),
],

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "deposited",

AbstractHTML :=
  "The <span class=\"pkgname\">QaoS</span> package provides gateway functions to access the QaoS databases of algebraic objects in Berlin. <span class=\"pkgname\">QaoS</span> is primarily intended to query for transitive groups or algebraic number fields and turn retrieved results into GAP objects for further computing.",

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
