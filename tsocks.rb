require 'formula'

# via: https://trac.macports.org/browser/trunk/dports/net/tsocks
# via: https://github.com/mxcl/homebrew/issues/11870
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

  depends_on :autoconf
  depends_on :automake

  def patches
    {
      :p0 => [
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-Makefile.in',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-configure.in',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-dead_pool.c',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.c',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.h',
        'https://trac.macports.org/export/81420/trunk/dports/net/tsocks/files/patch-tsocks.in',
        DATA
      ]
    }
  end

  def install
    system "autoconf"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}", "--libdir=#{prefix}/lib", "--mandir=#{prefix}/share/man",
           "--with-conf=#{etc}/tsocks.conf", "--enable-socksdns", "--disable-tordns"
    system "make"
    system "make install"

    unless config_file.exist?
      etc.install "tsocks.conf.simple.example" => "tsocks.conf"
    end
  end

  def test
    puts 'Your current public ip is:'
    ohai `curl -sS ifconfig.me 2>&1`.chomp
    puts "If your correctly configured #{config_file}, this should show the ip you have trough the proxy"
    puts 'Your ip through the proxy is:'
    ohai `tsocks curl -sS ifconfig.me 2>&1`.chomp
  end

  def config_file
    etc / 'tsocks.conf'
  end
end

__END__
--- tsocks.conf.simple.example.orig     2013-05-25 23:37:43.000000000 +0900
+++ tsocks.conf.simple.example  2013-05-25 23:37:54.000000000 +0900
@@ -9,8 +9,11 @@
 # tsocks.conf.complex.example

 # We can access 192.168.0.* directly
-local = 192.168.0.0/255.255.255.0
+# local = 192.168.0.0/255.255.255.0

 # Otherwise we use the server
-server = 192.168.0.1
+# server = 192.168.0.1

+server = 127.0.0.1
+server_type = 5
+server_port = 1080
