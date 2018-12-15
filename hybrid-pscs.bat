<# ::
@echo off
powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main %*'"
goto :eof

.SYNOPSIS
This is a hybrid Batch/PowerShell script that embeds C# within PowerShell.
This is a simpler approach than the hybrid-csharp.bat because there's less up-front
scripting and the C# compilation is done in-memory.

.DESCRIPTION
The top of the script begins with <#:: which is a batch redirection direcctive
meaning that <#: will be parsed as :<# which looks like a label in a batch script
but <# is also a valid powershell comment opener.

The next line turns off echo for batch scripts but remember we're now in a PowerShell
comment block so this is meaningless when the script is loaded by PowerShell.

And the last important line is the third line which invokes powershell.exe, loading
the current script. Note also that it invokes the 'main' function in the content
so we must implement a 'main' function below. Finally, we pass %* into the main
function which is the command-line argument collection for the batch script.
#>

function main
{
	param(
		[string] $Argument1,
		[switch] $Argument2
	)

	$code = @'
namespace Hybrid
{
	using System;

	// classes and members must be publicly accessible to script
	public class Program
	{
		public static void Main (string[] args)
		{
			Console.WriteLine("... we can run C# with arg:" + args[0] + "!");
		}
	}
}
'@

	Add-Type -TypeDefinition $code -ReferencedAssemblies @('System') -Language CSharp

	[Hybrid.Program]::Main($Argument1)
}
