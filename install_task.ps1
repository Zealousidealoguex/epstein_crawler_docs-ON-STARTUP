# Install a startup task that runs the Epstein crawler automatically

$TaskName = "EpsteinStartupScraper"
$ScriptPath = Join-Path $HOME "run_epstein_startup.ps1"

# Define the action: run PowerShell with the startup script
$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`"" `
    -WorkingDirectory "$HOME"

# Define the trigger: run at system startup
$Trigger = New-ScheduledTaskTrigger -AtStartup

# Define the principal: current user, highest privileges
$Principal = New-ScheduledTaskPrincipal `
    -UserId $env:USERNAME `
    -LogonType Interactive `
    -RunLevel Highest

# Register the task (overwrite if it already exists)
Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Trigger `
    -Principal $Principal `
    -Description "Runs the Epstein crawler at startup" `
    -Force
