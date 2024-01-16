using Godot;
using System;
using System;
using System.Diagnostics;
using System.ComponentModel;

public partial class ApiLauncher : Node
{
	[Signal]
	public delegate void ConsoleOutputEventHandler(string output);

	private bool isServiceLogsStarted = false;
	private string logs = "";
	private string prevSentLogs = "PREV";
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		RunCommand("cd node && npm i && npm run dev", true);
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (logs != prevSentLogs)
		{
			EmitSignal(SignalName.ConsoleOutput, logs);
			this.prevSentLogs = logs;
		}
		
	}

	private void FormatOutput(string data) 
	{
		if (data == "The server is running on port 6060") 
		{
			this.isServiceLogsStarted = true;
			return;
		}
		if (data.Contains("POST")) 
		{
			return;
		}
		if (this.isServiceLogsStarted == true) 
		{
			this.logs += data + '\n';
		}
		
	}

	private void RunCommand(string command, bool isLog)
	{
		var process = new Process()
						  {
							  StartInfo = new ProcessStartInfo("cmd")
							   {
							   UseShellExecute = false,
							   RedirectStandardInput = true,
							   RedirectStandardOutput = true,
							   CreateNoWindow = true,
							   Arguments = String.Format("/c \"{0}\"", command),
							   }
						  };
		if (isLog) {
 			process.OutputDataReceived += (s, e) => FormatOutput(e.Data);
		}
		process.Start();
		process.BeginOutputReadLine();
	}
}
