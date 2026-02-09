function Enter-TermuxDebug {
    $cmd = 'run-as com.termux sh -c ''export $(cat files/home/env | xargs) && exec bash'''

    # Check for device connection
    $deviceCheck = adb devices | Select-String -Pattern "\tdevice"
    if (-not $deviceCheck) {
        Write-Error "No ADB device found."
        return
    }
    Write-Host "🚀 Entering Termux (Debug Mode)..." -ForegroundColor Cyan
    adb shell -t $cmd
}

function Enter-Termux-root {    
    $cmd = 'uid=$(pm list packages -U | grep "com.termux " | grep -o "[0-9]*$" | head -n 1); su - $uid -c ''export $(cat /data/data/com.termux/files/home/env | xargs) && exec bash'''

    # Check connection
    $deviceCheck = adb devices | Select-String -Pattern "\tdevice"
    if (-not $deviceCheck) {
        Write-Error "No ADB device found."
        return
    }

    Write-Host "🚀 Entering Termux Root Shell..." -ForegroundColor Green
    adb shell -t $cmd
}
