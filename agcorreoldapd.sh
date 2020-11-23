#!/bin/sh
# Agrega una cuenta de correo.
# Dominio público.  Dedicado a Dios. 2016. vtamara@pasosdeJesus.org
# http://www.tumfatig.net/20150718/opensmtpd-dovecot-and-ldapd-on-openbsd-5-7/


# Ejemplo de uso:
# ./agcorreoldapd.sh pablo "Pablo" "Ramirez" estudiante facil
# Las posibles opciones como septimo parámetro son -sincuenta y -sinldap 
# para no crear cuenta o no ingresar datos en dir. LDAP.

usuario="$1"

. ./DN.sh

if (test "$usuario" = "") then {
  die "Falta usuario como primer parámetro";
} fi;

t=`mktemp`;
# Ponemos nombres y apellidos en cn porque es tipicamente usado en búsquedas
echo "
dn:cn=$usuario@$dcorreo,ou=aliases,$dn
rfc822MailMember: $usuario
cn: $usuario@$dcorreo
objectClass: nisMailAlias
" > $t
if (test "$depurar" = "1") then {
  echo $t
  cat $t
  read
} fi;
recode txt..UTF-8 $t
if (test "$depurar" = "1") then {
  echo "tras recode";
  cat $t
} fi;
./agldif.sh $t
if (test "$?" != "0") then {
  echo "Problema agregando $t de $usuario" > /dev/stderr
} fi;
if (test "$depurar" = "1" ) then {
  echo "fin de creación de cuentas LDAP";
} fi;

