echo "Using in MSYS2" 
./Configure mingw64 --prefix=/home/admin/openssl3-shared --with-zlib-include=/home/admin/openssl3-shared/zlib -shared threads zlib zlib-dynamic no-docs && make -j 20 && make install
