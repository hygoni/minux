source /srcs/build_cross/version.sh

cd $LFS/sources
tar -xf $BINUTILS_VERSION.tar.xz
cd $BINUTILS_VERSION
mkdir -v build
cd build

../configure --prefix=$LFS/tools \
     --with-sysroot=$LFS \
     --target=$LFS_TGT \
     --disable-nls \
     --disable-werror && \

make -j$JOBS
make install
