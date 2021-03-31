source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $TAR_VERSION.tar.xz
cd $TAR_VERSION

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --bindir=/bin

make -j$JOBS
make DESTDIR=$LFS install
