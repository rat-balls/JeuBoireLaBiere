using Godot;
using System;
using System.Numerics;

public partial class Camera2d : Camera2D
{	
	private const float speed = 150f;
	private float spawnTimer = 1.0f;
	private float spawnTimer1 = 0.0f;
	private float spawnTimer2 = 1.5f;
	private RandomNumberGenerator rand = new();
	private PackedScene platform = GD.Load<PackedScene>("res://Scenes/Platform.tscn");
	private Area2D beer;
	private float beerProg = -25f;

    public override void _Ready()
    {
		beer = GetNode<Area2D>("Death");
    }

    public override void _Process(double delta)
	{
		//Scrolls cam to the right
		GlobalTranslate(new Godot.Vector2((float)(speed * delta), 0f));

		if (Input.IsActionPressed("ui_down")) {
			beerProg = 80f;
		} else {
			beerProg = -25f;
		}

		if(spawnTimer <= 0.0f) {
			Godot.Vector2 pos = new Godot.Vector2(Position.X + 900f, rand.RandfRange(-330f, -100f));
			SpawnPlatform(pos);
			spawnTimer = rand.RandfRange(2.5f, 4f);
		} else {
			spawnTimer -= (float)(1f * delta);
		}

		if(spawnTimer1 <= 0.0f) {
			Godot.Vector2 pos1 = new Godot.Vector2(Position.X + 900f, rand.RandfRange(100f, 330f));
			SpawnPlatform(pos1);
			spawnTimer1 = rand.RandfRange(2f, 3.5f);
		} else {
			spawnTimer1 -= (float)(1f * delta);
		}

		if(spawnTimer2 <= 0.0f) {
			Godot.Vector2 pos2 = new Godot.Vector2(Position.X + 900f, rand.RandfRange(-100f, 100f));
			SpawnPlatform(pos2);
			spawnTimer2 = rand.RandfRange(3f, 3.5f);
		} else {
			spawnTimer2 -= (float)(1f * delta);
		}

		beer.Translate(new Godot.Vector2(0f, (float)(beerProg * delta)));
	}

	void SpawnPlatform(Godot.Vector2 pos) {
		var instance = platform.Instantiate();
		GetParent().AddChild(instance);
		(instance as Node2D).Position = pos;
	}
}
