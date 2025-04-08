using Godot;
using System;
using System.Numerics;

public partial class Camera2d : Camera2D
{	
	private const float speed = 150f;
	private float spawnTimer = 1.0f;
	private float spawnTimer1 = 0.0f;
	private RandomNumberGenerator rand = new();
	private PackedScene platform = GD.Load<PackedScene>("res://Scenes/Platform.tscn");

    public override void _Process(double delta)
	{
		//Scrolls cam to the right
		GlobalTranslate(new Godot.Vector2((float)(speed * delta), 0f));

		if(spawnTimer <= 0.0f) {
			Godot.Vector2 pos = new Godot.Vector2(Position.X + 900f, rand.RandfRange(-330f, 0f));
			SpawnPlatform(pos);
			spawnTimer = rand.RandfRange(1.5f, 2.5f);
		} else {
			spawnTimer -= (float)(1f * delta);
		}

		if(spawnTimer1 <= 0.0f) {
			Godot.Vector2 pos1 = new Godot.Vector2(Position.X + 900f, rand.RandfRange(0f, 330f));
			SpawnPlatform(pos1);
			spawnTimer1 = rand.RandfRange(1.5f, 2.5f);
		} else {
			spawnTimer1 -= (float)(1f * delta);
		}
		
	}

	void SpawnPlatform(Godot.Vector2 pos) {
		var instance = platform.Instantiate();
		GetParent().AddChild(instance);
		(instance as Node2D).Position = pos;
	}
}
