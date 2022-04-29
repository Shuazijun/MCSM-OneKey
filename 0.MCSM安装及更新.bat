@echo off
REM 提供Windows下MCSM和守护进程的检查更新功能
echo ================MCSM安装及更新================
::MCSM以及运行库所在目录
set MCSM_DIR=%~dp0
set GIT=%~dp0\Runtime\PortableGit\bin\git.exe
color 0a
TITLE MCSM安装及更新
CLS

:MENU
CLS
echo.=================MCSM安装及更新==================
echo.
    echo.  [1] 下载Web和Daemon到本地（Gitee）
    echo.  [2] 使用 Git 更新文件（强制覆盖）
    echo.  [3] 全量备份现有Web和Daemon文件
    echo.  [4] 刷新控制台 
echo.
echo.=================================================
echo.
	echo.  [0] 退 出
echo.
echo.=================================================
echo.请输入选择的序号:
set /p ID=
    IF "%id%"=="1" GOTO downloadwebanddaemon
    IF "%id%"=="2" GOTO gitupdate
    IF "%id%"=="3" GOTO backupfiles
    IF "%id%"=="4" GOTO MENU
    IF "%id%"=="0" EXIT
PAUSE

::*************************************************************************************************************

::通过Git下载
:downloadwebanddaemon
    call :downloadwebanddaemon
    GOTO MENU

::使用Git更新
:gitupdate
    call :gitupdate
    GOTO MENU


::备份文件
:backupfiles
    call:backupfiles
    GOTO MENU
    
::*************************************************************************************
::底层
::*************************************************************************************

:downloadwebanddaemon
    echo.
    echo.下载Web和Daemon到本地......
    cd %MCSM_DIR%
    echo.正在下载 MCSManager 面板程序......
    "%GIT%" clone https://gitee.com/mcsmanager/MCSManager-Web-Production.git
    echo.MCSManager 面板程序下载完成
    TIMEOUT /T 3
    echo.正在下载 MCSManager 守护进程......
    "%GIT%" clone https://gitee.com/mcsmanager/MCSManager-Daemon-Production.git
    echo.MCSManager 守护进程下载完成
    TIMEOUT /T 3
    echo.正在重命名文件夹
    ren "%MCSM_DIR%\MCSManager-Web-Production" "Web"
    echo.已重命名Web项目文件夹
    ren "%MCSM_DIR%\MCSManager-Daemon-Production" "Daemon"
    echo.已重命名Daemon项目文件夹
	echo.
	echo.=================================================
    echo.       下载已完成, 请使用运行库脚本安装依赖
    echo.=================================================
    echo.
    TIMEOUT /T 3
    goto :eof


:gitupdate
    echo.
    echo.正在更新 MCSManager 面板文件......
    echo.
    cd %MCSM_DIR%
	if not exist "Web" (
	echo. Web 目录不存在，请重新下载MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    cd %MCSM_DIR%\Web
    "%GIT%" init
    "%GIT%" remote add origin https://gitee.com/mcsmanager/MCSManager-Web-Production.git
    "%GIT%" fetch --all
    "%GIT%" reset --hard origin/master
    echo. MCSManager 面板程序更新完毕
    TIMEOUT /T 3
    echo.
    echo.正在更新 MCSManager 守护进程文件......
      
    cd %MCSM_DIR%
    if not exist "Daemon" (
	echo. Daemon 目录不存在，请重新下载MCSM
	TIMEOUT /T 3
	GOTO MENU
    )
    cd %MCSM_DIR%\Daemon
    "%GIT%" init
    "%GIT%" remote add origin https://gitee.com/mcsmanager/MCSManager-Daemon-Production.git
    "%GIT%" fetch --all
    "%GIT%" reset --hard origin/master
    echo. MCSManager 守护进程更新完毕
    echo.
    echo.=================================================
    echo.           更新已完成, 请留意更新日志
    echo.        个别版本可能需要删除依赖重新安装
    echo.=================================================
    echo.
    TIMEOUT /T 3
    goto :eof


:backupfiles
    echo.
    echo.正在全量备份本地的Web和Daemon......
    echo.具体时间依文件总量及大小不定
    echo.
    cd %MCSM_DIR%
    echo.检测文件是否存在......
	if not exist "Web" (
	echo. Web 目录不存在，请检查运行目录
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.Web 文件夹存在, 开始备份.....
    xcopy/e/y/d "%MCSM_DIR%\Web" "%MCSM_DIR%\Backups\Web"
    cd %MCSM_DIR%
    echo.检测文件是否存在......
    if not exist "Daemon" (
	echo. Daemon 目录不存在，请检查运行目录
	TIMEOUT /T 3
	GOTO MENU
    )
    echo.Daemon 文件夹存在, 开始备份.....
    xcopy/e/y/d "%MCSM_DIR%\Daemon" "%MCSM_DIR%\Backups\Daemon"
    echo.=================================================
    echo.               已完成全量备份
    echo.=================================================
    TIMEOUT /T 3
    goto :eof