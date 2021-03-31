source /srcs/build_cross/version.sh

cd $LFS/sources
tar -xf $GCC_VERSION.tar.xz
cd $GCC_VERSION
tar -xf ../$MPFR_VERSION.tar.xz
mv -v $MPFR_VERSION mpfr
tar -xf ../$GMP_VERSION.tar.xz
mv -v $GMP_VERSION gmp
tar -xf ../$MPC_VERSION.tar.gz
mv -v $MPC_VERSION mpc

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -v build
cd build
../configure \
	--target=$LFS_TGT \
	--prefix=$LFS/tools \
	--with-glibc-version=2.11 \
	--with-sysroot=$LFS \
	--with-newlib \
	--without-headers \
	--enable-initfini-array \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-decimal-float \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++

make -j$JOBS
make install

cd ../
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
