#!/bin/sh
# Agrega informaci�n de un archivo LDIF al directorio LDAP
# Dominio p�blico. 2005. vtamara@pasosdeJesus.org

. ./DN.sh
ldif="$1";

if (test ! -f "$ldif") then {
	die "Falta archivo LDIF como primer par�metro";
} fi;

cmd="ldapadd -x -D \"$cn\" -W -H $host -f $ldif"
echo $cmd
eval $cmd
if (test "$?" != "0") then {
	die "Problema ejecutando $ldif";
} fi;
