using Godot;
using System;

public partial class Camera2d : Camera2D
{	
	private const float speed = 150f;
	public override void _Process(double delta)
	{
		//Scrolls cam to the right
		GlobalTranslate(new Vector2((float)(speed * delta), 0f));
	}
}
