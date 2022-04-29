@echo off
REM 提供Windows下nginx和守护进程的启动，重启，关闭功能
echo. ==================MCSM一键反代==================

CLS
::nginx 所在目录
set NGINX_DIR=%~dp0
color 0a
TITLE MCSM反代管理
CLS

:MENU
CLS
echo.==========Nginx 进程列表=========
::tasklist|findstr /i "nginx.exe"
tasklist /fi "imagename eq nginx.exe"
echo.
echo.
echo.=================================
echo.
    echo.  [1] 启动Nginx反代
    echo.  [2] 关闭Nginx反代
    echo.  [3] 重启Nginx反代
    echo.  [4] 刷新控制台 
    echo.  [5] 重新加载Nginx配置文件
    echo.  [6] 检查测试Nginx配置文件
echo.
echo.============证书管理=============
echo.
    echo.  [7] 打开Web端SSL证书文件
    echo.  [8] 打开Daemon端SSL证书文件
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
    IF "%id%"=="5" GOTO reloadConf
    IF "%id%"=="6" GOTO checkConf
    IF "%id%"=="7" GOTO openwebsslfiles
    IF "%id%"=="8" GOTO openDaemonSslFiles
    IF "%id%"=="0" EXIT
PAUSE

::*************************************************************************************************************
::启动
:start
    call :startNginx
    GOTO MENU

::停止
:stop
    call :shutdownNginx
    GOTO MENU

::重启
:restart
    call :shutdownNginx
    call :startNginx
    GOTO MENU

::检查测试配置文件
:checkConf
    call :checkConfNginx
    TIMEOUT /T -1
    GOTO MENU

::重新加载Nginx配置文件
:reloadConf
    call :checkConfNginx
    call :reloadConfNginx
    GOTO MENU 

 ::打开SSL证书文件
:openWebSslFiles
    call :openWebSslFiles
    GOTO MENU

 ::打开SSL证书文件
:openDaemonSslFiles
    call :openDaemonSslFiles
    GOTO MENU

::*************************************************************************************
::底层
::*************************************************************************************
:shutdownNginx
    echo.
    echo.关闭Nginx反代......
    taskkill /F /IM nginx.exe > nul
    echo.已关闭Nginx进程
    goto :eof

:startNginx
    echo.
    echo.启动Nginx反代......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"不存在
        goto :eof
     )

    cd "%NGINX_DIR%"

    IF EXIST "%NGINX_DIR%nginx.exe" (
        echo "start '' nginx.exe"
        start "" nginx.exe
    )
    echo.OK
    goto :eof

:checkConfNginx
    echo.
    echo.检查测试 Nginx 配置文件......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"不存在
        goto :eof
     )

    cd "%NGINX_DIR%"
    nginx -t -c conf/nginx.conf
    goto :eof
 
::重新加载 nginx 配置文件
:reloadConfNginx
    echo.
    echo.重新加载 Nginx 配置文件......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"不存在
        goto :eof
     )

    cd "%NGINX_DIR%"
    nginx -s reload
	echo.已重载配置......
	TIMEOUT /T 3 /NOBREAK
    goto :eof
  
::打开Web端SSL证书文件
:openWebSslFiles
    echo.
    start notepad "%NGINX_DIR%\conf\ssl\Web\cert.pem"
    start notepad "%NGINX_DIR%\conf\ssl\Web\key.key"
    goto :eof
    
::打开Daemon端SSL证书文件
:openDaemonSslFiles
    echo.
    start notepad "%NGINX_DIR%\conf\ssl\Daemon\cert.pem"
    start notepad "%NGINX_DIR%\conf\ssl\Daemon\key.key"
    goto :eof