# homebrew-gpg21

This repository contains a [Homebrew][brew] formula for [GnuPG 2.1](https://gnupg.org/faq/whats-new-in-2.1.html),
just for testing until that version of GPG lands in Homebrew proper.

**BACK UP YOUR PRIVATE KEYS FIRST. THIS HAS NOT BEEN WELL-TESTED YET.** GnuPG 2.1 has a new system of handling keyrings, entirely in `gpg-agent`. You may have conflicts when running this alongside a GnuPG 2.X instance (such as that included in GPGTools) and you may lose your existing private keys.

**You will need to [install Homebrew][brew_install] to use this**, see
[here][brew_install].

[brew]: http://mxcl.github.com/homebrew/
[brew_install]: https://github.com/mxcl/homebrew/wiki/installation

## Usage

There are two methods to install packages from this repository.

### Method 1: Tap

Tap the repository into your brew installation

```
brew tap mtigas/gpg21
```

(You'll see some warnings about it conflicting with the `gnupg2` formula. Don't fret.)

You can then install the forumla by doing the following. (You might have to `brew uninstall gnupg2`
and `brew uninstall gpg-agent` first.)

```
brew install mtigas/gpg21/gnupg2
```

If you're daring and want to compile with support for generation of huge
keys and TLS support for keyservers that use it (like the HKPS pool
at https://sks-keyservers.net/overview-of-pools.php ), you can even do:

```
brew install mtigas/gpg21/gnupg2 --8192 --with-gnutls
```

### Method 2: Raw URL

You can install the formula without tapping this repo by doing:

```
brew install https://github.com/mtigas/homebrew-gpg21/raw/master/Formula/gnupg2.rb
```
