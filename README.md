Wrapper for Gurobi 6.0.5
========================

<http://www.gurobi.com>

Requires a free academic license or paid commercial license, as appropriate.
Install the license file to `$HOME/gurobi.lic`.

Platforms `power64`, `win32`, and `win64` are unsupported by this wrapper.
Versions other than 6.0.5 are also unsupported by this wrapper.

linux64
-------

Download `gurobi6.0.5_linux64.tar.gz` from
<https://www.gurobi.com/downloads/download-center>.

```
$ export GUROBI_DISTRO=/path/to/gurobi6.0.5_linux64.tar.gz
$ mkdir build && cd build
$ cmake ..
$ make install
```

mac64
-----

Download `gurobi6.0.5_mac64.pkg` from
<https://www.gurobi.com/downloads/download-center>.

```
$ export GUROBI_DISTRO=/path/to/gurobi6.0.5_mac64.pkg
$ mkdir build && cd build
$ cmake ..
$ make install
```