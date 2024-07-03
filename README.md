# depthai-vcpkg-ports

Unofficial vcpkg port for depthai-core.

## Usage

To use this repo, you will need to specify to `vcpkg` to use the ports contained in this repo using
the [`--overlay-ports` option](https://github.com/microsoft/vcpkg/blob/master/docs/specifications/ports-overlay.md). 

For example, you can first clone this repo:
~~~
git clone https://github.com/iit-danieli-joint-lab/depthai-vcpkg-ports
~~~

Then, to install the `depthai-core` port, run `vcpkg` with the following options: 
~~~
./vcpkg.exe --overlay-ports=<repo_parent_directory>depthai-vcpkg-ports install depthai-core:x64-windows
~~~

## Available ports 

| Port name | Official vcpkg triplet for which it is tested | 
|:---------:|:------------------------------------------------:|
| [`depthai-core`](depthai-core) | `x64-windows`, `x64-linux` | 


## Disclaimer 

> [!WARNING]  
> `depthai-core` port provided here is not updated continuously (i.e. as soon as new version is released) but only when useful for IIT-internal use. If you use this ports and you would like to have a new version released, please open an issue in this repo.
