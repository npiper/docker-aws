git clone http://$CHUCKUSER@chuck:7990/scm/buildeng/buildeng-sde-infra-prov.git


docker build -t iag-aws --build-arg http_proxy="http://$SUSER:$SPASS@proxy.auiag.corp:8080" --build-arg https_proxy="http://$SUSER:$SPASS@proxy.auiag.corp:8080" --build-arg no_proxy="chuck,*.auiag.corp" .
