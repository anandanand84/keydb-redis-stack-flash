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
