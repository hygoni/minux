source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $PATCH_VERSION.tar.xz
cd $PATCH_VERSION

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j$JOBS
make DESTDIR=$LFS install
