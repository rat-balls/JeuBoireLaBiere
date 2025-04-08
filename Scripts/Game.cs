using Godot;
using System;

public partial class Game : Node2D
{
	public void _on_death_body_entered(Node2D body) {
		if(body.GetGroups().Contains("Player")) {
			GetTree().CallDeferred("reload_current_scene");
		}
	}
}
