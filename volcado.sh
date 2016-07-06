#!/bin/sh
# Vuelca contenido completo de directorio LDAP a formato LDIF
# Dominio público. 2016. vtamara@pasosdeJesus.org
# Referencia:  http://www.tumfatig.net/20110112/backup-ldap-entries-with-ldapsearch/

. ./DN.sh

cmd="ldapsearch -H $host -W \
  -D \"$cn\" \
  -x -b \"$grupo\" \
  -LLL";

eval $cmd;



