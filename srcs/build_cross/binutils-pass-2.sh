source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $BINUTILS_VERSION.tar.xz
cd $BINUTILS_VERSION
rm -rf build
mkdir -v build
cd build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --disable-werror           \
    --enable-64-bit-bfd

make -j$JOBS
make DESTDIR=$LFS install
install -vm755 libctf/.libs/libctf.so.0.0.0 $LFS/usr/lib
