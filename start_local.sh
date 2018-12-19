#!/bin/bash
#if [ -z "$(ls public/wp-content/uploads)" ]; then
#   unzip -u build/develop/uploads.zip
#fi

#cp build/develop/wp-config.php public/wordpress

the_host=multisite.test

docker-compose up -d --build

if grep -q $the_host /etc/hosts; then
    echo "Host entry exists"
else
    echo "127.0.0.1 $the_host"  | sudo tee -a /etc/hosts > /dev/null
    echo "Added new host entry"
fi
echo "Webserver started at http://$the_host"