sudo docker volume create \
  --driver local \
  --opt type=none \
  --opt device=/mnt/docker-volumes/keydb-flash \
  --opt o=bind \
  keydbflash

sudo docker rm -f keydb;
sudo docker volume rm keydbflash;
sudo docker volume create keydbflash;
sudo docker run -d -it -p 6379:6379 --name keydb -v $(pwd)/lib:/modules \
--mount dst=/flash,src=keydbflash \
eqalpha/keydb:x86_64_v6.3.4 keydb-server /etc/keydb/keydb.conf \
--storage-provider flash /flash --maxmemory 500M --maxmemory-policy allkeys-lfu \
--loadmodule /modules/rejson.so \
--loadmodule /modules/redistimeseries.so \
--loadmodule /modules/redisearch.so \
--loadmodule /modules/tickstore.so


