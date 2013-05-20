
require 'formula'

# via: https://trac.macports.org/browser/trunk/dports/net/tsocks
#
# === #{etc}/tsocks.conf
# server = 127.0.0.1
# server_type = 5
# server_port = 1080
#
class Tsocks < Formula
  url 'http://distfiles.macports.org/tsocks/tsocks-1.8.4.tar.bz2'
  homepage 'http://tsocks.sourceforge.net/'
  sha1 'e72157e1431b789e99a307efe69cd5d55f24f9d0'
  def patches
    {
      :p0 => [
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-Makefile.in',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-configure.in',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-dead_pool.c',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.c',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.h',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.in',
      ]
    }
  end

  def install
    system "autoreconf"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}", "--libdir=#{prefix}/lib", "--mandir=#{prefix}/share/man",
           "--with-conf=#{etc}/tsocks.conf", "--enable-socksdns", "--disable-tordns"
    system "make"
    system "make install"
  end
end
