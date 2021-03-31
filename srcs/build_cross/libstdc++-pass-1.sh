source /srcs/build_cross/version.sh
cd $LFS/sources
cd $GCC_VERSION

rm -rf build
mkdir -v build
cd build
../libstdc++-v3/configure \
	--host=$LFS_TGT \
	--build=$(../config.guess) \
	--prefix=/usr \
	--disable-multilib \
	--disable-nls \
	--disable-libstdcxx-pch \
	--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
make -j$JOBS
make DESTDIR=$LFS install
