@echo off
REM 提供Windows下MCSM和守护进程的启动，重启，关闭功能
echo ==================MCSM启动==================
::MCSM以及运行库所在目录
set MCSM_DIR=%~dp0
set WEBTITLE="MCSM-网页后台"
set DAEMONTITLE="MCSM-守护进程"
color 0a
TITLE MCSM启动与关闭
CLS

:MENU
CLS
echo.==========MCSM 进程列表=========
tasklist /fi "imagename eq cmd.exe" /fi "windowtitle eq %WEBTITLE%"
tasklist /fi "imagename eq cmd.exe" /fi "windowtitle eq %DAEMONTITLE%"
tasklist /fi "imagename eq node.exe"
echo.
echo.
echo.=================================
echo.
    echo.  [1] 启动Web和Daemon
    echo.  [2] 关闭Web和Daemon
    echo.  [3] 重启Web和Daemon
    echo.  [4] 刷新控制台 
echo.
echo.=================================
echo.
	echo.  [0] 退 出
echo.
echo.=================================
echo.请输入选择的序号:
set /p ID=
    IF "%id%"=="1" GOTO start
    IF "%id%"=="2" GOTO stop
    IF "%id%"=="3" GOTO restart
    IF "%id%"=="4" GOTO MENU
    IF "%id%"=="5" GOTO MENU
    IF "%id%"=="6" GOTO MENU
    IF "%id%"=="7" GOTO MENU
    IF "%id%"=="8" GOTO MENU
    IF "%id%"=="9" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE
GOTO MENU

::*************************************************************************************************************
::启动
:start
    call :startMCSM
    GOTO MENU

::停止
:stop
    call :shutdownMCSM
    GOTO MENU

::重启
:restart
    call :startMCSM
    call :shutdownMCSM
    GOTO MENU

::*************************************************************************************
::底层
::*************************************************************************************
:shutdownMCSM
    echo.
    echo.关闭MCSM的Web和Daemon......
    taskkill /F /T /fi "imagename eq cmd.exe" /fi "windowtitle eq %WEBTITLE%" > nul
    taskkill /F /T /fi "imagename eq cmd.exe" /fi "windowtitle eq %DAEMONTITLE%" > nul
    echo.已关闭Web和Daemon进程
    TIMEOUT /T 3
    goto :eof

:startMCSM
    echo.
    echo.启动MCSM的Web和Daemon......
    if not exist "%MCSM_DIR%Web" (
	echo. Web 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon 文件夹不存在, 请下载安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Web\node_modules" (
	echo. Web 依赖文件夹不存在, 请安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Daemon\node_modules" (
	echo. Daemon 依赖文件夹不存在, 请安装后再使用
	TIMEOUT /T 3
	GOTO MENU
    )
	start "MCSM-守护进程" /min cmd.exe /c "cd %MCSM_DIR%Daemon && node app.js"
	start "MCSM-网页后台" /min cmd.exe /c "cd %MCSM_DIR%Web && node app.js"
    echo.MCSM已启动
    TIMEOUT /T 3
    goto :eof