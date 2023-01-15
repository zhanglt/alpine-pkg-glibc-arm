# Maintainer: Sasha Gerrand <alpine-pkgs@sgerrand.com>

pkgname="glibc"
pkgver="2.35"
_pkgrel="0"
pkgrel="0"
pkgdesc="GNU C Library compatibility layer"
arch="aarch64"
url="https://github.com/zhanglt/alpine-pkg-glibc-arm"
license="LGPL"
source="https://github.com/zhanglt/docker-glibc-builder-arm/releases/download/$pkgver-$_pkgrel/glibc-bin-$pkgver-$_pkgrel-aarch64.tar.gz
ld.so.conf"
subpackages="$pkgname-bin $pkgname-dev $pkgname-i18n"
triggers="$pkgname-bin.trigger=/lib:/usr/lib:/usr/glibc-compat/lib"

package() {
  mkdir -p "$pkgdir/lib" "$pkgdir/usr/glibc-compat/lib/locale"  "$pkgdir"/usr/glibc-compat/lib64 "$pkgdir"/etc
  cp -a "$srcdir"/usr "$pkgdir"
  cp "$srcdir"/ld.so.conf "$pkgdir"/usr/glibc-compat/etc/ld.so.conf
  rm "$pkgdir"/usr/glibc-compat/etc/rpc
  rm -rf "$pkgdir"/usr/glibc-compat/bin
  rm -rf "$pkgdir"/usr/glibc-compat/sbin
  rm -rf "$pkgdir"/usr/glibc-compat/lib/gconv
  rm -rf "$pkgdir"/usr/glibc-compat/lib/getconf
  rm -rf "$pkgdir"/usr/glibc-compat/lib/audit
  rm -rf "$pkgdir"/usr/glibc-compat/share
  rm -rf "$pkgdir"/usr/glibc-compat/var
  ln -s /usr/glibc-compat/lib/ld-linux-aarch64.so.1 ${pkgdir}/lib/ld-linux-aarch64.so.1
  ln -s /usr/glibc-compat/lib/ld-linux-aarch64.so.1 ${pkgdir}/usr/glibc-compat/lib64/ld-linux-aarch64.so.1
  ln -s /usr/glibc-compat/etc/ld.so.cache ${pkgdir}/etc/ld.so.cache
}

bin() {
  depends="$pkgname bash libc6-compat libgcc"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/bin "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/sbin "$subpkgdir"/usr/glibc-compat
}

i18n() {
  depends="$pkgname-bin"
  arch="noarch"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/share "$subpkgdir"/usr/glibc-compat
}

sha512sums="
706934655d22f40007cf823d3b781cbf38500db8ab1206bbbdcb1a4786c56feeb5f1f9c26f786e1aba758e4e55e4c6d5bdd5d010ce462e8cf298409e342751ae  glibc-bin-2.35-arm64.tar.gz
2912f254f8eceed1f384a1035ad0f42f5506c609ec08c361e2c0093506724a6114732db1c67171c8561f25893c0dd5c0c1d62e8a726712216d9b45973585c9f7  ld.so.conf
"
