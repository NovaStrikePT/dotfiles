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
function Format-FileSize()
{
    Param ([uint64]$size)
    If     ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
    ElseIf ($size -gt 0)   {[string]::Format("{0:0.00} B" , $size)}
    Else                   {""}
}

# Confer with `Find-Module -Name Recycle`
Set-Alias -Name recycle -Value Remove-ItemSafely

# Last bootup time
function Get-LastBootupTime
{
    return (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
}