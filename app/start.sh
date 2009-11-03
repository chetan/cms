DIR=`dirname $0`

# can use any of these to start

#thin start -R $DIR/server.ru
#rackup -s webrick $DIR/server.ru
#rackup -s mongrel $DIR/server.ru
rackup -s thin $DIR/server.ru
