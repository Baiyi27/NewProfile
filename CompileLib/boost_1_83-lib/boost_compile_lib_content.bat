@echo off
set linkSts=static
set runtimeSts=static
set libDir="./myBuild/mingw64-lnk_%linkSts%-rt_%runtimeSts%"
::@echo %libDir% 
::@pause --build-dir=build

.\b2 --prefix=%libDir% --stagedir=%libDir% --with-system --with-coroutine --with-python --with-thread --with-date_time --with-regex --with-serialization address-model=64 toolset=gcc link=%linkSts% runtime-link=%runtimeSts% stage