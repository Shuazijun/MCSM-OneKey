@echo off
REM �ṩWindows��OpenJDK���пⰲװ��ж��
echo ==================MCSM���п����==================
::MCSM�Լ����п�����Ŀ¼
set MCSM_DIR=%~dp0
set WGET=%~dp0Runtime\Wget\wget.exe
color 0a
TITLE OpenJDK ��װ����
CLS

:MENU
CLS
color 0a
echo.
echo.=============OpenJDK ��װ����=============
echo.
    echo.  [1] ���ذ�װ Microsoft OpenJDK 17
    echo.  [2] ж�� Microsoft OpenJDK 17
    echo.
    echo.  [3] ���ذ�װ Microsoft OpenJDK 11
    echo.  [4] ж�� Microsoft OpenJDK 11
    echo.
    echo.  [5] ���ذ�װ Adoptium OpenJDK 8
    echo.  [6] ж�� Adoptium OpenJDK 8
    echo.
    echo.  [0] �� ��
    echo.
    echo.========================================
echo.

echo.������ѡ������:
set /p ID=
    IF "%id%"=="1" GOTO installmopenjdk17
    IF "%id%"=="2" GOTO uninstallmopenjdk17
    IF "%id%"=="3" GOTO installmopenjdk11
    IF "%id%"=="4" GOTO uninstallmopenjdk11
    IF "%id%"=="5" GOTO installaopenjdk8
    IF "%id%"=="6" GOTO uninstallaopenjdk8
    IF "%id%"=="7" GOTO MENU
    IF "%id%"=="8" GOTO MENU
    IF "%id%"=="9" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE
GOTO MENU

::*************************************************************************************************************
::��װ Microsoft OpenJDK 17.0.2.8.1 x64 ����
:installmopenjdk17
    call :installmopenjdk17
    GOTO MENU
    
:uninstallmopenjdk17
    call :uninstallmopenjdk17
    GOTO MENU

:installmopenjdk11
    call :installmopenjdk11
    GOTO MENU

:uninstallmopenjdk11
    call :uninstallmopenjdk11
    GOTO MENU

:installaopenjdk8
    call :installaopenjdk8
    GOTO MENU

:uninstallaopenjdk8
    call :uninstallaopenjdk8
    GOTO MENU

::*************************************************************************************
::�ײ�
::*************************************************************************************
:installmopenjdk17
    echo.
    echo.�������� Microsoft OpenJDK 17.0.2.8.1 x64 ��װ��......
    echo.
    cd %MCSM_DIR%Runtime\OpenJDK
    "%WGET%" https://aka.ms/download-jdk/microsoft-jdk-17.0.2.8.1-windows-x64.msi
    if not exist "%MCSM_DIR%Runtime\OpenJDK\microsoft-jdk-17.0.2.8.1-windows-x64.msi" (
	echo. microsoft-jdk-17.0.2.8.1-windows-x64.msi �����ڣ�������������
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.���سɹ�!
	echo.���ڰ�װ,��ȴ���װ���......
	start "" /wait "msiexec" /i "%MCSM_DIR%Runtime\OpenJDK\microsoft-jdk-17.0.2.8.1-windows-x64.msi" /qb
	echo.========================================
    echo.  Microsoft OpenJDK 17.0.2.8.1 ��װ���
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:uninstallmopenjdk17
    echo.
    echo.����ж�� Microsoft OpenJDK 17.0.2.8.1 x64 ......
	start "" /wait "msiexec" /x "{A34F9424-5651-47B0-825B-9C761BB7430B}" /qb
	echo.========================================
    echo.  Microsoft OpenJDK 17.0.2.8.1 ж�����
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:installmopenjdk11
    echo.
    echo.�������� Microsoft OpenJDK 11.0.14.1_1-31205 x64 ��װ��......
    echo.
    cd %MCSM_DIR%Runtime\OpenJDK
    "%WGET%" https://aka.ms/download-jdk/microsoft-jdk-11.0.14.1_1-31205-windows-x64.msi
    if not exist "%MCSM_DIR%Runtime\OpenJDK\microsoft-jdk-11.0.14.1_1-31205-windows-x64.msi" (
	echo. microsoft-jdk-11.0.14.1_1-31205-windows-x64.msi �����ڣ�������������
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.���سɹ�!
	echo.���ڰ�װ,��ȴ���װ���......
	start "" /wait "msiexec" /i "%MCSM_DIR%Runtime\OpenJDK\microsoft-jdk-11.0.14.1_1-31205-windows-x64.msi" /qb
	echo.========================================
    echo.  Microsoft OpenJDK 11.0.14.1_1-31205 ��װ���
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:uninstallmopenjdk11
    echo.
    echo.����ж�� Microsoft OpenJDK 11.0.14.1_1-31205 x64 ......
	start "" /wait "msiexec" /x "{3F6CD372-8CEB-451E-90F4-7D7DD1F99F15}" /qb
	echo.========================================
    echo.  Microsoft OpenJDK 11.0.14.1_1-31205 ж�����
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:installaopenjdk8
    echo.
    echo.�������� Adoptium OpenJDK 8u322 x64 ��װ��......
    echo.
    cd %MCSM_DIR%Runtime\OpenJDK
    "%WGET%" https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jdk_x64_windows_hotspot_8u322b06.msi
    if not exist "%MCSM_DIR%Runtime\OpenJDK\OpenJDK8U-jdk_x64_windows_hotspot_8u322b06.msi" (
	echo. OpenJDK8U-jdk_x64_windows_hotspot_8u322b06.msi �����ڣ�������������
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.���سɹ�!
	echo.���ڰ�װ,��ȴ���װ���......
	start "" /wait "msiexec" /i "%MCSM_DIR%Runtime\OpenJDK\OpenJDK8U-jdk_x64_windows_hotspot_8u322b06.msi" /qb
	echo.========================================
    echo.  Adoptium OpenJDK 8u322 ��װ���
    echo.========================================
    TIMEOUT /T 3
    goto :eof

:uninstallaopenjdk8
    echo.
    echo.����ж�� Adoptium OpenJDK 8u322 x64 ......
	start "" /wait "msiexec" /x "{774E681F-595E-4587-BFA5-B4B45D7BB2F0}" /qb
	echo.========================================
    echo.  Adoptium OpenJDK 8u322 ж�����
    echo.========================================
    TIMEOUT /T 3
    goto :eof