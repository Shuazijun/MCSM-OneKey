@echo off
REM �ṩWindows��MCSM���ػ����̵��������������رչ���
echo ==================MCSM����==================
::MCSM�Լ����п�����Ŀ¼
set MCSM_DIR=%~dp0
set DAEMONTITLE="MCSM-�ػ�����"
color 0a
TITLE ���ػ�����������ر�
CLS

:MENU
CLS
echo.========MCSM �ػ������б�========
tasklist /fi "imagename eq cmd.exe" /fi "windowtitle eq %DAEMONTITLE%"
tasklist /fi "imagename eq node.exe"
echo.
echo.
echo.=================================
echo.
    echo.  [1] ����Daemon
    echo.  [2] �ر�Daemon
    echo.  [3] ����Daemon
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
    IF "%id%"=="5" GOTO MENU
    IF "%id%"=="6" GOTO MENU
    IF "%id%"=="7" GOTO MENU
    IF "%id%"=="8" GOTO MENU
    IF "%id%"=="9" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE
GOTO MENU

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
    taskkill /F /T /fi "imagename eq cmd.exe" /fi "windowtitle eq %DAEMONTITLE%" > nul
    echo.�ѹر�Daemon����
    TIMEOUT /T 3
    goto :eof

:startMCSM
    echo.
    echo.����MCSM��Daemon......
    if not exist "%MCSM_DIR%Daemon" (
	echo. Daemon �ļ��в�����, �����ذ�װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
    if not exist "%MCSM_DIR%Daemon\node_modules" (
	echo. Daemon �����ļ��в�����, �밲װ����ʹ��
	TIMEOUT /T 3
	GOTO MENU
    )
	start "MCSM-�ػ�����" /min cmd.exe /c "cd %MCSM_DIR%Daemon && node app.js"
    echo.MCSM������
    TIMEOUT /T 3
    goto :eof