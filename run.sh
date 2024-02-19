mkdir -p /keydb/flash;
chmod a+rw /keydb/flash;
docker run -d -it -p 6349:6379 \
--name keydb \
-v /keydb/flash:/flash \
anandanand84/keydb \
keydb-server /etc/keydb/keydb.conf \
--storage-provider flash /flash \
--maxmemory 100M \
--maxmemory-policy allkeys-lfu


# From direct image
sudo docker rm -f keydb;
sudo docker volume rm keydbflash;
sudo docker volume create keydbflash;
sudo docker run -d -it -p 6379:6379 --name keydb -v $(pwd)/lib:/modules \
--mount dst=/flash,src=keydbflash \
eqalpha/keydb keydb-server /etc/keydb/keydb.conf \
--storage-provider flash /flash --maxmemory 500M --maxmemory-policy allkeys-lfu \
--loadmodule /modules/rejson.so \
--loadmodule /modules/redistimeseries.so \
--loadmodule /modules/redisearch.so
