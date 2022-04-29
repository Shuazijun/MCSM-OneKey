@echo off
REM �ṩWindows��nginx���ػ����̵��������������رչ���
echo. ==================MCSMһ������==================

CLS
::nginx ����Ŀ¼
set NGINX_DIR=%~dp0
color 0a
TITLE MCSM��������
CLS

:MENU
CLS
echo.==========Nginx �����б�=========
::tasklist|findstr /i "nginx.exe"
tasklist /fi "imagename eq nginx.exe"
echo.
echo.
echo.=================================
echo.
    echo.  [1] ����Nginx����
    echo.  [2] �ر�Nginx����
    echo.  [3] ����Nginx����
    echo.  [4] ˢ�¿���̨ 
    echo.  [5] ���¼���Nginx�����ļ�
    echo.  [6] ������Nginx�����ļ�
echo.
echo.============֤�����=============
echo.
    echo.  [7] ��Web��SSL֤���ļ�
    echo.  [8] ��Daemon��SSL֤���ļ�
echo.
echo.=================================
echo.
	echo.  [0] �� ��
echo.
echo.=================================
echo.������ѡ������:
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
::����
:start
    call :startNginx
    GOTO MENU

::ֹͣ
:stop
    call :shutdownNginx
    GOTO MENU

::����
:restart
    call :shutdownNginx
    call :startNginx
    GOTO MENU

::�����������ļ�
:checkConf
    call :checkConfNginx
    TIMEOUT /T -1
    GOTO MENU

::���¼���Nginx�����ļ�
:reloadConf
    call :checkConfNginx
    call :reloadConfNginx
    GOTO MENU 

 ::��SSL֤���ļ�
:openWebSslFiles
    call :openWebSslFiles
    GOTO MENU

 ::��SSL֤���ļ�
:openDaemonSslFiles
    call :openDaemonSslFiles
    GOTO MENU

::*************************************************************************************
::�ײ�
::*************************************************************************************
:shutdownNginx
    echo.
    echo.�ر�Nginx����......
    taskkill /F /IM nginx.exe > nul
    echo.�ѹر�Nginx����
    goto :eof

:startNginx
    echo.
    echo.����Nginx����......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
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
    echo.������ Nginx �����ļ�......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
        goto :eof
     )

    cd "%NGINX_DIR%"
    nginx -t -c conf/nginx.conf
    goto :eof
 
::���¼��� nginx �����ļ�
:reloadConfNginx
    echo.
    echo.���¼��� Nginx �����ļ�......
    IF NOT EXIST "%NGINX_DIR%nginx.exe" (
        echo "%NGINX_DIR%nginx.exe"������
        goto :eof
     )

    cd "%NGINX_DIR%"
    nginx -s reload
	echo.����������......
	TIMEOUT /T 3 /NOBREAK
    goto :eof
  
::��Web��SSL֤���ļ�
:openWebSslFiles
    echo.
    start notepad "%NGINX_DIR%\conf\ssl\Web\cert.pem"
    start notepad "%NGINX_DIR%\conf\ssl\Web\key.key"
    goto :eof
    
::��Daemon��SSL֤���ļ�
:openDaemonSslFiles
    echo.
    start notepad "%NGINX_DIR%\conf\ssl\Daemon\cert.pem"
    start notepad "%NGINX_DIR%\conf\ssl\Daemon\key.key"
    goto :eof