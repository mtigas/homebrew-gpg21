# homebrew-gpg21

This repository contains a [Homebrew][brew] formula for [GnuPG 2.1](https://gnupg.org/faq/whats-new-in-2.1.html),
just for testing until that version of GPG lands in Homebrew proper

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

(You'll see some warnings about it conflictingw ith the `gnupg2` and `gpg-agent`
formulae. Don't fret.)

You can then install the forumla by doing:

```
brew install mtigas/gpg21/gnupg21
```

...or, if you're daring and want to compile with support for generation of huge
keys and TLS support for keyservers that use it (like the HKPS pool
at https://sks-keyservers.net/overview-of-pools.php )

```
brew install mtigas/gpg21/gnupg21 --8192 --with-gnutls
```

### Method 2: Raw URL

You can install the formula without tapping this repo by doing:

```
brew install https://github.com/mtigas/homebrew-gpg21/raw/master/Formula/gnupg21.rb
```
