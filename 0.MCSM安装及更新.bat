@echo off
REM �ṩWindows��MCSM���ػ����̵ļ����¹���
echo ================MCSM��װ������================
::MCSM�Լ����п�����Ŀ¼
set MCSM_DIR=%~dp0
set GIT=%~dp0\Runtime\PortableGit\bin\git.exe
color 0a
TITLE MCSM��װ������
CLS

:MENU
CLS
echo.=================MCSM��װ������==================
echo.
    echo.  [1] ����Web��Daemon�����أ�Gitee��
    echo.  [2] ʹ�� Git �����ļ���ǿ�Ƹ��ǣ�
    echo.  [3] ȫ����������Web��Daemon�ļ�
    echo.  [4] ˢ�¿���̨ 
echo.
echo.=================================================
echo.
	echo.  [0] �� ��
echo.
echo.=================================================
echo.������ѡ������:
set /p ID=
    IF "%id%"=="1" GOTO downloadwebanddaemon
    IF "%id%"=="2" GOTO gitupdate
    IF "%id%"=="3" GOTO backupfiles
    IF "%id%"=="4" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE

::*************************************************************************************************************

::ͨ��Git����
:downloadwebanddaemon
    call :downloadwebanddaemon
    GOTO MENU

::ʹ��Git����
:gitupdate
    call :gitupdate
    GOTO MENU


::�����ļ�
:backupfiles
    call:backupfiles
    GOTO MENU
    
::*************************************************************************************
::�ײ�
::*************************************************************************************

:downloadwebanddaemon
    echo.
    echo.����Web��Daemon������......
    cd %MCSM_DIR%
    echo.�������� MCSManager ������......
    "%GIT%" clone https://gitee.com/mcsmanager/MCSManager-Web-Production.git
    echo.MCSManager �������������
    TIMEOUT /T 3
    echo.�������� MCSManager �ػ�����......
    "%GIT%" clone https://gitee.com/mcsmanager/MCSManager-Daemon-Production.git
    echo.MCSManager �ػ������������
    TIMEOUT /T 3
    echo.�����������ļ���
    ren "%MCSM_DIR%\MCSManager-Web-Production" "Web"
    echo.��������Web��Ŀ�ļ���
    ren "%MCSM_DIR%\MCSManager-Daemon-Production" "Daemon"
    echo.��������Daemon��Ŀ�ļ���
	echo.
	echo.=================================================
    echo.       ���������, ��ʹ�����п�ű���װ����
    echo.=================================================
    echo.
    TIMEOUT /T 3
    goto :eof


:gitupdate
    echo.
    echo.���ڸ��� MCSManager ����ļ�......
    echo.
    cd %MCSM_DIR%
	if not exist "Web" (
	echo. Web Ŀ¼�����ڣ�����������MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    cd %MCSM_DIR%\Web
    "%GIT%" init
    "%GIT%" remote add origin https://gitee.com/mcsmanager/MCSManager-Web-Production.git
    "%GIT%" fetch --all
    "%GIT%" reset --hard origin/master
    echo. MCSManager ������������
    TIMEOUT /T 3
    echo.
    echo.���ڸ��� MCSManager �ػ������ļ�......
      
    cd %MCSM_DIR%
    if not exist "Daemon" (
	echo. Daemon Ŀ¼�����ڣ�����������MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    cd %MCSM_DIR%\Daemon
    "%GIT%" init
    "%GIT%" remote add origin https://gitee.com/mcsmanager/MCSManager-Daemon-Production.git
    "%GIT%" fetch --all
    "%GIT%" reset --hard origin/master
    echo. MCSManager �ػ����̸������
    echo.
    echo.=================================================
    echo.           ���������, �����������־
    echo.        ����汾������Ҫɾ���������°�װ
    echo.=================================================
    echo.
    TIMEOUT /T 3
    goto :eof


:backupfiles
    echo.
    echo.����ȫ�����ݱ��ص�Web��Daemon......
    echo.����ʱ�����ļ���������С����
    echo.
    cd %MCSM_DIR%
    echo.����ļ��Ƿ����......
	if not exist "Web" (
	echo. Web Ŀ¼�����ڣ���������Ŀ¼
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.Web �ļ��д���, ��ʼ����.....
    xcopy/e/y/d "%MCSM_DIR%\Web" "%MCSM_DIR%\Backups\Web"
    cd %MCSM_DIR%
    echo.����ļ��Ƿ����......
    if not exist "Daemon" (
	echo. Daemon Ŀ¼�����ڣ���������Ŀ¼
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.Daemon �ļ��д���, ��ʼ����.....
    xcopy/e/y/d "%MCSM_DIR%\Daemon" "%MCSM_DIR%\Backups\Daemon"
    echo.=================================================
    echo.               �����ȫ������
    echo.=================================================
    TIMEOUT /T 3
    goto :eof