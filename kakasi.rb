require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Kakasi < Formula
  homepage 'http://kakasi.namazu.org/index.html.ja'
  url 'http://kakasi.namazu.org/stable/kakasi-2.3.4.tar.gz'
  sha1 'ab95a226f301955d2e8ae0d347afbb567e25fbe7'

  def patches
    {
      :p0 => ['https://gist.github.com/koshigoe/2575121/raw/b22076ebda59296137ef065bae33049a0b9213c8/kakasi-2.3.4-configure.diff']
    }
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make check"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test kakasi`.
    system "false"
  end
end
