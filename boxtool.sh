##Building box tools for configs and database templates 
DIR=$(pwd)
VER=1.06
rm $DIR/local_packages/boxtools*.deb
mkdir -p $DIR/boxtools_amd64/opt
cd $DIR/boxtools_amd64/opt
git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git mp4auto
cd $DIR
cp $DIR/templates/boxtools/* $DIR/boxtools_amd64 -rf
chmod 775 $DIR/boxtools_amd64/DEBIAN
dpkg-deb -b boxtools_amd64/ boxtools_$VER-amd64.deb
mv boxtools_$VER-amd64.deb ./local_packages
##Remove html folder for next build or it will cause errors
rm $DIR/templates/boxtools/var/www/html -rf
rm $DIR/boxtools_amd64/ -rf
exit 0