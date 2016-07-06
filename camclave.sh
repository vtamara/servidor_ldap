#!/bin/sh
# Cambia clave a un usuario
# Dominio público. 2005. vtamara@pasosdeJesus.org

. ./DN.sh
usuario="$1";
nuevaclave="$2";
if (test "$usuario" = "") then {
	die "Falta usuario como primer parámetro";
} fi;

if (test "$nuevaclave" = "") then {
	echo -n "clave: ";
	stty -echo; read nuevaclave; stty echo
} fi;

if (test "$nuevaclave" = "") then {
	echo "Falta clave";
	exit 1;
} fi;

t=`mktemp`;
cclave=`slappasswd -v -u -h {SHA} -s $nuevaclave`;
echo "dn:cn=$usuario,$grupo
changetype: modify
replace: userPassword
userPassword: $cclave
" > $t
echo $t
cat $t
#recode txt..UTF-8 $t
cmd="ldapmodify -x -D \"$cn\" -W -H $host -f $t"
echo "$cmd"
eval "$cmd"
if (test "$?" != "0") then {
	die "Problema cambiando clave";
} fi;
