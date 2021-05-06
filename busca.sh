#!/bin/sh
#  Busca todos o un usuario en una base LDAP
# Dominio público. 2005. vtamara@pasosdeJesus.org

. ./DN.sh

n=$1;

if (test "$tls" = "1") then {
  iniord="ldapsearch -Z "
} else {
  iniord="ldapsearch "
} fi;
if (test "$n" = "")  then {
  echo "vaio"
  cmd="$iniord -x -b $dn '(objectclass=*)'"
} 
else {
  cmd="$iniord -P 3 -H $host -W  \
    -D \"$cn\" \
    -x -b \"$grupo\" \
    \"(&(objectclass=posixAccount)(uid=$n))\"";
  cmd="$iniord -P 3 -H $host -W  \
    -D \"$cn\" \
    -x -b \"$grupo\" \
    \"(&(objectclass=inetOrgPerson)(uid=$n))\"";
} fi;

echo $cmd;
eval $cmd;


