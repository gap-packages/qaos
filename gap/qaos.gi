############################################################################
##
#W  qaos.gi  QaoS - Interfacing the QaoS database          Sebastian Freundt
##
##
## Copyright (C) 2005 by Sebastian Freundt, Sebastian Pauli
## Authors: Sebastian Freundt <freundt@math.tu-berlin.de>
##          Sebastian Pauli <pauli@math.tu-berlin.de>
## Created: 2005/08/24
## Keywords: 
##
## This program is free software; you can redistribute it and/or modify it
## under a BSD-like licence.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are met:
## Redistributions of source code must retain the above copyright notice, this
## list of conditions and the following disclaimer.
## Redistributions in binary form must reproduce the above copyright notice,
## this list of conditions and the following disclaimer in the documentation
## and/or other materials provided with the distribution.
## Neither the name of the Technical University of Berlin nor the names of its
## contributors may be used to endorse or promote products derived from this
## software without specific prior written permission.
## 
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
## AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
## LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
## CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
## SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
## INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
## CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
## ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
## POSSIBILITY OF SUCH DAMAGE.
## 
## Code:


_QaosBase := "http://qaos.math.tu-berlin.de/qaos/";
_QaosBaseS := "https://qaos.math.tu-berlin.de/qaos/";

_QaosModules := Alist(["query","query.scm"]);
_QaosQueryActions := Alist(["query","Go"],["help","Help"],["count","Count"]);
_QaosQueryTypes :=
  Alist(
    ["anf",rec(
      basefield := "generator",
      description := "number field")],
    ["trnsg",rec(
      basefield := "name",
      description := "transitive group")]);




#############################################################################
##
#M  ViewObj( <r> )
##
InstallMethod( ViewObj, "for QaoS results", [ IsDatabaseCollection ],
  function( r )
    local l;
    l := Length(QaosResult(r));
    if l < 1 then
      Print( "<collection from database: no matches; ",
        "\"",QaosQuery(r), "\">" );
    elif l=1 then
      Print( "<collection from database: 1 ",QaosObjectType(r),"; ",
        "\"", QaosQuery(r), "\">" );
    else
      Print( "<collection from database: ",l," ",QaosObjectType(r),"s; ",
        "\"",QaosQuery(r), "\">" );
    fi;
  end );
InstallMethod( ViewObj, "for QaoS results", [ IsDatabaseAtom ],
  function( r )
    local l;
    l := QaosResult(r);
    if l < 1 then
      Print( "no ",QaosObjectType(r),"s satisfy ",
        "\"",QaosQuery(r), "\"" );
    elif l=1 then
      Print( "1 ",QaosObjectType(r)," satisfies ",
        "\"",QaosQuery(r), "\"" );
    else
      Print( l," ",QaosObjectType(r)," satisfy ",
        "\"",QaosQuery(r), "\"" );
    fi;
  end );
InstallMethod( ViewObj, "for a QaoS result", [ IsDatabaseObject ],
  function( r )
    Print( "<",QaosObjectType(r)," from database: ",
      QaosObjectLabel(r),"; ",
      "id ",QaosObjectID(r),">" );
  end );


#############################################################################
##
#M  PrintObj( <r> )
##
InstallMethod( PrintObj, "for QaoS results", [ IsDatabaseCollection ],
  function( r )
    local l, i;
    l := Length(QaosResult(r));
    if l < 1 then
      Print( "<collection from database with no results\n" );
      Print( " over query: \"",QaosQuery(r),"\">\n");
    elif l = 1 then
      Print("<collection from database: 1 ",QaosObjectType(r),"\n" );
      Print(" "); PrintObj(QaosResult(r)[1]); Print("\n");
      Print(" over query: \"",QaosQuery(r),"\">\n");
    else
      Print("<collection from database: ",l," ",QaosObjectType(r),"s\n" );
      for i in QaosResult(r) do
        Print(" "); PrintObj(i); Print("\n");
      od;
      Print(" over query: \"",QaosQuery(r),"\">\n");
    fi;
  end );
InstallMethod( PrintObj, "for QaoS results", [ IsDatabaseAtom ],
  function( r )
    local l;
    l := QaosResult(r);
    if l < 1 then
      Print( "no ",QaosObjectType(r),"s satisfy ",
        "\"",QaosQuery(r), "\"" );
    elif l=1 then
      Print( "1 ",QaosObjectType(r)," satisfies ",
        "\"",QaosQuery(r), "\"" );
    else
      Print( l," ",QaosObjectType(r)," satisfy ",
        "\"",QaosQuery(r), "\"" );
    fi;
  end );
InstallMethod( PrintObj, "for a QaoS result", [ IsDatabaseObject ],
  function( r )
    Print( "<",QaosObjectType(r)," from database: ",
      QaosObjectLabel(r),"; ",
      "id ",QaosObjectID(r),">" );
  end );


############################################################################
## 
#F QaosGenericQueryResult( query, offset, limit, optarg )
##  
InstallGlobalFunction( QaosGenericQueryResult,
  function(arg)
    local query,optarg,limit,offset,uri,buf,pip,result,
      type, action, basefield, colgroups;

    if Length(arg)<3 or Length(arg)>4 then
      Error("Usage: QaosGenericQueryResult(<string>,<integer>,<integer> [, optarg])");
    elif Length(arg)=3 then
      query := arg[1];
      offset := arg[2];
      limit := arg[3];
      optarg := rec();
    elif Length(arg)=4 then
      query := arg[1];
      offset := arg[2];
      limit := arg[3];
      optarg := arg[4];
    fi;

    type := _GetEntry_rec_string(optarg,"Type",rec(Fail:="trnsg"));
    action := _GetEntry_rec_string(optarg,"Action",rec(Fail:="query"));
    colgroups := _GetEntry_rec_string(optarg,"ColGroups",
                   rec(Fail:=["cgall"]));

    uri:= Concatenation(
      _QaosBase, Assoc(_QaosModules,"query"),
      "?type=",type,
      "&mode=keyword",
      "&query=",
      UrlEncode(query),
      "&action=",Assoc(_QaosQueryActions, action),
      Mapconcat(i->Concatenation("&",i,"=on"), colgroups, ""),
      "&offset=",String(offset),
      "&limit=",String(limit),
      "&output=kash");

    result:=Curl(uri);
    return result;
  end );


############################################################################
##
#F QaosGenericQuery( query, offset, limit, optarg )
##
InstallGlobalFunction( QaosGenericQuery,
  function(arg)
    local query,optarg,limit,offset, result, L, l,stime,
      type, typeval, basefield, resulttransformhook,
      fam, typ, oidfield, labelfield;

    if Length(arg)<3 or Length(arg)>4 then
      Error("Usage: QaosGenericQuery(<string>,<integer>,<integer> [, optarg])");
    elif Length(arg)=3 then
      query := arg[1];
      offset := arg[2];
      limit := arg[3];
      optarg := rec();
    elif Length(arg)=4 then
      query := arg[1];
      offset := arg[2];
      limit := arg[3];
      optarg := arg[4];
    fi;

    type := _GetEntry_rec_string(optarg,"Type",rec(Fail:="trnsg"));
    typeval := Assoc(_QaosQueryTypes,type);
    basefield := _GetEntry_rec_string(optarg,"BaseField",
                   rec(Fail:=typeval.basefield));
    resulttransformhook := _GetEntry_rec_string(optarg,"ResultTransformHook",
                   rec(Fail:=[]));

    optarg.("type") := type;

#    stime := UTime();

    result := QaosGenericQueryResult(query,offset,limit,optarg);
    result := RunHookWithArg(resulttransformhook, result);
    L := EvalString(result);

    if not IsRecord(L) then
      L := rec(base:=L);
    fi;
    if not IsBound(L.("field_alist")) then
      L.("field_alist") := Alist();
    fi;

    if IsList(L.base) then
      fam := NewFamily("QaosDatabaseObject",
               IsDatabaseObject
               and IsMutable
               and IsAttributeStoringRep);
      typ := NewType(fam, IsAttributeStoringRep
               and IsMutable
               and IsDatabaseObject and IsDatabaseObjRep);
      oidfield := Concatenation(type,"_id");
      labelfield := typeval.("basefield");
      Apply(L.base,
        function(l)
          local tmpl;
          tmpl := rec();
          ObjectifyWithAttributes(
            tmpl,typ,
            QaosQuery,query,
            QaosFieldAlist,L.("field_alist"),
            QaosResult,l,
            QaosObjectID,l.(oidfield),
            QaosObjectLabel,l.(labelfield),
            QaosObjectType,typeval.description,
            QaosObjectTypeShort,type);
          return tmpl;
        end );

      ## initiate the db collection family
      fam := NewFamily("QaosDatabaseCollectionFam",
               IsDatabaseCollection
               and IsMutable
               and IsAttributeStoringRep);
      fam!.size := Length(L.("base"));
      fam!.set := L.("base");
      typ := NewType(fam,
               IsDatabaseCollection
               and IsMutable
               and IsDatabaseCollRep and IsCollection);

      result := rec();
      ObjectifyWithAttributes(
        result,typ,
        QaosQuery,query,
        QaosFieldAlist,L.("field_alist"),
        QaosResult,L.("base"),
        QaosResultLength,Length(L.("base")),
        QaosObjectType,typeval.description,
        QaosObjectTypeShort,type,
        QaosObjectID,0);

    else

      ## initiate the db simple family
      fam := NewFamily("QaosDatabaseAtomFam",
               IsDatabaseAtom and IsMutable
               and IsAttributeStoringRep);
      typ := NewType(fam,
               IsDatabaseAtom
               and IsMutable
               and IsDatabaseAtomRep and IsObject);

      result := rec();
      ObjectifyWithAttributes(
        result,typ,
        QaosQuery,query,
        QaosResult,L.("base"),
        QaosObjectType,typeval.description,
        QaosObjectTypeShort,type,
        QaosObjectID,0);

    fi;

    ## for timing purposes
    ## Print("Time: ",UTime()-stime," s\n");

    return result;
  end );



#############################################################################
##
#F QaosTransitiveGroup( query, [, optarg]) -> result
##
InstallGlobalFunction( QaosTransitiveGroup,
  function(arg)
    local query,optarg,offset,limit,action,colgroups,coll,result,
      fam,typ, l, QRl;

    if Length(arg)>2 then
      Error("Usage: QaosTransitiveGroup(<query> [, <optarg>).");
    elif Length(arg) = 0 then 
      Print(
        "QaosTransitiveGroup(<query> [, <optarg>]) -> <result>\n\n",
        "Searches the Algebraic Objects Database in Berlin.\n",
        "The query string equals the keyword search method in the web surface.\n",
        "See `",_QaosBase,Assoc(_QaosModules,"query"),
        "?type=trnsg&action=",Assoc(_QaosQueryActions,"help"),"'\n",
        "for more information about the syntax and keywords.\n\n",

        "Note: You must have `curl' (see http://curl.haxx.se) installed and\n",
        "properly configured in order to use QaoS from within GAP.\n\n");
      return TRUE;
    elif Length(arg)=1 then
      if IsString(arg[1]) then
        query := arg[1];
        optarg := rec();
      else
        Error("Usage: QaosTransitiveGroup(<string>).");
      fi;
    elif Length(arg)=2 then
      if IsString(arg[1]) then
        query := arg[1];
        optarg := arg[2];
      else
        Error("Usage: QaosTransitiveGroup(<string>).");
      fi;
    fi;

    offset := _GetEntry_rec_string(optarg,"Offset", rec(Fail:=0));
    limit := _GetEntry_rec_string(optarg,"Limit",
               rec(Fail:=QaosDefaultLimit));
    action := _GetEntry_rec_string(optarg,"Action", rec(Fail:="query"));
    colgroups := _GetEntry_rec_string(optarg,"ColGroups",
                   rec(Fail:=["cgall"]));

    optarg.Type := "trnsg";
    optarg.Action := action;
    optarg.ColGroups := colgroups;

    result := QaosGenericQuery(query,offset,limit,optarg);
    coll := QaosResult(result);

    if IsList(coll) then
      ## now re-objectify them
      fam := NewFamily("QaosDatabaseObject",
               IsDatabaseObject and IsPermCollection
               and IsAttributeStoringRep);
      typ := NewType(fam, IsAttributeStoringRep
               and IsMutable
               and IsDatabaseObject and IsDatabaseObjRep
               and IsGroup
               and HasGeneratorsOfMagmaWithInverses
               and IsFinitelyGeneratedGroup 
               and IsTransitive);
  
      for l in coll do
        QRl := QaosResult(l);
        Objectify(typ,l);
        SetIsTransitive(l,true);
        SetIsFinitelyGeneratedGroup(l,true);
        SetSize(l,QRl.ord);
        SetGeneratorsOfMagmaWithInverses(l,AsList(QRl.perm_gens));
        if QRl.deg<9 then
          ## GAP dies otherwise
          SetAsSSortedList(l,AsSet(Group(AsList(QRl.perm_gens))));
        fi;
      od;
    fi;

    return result;
  end );

InstallOtherMethod( AsGroup,
  "for database groups", true, [IsDatabaseObject], 0,
  function(obj)
    if HasGeneratorsOfGroup(obj) then
      return Group(GeneratorsOfGroup(obj));
    else
      return fail;
    fi;
  end );



#############################################################################
##
#F QaosNumberField( query, [, optarg]) -> result
##
InstallGlobalFunction( QaosNumberField,
  function(arg)
    local query,optarg,offset,limit,action,colgroups,coll,result,
      fam,typ, l, QRl;

    if Length(arg)>2 then
      Error("Usage: QaosNumberField(<query> [, <optarg>]).");
    elif Length(arg) = 0 then 
      Print(
        "QaosNumberField(<query> [, <optarg>]) -> <result>\n\n",
        "Searches the Algebraic Objects Database in Berlin.\n",
        "The query string equals the keyword search method in the web surface.\n",
        "See `",_QaosBase,Assoc(_QaosModules,"query"),
        "?type=anf&action=",Assoc(_QaosQueryActions,"help"),"'\n",
        "for more information about the syntax and keywords.\n\n",

        "Note: You must have `curl' (see http://curl.haxx.se) installed and\n",
        "properly configured in order to use QaoS from within GAP.\n\n");
      return TRUE;
    elif Length(arg)=1 then
      if IsString(arg[1]) then
        query := arg[1];
        optarg := rec();
      else
        Error("Usage: QaosNumberField(<string>).");
      fi;
    elif Length(arg)=2 then
      if IsString(arg[1]) then
        query := arg[1];
        optarg := arg[2];
      else
        Error("Usage: QaosNumberField(<string>).");
      fi;
    fi;

    offset := _GetEntry_rec_string(optarg,"Offset", rec(Fail:=0));
    limit := _GetEntry_rec_string(optarg,"Limit",
               rec(Fail:=QaosDefaultLimit));
    action := _GetEntry_rec_string(optarg,"Action", rec(Fail:="query"));
    colgroups := _GetEntry_rec_string(optarg,"ColGroups",
                   rec(Fail:=["cgall"]));

    optarg.Type := "anf";
    optarg.Action := action;
    optarg.ColGroups := colgroups;
    optarg.ResultTransformHook :=
      [i->ReplacedString(i,"X","Indeterminate(Rationals,1)"),
       i->ReplacedString(i,"reg:=","reg:=\""),
       ## kill me for this ugly hack, this assumption is evil :|
       i->ReplacedString(i,",num_roots_un","\",num_roots_un")];

    result := QaosGenericQuery(query,offset,limit,optarg);
    coll := QaosResult(result);

    if IsList(coll) then
      ## now re-objectify them
      fam := NewFamily("QaosDatabaseObject",
               IsDatabaseObject and IsPermCollection
               and IsAttributeStoringRep);
      typ := NewType(fam, IsAttributeStoringRep
               and IsMutable
               and IsDatabaseObject and IsDatabaseObjRep
               and IsField
               and IsAlgebraicExtension
               and HasGeneratorsOfField);
  
      for l in coll do
        QRl := QaosResult(l);
        Objectify(typ,l);
        SetGeneratorsOfField(l,QRl.generator);
      od;
    fi;

    return result;
  end );

InstallOtherMethod( AsField,
  "for number fields from database", true, [IsDatabaseObject], 0,
  function(obj)
    local x, gpoly;
    if HasGeneratorsOfField(obj) then
      return AlgebraicExtension(Rationals,GeneratorsOfField(obj));
    else
      return fail;
    fi;
  end );



### qaos.gi ends here
