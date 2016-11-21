Wrapper for Gurobi
==================

<http://www.gurobi.com>

macOS / OS X

Download `gurobi6.0.5_mac64.pkg` from
<https://www.gurobi.com/downloads/download-center>.

```
$ brew install cmake
```

Debian / Ubuntu

Download `gurobi6.0.5_linux64.tar.gz` from
<https://www.gurobi.com/downloads/download-center>.


```
$ sudo apt-get install build-essential cmake
```

All Platforms

Set the `GUROBI_DISTRO` environment variable to the absolute path to the
Gurobi archive that you just downloaded.  Then:


```
$ mkdir build && cd build
$ cmake ..
$ make install
```
