# Usage as a shortcut: `powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -Noninteractive -File %UserProfile%\bin\Windows\Switch-Display-off.ps1 < nul`

$MethodDefinition = @'
[DllImport("user32.dll", SetLastError = true)]
public static extern int SendMessage(IntPtr hWnd, uint msg, IntPtr wParam, IntPtr lParam);
'@
$Kernel32 = Add-Type -MemberDefinition $MethodDefinition -Name 'Win32SendMessage' -Namespace Win32Functions -PassThru

# Params
# WindowHandle = HWND_TOPMOST (-1) ; see https://msdn.microsoft.com/en-us/library/windows/desktop/ms633545(v=vs.85).aspx
# Message = WM_SYSCOMMAND (0x0112)
# wParam  = SC_MONITORPOWER (0xF170)
# lParam: {
#     -1 (the display is powering on)
#     1 (the display is going to low power)
#     2 (the display is being shut off)
# }
$Kernel32::SendMessage(-1, 0x0112, 0xF170, 2);

# References
# * [Add-Type, call native Windows APIs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-6#examples)
# * [Windows API SendMessage](https://msdn.microsoft.com/en-us/library/windows/desktop/ms644950.aspx)
# * [WM_SYSCOMMAND](https://docs.microsoft.com/en-us/windows/desktop/menurc/wm-syscommand)
