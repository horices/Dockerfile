FROM php:7.3-fpm-alpine

WORKDIR /var/www/html

COPY *.tar.gz ./
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add make autoconf gcc musl-dev g++ zlib-dev openssl-dev
# install imagick support gif 
# RUN set -ex && wget http://www.feadi.com/soft/libpng-1.6.31.tar.gz   && mkdir build && tar -xzf libpng-1.6.31.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
# RUN set -ex && wget http://www.feadi.com/soft/jpegsrc.v9b.tar.gz   && mkdir build && tar -xzf jpegsrc.v9b.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
# RUN set -ex && wget http://www.feadi.com/soft/freetype-2.8.1.tar.gz   && mkdir build && tar -xzf freetype-2.8.1.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
# RUN set -ex && wget http://www.feadi.com/soft/ImageMagick.tar.gz  &&  mkdir build && tar -xzf ImageMagick.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. && rm -r build
# install swoole
# RUN set -ex && wget http://www.feadi.com/soft/swoole-src-4.3.5.tar.gz  &&  mkdir build && tar -xzf swoole-src-4.3.5.tar.gz -C ./build --strip-components 1 && cd build && phpize &&  ./configure --enable-openssl --enable-http2 && make && make install && cd .. && rm -r build

RUN set -ex && mkdir build && tar -xzf swoole-src-4.3.5.tar.gz -C ./build --strip-components 1 && cd build && phpize &&  ./configure && make && make install && cd .. &&  rm -r build
RUN set -ex && mkdir build && tar -xzf php-xhprof-extension-5.0.2.tar.gz -C ./build --strip-components 1 && cd build && phpize &&  ./configure && make && make install && cd .. &&  rm -r build
RUN set -ex && mkdir build && tar -xzf libpng-1.6.31.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
RUN set -ex && mkdir build && tar -xzf jpegsrc.v9b.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
RUN set -ex && mkdir build && tar -xzf freetype-2.8.1.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
RUN set -ex && mkdir build && tar -xzf ImageMagick.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build

RUN pecl install imagick redis mongodb &&  docker-php-ext-install opcache pdo pdo_mysql gd && docker-php-ext-enable opcache imagick swoole pdo pdo_mysql redis gd mongodb
# RUN set -ex && mkdir build && tar -xzf xhgui-branch-1.0.3.tar.gz -C ./build --strip-components 1 && cd build &&  ./configure && make && make install && cd .. &&  rm -r build
EXPOSE 9000
