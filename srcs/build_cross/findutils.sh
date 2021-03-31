source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $FINDUTILS_VERSION.tar.xz
cd $FINDUTILS_VERSION

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j$JOBS
make DESTDIR=$LFS install

mv -v $LFS/usr/bin/find $LFS/bin
sed -i 's|find:=${BINDIR}|find:=/bin|' $LFS/usr/bin/updatedb
