require 'formula'

class Pgmodeler < Formula
  homepage 'http://pgmodeler.com.br/'
  head 'https://github.com/pgmodeler/pgmodeler.git', :revision => '61d4b019dbc929b9c6d35cec26afc104ab42bba1'

  depends_on 'qt5'
  depends_on 'postgresql'

  patch DATA

  def install
    system "/usr/local/opt/qt5/bin/qmake PREFIX+=#{prefix}/pgmodeler.app/Contents pgmodeler.pro"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/pgmodeler.pri b/pgmodeler.pri
index 06edd7b..679baa3 100644
--- a/pgmodeler.pri
+++ b/pgmodeler.pri
@@ -134,6 +134,7 @@ macx {
 
   # Specifies where to find the libraries at runtime
   QMAKE_RPATHDIR += $$PRIVATELIBDIR
+  QMAKE_LFLAGS_SONAME = -Wl,-install_name,@rpath/
 }
 
 # Creating constants based upon the custom paths so the GlobalAttributes
@@ -166,8 +167,8 @@ unix:!macx {
 }
 
 macx {
-  PGSQL_LIB = /Library/PostgreSQL/9.3/lib/libpq.dylib
-  PGSQL_INC = /Library/PostgreSQL/9.3/include
+  PGSQL_LIB = /usr/local/opt/postgresql/lib/libpq.dylib
+  PGSQL_INC = /usr/local/opt/postgresql/include
   XML_INC = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2
   XML_LIB = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libxml2.dylib
 
