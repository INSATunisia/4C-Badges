#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "You need two arguments: file path, and assertion type (entrep, soft, tech)"
    exit 1
elif [[  $2 -ne "entrep" && $2 -ne "soft" && $2 -ne "tech" ]]; then
	echo "Second argument must be one of these (entrep, soft, tech)"
    exit 1
fi


today=$(date +"%Y-%m-%d")

email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"
badge_file="https://badges.lilisfaxi.now.sh/json/entrep-badge.json"

if [[ $2 -eq "soft" ]]; then
   badge_file="https://badges.lilisfaxi.now.sh/json/soft-badge.json"
elif [[ $2 -eq "tech" ]]; then
   badge_file="https://badges.lilisfaxi.now.sh/json/tech-badge.json"
fi



while read line
do
    name=$line
    login="$(cut -d'@' -f1 <<<$name)"
    id_assertion=$login"-"$2"-"$today
    file="json/generated/"$id_assertion".json"

	if [[ $name =~ $email_regex ]] ; then
		echo "{\"uid\": \""$id_assertion"\", 
		  \"recipient\": {	
		    \"type\": \"email\",	
		    \"identity\": \""$name"\",	
		    \"hashed\": false	
		  },	
		  \"issuedOn\": \""$today"\",	
		  \"badge\": \""$badge_file"\",	
		  \"verify\": {	
		    \"type\": \"hosted\",	
		    \"url\": \"https://badges.lilisfaxi.now.sh/json/generated/"$id_assertion".json\"	
		  }	
		}" > $file
		
	    echo "OK"
	else
	    echo $name": this is not a valid email!"
	fi
done < $1;
