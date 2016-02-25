require "formula"

class Gnupg2 < Formula
  homepage "https://www.gnupg.org/"
  url "ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.11.tar.bz2"
  mirror "ftp://ftp.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.11.tar.bz2"
  mirror "ftp://mirror.tje.me.uk/pub/mirrors/ftp.gnupg.org/gnupg/gnupg-2.1.11.tar.bz2"
  sha1 "4af2032a60ff22e322b1c5b270d6d2228f59a3a3"
  revision 2

  option "8192", "Build with support for private keys of up to 8192 bits"
  # http://comments.gmane.org/gmane.comp.encryption.gpg.devel/20856
  option "with-adns", "adns support on osx."

  depends_on "adns"
  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "pinentry-mac"
  depends_on "mtigas/gpg21/npth"

  depends_on "readline" => :optional
  depends_on "pkg-config" => :build
  depends_on "gnutls" => :optional

  conflicts_with "gpg-agent", :because => "GnuPG 2.1 includes gpg-agent"
  conflicts_with "dirmngr", :because => "GnuPG 2.1 includes dirmngr"

  def install
    # Adjust package name to fit our scheme of packaging both gnupg 1.x and
    # 2.x, and gpg-agent separately, and adjust tests to fit this scheme
    inreplace "configure" do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end
    #inreplace "tools/gpgkey2ssh.c", "gpg --list-keys", "gpg2 --list-keys"

    #inreplace "g10/keygen.c", "max=4096", "max=8192" if build.include? "8192"

    (var/"run").mkpath

    ENV.append "LDFLAGS", "-lresolv"

    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sbindir=#{bin}
      --enable-symcryptrun
      --with-adns
    ]

    if build.with? "readline"
      args << "--with-readline=#{Formula["readline"].opt_prefix}"
    end

    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"

    # Conflicts with a manpage from the 1.x formula, and
    # gpg-zip isn't installed by this formula anyway
    #rm man1/"gpg-zip.1"
  end
end
