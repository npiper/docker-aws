TAG_NAME="aws:latest"
docker run -P -e "http_proxy=${http_proxy}" -e "https_proxy=${https_proxy}" -e "no_proxy=${no_proxy}" -e "AD_PASSWORD=$SPASS" -e "AD_USER=$SUSER" -v $(pwd):/home/working -d -t ${TAG_NAME} bash


