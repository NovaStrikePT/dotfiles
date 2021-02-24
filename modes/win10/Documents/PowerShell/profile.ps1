# CurrentUserAllHosts profile
# See $PROFILE | Format-List * -Force
# See also https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/

# Customize PSReadLine behavior
    # Disable default history handler (sensitive info in command history DISCLAIMER). See PowerShell/PSReadLine pull 1058
    # Picking a default from PowerShell session history default $MaximumHistoryCount
    # Because bells…
Set-PSReadLineOption `
    -AddToHistoryHandler $null `
    -MaximumHistoryCount 4096  `
    -BellStyle           None  `
    -PredictionSource    History
;

# Map PSReadLine key handlers using chords VSCode understands in its integrated terminals so that default keys work
# like the external terminal (e.g. Ctrl+Backspace, Ctrl+Del, Ctrl+Space)
# See also PowerShell vscode-powershell issue 535
if ($env:TERM_PROGRAM -eq "vscode")
{
    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Chord 'Alt+D' -Function KillWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+@' -Function MenuComplete
}

# `rg` aliases
function arg
{
    rg.exe --hidden --pretty --smart-case --no-ignore-vcs --glob !.git $args
}

# Human-readable file sizes
# Source: https://superuser.com/questions/468782/show-human-readable-file-sizes-in-the-default-powershell-ls-command#answer-468795
# Example usage: Get-ChildItem | Select-Object Name, @{Name="Size";Expression={Format-FileSize($_.Length)}}
function Format-FileSize
{
    Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [uint64]
        $size
    )
    If     ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
    ElseIf ($size -gt 0)   {[string]::Format("{0:0.00} B" , $size)}
    Else                   {""}
}

# Compare input objects for equality
# Returns true if and only if all inputs have matching hash contents
function Compare-FileHashes
{
    Param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string[]]
        $InputObjects,

        [Parameter()]
        [ValidateSet('SHA1', 'SHA256', 'SHA384', 'SHA512', 'MD5')]  # See Get-FileHash
        [string]
        $Algorithm = 'SHA256'
    )

    # Map each input object to a hash value
    # Initialize the mapping result to match length; by default we assume a literal hash value is given as input (see loop below)
    $hashes = $($InputObjects)  # Use subexpression $() to force array copy

    # Every hash in the array must match to return a $true result; $false if at least one item doesn't match
    $areEqual = $true

    for ($i = 0 ; $i -lt $InputObjects.Length ; $i++)
    {
        $obj = $InputObjects[$i]

        # If the input object is a file path, compute its hash value
        if (Test-Path -Path $obj -PathType Leaf)
        {
            $hashes[$i] = (Get-FileHash -Algorithm $Algorithm -Path $obj).Hash
        }
        # Otherwise, by default, the input object is taken to be a literal hash value

        # Short-circut:
        # * Once a mismatch is detected, we don't need to continue checking
        # * Nothing to compare first object to
        # Use case-insensitive comparison for file hash values
        if ($areEqual -and ($i -gt 0) -and ($hashes[$i] -ne $hashes[$i - 1]))
        {
            $areEqual = $false
        }
    }

    # Prepare the return value as a custom object
    return [PSCustomObject]@{
        Algorithm = $Algorithm;
        InputObjects = $InputObjects;
        Hashes = $hashes;
        AreEqual = $areEqual
    }
}

# Confer with `Find-Module -Name Recycle`
Set-Alias -Name recycle -Value Remove-ItemSafely

# Last bootup time
function Get-LastBootupTime
{
    return (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
}

# At least until PowerShell/PowerShell issue 2289 has a solution
# Not intended to be a complete replacement for https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-command
function MyMeasure-Command
{
    Param(
        [Parameter(Mandatory=$true)]
        [ScriptBlock]
        $Expression
    )

    $stopwatch = New-Object 'System.Diagnostics.Stopwatch'
    $stopwatch.Start()

    & $Expression
    
    $stopwatch.Stop()

    Write-Host "`nElapsed:" $stopwatch.Elapsed.ToString()
    Write-Host "Finished:" (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
}

# Use rg and fd ArgumentCompleter registrations
. $HOME\bin\Windows\_rg.ps1
. $HOME\bin\Windows\_fd.ps1

# Import posh-git
Import-Module posh-git

# Add a newline after prompt (requires posh-git 1.0+)
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`nPS'

# Green path
$GitPromptSettings.DefaultPromptPath.ForegroundColor = 'Green'
