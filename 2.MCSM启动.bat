@echo off
REM �ṩWindows��MCSM���ػ����̵��������������رչ���
echo ==================MCSM����==================
::MCSM�Լ����п�����Ŀ¼
set MCSM_DIR=%~dp0
color 0a
TITLE MCSM������ر�
CLS

:MENU
CLS
echo.==========Node �����б�=========
::tasklist|findstr /i "Node.exe"
tasklist /fi "imagename eq node.exe"
echo.
echo.
echo.=================================
echo.
    echo.  [1] ����Web��Daemon
    echo.  [2] �ر�Web��Daemon
    echo.  [3] ����Web��Daemon
    echo.  [4] ˢ�¿���̨ 
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
    IF "%id%"=="0" EXIT
PAUSE

::*************************************************************************************************************
::����
:start
    call :startMCSM
    GOTO MENU

::ֹͣ
:stop
    call :shutdownMCSM
    GOTO MENU

::����
:restart
    call :startMCSM
    call :shutdownMCSM
    GOTO MENU

::*************************************************************************************
::�ײ�
::*************************************************************************************
:shutdownMCSM
    echo.
    echo.�ر�MCSM��Web��Daemon......
    taskkill /F /IM node.exe > nul
    echo.�ѹر�Web��Daemon����
    TIMEOUT /T -2
    goto :eof

:startMCSM
    echo.
    echo.����MCSM��Web��Daemon......
    if not exist "%MCSM_DIR%\Web" (
	echo. Web �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%\Daemon" (
	echo. Daemon �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%\Web\node_modules" (
	echo. Web �����ļ��в�����, �밲װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%\Daemon\node_modules" (
	echo. Daemon �����ļ��в�����, �밲װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
	start cmd /k "cd /d %MCSM_DIR%\Daemon && node app.js"
	start cmd /k "cd /d %MCSM_DIR%\Web && node app.js"
    echo.MCSM������
    TIMEOUT /T -2
    goto :eof