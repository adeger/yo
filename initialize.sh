# Run this file (by sourcing) to initialize a deployment host for deployment of the
# awesome yo service
#
# Requires: python 2.7, pip
# 
# TODO: implement good cli switch handling with argparse


function help(){
  echo '
initialize - initializes a directory for interactive yo app managemnt

. initialize [--help|--vault]

  --help : this help screen
  --with_vault : Add vault secrets file to ~/.ssh 
                (only needed once or if password changes)

  Notes: run with --with_vault only the first time or if the
         Ansible vault password changes
'
}

# declare various vars
registry_name="yo-registry"
vault_password_file="${HOME}/.ssh/vault_password.txt"

# handle help argument
if [[ $1 == '--help' ]]; then
  help
  exit 0
fi

# make sure we are sourced
if [[ $0 == ${BASH_SOURCE} ]]; then
    echo "Script must be sourced (e.g. 'source initialize.sh')" >&2
    kill -INT $$
fi

# make sure we are local
if [[ "${BASH_SOURCE}" == 'initialize.sh'  || "${BASH_SOURCE}" == 'initialize.sh' ]]; then
    echo "local"
else
    echo "not local"
fi

echo -e "\nDeactivating any virtual environments"
deactivate 2> /dev/null

echo Ensure Ansible and boto installed
sudo pip install ansible
sudo pip install boto
sudo pip install boto3


if [[ $1 == "--with_vault" ]]; then
  echo "Setting up vault password file in ~/.ssh..."
  echo "Enter the vault password: "
  read -s vault_password
  echo ${vault_password} > ${vault_password_file} 
  chmod 400 ${vault_password_file} || echo "Couldn't chmod ${vault_password_file}"
fi

echo -e "\nSetting up virtualenv"
pip install virtualenv

echo -e "\nInitializeing virtualenv in directory pyvirtual"
virtualenv pyvirtual

echo -e "\nexcluding the pyvirtual directory from git snooping"
grep -q pyvirtual .gitignore || echo pyvirtual >> .gitignore


. pyvirtual/bin/activate && echo -e "
============================================================================
Deactivate the pyvirtual virtualenv by typing 'deactivate' at command prompt
============================================================================
"

echo -e "\nPip installing other python necessaries"
pip install -r requirements.txt
