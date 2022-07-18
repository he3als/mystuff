@echo off
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell -NonInteractive -NoProfile Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Set strong cryptography on 64 bit and 32 bit .Net Framework (version 4 and above) to fix a Scoop installation issue
:: https://github.com/ScoopInstaller/Scoop/issues/2040#issuecomment-369686748
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /v "SchUseStrongCrypto" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NetFramework\v4.0.30319" /v "SchUseStrongCrypto" /t REG_DWORD /d "1" /f
echo PowerShell TLS issues should be fixed, restart your computer.
pause