require "formula"

class GpgAgent < Formula
  homepage "https://www.gnupg.org/"
  url "ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.0.tar.bz2"
  mirror "ftp://ftp.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.0.tar.bz2"
  mirror "ftp://mirror.tje.me.uk/pub/mirrors/ftp.gnupg.org/gnupg/gnupg-2.1.0.tar.bz2"
  sha1 "2fcd0ca6889ef6cb59e3275e8411f8b7778c2f33"
  revision 1

  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "mtigas/gpg21/npth"
  depends_on "pinentry"

  # Adjust package name to fit our scheme of packaging both
  # gnupg 1.x and 2.x, and gpg-agent separately
  patch :DATA

  def install
    # don't use Clang's internal stdint.h
    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-agent-only",
                          "--with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry",
                          "--with-scdaemon-pgm=#{Formula["gnupg2"].opt_libexec}/scdaemon"
    system "make install"
  end
end

__END__
diff --git a/configure b/configure
index c022805..96ea7ed 100755
--- a/configure
+++ b/configure
@@ -578,8 +578,8 @@ MFLAGS=
 MAKEFLAGS=
 
 # Identity of this package.
-PACKAGE_NAME='gnupg'
-PACKAGE_TARNAME='gnupg'
+PACKAGE_NAME='gpg-agent'
+PACKAGE_TARNAME='gpg-agent'
 PACKAGE_VERSION='2.1.0'
 PACKAGE_STRING='gnupg 2.1.0'
 PACKAGE_BUGREPORT='http://bugs.gnupg.org'
