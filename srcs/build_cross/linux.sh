source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $LINUX_VERSION.tar.xz
cd $LINUX_VERSION

make mrproper
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

