#!/bin/sh
# Elimina un  usuario.
# Dominio p�blico.  Dedicado a Dios. 2005. vtamara@pasosdeJesus.org

# Ejemplo de uso:
# ./elimusuario.sh pablo

usuario="$1"

. ./DN.sh
if (test "$usuario" = "") then {
	die "Falta usuario como primer par�metro";
} fi;

if (test -h /home/$usuario) then {
	userdel -r $usuario;
	rm /home/$usuario
} fi;

ldapdelete -v -P 2 -H ldap://$serv:389 -w $claveLDAP \
  -D "cn=Manager,$dn" \
  -x  "uid=$usuario,ou=gente,$dn"

