//>nul 2>nul || @echo off && goto :batch
/*
:batch
setlocal
set framework=%SystemRoot%\Microsoft.NET\Framework
for /f "tokens=* delims=" %%v in ('dir /b /a:d /o:-n "%framework%\v*"') do (
   set version=%%v
   goto :found_version
)
:found_version
set csc=%framework%\%version%\csc.exe
set program=%~n0.hybrid.exe
call %csc% /nologo /out:"%program%" "%~dpsfnx0" 
%program%
set lastExitCode=%ERRORLEVEL%
del /f %program%
endlocal
exit /b %lastExitCode%
*/

namespace BatchHybrid
{
	using System;

	class Program
	{
		static void Main (string[] args)
		{
			Console.WriteLine("... we can run C#!");
		}
	}
}
