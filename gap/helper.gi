############################################################################
##
#W  helper.gi  QaoS - Interfacing the QaoS database        Sebastian Freundt
##


Alist:=
  function(arg)
    return arg;
  end;




#############################################################################
##
#F auxiliary funs
##
Assoc:=
  function(lis,key)
    return First(lis,i->i[1]=key)[2];
  end;

Butlast:=
  lis->lis{[1..Size(lis)-1]};
Last:=
  lis->lis[Size(lis)];

TRUE:=true;
FALSE:=false;
FAILURE:=fail;

_GetEntry_rec_string:=
  function(arg)
    local record,field,optarg,Fail;

    if Length(arg)<2 or Length(arg)>3 then
      Error("Usage: _GetEntry_rec_string(<record>,<string> [, optarg]");
    elif Length(arg)=2 then
      record := arg[1];
      field := arg[2];
      optarg := rec();
    elif Length(arg)=3 then
      record := arg[1];
      field := arg[2];
      optarg := arg[3];
    fi;

    if "Fail" in RecNames(optarg) then
      Fail := optarg.("Fail");
    else
      Fail := FAILURE;
    fi;

    if field in RecNames(record) then
      return record.(field);
    else
      return Fail;
    fi;
  end;

_Base:=j->j.("base");

RunHookWithArg :=
  function(hook,arg)
    local i;
    for i in hook do
      arg := i(arg);
    od;
    return arg;
  end;


IsAlphaNumChar:=chr->IsAlphaChar(chr) or (chr >= '0' and chr <= '9');
IsAlphaNumSpaceChar:=chr->IsAlphaNumChar(chr) or chr=' ';

InstallGlobalFunction( UrlEncode,
  function(string)
    local tmp, mpos, new, j, startpos, endpos, tmpstring;
    tmp:=ShallowCopy(string);
    mpos := Filtered([1..Length(tmp)], i->not IsAlphaNumSpaceChar(tmp[i]));

    ## the trivial case
    if Length(mpos) = 0 then
      return ReplacedString(tmp," ","+");
    fi;

    new := "";
    for j in [1..Length(mpos)] do
      ## copy the non-matching string
      if j>1 then
	startpos := mpos[j-1]+1;
      else
	startpos := 1;
      fi;
      endpos := mpos[j];
      tmpstring := tmp{[startpos..endpos-1]};
      new := Concatenation(new, tmpstring);

      ## now copy and transform the matched string
      startpos := mpos[j];
      new := Concatenation(new, "%",HexStringInt(INT_CHAR(tmp[startpos])));
    od;

    ## copy unmatched data at the end
    endpos:=mpos[Length(mpos)]+1;
    if endpos <= Length(tmp) then
      new := Concatenation(new,tmp{[endpos..Length(tmp)]});
    fi;

    ## now wipe spaces
    return ReplacedString(new," ","+");
  end );


InstallGlobalFunction( Mapconcat,
  function(fun,lis,sep)
    return JoinStringsWithSeparator(List(lis,i->fun(i)),sep);
  end );


## cURL is a must at the moment.
## fetch it at http://curl.haxx.se/
InstallGlobalFunction( Curl,
  function(uri)
    local path, curl, str, a;

    path := DirectoriesSystemPrograms();;
    curl := Filename(path,"curl");
    str := "";; a := OutputTextString(str,true);;
    Process( DirectoryCurrent(), curl, InputTextNone(), a, ["-s","-k",uri] );
    CloseStream(a);
    #Print(str);
    return str;
  end );



### helper.gi ends here
