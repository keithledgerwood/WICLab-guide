$labName=$labName.replace('demo-','')
echo "Running as Lab Name: $labName"

 #Type needed for MoveWindow & Screen Size
 Add-Type '
 using System;
 using System.Runtime.InteropServices;

 public class Win32 {
     [DllImport("user32.dll")]
     [return: MarshalAs(UnmanagedType.Bool)]
     public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
 }
' -PassThru

Add-Type -AssemblyName System.Windows.Forms

#Open Google Chrome LaunchPad app and Chrome Windows into Appropriate Positions
$screen=[System.Windows.Forms.SystemInformation]::PrimaryMonitorSize

$googleapp = Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ArgumentList "https://demo-$($labName).okta.com --window-size=$($screen.Width-600),$($screen.Height) --window-position=150,0 " -PassThru
Start-Sleep -Milliseconds 1000
$launchpadapp = Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ArgumentList "-app=https://labs.demo.okta.com/lab/$($labName)?LaunchPanel" -PassThru
Start-Sleep -Milliseconds 3000
$result = [Win32]::MoveWindow($googleapp.MainWindowHandle, $($screen.Width-450), (0 - 10000), 450, $($screen.Height-25), $true) -and [Win32]::MoveWindow($googleapp.MainWindowHandle, $($screen.Width-450), (0), 450, $($screen.Height-25), $true)
Start-Sleep -Milliseconds 1000
$result = [Win32]::MoveWindow($googleapp.MainWindowHandle, $($screen.Width-450), (0 - 10000), 450, $($screen.Height-25), $true) -and [Win32]::MoveWindow($googleapp.MainWindowHandle, $($screen.Width-450), (0), 450, $($screen.Height-25), $true)

exit