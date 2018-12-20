#!/bin/bash
#if [ -z "$(ls public/wp-content/uploads)" ]; then
#   unzip -u build/develop/uploads.zip
#fi

#cp build/develop/wp-config.php public/wordpress

the_host=multisite.test
the_host2=site1.multisite.test

docker-compose up -d --build

make_host_entry() {
    if grep -q $1 /etc/hosts; then
        echo "Host entry exists"
    else
        echo "127.0.0.1 $1"  | sudo tee -a /etc/hosts > /dev/null
        echo "Added new host entry"
    fi
}

make_host_entry $the_host
make_host_entry $the_host2

echo "Webserver started at http://$the_host"