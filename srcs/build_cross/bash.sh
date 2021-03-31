source /srcs/build_cross/version.sh
cd $LFS/sources
tar -xf $BASH_VERSION.tar.gz
cd $BASH_VERSION

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc

make -j$JOBS
make DESTDIR=$LFS install
mv $LFS/usr/bin/bash $LFS/bin/bash
ln -sv bash $LFS/bin/sh
