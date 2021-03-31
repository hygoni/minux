source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $DIFFUTILS_VERSION.tar.xz
cd $DIFFUTILS_VERSION

./configure --prefix=/usr --host=$LFS_TGT

make -j$JOBS
make DESTDIR=$LFS install
