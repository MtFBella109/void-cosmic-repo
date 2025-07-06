#!/bin/bash
cp -n ~/void-packages/hostdir/binpkgs/cosmic*x86_64.xbps ~/void-cosmic-repo/repo/x86_64/
cp -n ~/void-packages/hostdir/binpkgs/pop-launcher*x86_64.xbps ~/void-cosmic-repo/repo/x86_64/
xbps-rindex -a ~/void-cosmic-repo/repo/x86_64/*.xbps
xbps-rindex -S ~/void-cosmic-repo/x86_64/*.xbps --privkey ~/repo-private-key.pem --signedby "Bella Wagner <belladev109@proton.me>"
xbps-rindex -r ~/void-cosmic-repo/x86_64/

if [ "$1" != "glibc" ]; then
	cp -n ~/void-packages/hostdir/binpkgs/cosmic*musl.xbps ~/void-cosmic-repo/repo/x86_64-musl/
	cp -n ~/void-packages/hostdir/binpkgs/pop-launcher*musl.xbps ~/void-cosmic-repo/repo/x86_64-musl/
	XBPS_TARGET_ARCH=x86_64-musl xbps-rindex -a ~/void-cosmic-repo/repo/x86_64-musl/*.xbps
	xbps-rindex -S ./x86_64-musl/*.xbps --privkey ~/repo-private-key.pem --signedby "Bella Wagner <belladev109@proton.me>"
	XBPS_TARGET_ARCH=x86_64-musl xbps-rindex -r ~/void-cosmic-repo/repo/x86_64-musl/
fi
git add .
if [ -v 1 ] &&  [ "$1" != "glibc" ]; then
	git commit -m $1
elif [ -v 2 ]; then
	git commit -m $2
else
	git commit -m "Updated Packages"
fi
git push -u origin master
