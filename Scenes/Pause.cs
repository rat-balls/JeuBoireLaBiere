using Godot;
using System;

public partial class Pause : Control
{
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(Input.IsActionJustPressed("Pause")) {
			PauseGame();
		}
	}

	void PauseGame() {
		GetTree().Paused = !GetTree().Paused;
	}
}
