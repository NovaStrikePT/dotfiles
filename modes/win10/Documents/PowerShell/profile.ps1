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

#region Override default key bindings for PSReadLine's prediction suggestions

# Copied from PowerShell/PSReadLine f8fb650774a0c0e9421d9389f4a6dee5b8718b07 SamplePSReadLineProfile.ps1#L585-L602
# "Out of the box", `ForwardChar` accepts the entire suggestion text when the cursor is at the end of the line.
# This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
Set-PSReadLineKeyHandler -Key RightArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "Move cursor one character to the right in the current editing line or accept the next word in suggestion when it's at the end of current editing line" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -lt $line.Length) {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    }
}

# Adapted from the ForwardChar above 👆
# This custom binding makes `End` do what `ForwardChar` did: accept the entire suggestion text when the cursor is at the end of the line.
Set-PSReadLineKeyHandler -Key End `
                         -BriefDescription EndOfLineAndAcceptSuggestion `
                         -LongDescription "Move cursor to the end of the current editing line or accept the suggestion when it's at the end of current editing line" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -lt $line.Length) {
        [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
    }
}
#endregion

# Set custom VS Code-specific PSReadLine behaviors
if ($env:TERM_PROGRAM -eq "vscode")
{
    # Map PSReadLine key handlers using chords VSCode understands in its integrated terminals so that default keys work
    # like the external terminal (e.g. Ctrl+Backspace, Ctrl+Del, Ctrl+Space)
    # See also PowerShell vscode-powershell issue 535
    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Chord 'Alt+D' -Function KillWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+@' -Function MenuComplete

    # The default InlinePredictionColor appears to be reduced to black in VS Code, rendering it indistinguishable from a dark background theme
    # Here is the default: `Set-PSReadLineOption -Colors @{ InlinePrediction = "$([char]0x1b)[38;5;238m" }`
    # Setting it to a ConsoleColor seems to work just fine
    Set-PSReadLineOption -Colors @{ InlinePrediction = [ConsoleColor]::DarkGray }
}

# `rg` aliases
function arg
{
    rg.exe --hidden --pretty --smart-case --no-ignore-vcs --glob !.git $args
}

<#
.SYNOPSIS
Shorthand for creating a symbolic link

.PARAMETER Target
The link target

.PARAMETER LinkPath
The link to create

.PARAMETER UseTheForce
Allows overwriting LinkPath if it already exists

.EXAMPLE
PS> New-Symlink .\README.md my-symlinks\overwrite-me.md

.EXAMPLE
PS> New-Symlink -UseTheForce .\README.md my-symlinks\overwrite-me.md

#>
function New-Symlink
{
    Param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]
        $Target,

        [Parameter(Mandatory=$true, Position=1)]
        [string]
        $LinkPath,

        [Parameter(Mandatory=$false)]
        [Switch]
        $UseTheForce
    )

    # $Target must be a resolvable path; otherwise, generate a terminating error
    $resolvedPath = Resolve-Path $Target -ErrorAction Stop

    # Variable parameters via splatting (see https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting)
    $newItemParams = @{
        ItemType = "SymbolicLink";
        Target   = $resolvedPath;
        Path     = $LinkPath;
        Force    = $UseTheForce
    }
    New-Item @newItemParams
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

# Use rg and fd ArgumentCompleter registrations
. $HOME\bin\Windows\_rg.ps1
. $HOME\bin\Windows\_fd.ps1

# Import posh-git
Import-Module posh-git

# Add a newline after prompt (requires posh-git 1.0+)
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`nPS'

# Color the path portion of the prompt
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::DarkGreen
