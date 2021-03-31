source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $SED_VERSION.tar.xz
cd $SED_VERSION


./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --bindir=/bin

make -j$JOBS
make DESTDIR=$LFS install
