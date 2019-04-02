FROM centos
LABEL author = "Yugo <belovedyogurt@gmail.com>"

RUN yum install -y -q gcc make openssl-devel \
	mariadb-devel mariadb-libs m4 readline-devel \
	unzip wget lua-devel git

RUN yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo	

# other see http://openresty.org/cn/linux-packages.html
RUN yum install -y -q openresty

# 5.3 not supports
# RUN curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz && \
# 	tar zxf lua-5.3.5.tar.gz && \
# 	cd lua-5.3.5 && \
# 	make install
# # replace v5.1
# RUN mv /usr/local/bin/lua /usr/bin/lua

ADD /scripts /scripts

RUN chmod a+x /scripts/*.sh

RUN sh -c /scripts/install_luarocks.sh > /dev/null

# fix deps
RUN cp /usr/lib64/mysql/libmysqlclient.so /usr/local/lib

WORKDIR /app

RUN luarocks install lapis && \
	luarocks install moonscript && \
	luarocks install luasql-mysql MYSQL_INCDIR=/usr/include/mysql

VOLUME [ "/app" ] 

EXPOSE 8080

CMD [ "/bin/bash" ]

