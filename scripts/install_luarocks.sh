#!/bin/sh
wget https://luarocks.org/releases/luarocks-3.0.4.tar.gz && \
	tar zxvf luarocks-3.0.4.tar.gz && \
	cd luarocks-3.0.4 && \
	./configure && make build && \
	make install