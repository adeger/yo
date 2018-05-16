#! /bin/bash
# quickie for adding ingress cidr to the bastion security group
#   $1 = ingress cidr

# TODO: make this so that another argument is the vpc to be used and then query the security groups
# for tag, etc to get the group-id instead of the hard-coded one below
arg="${1}"

if [[ ${arg} == "-h" ]]; then
    echo Printing help
    echo -e '

add_bastion_ingress_cidr.sh - add a cidr to the bastion aws security group

  add_bastion_ingress_cidr.sh [-h|-m|cidr]

   -h = this screen
   -m = (mine) a 32 bit masked cidr for the host that the script is run from
   -c cidr = an (unchecked) cidr of the form xxx.xxx.xxx.xxx/yy

   Note: this program uses the CLI AWS utility and needs ~/.aws or enviroment
         key variable authentication!
'
  exit
elif [[ ${arg} == "-m" ]]; then
    cidr="$(echo $(curl ifconfig.co)/32)"
elif [[ ${arg} == "-c" ]]; then
    cidr=${2}
fi
echo Adding: ${cidr}

aws ec2  authorize-security-group-ingress --group-id sg-ef245891 --protocol tcp --port 22  --cidr ${cidr}
error=$?
if [[ $error != 0 ]]; then
  echo "Errors.  Make sure you are using switches '-h', '-m' or '-c some_cidr'" >&2
fi
exit $error

