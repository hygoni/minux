source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $GAWK_VERSION.tar.xz
cd $GAWK_VERSION

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./config.guess)

make -j$JOBS
make DESTDIR=$LFS install
