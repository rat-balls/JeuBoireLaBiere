using Godot;
using System;

public partial class Score : Label
{	

	public float score = 0;

	public override void _Process(double delta)
	{
		score += (float)(10f * delta);
		Text = Mathf.FloorToInt(score).ToString();
	}
}
