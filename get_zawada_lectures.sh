#!/bin/bash

#Created by Albert Piekielny
#$1 link to presentation
#$2 output director
# ex : ./get_zawada_lectures.sh https://cs.pwr.edu.pl/zawada/kwjp/download/20200313/#/ ./wyk3/				<- directory ends with "/"
# or  ./get_zawada_lectures.sh https://cs.pwr.edu.pl/zawada/kwjp/download/20200313/#/ ./wyk3/ pdf     <- it automatic create pdf file
# NOTE : if pdf is not created please go to /etc/ImageMagick-${your_version} and in file "policy.xml" comment line    <policy domain="coder" rights="none" pattern="PDF" />
# comment line    <policy domain="coder" rights="none" pattern="PDF" />  like that  <!-- <policy domain="coder" rights="none" pattern="PDF" /> -->


if [[ $# -lt 2 ]]; then
	echo "Missing link to scaning '$1' or output directory '$2'";
	exit 1;
fi

login="244951"					#your login to zawada page
password="41kHRSgCNH"		# -- || -- password

if [[ ${#login} -lt 6 || ${#password} -lt 1 ]]; then
	echo "Please assign correct login and password to variables";
	exit 1;
fi
	
auth=`echo -n "$login:$password" | base64`
correctLink=${1%#*}
wget --header="Authorization: Basic $auth" -c -O index.html $1 
targets=($(grep -o -i '[[:alnum:]]*\.png' index.html))

arraylength=${#targets[@]}
for (( i=0; i<${arraylength}; i++ )); do
   wget --header="Authorization: Basic $auth" -q -c -O "$2$i.png" "$correctLink${targets[$i]}"
	 echo -e "\033[1m\e[34mDownloaded ${targets[$i]} as $i.png \e[39m"
	 targets[$i]="$2$i.png"
done

rm index.html

if [ "$3" = "pdf" ]; then
	  convert $(echo ${targets[@]} | sort -g) $2$(date +'%H_%M_%S')_output.pdf
	  rm $(echo ${targets[@]} | sort -g)
fi
