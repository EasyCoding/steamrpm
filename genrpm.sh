#!/bin/sh

echo Creating temporary directory for building process...
TMPATH=`mktemp -d`
cd $TMPATH

echo Downloading Ubuntu package...
<<<<<<< HEAD
wget http://media.steampowered.com/client/installer/steam.deb -O steam.deb
=======
wget http://media.steampowered.com/client/installer/steam.deb -O $TMPATH/steam.deb
>>>>>>> upstream/master

if [ -f "$TMPATH/steam.deb" ]; then
  echo Unpacking Ubuntu package...
  ar vx steam.deb
  
  if [ -f "$TMPATH/data.tar.gz" ]; then
    echo Checking rpmbuild working directory...
    if [ ! -d ~/rpmbuild/SOURCES/ ]; then
      echo Creating SOURCES in rpmbuild working directory...
      mkdir -p ~/rpmbuild/SOURCES/
    fi
    
    echo Copying archive with binaries to rpmbuild working directory...
    cp -f data.tar.gz ~/rpmbuild/SOURCES/steam.tar.gz
    
    echo Downloading SPEC file...
    wget http://raw.github.com/justdan96/steamrpm/patch-2/steam.spec
    
    if [ -f "$TMPATH/steam.spec" ]; then
      
      if [ -f "$TMPATH/data.tar.gz" ]; then
	tar -zxf control.tar.gz -C $TMPATH
	if [ -f "$TMPATH/control" ]; then
	  echo Updating version info from DEB package...
	  sed -i "s/Version: .*/Version: `awk '/Version:/ {print $2}' control`/g" steam.spec
	fi
      fi
      
      echo Building package...
<<<<<<< HEAD
      rpmbuild -bb --buildroot "`rpm --eval "%_tmppath"`/steam-root" steam.spec
=======
      rpmbuild -bb --clean --buildroot ~/rpmbuild/BUILDROOT/steam-root steam.spec
>>>>>>> upstream/master
    fi
  fi
fi

echo Executting cleanup...
rm -rf $TMPATH
