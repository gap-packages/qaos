################################################################################
##
##  offline.tst           test for package 'QaoS'           
##
gap> START_TEST("offline.tst");
gap> QaosTransitiveGroup();
QaosTransitiveGroup(<query> [, <optarg>]) -> <result>

Searches the Algebraic Objects Database in Berlin.
The query string equals the keyword search method in the web surface.
See `http://qaos.math.tu-berlin.de/qaos/query.scm?type=trnsg&action=Help'
for more information about the syntax and keywords.

Note: You must have `curl' (see http://curl.haxx.se) installed and
properly configured in order to use QaoS from within GAP.

true
gap> QaosNumberField();
QaosNumberField(<query> [, <optarg>]) -> <result>

Searches the Algebraic Objects Database in Berlin.
The query string equals the keyword search method in the web surface.
See `http://qaos.math.tu-berlin.de/qaos/query.scm?type=anf&action=Help'
for more information about the syntax and keywords.

Note: You must have `curl' (see http://curl.haxx.se) installed and
properly configured in order to use QaoS from within GAP.

true
gap> STOP_TEST("offline.tst");
