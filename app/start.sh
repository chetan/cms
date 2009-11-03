DIR=`dirname $0`
thin start -R $DIR/server.ru
