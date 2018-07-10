# Disable term bell
Set-PSReadlineOption -BellStyle None

# `rg` aliases
function arg {
    rg.exe --hidden --pretty --smart-case --glob !.git $args
}

# Use a specialized profile to start Git bash for Windows
# See git-bash-for-windows.profile
function git-bash {
    & $env:ProgramFiles\Git\bin\bash.exe --init-file $HOME\git-bash-for-windows.profile $args
}

# Confer with `Find-Module -Name Recycle`
Set-Alias -Name recycle -Value Remove-ItemSafely

# Always start in $HOME, even when running with elevated privileges (Administrator)
# (or with a GPO'd HOMEDRIVE/HOMEPATH/HOMESHARE)
Set-Location $HOME