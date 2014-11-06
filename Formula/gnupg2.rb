require "formula"

class Gnupg2 < Formula
  homepage "https://www.gnupg.org/"
  url "ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.0.tar.bz2"
  mirror "ftp://ftp.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.0.tar.bz2"
  mirror "ftp://mirror.tje.me.uk/pub/mirrors/ftp.gnupg.org/gnupg/gnupg-2.1.0.tar.bz2"
  sha1 "2fcd0ca6889ef6cb59e3275e8411f8b7778c2f33"
  revision 1

  patch do
    url "https://github.com/mtigas/homebrew-gpg21/raw/master/Patches/0001-fix-mac-os-x-build.patch"
    sha1 "4cd7ec2081646032de291b1f012a647841296f1d"
  end
  patch do
    url "https://github.com/mtigas/homebrew-gpg21/raw/master/Patches/0002-fix-mac-os-x-build.patch"
    sha1 "6881a4fb198b0399f75e82c73f3c8a8b0e6711a0"
  end

  option "8192", "Build with support for private keys of up to 8192 bits"

  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "pinentry"
  depends_on "mtigas/gpg21/npth"
  depends_on "curl" if MacOS.version <= :mavericks
  depends_on "libusb-compat" => :recommended
  depends_on "readline" => :optional
  depends_on "pkg-config" => :build
  depends_on "gnutls" => :optional

  conflicts_with "gpg-agent", :because => "This GnuPG 2.1 includes gpg-agent"
  conflicts_with "dirmngr", :because => "This GnuPG 2.1 includes dirmngr"

  def install
    # Adjust package name to fit our scheme of packaging both gnupg 1.x and
    # 2.x, and gpg-agent separately, and adjust tests to fit this scheme
    inreplace "configure" do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end
    inreplace "tools/gpgkey2ssh.c", "gpg --list-keys", "gpg2 --list-keys"

    inreplace "g10/keygen.c", "max=4096", "max=8192" if build.include? "8192"

    (var/"run").mkpath

    ENV.append "LDFLAGS", "-lresolv"

    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sbindir=#{bin}
      --enable-symcryptrun
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
    rm man1/"gpg-zip.1"
  end
end
