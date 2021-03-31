source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $GREP_VERSION.tar.xz
cd $GREP_VERSION

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --bindir=/bin

make -j$JOBS
make DESTDIR=$LFS install
