source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $GZIP_VERSION.tar.xz
cd $GZIP_VERSION

./configure --prefix=/usr --host=$LFS_TGT

make -j$JOBS
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/gzip $LFS/bin
