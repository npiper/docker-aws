docker run -P -e "http_proxy=http://$SUSER:$SPASS@proxyurl:8080" -e "https_proxy=http://$SUSER:$SPASS@proxyurl:8080" -e "no_proxy=noproxy1,noproxy2" -e "AD_PASSWORD=$SPASS" -e "AD_USER=$SUSER" -v $(pwd):/home/working -d -t docker-aws bash


