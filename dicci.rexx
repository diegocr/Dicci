/* ***** BEGIN LICENSE BLOCK *****
 * Version: APL License
 * 
 * Copyright (c) 2003 Diego Casorran <dcasorran@gmail.com>
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * ***** END LICENSE BLOCK ***** */

/* $VER: 1.9.1
*/
signal on syntax
signal on halt
signal on break_c

    l="rmh.library";if ~show("L",l) then;if ~AddLib(l,0,-30) then exit 15
    if AddLibrary("rxmui.library","rxsocket.library")~=0 then call er("Necesitas la "result)
    call SetRxMUIStack(65536);cr="D0A"x;i=0
    app.title="dicci"
    app.version=" v1.9.1"
    app.description="Consultas Online."
    app.base="dicci";mcorr.ObjectID=10;mcont.ObjectID=11;mtra.ObjectID=12
	app.menustrip=MakeObj(,"Menustrip",MakeObj(,"Menu","Proyecto",Menuitem("mabout","Sobre...","?"),Menuitem("maboutrxmui","Sobre RxMUI..."),Menuitem("maboutmui","Sobre MUI..."),Menuitem("","BAR"),Menuitem("mhide","Ocultar","H"),Menuitem("","BAR"),Menuitem("mquit","Salir","Q")),,
        MakeObj("medit","Menu","Opciones",Menuitem("mcorr","Corrector",,"CheckIt Toggle"),Menuitem("mcont","Corpus",,"CheckIt Toggle"),Menuitem("mtra","Traductor",,"CheckIt Toggle"),Menuitem("","BAR"),Menuitem("mupdate","Actualizar programa"),Menuitem("mbug","Avisar dicci. roto..."),Menuitem("","BAR"),Menuitem("mmui","MUI...","M")))
    app.SubWindow="mwin"
     mwin.ID="MAIN"
     mwin.width=321
     mwin.title=" Dicci v1.9.1  ©2k2 bY Diego CR "
     mwin.contents=mgroup
	mgroup.background=shadow

      call child("mgroup","g0","group")
       g0.Horiz=1;g0.frame=group
       g0.frametitle="Busqueda en Diccionarios"
	g0.background=shadow;exe.ShortHelp="Recibir resultados...";exe.FixWidth=5
	g0.0=button("exe","_Buscar")
	  bus.ObjectID=1;bus.ShortHelp="cadena a buscar"
	g0.1=string("bus","b")
uso.ObjectID=2;uso.ShortHelp='Seleccion de Diccionario'
g0.2=MakeObj("uso","cycle","Lengua|Sinónimos/Antónimos|English - Spanish|Español - Inglés|Français - Espagnol|Español - Francés|Català - Castellà|Castellano - Catalán|English - Spanish (Collins)|Español - Inglés (Collins)|Castellano-Euskera|Euskera-Castellano|Conjugaciones|Modismos|R.A.E.|Informático|Médico","n")

	call child "mgroup","spell","group"
	 spell.Horiz=1;spell.frame=group;spell.ShowMe=0
         spell.frametitle="Correción Ortográfica";corr.FixWidth=5
	spell.0=button("corr","_Corregir");file.ObjectID=3
	spell.1=string("file","c")
	;cc.ObjectID=4
        spell.2=MakeObj("cc","cycle","Español|Ingles|Aleman|Frances","n")

	call child "mgroup","contexto","group"
         contexto.Horiz=1;contexto.frame=group;contexto.showme=0
	 contexto.frametitle="Búsqueda de Palabras en Contexto";corpus.FixWidth=5
	contexto.0=button("corpus","Busc_ar");corw.ObjectID=5
	contexto.1=string("corw","a");cont.ObjectID=6
	contexto.2=MakeObj("cont","cycle","El Quijote|La Biblia|Cuentos|Corpus Oral: Administración|Corpus Oral: Conversación|Corpus Oral: Humor|Corpus Oral: Instrucciones|Corpus Oral: Jurídico|Corpus Oral: Periodismo|Corpus Oral: Técnica|Periodismo: Cultura","n")

	call child "mgroup","trad","group"
	 trad.Horiz=1;trad.frame=group;trad.ShowMe=0
	 trad.frametitle="..Traductor..";tra.FixWidth=5
	trad.0=button("tra","_Traducir");tot.ObjectID=7;tot.MaxLen=3456
	trad.1=string("tot","t");tol.ObjectID=8
	trad.2=MakeObj("tol","cycle","English to Chinese|English to French|English to German|English to Italian|English to Japanese|English to Korean|English to Portuguese|English to Spanish|Chinese to English|French to English|French to German|German to English|German to French|Italian to English|Japanese to English|Korean to English|Portuguese to English|Russian to English|Spanish to English","n")

	gaug.Spacing=0
	gauge.frame=none
	gauge.FixHeightTxt="n"
	gauge.ShortHelp="Barra informativa"
   gauge.InfoText=parsetext("%bB i e n v e n i d o  a  D i c c i !")
  call child "mgroup",MakeObj("gaug",'HGroup',MakeObj("izq","Imagebutton","ArrowLeft"),MakeObj("gauge","gauge"),MakeObj("der","Imagebutton","ArrowRight"))

  call child "mgroup","vg","group";vg.Spacing=0
    call child "vg","hg","group";hg.Horiz=1;hg.Spacing=0
      call child "hg","html","HTMLview"
       html.Frame="Virtual"
	html.ShortHelp=parsetext("%b%5Campo para los resultados..\n\n%n%0
Controles:\n
%i(teclado numerico)\n%n
  7: ir al comienzo de la pagina\n
  9: subir una pagina\n
  4: ir a la izquierda\n
  6: ir a la derecha\n
  1: ir al final de la pagina\n
  3: bajar una pagina\n
 <espacio>: desplazar pagina\n")
       html.NTAutoLoad=1
	html.NoContextMenu=1
       html.contents="<html><body bgcolor=black><center><font color=white><br><hr><b>Dicci v1.9.1 ©2002 By Diego CR</b><hr><br><br>Usando:<br><br>RxMUI © By Alfonso Ranieri<br>&<br>HTMLView © By Allan Odgaard</font></center></body></html>"
      call child "hg","sbv","scrollbar"
       sbv.ShowMe=1

cdata.ShowMe=0;cdata.MaxLen=666;call child "mgroup",string("cdata",,"")

    res=NewObj("application","app")
    if res~=0 then call er("No puedo crear la aplicacion!")

    awin.ID="AWIN"
    awin.BorderLess=1
    awin.CloseGadget=0
    awin.DepthGadget=0
    awin.DragBar=0
    awin.NoMenus=1
    awin.SizeGadget=0
    awin.Activate=0;a1.font=BIG;
    awin.Contents="agroup"
	agroup.background=shadow;agroup.frame=prop
	call child "agroup",MakeObj(,"VGroup",,
MakeObj("a1",'HGroup',label(parsetext("%b%c%3\nDicci v1.9.1   (15.01.2003)\n"))),,
MakeObj(,'HBar',),,
MakeObj("a2",'HGroup',label(parsetext("%c%3\nCopyright 2001-02 Diego CR\n< dcr8520@amiga.org >\n\nTodos los derechos reservados.\n"))),,
MakeObj(,'HBar',),,
MakeObj("a3",'HGroup',label(parsetext("%c\nPagina web de soporte: \n\n%bhttp://dicci.alturl.com/ \n"))),,
MakeObj(,'HBar',),MakeObj(,'HBar',),MakeObj("a99",'HGroup',button("aclose","Cerrar")),MakeObj(,'HBar',),MakeObj(,'HBar',))
    res=NewObj("window","awin")
    if res~=0 then call ER("No pude crear todas las ventanas!")
    call Add("app","awin")

	bwin.ID="BWIN";lev.ShowMe=0;lev.isnumeric=1;lev.ObjectID=1234
	bwin.contents="bgroup";bsend.fixwidth=5;bs.ObjectID=111;bf.ObjectID=101
	call child "bgroup",MakeObj(,'hgroup',label(parsetext("%c
Si los resultados de un diccionario no \n
aparecen, o no se ven correctamente...\n
puede usar esta opcion para comunicarme,\n
via email, cual es el que no funciona bien.\n%b
por favor, no use esto a la ligera... gracias.")))
	call child "bgroup",MakeObj(,'hbar')
	call child "bgroup",MakeObj(,'hgroup',label(" SMTP: "),string("bs"),button("bsend","Enviar"))
	call child "bgroup",MakeObj(,'hgroup',label("Desde: "),string("bf",,))
	call child "bgroup",MakeObj(,'hgroup',label(" Fallo:  "),MakeObj("bd","cycle","Lengua|Sinónimos/Antónimos|English - Spanish|Español - Inglés|Français - Espagnol|Español - Francés|Català - Castellà|Castellano - Catalán|English - Spanish (Collins)|Español - Inglés (Collins)|Castellano-Euskera|Euskera-Castellano|Conjugaciones|Modismos|R.A.E.|Informático|Médico|Corrector|Corpus|Traductor","n"))
	call child "bgroup",MakeObj(,'hgroup',label(" Nota: "),string("bn"),string("lev",,0))

    res=NewObj("window","bwin")
    if res~=0 then call ER("No pude crear todas las ventanas!")
    call Add("app","bwin")

    call notify("bwin","CloseRequest",1,"bwin","set","open",0)
    call notify("mwin","CloseRequest",1,"app","ReturnID","QUIT")
    call notify("exe","pressed",0,"app","return","run")
    call notify("corr","pressed",0,"app","return","corre")
    call notify("corpus","pressed",0,"app","return","contxt")
    call notify("tra","pressed",0,"app","return","traducir")
    call Notify("bus","Acknowledge","Everytime","app","return","run")
    call Notify("file","Acknowledge","Everytime","app","return","corre")
    call Notify("corw","Acknowledge","Everytime","app","return","contxt")
    call Notify("tot","Acknowledge","Everytime","app","return","traducir")
    call notify("izq","pressed",0,"app","return","cacheb")
    call notify("der","pressed",0,"app","return","cachef")
    call notify("aclose","pressed",0,"awin","set","open",0)
    call notify("bsend","pressed",0,"app","return","sbug")
    call Notify "html","ClickedURL","EveryTime","cdata","set","contents","triggervalue"
    call Notify "html","ClickedURL","EveryTime","app","return","run"
    call Notify "html","virtgroupheight","everytime","sbv","set","entries","triggervalue"
    call Notify "html","virtgrouptop","everytime","sbv","set","first","triggervalue"
    call Notify "html","height","everytime","sbv","nonotifyset","visible","triggervalue"
    call Notify "sbv","first","everytime","html","set","virtgrouptop","triggervalue"
    call Notify("mabout","menutrigger","everytime","awin","set","open",1)
    call Notify("maboutrxmui","menutrigger","everytime","_app","aboutrxmui","win")
    call Notify("maboutmui","menutrigger","everytime","_app","aboutmui","win")
    call Notify("mhide","menutrigger","everytime","_app","set","iconified",1)
    call Notify("mquit","menutrigger","everytime","_app","returnid","quit")
    call notify("mmui","MenuTrigger","Everytime","app","OpenConfigWindow")
    call notify("mcorr","Checked","Everytime","spell","set","ShowMe","triggervalue")
    call notify("mcont","Checked","Everytime","contexto","set","ShowMe","triggervalue")
    call notify("mtra","Checked","Everytime","trad","set","ShowMe","triggervalue")
    call Notify("mupdate","menutrigger","everytime","_app","return","update")
    call Notify("mbug","menutrigger","everytime","bwin","set","open",1)
    call ProgDir()
    call DoMethod("app","load","env")
    level=xget("lev","contents")+1
    call set("lev","contents",level)
    call DoMethod("app","save","envarc")
    call DoMethod("app","save","env")
    call set("izq","disabled",1)
    call set("der","disabled",1)
    call set("mwin","open",1)
    call getattr("mwin","open","o")
    if o=0 then call er("No puedo abrir la ventana!")
    do forever
        call NewHandle("APP","H",2**12)
        if and(h.signals,2**12)>0 then exit
        select
	WHEN h.event="QUIT" THEN DO
            call DoMethod("app","save","envarc")
            call DoMethod("app","save","env") ;  ExiT ; END
	WHEN h.event="run" THEN call dicci()
	WHEN h.event="corre" THEN call corregir()
	WHEN h.event="contxt" THEN call bctxt()
	WHEN h.event="traducir" THEN call trans()
	WHEN h.event="cacheb" then do
		if i>1 then do;i=i-1
		call domethod("html","GoToURL","file://"temp.i)
		call domethod("html","Reload")
		call set("der","disabled",0)
		if i<=1 then call set("izq","disabled",1);end;END
	WHEN h.event="cachef" then do
		call set("izq","disabled",0)
		i=i+1;if exists(temp.i) then do
		call domethod("html","GoToURL","file://"temp.i)
		call domethod("html","Reload");i=i+1
		if ~exists(temp.i) then call set("der","disabled",1);i=i-1;end;END
	WHEN h.event="update" then call update()
	WHEN h.event="sbug" then call enviarbug()
	OTHERWISE NOP
        end
    end

dicci:
usa=xget("uso","Active");pal=xget("bus","contents")
if pal='' then do;call nfo("Debe introducir una palabra....");return;end
if words(pal)>1 then pal=translate(pal,"+"," ")
cdat=xget("cdata","contents");if cdat~='' then do;len=length(cdat);pos=pos('=',cdat);pos=len-pos;if usa=13 then pal="&word="||right(cdat,pos);else pal=right(cdat,pos);call set("cdata","contents","");END
i=i+1;temp.i=CreateTempFile();call open(file,temp.i,"W");SELECT
WHEN usa='8' |usa='9' then do;call Collins();return;end
WHEN usa="10" |usa="11" then do;call euca();return;end
WHEN usa="12" then do;call conju();return;end
WHEN usa="13" then do;call mods();return;end
WHEN usa='14' then do;call drae();return;END
WHEN usa='15' then do;call infort();return;end
WHEN usa='16' then do;call medico();return;end;OTHERWISE nop;END
dir='www.diccionarios.com';if conn(dir)>0 then return;SELECT
WHEN usa='0' THEN tomo="dgle"
WHEN usa='1' THEN tomo="sinonim"
WHEN usa='2' THEN tomo="engesp"
WHEN usa='3' THEN tomo="espeng"
WHEN usa='4' THEN tomo="fraesp"
WHEN usa='5' THEN tomo="espfra"
WHEN usa='6' THEN tomo="catesp"
WHEN usa='7' THEN tomo="espcat";END
Call Write("GET /index.phtml?diccionario="||tomo||"&query="||pal||"&acepciones=15 HTTP/1.0")
Call Write("Cookie: cookiedic=dc3cc9e5ffb71c8; PHPSESSID=2976e7203a366215293cf81a70bb830e; last_sess=2976e7203a366215293cf81a70bb830e")
if req()>0 then return;z=0;do until stat==0;stat=RecvLine(sock,"BUF")
if pos('Failed: Too many connections',buf)>0 then call writeln(file,buf)
if pos('<td colspan="2" valign="top">',buf)>0 then do
do until pos('<table width="508" border="0" cellpadding="0" cellspacing="0">',buf)>0|POS('<table width="500" border="0">',buf)>0|stat==0
stat=RecvLine(sock,"BUF");buf=replace(buf,"00"x,"")
call writeln(file,buf);end;z=1;stat=0;end;END;call fin()
return

euca:
dir="www1.euskadi.net";if conn(dir)>0 then return
if usa=10 then Call Write("GET /cgi-bin_m33/DicioIe.exe?IdiomaEntrada=CAS&Idioma=EUS&Txt_Castellano="||pal" HTTP/1.0")
else Call Write("GET /cgi-bin_m33/DicioIe.exe?IdiomaEntrada=EUS&Idioma=CAS&Txt_Euskera="||pal" HTTP/1.0")
if req()>0 then return;DO UNTIL stat==0;stat=recvLine(sock,"BUF")
if pos("<TD ALIGN='CENTER' COLSPAN='2' HEIGHT='20'></TD>",buf)>0|pos("  <TD ALIGN='LEFT'>",buf)>0 then do
do until pos("</TABLE>",buf)>0|pos("<TD ALIGN='CENTER' COLSPAN='2' HEIGHT='20'></TD>",buf)>0|stat==0
stat=recvLine(sock,"BUF");if pos(" hitza ez da aurkitu, aukeratu bat zerrendatik.</FONT>",buf)>0 | pos('No se ha encontrado la palabra',buf)>0 then do;call writeln(file,"--><html><body>"nosta()"</body></HTML><!--");stat=0;end
call writeln(file,buf);end;stat=0;end;end
call fin()
RETURN

conju:
dir="dlc.rae.es";if conn(dir)>0 then return
call write("GET /verba/servlet/conjuga?verbo="||pal||"&ec=UTF-8&ct=1038371855919&dt=79565&cf=conjugar&rdns=%28%29&ipaddress=%28%29 HTTP/1.0")
call write("Referer: http://dlc.rae.es/verba/index.jsp");if req()>0 then return;DO UNTIL stat==0;stat=recvLine(sock,"BUF")
if pos('<BODY BGCOLOR=WHITE>',upper(buf))>0 then do;do until pos('<HR>',buf)>0|stat=0;stat=recvLine(sock,"BUF");if left(buf,16)="<P class=rae2><A" then stat=recvLine(sock,"BUF")
call writeln(file,buf);end;end;end;call fin()
RETURN

mods:
dir="www.latin-connection.com";if conn(dir)>0 then return
call write("GET /spanish/modismo.cgi?query="||pal||"&lang=spanish HTTP/1.0")
if req()>0 then return
DO UNTIL stat==0;stat=recvLine(sock,"BUF");parse var buf buf"00"x
if pos('<hr ',buf)>0 then do;str=""
if left(pal,1)="&" then buf=translate(buf,,"=")
str=str||right(buf,length(buf)-pos('<hr ',buf)-5)
do until stat=0
stat=recvLine(sock,"BUF");parse var buf buf"00"x
if left(pal,1)="&" then buf=translate(buf,,"=")
str=str||buf
if pos('<HR ',buf)>0 then LEAVE
end;str=left(str,pos('<HR ',str)-1)
if left(str,12)="<br />No hay" then call writeln(file,nosta())
else call writeln(file,str)
end;end;drop str;call fin()
RETURN

drae:
if exists("libs:rxlibnet.library") THEN if AddLibrary("rxlibnet.library")=0 THEN pal=URLEncode(pal)
dir="buscon.rae.es";if conn(dir)>0 then return;str=""
Call Write("GET /draeI/SrvltGUIBusUsual?TIPO_HTML=2&LEMA="||pal" HTTP/1.0");if req()>0 then return
DO UNTIL stat==0;stat=recvLine(sock,"BUF")
if pos('error en el direccionamiento',buf)>0 then call writeln(file,"<br><br><br><B>Ha habido un error interno... probablemente el enlace que pulsó redireccionaba a la misma pagina...</B>")
if pos('La palabra consultada no est&aacute; en el Diccionario',buf)>0 then call writeln(file,nosta())
if pos('<TITLE>RAE. Usual. Resultado de Listado de Usual</TITLE></head>',buf)>0 then do
stat=recvLine(sock,"BUF");len=Length(buf)-170;buf=right(buf,len);if left(buf,1)~="<" then buf="<lol"buf;call writeln(file,purify(buf))
do until stat==0;stat=recvLine(sock,"BUF");buf=purify(buf);str=str||buf;END;stat=0;end;end;call writeln(file,str);DROP str;call fin()
return

infort:
dir="www.lawebdelprogramador.com";if conn(dir)>0 then return
Call Write("GET /diccionario/buscar.php?cadena="||pal||"&y= HTTP/1.0");if req()>0 then return
DO UNTIL stat==0;stat=recvLine(sock,"BUF")
if pos('<a href="mostrar.php?letra=Z"><font color="#ffffff">Z</font></A>',buf)>0 then do
do until POS("</td></tr></table><BR><p><table width=100% border=0 cellspacing=0 cellpadding=0 bgcolor='#5b62a0'>",buf)>0|POS('<table border=0 width=780 cellspacing=0 cellpadding=0>',buf)>0|stat==0
if left(buf,55)='</tr></table>No hay ninguna coincidencia con la palabra' then call writeln(file, "<html><BODY>"nosta()"</body></html>")
stat=recvLine(sock,"BUF");parse var buf buf"00"x;call writeln(file,buf);END;stat=0;end;end;call fin()
return

medico:
dir="www.buenasalud.com";if conn(dir)>0 then return
Call Write("GET /dic/DicSearchResults.cfm?search="||pal" HTTP/1.0");if req()>0 then return
DO UNTIL stat==0;stat=recv(sock,"BUF",256)
if POS('<TR><TD COLSPAN=2>',buf)>0 then stat=recvLine(sock,"BUF")
IF POS('<tr><td colspan="3">&nbsp;</td></tr>',buf)>0 then do;str=right(buf,20);if left(str,1)~="<" then str="<"||str;call writeln(file,str);str=""
do until POS('<TR><TD COLSPAN 2>',buf)>0|stat==0;stat=recvLine(sock,"BUF");buf=translate(buf,"","=");buf=replace(buf,"00"x,"");str=str||replace(buf,"79%",);end;stat=0;END;end
if pos('_blank">Bibliomed, Inc. </a',str)>0 then call writeln(file,nosta());else call writeln(file,str);call fin()
return

corregir:
lang=xget("cc","Active");pal=xget("file","contents")
if pal ='' then do;call nfo("Debe introducir una palabra....");return;end
if words(pal)>1 then pal=translate(pal,"+"," ");SELECT
WHEN lang=0 THEN lang="spanish";WHEN lang=1 THEN lang="english"
WHEN lang=2 THEN lang="german";WHEN lang=3 THEN lang="french"
END;i=i+1;temp.i=CreateTempFile();call open(file,temp.i,"W")
dir="www.datsi.fi.upm.es";if conn(dir)>0 then return
call write("GET /~coes/interactivo/palabra.cgi?palabra="||pal||"&idioma="||lang" HTTP/1.0"||cr);if req()>0 then return
do until stat==0;stat=recvline(sock,"BUF",256)
if pos('<HR>',buf)>0 then do;do until pos('<H5>',buf)>0|stat==0
stat=recvline(sock,"BUF",256);call writeln(file,buf);end;v=1;end
if v==1 then leave;end;v=0;call fin()
RETURN

bctxt:
corp=xget("cont","Active");pal=xget("corw","contents")
if pal ='' then do;call nfo("Debe introducir una palabra....");return;end
if words(pal)>1 then pal=translate(pal,"+"," ");SELECT
WHEN corp=0 THEN corp="quijote";WHEN corp=1 THEN corp="biblia";WHEN corp=2 THEN corp="cuentos"
WHEN corp=3 THEN corp="oral_adm";WHEN corp=4 THEN corp="oral_conv";WHEN corp=5 THEN corp="oral_hum"
WHEN corp=6 THEN corp="oral_ins";WHEN corp=7 THEN corp="oral_jur";WHEN corp=8 THEN corp="oral_per"
WHEN corp=9 THEN corp="oral_tec";WHEN corp=10 THEN corp="per_cultura";END
i=i+1;temp.i=CreateTempFile();call open(file,temp.i,"W")
dir="www.datsi.fi.upm.es";if conn(dir)>0 then return
call write("GET /~coes/interactivo/contexto.cgi?palabra="||pal||"&corpus="||corp" HTTP/1.0"||cr);if req()>0 then return
do until stat==0;stat=recvline(sock,"BUF",256)
if pos('<HR>',buf)>0 then do;do until pos('<H5>',buf)>0|stat==0
stat=recvline(sock,"BUF",256);call writeln(file,buf);end;v=1;end
if v==1 then leave;end;v=0;call fin()
RETURN

trans:
lang=xget("tol","Active");pal=xget("tot","contents")
if pal ='' then do;call nfo("Debe introducir una palabra....");return;end
if words(pal)>1 then pal=translate(pal,"+"," ");SELECT
WHEN lang=0 then lang="en_zh";WHEN lang=1 then lang="en_fr";WHEN lang=2 then lang="en_de";
WHEN lang=3 then lang="en_it";WHEN lang=4 then lang="en_ja";WHEN lang=5 then lang="en_ko";
WHEN lang=6 then lang="en_pt";WHEN lang=7 then lang="en_es";WHEN lang=8 then lang="zh_en";
WHEN lang=9 then lang="fr_en";WHEN lang=10 then lang="fr_de";WHEN lang=11 then lang="de_en";
WHEN lang=12 then lang="de_fr";WHEN lang=13 then lang="it_en";WHEN lang=14 then lang="ja_en";
WHEN lang=15 then lang="ko_en";WHEN lang=16 then lang="pt_en";WHEN lang=17 then lang="ru_en";
WHEN lang=18 then lang="es_en";END;i=i+1;temp.i=CreateTempFile();call open(file,temp.i,"W")
dir="babelfish.altavista.com";if conn(dir)>0 then return;str="doit=done&tt=urltext&urltext="pal"&lp="lang
trlen=length(str);call write("POST /babelfish/tr HTTP/1.0");TR=1;if req()>0 then return;do until stat==0;stat=recvline(sock,"BUF",8192);
if pos('class=s><Div style=padding:10px;>',buf)>0 then do;buf=purify(buf);call writeln(file,"<br><font size=2><B>"right(buf,length(buf)-(pos(':10px;>',buf)+6))"</b></font>");stat=0;end;end;call fin()
RETURN

Collins:
dir="wordreference.com";if conn(dir)>0 then return;str=""
if usa=8 then call write("GET /es/translation.asp?tranword="||pal" HTTP/1.0")
else call write("GET /es/en/translation.asp?spen="||pal" HTTP/1.0");if req()>0 then return
do until stat==0;stat=recvline(sock,"BUF");if left(buf,11)="We found no" then do;str=nosta();stat=0;end
if pos('Source: The Collins ',buf)>0 then do;do until pos('</SPAN>',buf)>0|stat==0;stat=recvline(sock,"BUF");parse var buf buf"00"x;
str=str||buf;if left(buf,11)="We found no" then do;str=nosta();stat=0;end;end;stat=0;end;end;call writeln(file,str);drop str;call fin()
RETURN

conn:
if IsLibOn()=="" then do;call nfo("%0No esta conectado a Internet!");return 1;end;call nfo("Conectando...")
sin.ADDRFAMILY='INET';sin.ADDRPORT=80;sin.ADDRADDR=resolve(arg(1));sock=socket('INET','stream','TCP')
  if sock<0 then do;call nfo("No hay socket ("errno()") : "errorstring(errno())")");return 1;end
  if connect(sock,'SIN')<0 then do;call nfo("Error conectando ("errno()") : "errorstring(errno())".");call closeSocket(sock);return 1;end
call nfo("Enviando peticion...")
RETURN 0

write:
len = send(sock,arg(1)||cr)
if len<0 then do;call nfo("Error enviando ("errno()") : "errorstring(errno()));call CloseSocket(sock);return;end
RETURN

read:
len = recvLine(sock,"BUF")
if len<0 then do;call nfo("Error ("errno()") : "errorstring(errno()));call CloseSocket(sock);return;end
RETURN

nfo:
call set("gauge","infotext",parsetext("%n%b%c%5"arg(1)))
return

req:
Call Write("User-Agent: MSIE/8.0; (spOOfEd bY Dicci v1.9.1 ©2002 By Diego Casorran <dcr8520@amiga.org> [AmigaOS] )")
Call Write("Accept: */*;q=1.0");Call Write("Host: "dir)
Call Write("Referer: http://"||dir);if TR~=1 then Call write();else do
call write("Content-Type: application/x-www-form-urlencoded")
call write("Content-Length: "trlen);call write(cr||str||cr);TR=0;end
stat=recv(sock,"BUF",16);IF Word(buf,2)~="200" THEN DO;call nfo("Error del Servidor: "buf);Call CloseSocket(sock);RETURN 1;END
call nfo("Recibiendo resultados...");call writeln(file,'<html><body><table border="0" width="100%"><tr><td>')
return 0

fin:
call writeln(file,"</td></tr></table></body></html>");call close(file)
call domethod("html","GoToURL","file://"temp.i)
call domethod("html","Reload");call CloseSocket(sock)
t=random(1,20,time('s'));SELECT
WHEN t=1 THEN tag='"Nunca puedes planear el futuro a través del pasado."'
WHEN t=2 THEN tag='"Pensar es mas interesante que saber, pero menos interesante que mirar."'
WHEN t=3 THEN tag='"La manera de hacer es ser."'
WHEN t=4 THEN tag='"Invertir en conocimientos produce siempre los mejores intereses."'
WHEN t=5 THEN tag='"La superstición trae mala suerte..."'
WHEN t=6 THEN tag='"El peligro es el gran remedio para el aburrimiento."'
WHEN t=7 THEN tag='"Lo que no comprendemos no lo poseemos."'
WHEN t=8 THEN tag='"Nunca es definitivo el éxito, ni perenne el fracaso."'
WHEN t=9 THEN tag='"En la tragedia solo conmueve lo verosimil."'
WHEN t=10 THEN tag='"El ayer es experiencia, y el mañana, esperanza."'
WHEN t=11 THEN tag='"Hablar sin pensar es como disparar sin apuntar."'
WHEN t=12 THEN tag='"¿Cuál es la tarea mas difícil del mundo?... Pensar."'
WHEN t=13 THEN tag='"Desdichado es el que por tal se tiene."'
WHEN t=14 THEN tag='"Que fácil es empujar a la gente... Pero que difícil guiarla."'
WHEN t=15 THEN tag='"El que no pueda guardar sus pensamientos, jamás sabrá analizar grandes cosas."'
WHEN t=16 THEN tag='"La sabiduría es un tesoro que nunca causa entorpecimientos."'
WHEN t=17 THEN tag='"Mayor es el peligro cuando mayor es el temor."'
WHEN t=18 THEN tag='"No basta adquirir la sabiduría, es preciso usarla."'
WHEN t=19 THEN tag='"Todo está dicho, pero como nadie escucha..."'
WHEN t=20 THEN tag='"La teoría en la práctica es otra..."'
END;call nfo("%n%3"tag);if i>1 then call set("izq","disabled",0);call set("der","disabled",1)
return;nosta:;RETURN "<br><br><br><B>El término <FONT color=#3333FF>"translate(pal," ","+")"</FONT> no ha sido encontrado en el diccionario.</B>"

update:
if ~open(1,"tcp:amiga.sourceforge.net/80","RW") then do;call nfo("No pude conectar!");return;end;call nfo("Comprobando version...")
call writeln(1,"GET /dicciver HTTP/1.0");call writeln(1,"Host: amiga.sourceforge.net"||'a'x)
if word(readln(1),2)~=200 then do;call nfo("Comprobacion de version fallida...");return;end
do forever;if readln(1)=="0D"x then LEAVE;end;version=readln(1);call close(1)
if version=="1.9.1" then do;call nfo("%3Ya está usando la ultima version.");return;end
call nfo("%0Version "version" disponible,%i  descargando... ")
if ~open(1,"TCP:193.190.198.97/80","RW") then do;call nfo("No he podido descargar el archivo...");return;end
call open(2,"ram:dicci.lha","W")
call writeln(1,"GET /sourceforge/amiga/dicci-upd.lha HTTP/1.0"'0a'x)
x=readln(1);if word(x,2)~=200 then do;call nfo("No he podido descargar el archivo....");return;end;actu=0
do forever;z=readln(1);parse var z z"0d"x
IF LEFT(z,16)="Content-Length: " THEN total=delstr(z,1,16)
if z="" then leave;end
do until eof(1);actu=actu+WRITECH(2,READCH(1,1024))
call nfo("%0"actu" bytes de un total de "total" descargados...")
end;call close(1);call close(2);
if ~exists("c:lha") then do;call nfo("No se encontro C:LHA, instalacion abortada...");return;end
call nfo("Instalando, por favor espere...");epath=realname("");if right(epath,1)~=":" then epath=epath||"/"
call system('c:lha <>NIL: -x2 e ram:dicci.lha 'epath)
call nfo("%3Instalacion concluida, reinicie el programa...")
RETURN

enviarbug:
smtp=xget("bs","contents");from=xget("bf","contents");bdicci=xget('bd','activeentry')
if msg==bdicci then call er("OTRA VEZ ME QUIERES MANDAR EL MISMO MSG??... xP")
if smtp="" | from="" then do;call nfo("ES NECESARIO QUE RELLENE TODOS LOS CAMPOS...");RETURN;END
smtp=resolve(smtp);if smtp==-1 then do;call nfo("EL SERVIDOR SMTP NO ES VALIDO !!");RETURN;END
sin.ADDRFAMILY='INET';sin.ADDRPORT=25;sin.ADDRADDR=smtp;sock=socket('INET','stream','TCP')
call nfo("Conectando a: "smtp)
  if sock<0 then do;call nfo("No hay socket ("errno()") : "errorstring(errno())")");return 1;end
  if connect(sock,'SIN')<0 then do;call nfo("Error conectando ("errno()") : "errorstring(errno())".");call closeSocket(sock);return 1;end
call nfo("Enviando aviso...")
call read();if word(buf,1)~=220 then do;call nfo("error del servidor: "buf);return;end
call write("HELO www."getvar(username)".com")
call read();if word(buf,1)~=250 then do;call nfo("error del servidor: "buf);return;end
call write("MAIL FROM: "from)
call read();if word(buf,1)~=250 then do;call nfo("error del servidor: "buf);return;end
call write("RCPT TO: dcr8520@wanadoo.es")
call read();if word(buf,1)~=250 then do;call nfo("error del servidor: "buf);return;end
call write("DATA")
call read();if word(buf,1)~=354 then do;call nfo("error del servidor: "buf);return;end
call write("X-Mailer: Dicci v1.9.1 (User: "getvar(realname)"  UserHost: "getvar(hostname)"  UserLevel: "level")")
call write("Subject: PROBLEMA CON EL DICCIONARIO: "bdicci)
call write(xget("bn","contents"))
call write(".");call closeSocket(sock);msg=bdicci
call nfo("Aviso enviado,  Muchas Gracias! :-)")
RETURN

er:
call EasyRequest(arg(1),"Dicci","oK")
halt:
break_c:
    exit

purify:
parse arg buf
buf=replace(buf,"00"x,"");buf=replace(buf,"8e"x,"");buf=replace(buf,"81"x,"")
buf=replace(buf,"8d"x,"");buf=replace(buf,"89"x,"");buf=replace(buf,"b6"x,"")
buf=replace(buf,"Ã³","ó");buf=replace(buf,"Ã¡","á");buf=replace(buf,"Ã©","é")
buf=replace(buf,"Ãº","ú");buf=replace(buf,"Ã­","í");buf=replace(buf,"E2B7"x,"");
buf=replace(buf,"Ã±","ñ");
RETURN buf

REPLACE: procedure
parse arg src, old, new
if pos(old, src) > 0 then do
   parse var src left(old)right
   return left||new||replace(right, old, new)
end
return src
