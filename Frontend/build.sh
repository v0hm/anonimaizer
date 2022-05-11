rm -rf /build

flutter build web

rm -rf ../Frontend-Build
cp -r ./build/web ../Frontend-Build