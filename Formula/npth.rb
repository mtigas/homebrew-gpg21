require 'formula'

class Npth < Formula
  homepage 'http://lwn.net/Articles/496268/'
  url 'ftp://ftp.gnupg.org/gcrypt/npth/npth-1.1.tar.bz2'
  mirror "ftp://ftp.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/npth/npth-1.1.tar.bz2"
  mirror "ftp://mirror.tje.me.uk/pub/mirrors/ftp.gnupg.org/gcrypt/npth/npth-1.1.tar.bz2"
  sha1 '597ce74402e5790553a6273130b214d7ddd0b05d'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
