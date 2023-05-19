
#!/bin/bash



export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH


rapiddns(){
curl -s "https://rapiddns.io/subdomain/$1?full=1" \
 | grep -oP '_blank">\K[^<]*' \
 | grep -v http \
 | sort -u
}




wlist_maker(){
        seq 1 400 > list.tmp
        echo $1 >> list.tmp
        seq 401 800 >> list.tmp
        echo $1 >> list.tmp
}


crtsh(){
curl -s https://crt.sh/\?q\=%25.$1\&output\=json | jq . | grep 'name_value' | awk '{print $2}' | sed -e 's/"//g'| sed -e 's/,//g' |  awk '{gsub(/\\n/,"\n")}1' | sort -u | grep -v '*'
}

fuf(){
ffuf -u $1/FUZZ -w ~/wordlist/directory/raft-large-directories -mc 200,301,302 -t 200 -D -e js,php,bak,txt,html,zip,sql,old,gz,log,swp,yaml,yml,config,save,rsa,ppk -ac
}


fufapi(){
ffuf -u $1/FUZZ -w ~/wordlist/files/apiwords.txt -mc 200 -t 200 -D -e js,php,bak,txt,html,zip,sql,old,gz,log,swp,yaml,yml,config,save,rsa,ppk -ac
}

x8(){
cd ~/tools
./x8/target/release/x8 -u $1 -m 25 -w ~/wordlist/parameter/param1
cd -
}


ipinfo(){
curl ipinfo.io/$1
}


dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,404,400,429 -t 200
cd -
}

dirapi(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,429,404,400 -t 200 -w 
cd -
}
fuffiles(){
ffuf -u $1/FUZZ -w ~/wordlist/files/raft-medium-files -mc 200,301,302 -t 200
}

fufdir(){
ffuf -u $1/FUZZ -w ~/wordlist/directory/raft-large-directories -mc 200,301,302,403 -t 200
}

dirsearch(){
cd ~/tools/dirsearch
sudo python3 dirsearch.py -u $1 -e htm,html,xml,js,json,zip,asp,aspx,php,bak,sql,old,txt,gz,gz.tar -x 301,502,404,400,429 -t 200
cd -
}

bypass(){
~/tools/4-ZERO-3/403-bypass.sh -u $1 --exploit
}

source "$HOME/.cargo/env"

linkfinder(){
python3 ~/tools/LinkFinder/linkfinder.py -i $1 -o cli
}

fufresult(){
cat * | jq -r '.results[] | "\(.length)"+ " " +"\(.url)" + " " +  "\(.status)"' | sort -unt " " -k "1,1"
}


fierce(){
python3 ~/tools/fierce/fierce/fierce.py --domain $1 --wide --traverse 10
}

ggospider(){
        host=$(echo $1 | unfurl format %d)
        gospider --site $1 --other-source --include-other-source --depth 3 --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15" --quiet --robots --sitemap --json | grep -v '\[url\]' | jq -r ".output" | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|mp4|flv|ogv|webm|webp |mov|mp3|m4a|m4p| ppt |pptx|scss|tif| tiff|ttf lott |woff|woff2|bmp|ico|eot|htc|swf|rtf|image)' | grep $host | sort -u | tee $host.gospider.txt
}


hiddenParam()
{
    # check if the  input is a file
    if [ -f "$1" ]; then
        # input is a file, check if it has value
        if [ -s "$1" ]; then
            # out has "
            if [ -f "$2" ]; then

                python3 ~/tools/hiddenParam.py -l $1 -o $2

            else
               
               python3 ~/tools/hiddenParam.py -l $1 -o outPut.txt
            fi
        
        else
            # file has no value"
            echo "list url is empty !!!!"
        fi
    else
        # input is not a file, check if it's a string
        if [ -n "$1" ]; then

            if [ -f "$2" ]; then

                python3 ~/tools/hiddenParam.py -u $1 -o $2

            else
               
               python3 ~/tools/hiddenParam.py -u $1 -o outPut.txt
            fi

        else
            # input is neither a file nor a string
            echo "Enter url !!!!!"
        fi
    fi
}





robofinder(){

    if [ $(wc -c < timestamp.txt) -eq 0 ]; then
        echo "$host is not correct"
    else
        cat timestamp.txt | while read line; do  curl -s  "https://web.archive.org/web/$line/$host/robots.txt" >> robot.txt;done

        cat robot.txt | grep -Eioh '^disallow:(\s?)(.*)' | sed "s|Disallow: |$host|g" >> robots.txt
        cat robot.txt | grep -Eioh "^allow:(\s?)(.*)" | sed "s|Allow: |$host|g" >> robots.txt
        cat robot.txt | grep -Ei "(Sitemap: |site-map: )" | sed "s/^Sitemap: //g" >> robots.txt
        cat robots.txt | grep -Eioh "^User-agent:(\s?)(.*)"
        cat robots.txt | sort | uniq > out-robofinder.txt
        rm -rf robot.txt
        rm -rf robots.txt
        rm -rf timestamp.txt
    fi
}


flinks(){

    if [ -z "$1" ]; then
        echo "Error: No value passed to function. Exiting."
        return 1
    fi
    host=$(echo $1 | unfurl domains)

    robofinder $1
    ggospider $1

 }

IP_ASN(){
  curl -s https://api.bqpview.io/ip/$1 | jq -r ".data.prefixes[] | {prefix: .prefix, ASN: .asn.asn}"
}

certificate_search(){

  host=$(echo $1 | unfurl format %r.%t)
  echo | openssl s_client -showcerts -servername $host -connect IP:443 2> /dev/null | openssl x509 -inform pem -noout -text
}

get_sub(){

        

	curl -s "https://www.abuseipdb.com/whois/$1" -H "user-agent: Chrome" | grep -E '<li>\w.*</li>'| grep -o '<li>.*</li>' | sed -e 's/<[^>]*>//g'| sed "s/$/.$1/g" 
}


crt_domain(){

	curl -s https://crt.sh/\?o\=$1\&output\=json| jq -r '.[].common_name' |sed 's/\*//g' | sort -u | rev | cut -d "." -f 1,2 | rev | sort -u 
  }


subParam(){

  file_name=$1

  if [ -s "$file_name" ]; then
    sort -u $file_name | rev | cut -d "." -f 3,4,5,6,7,8,9 | rev >> subParams.txt

    python_subParam subParams.txt 
    sort_subParma params.txt   subParams.txt

  else
    echo "File is empty or does not exist."
  fi

}
python_subParam(){
    python3 ~/tools/sub.py -l $1
}
sort_subParma(){
    
    sort -u $1 >> param.txt

    rm -rf $1
    rm -rf $2
}


email-domain()
{
    if [ -f "$1" ]; then
        # input is a file, check if it has value
        if [ $(wc -c < $1) -eq 0 ]; then
            echo "list url is empty !!!!"
            return 1
     
        else

            # file has value

            if [ -z "$2" ]; then
                echo "Error: No domain target passed to function. Exiting."
                return 1
            fi
            touch email-domains.txt
            for i in $(sort -u $1)
            do
               email=$(whois $(dig A +short $i) | grep "@" )
               if [[ $email == *"$2"* ]]; then
                    echo $i >> email-domains.txt
               fi
            done
          
        fi

    else
        # file does not exist
        echo "Please pass list of domain!!!!"
        return 1
    fi

}
crt_sub(){
   curl -s https://crt.sh/\?q=$1\&output\=json| jq -r '.[].common_name' |sed 's/\*//g' | sort -u | tee crt-$1-subs 
}
. "$HOME/.cargo/env"
