ifeq ($(ARCHITECTURE),broadcom)
ifneq ($(CONFIG_BCMMODERN),y)
NO_TLS=ac_cv_tls=none
endif
endif


wolfssl-configure:
	cd wolfssl && ./autogen.sh
	mkdir -p wolfssl/minimal
	mkdir -p wolfssl/standard
	mkdir -p wolfssl/standard_static
	cd wolfssl/standard && ../configure $(NO_TLS)  --prefix=/usr --libdir=/usr/lib --host=$(ARCH)-linux --disable-crypttests --disable-examples --disable-benchmark --disable-examples --enable-opensslextra --enable-opensslall --enable-shared --enable-fastmath --disable-static -disable-errorstrings   --enable-ocsp --enable-lowresource --disable-oldtls --enable-aesgcm  --enable-aesccm --enable-poly1305 --enable-chacha --enable-ecc --disable-sslv3 --enable-des3 --enable-md4 --enable-stunnel --enable-tls13 --enable-session-ticket --enable-wpas --enable-cmac --enable-dh --enable-certgen --enable-certreq --enable-sha --enable-secure-renegotiation --enable-alpn CFLAGS="$(COPTS) $(MIPS16_OPT) $(LTO) -ffunction-sections -fdata-sections -Wl,--gc-sections" \
	    AR_FLAGS="cru $(LTOPLUGIN)" \
	    RANLIB="$(ARCH)-linux-ranlib $(LTOPLUGIN)"

#	cd wolfssl/standard_static && ../configure $(NO_TLS)  --prefix=/usr --libdir=/usr/lib --host=$(ARCH)-linux --disable-crypttests --disable-examples --disable-benchmark --disable-examples --enable-opensslextra --enable-opensslall --disable-shared --enable-fastmath --enable-static -disable-errorstrings   --enable-ocsp --enable-lowresource --disable-oldtls --enable-aesgcm  --enable-aesccm --enable-poly1305 --enable-chacha --enable-ecc --disable-sslv3 --enable-des3 --enable-md4 --enable-stunnel --enable-tls13 --enable-session-ticket --enable-wpas --enable-cmac --enable-dh CFLAGS="$(COPTS) $(MIPS16_OPT) $(LTO) -ffunction-sections -fdata-sections -Wl,--gc-sections" \
#	    AR_FLAGS="cru $(LTOPLUGIN)" \
#	    RANLIB="$(ARCH)-linux-ranlib $(LTOPLUGIN)"

	cd wolfssl/standard_static && ../configure $(NO_TLS)  --prefix=/usr --libdir=/usr/lib --host=$(ARCH)-linux --disable-shared --enable-static --enable-lighty --enable-opensslall --enable-opensslextra --enable-sni --enable-stunnel --enable-altcertchains --disable-crypttests --disable-examples --enable-ipv6 --enable-aesccm --enable-certgen --enable-chacha --enable-poly1305 --enable-dh --enable-arc4 --enable-tlsv10 --enable-tls13 --enable-session-ticket --disable-dtls --enable-curve25519 --disable-curve448 --enable-openvpn --disable-afalg --enable-devcrypto=no --enable-ocsp --enable-ocspstapling --enable-ocspstapling2 --enable-wpas --enable-fortress --enable-fastmath CFLAGS="$(COPTS) $(MIPS16_OPT) $(LTO) -ffunction-sections -fdata-sections -Wl,--gc-sections" \
	    AR_FLAGS="cru $(LTOPLUGIN)" \
	    RANLIB="$(ARCH)-linux-ranlib $(LTOPLUGIN)"

	cd wolfssl/minimal && ../configure $(NO_TLS) --prefix=/usr --libdir=/usr/lib --host=$(ARCH)-linux --disable-crypttests --disable-examples --disable-benchmark --enable-opensslextra --disable-shared --enable-fastmath --enable-static -disable-errorstrings --disable-oldtls --disable-sha --enable-lowresource --disable-md5 --disable-arc4 --disable-poly1305 --disable-chacha --enable-ecc --disable-sslv3 --disable-tls13 --disable-des3 --enable-md4 --enable-stunnel --enable-session-ticket --enable-cmac CFLAGS="$(COPTS) $(MIPS16_OPT) $(LTO) -ffunction-sections -fdata-sections -Wl,--gc-sections" \
	    AR_FLAGS="cru $(LTOPLUGIN)" \
	    RANLIB="$(ARCH)-linux-ranlib $(LTOPLUGIN)"
	$(MAKE) -C wolfssl/minimal
	$(MAKE) -C wolfssl/standard
	$(MAKE) -C wolfssl/standard_static

wolfssl:
ifeq ($(CONFIG_WOLFSSLMIN),y)
	$(MAKE) -C wolfssl/minimal
else
	$(MAKE) -C wolfssl/standard
	$(MAKE) -C wolfssl/standard_static
endif
	-rm wolfssl/wolfssl/options.h

wolfssl-clean:
	-make -C wolfssl/minimal clean
	-make -C wolfssl/standard clean
	-make -C wolfssl/standard_static clean
	@true

wolfssl-install:
ifneq ($(CONFIG_WOLFSSLMIN),y)
	$(MAKE) -C wolfssl/standard install DESTDIR=$(INSTALLDIR)/wolfssl
	rm -rf $(INSTALLDIR)/wolfssl/usr/bin
	rm -rf $(INSTALLDIR)/wolfssl/usr/include
	rm -rf $(INSTALLDIR)/wolfssl/usr/lib/pkgconfig
	rm -f $(INSTALLDIR)/wolfssl/usr/lib/*.la
	rm -rf $(INSTALLDIR)/wolfssl/usr/share
else
	@true
endif
