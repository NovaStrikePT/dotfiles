# Disable term bell
Set-PSReadlineOption -BellStyle None

# Map PSReadLine key handlers using chords VSCode understands in its integrated terminals so that default keys work
# like the external terminal (e.g. Ctrl+Backspace, Ctrl+Del, Ctrl+Space)
# See also PowerShell vscode-powershell issue 535
if ($env:TERM_PROGRAM -eq "vscode") {
    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Chord 'Alt+D' -Function KillWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+@' -Function MenuComplete
}

# `rg` aliases
function arg {
    rg.exe --hidden --pretty --smart-case --no-ignore-vcs --glob !.git $args
}

# Confer with `Find-Module -Name Recycle`
Set-Alias -Name recycle -Value Remove-ItemSafely

# Last bootup time
function Last-Bootup-Time {
    return (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
}