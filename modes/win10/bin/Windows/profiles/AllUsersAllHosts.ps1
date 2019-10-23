# Disable term bell
Set-PSReadlineOption -BellStyle None

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