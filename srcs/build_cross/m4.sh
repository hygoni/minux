source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $M4_VERSION.tar.xz
cd $M4_VERSION

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make -j$JOBS
make DESTDIR=$LFS install
