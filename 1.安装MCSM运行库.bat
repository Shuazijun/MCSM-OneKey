@echo off
REM 提供Windows下MCSM运行库安装、卸载
echo ==================MCSM运行库管理==================
::MCSM以及运行库所在目录
set MCSM_DIR=%~dp0
set WGET=%~dp0Runtime\Wget\wget.exe
color 0a
TITLE MCSM运行库管理
CLS

:MENU
CLS
color 0a
echo.
echo.=============MCSM运行库管理=============
echo.
    echo.  [1] 下载安装 Node.JS 环境（v14.19.2）
    echo.  [2] 安装Web前端和Daemon守护进程的依赖
    echo.  [3] 删除Web前端和Daemon守护进程的依赖
    echo.
    echo.============配置以及文件管理============
    echo.
    echo.  [4] 打开Web前端所在目录
    echo.  [5] 打开Web配置文件
    echo.
    echo.  [6] 打开Daemon所在目录
    echo.  [7] 打开Daemon配置文件
    echo.
    echo.==================其他==================
    echo.
    echo.  [0] 退 出
    echo.
    echo.========================================
echo.

echo.请输入选择的序号:
set /p ID=
    IF "%id%"=="1" GOTO installnodejs
    IF "%id%"=="2" GOTO installwebanddaemon
    IF "%id%"=="3" GOTO uninstallwebanddaemon
    IF "%id%"=="4" GOTO openweb
    IF "%id%"=="5" GOTO openwebconfig
    IF "%id%"=="6" GOTO opendaemon
    IF "%id%"=="7" GOTO opendaemonconfig
    IF "%id%"=="8" GOTO MENU
    IF "%id%"=="9" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE
GOTO MENU

::*************************************************************************************************************
::安装 Node.JS 14.19.1 x64 环境
:installnodejs
    call :installnodejs
    GOTO MENU

::安装Web前端和Daemon守护进程的依赖
:installwebanddaemon
    if not exist "%MCSM_DIR%Web" (
	echo. Web 文件夹不存在，请重新下载MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    call :installweb
    echo.========================================
    echo.            Web依赖安装完成
    echo.========================================
    TIMEOUT /T 3
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon 文件夹不存在，请重新下载MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    call :installdaemon
    echo.========================================
    echo.           Daemon依赖安装完成
    echo.========================================
    TIMEOUT /T 3
    GOTO MENU

::删除Web前端和Daemon守护进程的依赖
:uninstallwebanddaemon
    call :uninstallwebanddaemon
    GOTO MENU

::打开Web前端所在目录
:openweb
    call :openweb
    GOTO MENU

::打开Daemon守护进程所在目录
:opendaemon
    call :opendaemon
    GOTO MENU

::打开Web配置文件
:openwebconfig
    call :openwebconfig
    GOTO MENU  

 ::打开Daemon守护进程配置文件
:opendaemonconfig
    call :opendaemonconfig
    GOTO MENU

::*************************************************************************************
::底层
::*************************************************************************************
:installnodejs
    echo.
    echo.正在下载 Node.JS 14.19.2 x64 环境安装包......
    echo.
    cd %MCSM_DIR%Runtime\NodeJS
    "%WGET%" https://nodejs.org/download/release/v14.19.2/node-v14.19.2-x64.msi
    if not exist "%MCSM_DIR%Runtime\NodeJS\node-v14.19.2-x64.msi" (
	echo. node-v14.19.2-x64.msi 不存在，请检查下载链接
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.下载成功!
	echo.正在安装,请等待安装完成......
	start "" /wait "msiexec" /i "%MCSM_DIR%Runtime\NodeJS\node-v14.19.2-x64.msi" /qb
	echo.========================================
    echo.           NodeJS安装完成
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:installweb
    echo.
    echo.安装Web依赖......
	cd %MCSM_DIR%Web && npm install
    goto :eof

:installdaemon
    echo.
    echo.安装Daemon依赖......
	cd %MCSM_DIR%Daemon && npm install
    goto :eof

:uninstallwebanddaemon
	echo.
    echo.正在删除Web的依赖......
    if not exist "%MCSM_DIR%Web" (
	echo. Web 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    rd /s /q %MCSM_DIR%Web\node_modules
    del /f /s /q %MCSM_DIR%Web\package-lock.json
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
	echo.正在删除Daemon的依赖......
    rd /s /q %MCSM_DIR%Daemon\node_modules
    del /f /s /q %MCSM_DIR%Daemon\package-lock.json
    echo.========================================
    echo.           依赖删除完成
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:openweb
	echo.
	if not exist "%MCSM_DIR%Web" (
	echo. Web 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    start "" "%MCSM_DIR%Web"
    goto :eof

:opendaemon
	echo.
	if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    start "" "%MCSM_DIR%Daemon"
    goto :eof

:openwebconfig
	echo.
	if not exist "%MCSM_DIR%Web" (
	echo. Web 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Web\data\SystemConfig\config.json" (
	echo. Web 配置文件不存在, 请运行后再试
	TIMEOUT /T 3
	GOTO MENU
    )
    start notepad "%MCSM_DIR%Web\data\SystemConfig\config.json"
    goto :eof

:opendaemonconfig
	echo.
	if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Daemon\data\Config\global.json" (
	echo. Daemon 配置文件不存在, 请运行后再试
	TIMEOUT /T 3
	GOTO MENU
    )
    start notepad "%MCSM_DIR%Daemon\data\Config\global.json"
    goto :eof