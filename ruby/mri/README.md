### Setting version to install
```
export version=<version-to-install> # Ex. 2.2.3
```

### Building package
```
cd src/
docker build --build-arg version=${version} -t kimh/ruby-build:${version} .
```

### Copying package
```
docker run kimh/ruby-build:${version} cat ruby_${version}_amd64.deb > ruby_${version}_amd64.deb
```

### Testing package
```
# Assuming you already copy .deb file to test/ directory
cd test/
docker build --no-cache --build-arg version=${version} .
```

