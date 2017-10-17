docker build -t docker-aws --build-arg http_proxy="http://$SUSER:$SPASS@proxyurl:8080" --build-arg https_proxy="http://$SUSER:$SPASS@proxyurl:8080" --build-arg no_proxy="noproxy1,noproxy2" .
