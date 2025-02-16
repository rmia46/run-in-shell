# Function to write messages with a delay and color
function Write-ColorMessage {
    param (
        [string]$message,
        [ConsoleColor]$color = [ConsoleColor]::White,
        [int]$delay = 1
    )
    Write-Host $message -ForegroundColor $color
    Start-Sleep -Seconds $delay
    Write-Host "`n"  # New line for better readability
}

# Define the URL of the GitHub file to be appended
$githubUrl = "https://raw.githubusercontent.com/rmia46/run-in-shell/refs/heads/main/Microsoft.PowerShell_profile.ps1"

# Get the path of the PowerShell profile
$profilePath = $PROFILE

# Check if the profile file exists
if (-Not (Test-Path $profilePath)) {
    # Create the profile file if it does not exist
    New-Item -Path $profilePath -Type File -Force
    Write-ColorMessage "PowerShell profile created at $profilePath" -color Green
} else {
    Write-ColorMessage "PowerShell profile already exists at $profilePath" -color Yellow
}

# Download the content from the GitHub URL
try {
    $content = Invoke-RestMethod -Uri $githubUrl -ErrorAction Stop
} catch {
    Write-ColorMessage "Failed to download the profile content from GitHub. Please check the URL." -color Red
    exit
}

# Append the content to the profile
Add-Content -Path $profilePath -Value $content
Write-ColorMessage "Content from GitHub has been appended to $profilePath" -color Cyan

# Set the execution policy to RemoteSigned
try {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-ColorMessage "Execution policy set to RemoteSigned" -color Green
} catch {
    Write-ColorMessage "Failed to set execution policy. You may need to run PowerShell as an administrator." -color Red
}

# Notify the user to reload their PowerShell session
Write-ColorMessage "Please restart your PowerShell session to apply the changes." -color Magenta

# Wait for user input before closing
Read-Host -Prompt "Press Enter to exit..."