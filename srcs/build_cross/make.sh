source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $MAKE_VERSION.tar.gz
cd $MAKE_VERSION

./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j$JOBS
make DESTDIR=$LFS install
