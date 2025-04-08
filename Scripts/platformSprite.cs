using Godot;
using System;
using System.Threading.Tasks;

public partial class platformSprite : Sprite2D
{	

	bool evil = false;	
	int i = 0;
	public override void _Ready()
	{	
		int n = (int)(GD.Randi() % 100);
		if(n <= 50) {
			evil = true;
		}
		i = (int)(GD.Randi() % 2 + 1);
		Texture = GD.Load<Texture2D>("Assets/Sprites/capsule " + i + ".png");
	}

	public async void _on_area_2d_body_entered(Node2D body) {
		if(body.GetGroups().Contains("Player") && evil) {
			Texture = GD.Load<Texture2D>("Assets/Sprites/capsule " + (i + 2) + ".png");
			await platformDies();
		}
	}

	public async Task platformDies() {
		await ToSignal(GetTree().CreateTimer(0.7f), Timer.SignalName.Timeout);
    	GetParent().QueueFree();
	}
}
