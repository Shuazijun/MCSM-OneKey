@echo off
REM �ṩWindows��MCSM���пⰲװ��ж��
echo ==================MCSM���п����==================
::MCSM�Լ����п�����Ŀ¼
set MCSM_DIR=%~dp0
set WGET=%~dp0Runtime\Wget\wget.exe
color 0a
TITLE MCSM���п����
CLS

:MENU
CLS
color 0a
echo.
echo.=============MCSM���п����=============
echo.
    echo.  [1] ���ذ�װ Node.JS ������v14.19.2��
    echo.  [2] ��װWebǰ�˺�Daemon�ػ����̵�����
    echo.  [3] ɾ��Webǰ�˺�Daemon�ػ����̵�����
    echo.
    echo.============�����Լ��ļ�����============
    echo.
    echo.  [4] ��Webǰ������Ŀ¼
    echo.  [5] ��Web�����ļ�
    echo.
    echo.  [6] ��Daemon����Ŀ¼
    echo.  [7] ��Daemon�����ļ�
    echo.
    echo.==================����==================
    echo.
    echo.  [0] �� ��
    echo.
    echo.========================================
echo.

echo.������ѡ������:
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
::��װ Node.JS 14.19.1 x64 ����
:installnodejs
    call :installnodejs
    GOTO MENU

::��װWebǰ�˺�Daemon�ػ����̵�����
:installwebanddaemon
    if not exist "%MCSM_DIR%Web" (
	echo. Web �ļ��в����ڣ�����������MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    call :installweb
    echo.========================================
    echo.            Web������װ���
    echo.========================================
    TIMEOUT /T 3
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon �ļ��в����ڣ�����������MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    call :installdaemon
    echo.========================================
    echo.           Daemon������װ���
    echo.========================================
    TIMEOUT /T 3
    GOTO MENU

::ɾ��Webǰ�˺�Daemon�ػ����̵�����
:uninstallwebanddaemon
    call :uninstallwebanddaemon
    GOTO MENU

::��Webǰ������Ŀ¼
:openweb
    call :openweb
    GOTO MENU

::��Daemon�ػ���������Ŀ¼
:opendaemon
    call :opendaemon
    GOTO MENU

::��Web�����ļ�
:openwebconfig
    call :openwebconfig
    GOTO MENU  

 ::��Daemon�ػ����������ļ�
:opendaemonconfig
    call :opendaemonconfig
    GOTO MENU

::*************************************************************************************
::�ײ�
::*************************************************************************************
:installnodejs
    echo.
    echo.�������� Node.JS 14.19.2 x64 ������װ��......
    echo.
    cd %MCSM_DIR%Runtime\NodeJS
    "%WGET%" https://nodejs.org/download/release/v14.19.2/node-v14.19.2-x64.msi
    if not exist "%MCSM_DIR%Runtime\NodeJS\node-v14.19.2-x64.msi" (
	echo. node-v14.19.2-x64.msi �����ڣ�������������
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.���سɹ�!
	echo.���ڰ�װ,��ȴ���װ���......
	start "" /wait "msiexec" /i "%MCSM_DIR%Runtime\NodeJS\node-v14.19.2-x64.msi" /qb
	echo.========================================
    echo.           NodeJS��װ���
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:installweb
    echo.
    echo.��װWeb����......
	cd %MCSM_DIR%Web && npm install
    goto :eof

:installdaemon
    echo.
    echo.��װDaemon����......
	cd %MCSM_DIR%Daemon && npm install
    goto :eof

:uninstallwebanddaemon
	echo.
    echo.����ɾ��Web������......
    if not exist "%MCSM_DIR%Web" (
	echo. Web �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    rd /s /q %MCSM_DIR%Web\node_modules
    del /f /s /q %MCSM_DIR%Web\package-lock.json
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
	echo.����ɾ��Daemon������......
    rd /s /q %MCSM_DIR%Daemon\node_modules
    del /f /s /q %MCSM_DIR%Daemon\package-lock.json
    echo.========================================
    echo.           ����ɾ�����
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:openweb
	echo.
	if not exist "%MCSM_DIR%Web" (
	echo. Web �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    start "" "%MCSM_DIR%Web"
    goto :eof

:opendaemon
	echo.
	if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    start "" "%MCSM_DIR%Daemon"
    goto :eof

:openwebconfig
	echo.
	if not exist "%MCSM_DIR%Web" (
	echo. Web �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Web\data\SystemConfig\config.json" (
	echo. Web �����ļ�������, �����к�����
	TIMEOUT /T 3
	GOTO MENU
    )
    start notepad "%MCSM_DIR%Web\data\SystemConfig\config.json"
    goto :eof

:opendaemonconfig
	echo.
	if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Daemon\data\Config\global.json" (
	echo. Daemon �����ļ�������, �����к�����
	TIMEOUT /T 3
	GOTO MENU
    )
    start notepad "%MCSM_DIR%Daemon\data\Config\global.json"
    goto :eof