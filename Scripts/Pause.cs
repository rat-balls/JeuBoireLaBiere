using Godot;
using System;

public partial class Pause : Control
{
	private ColorRect PauseScreen;

    public override void _Ready()
    {
        PauseScreen = (ColorRect)GetParent().GetNode("Camera2D/UI/PauseScreen");
    }
    public override void _Process(double delta)
	{
		if(Input.IsActionJustPressed("Pause")) {
			PauseGame();
		}
	}
	void PauseGame() {
		bool paused = !GetTree().Paused;
		GetTree().Paused = paused;
		PauseScreen.Visible = paused;
	}
	public void _on_death_body_entered(Node2D body) {
		if(body.GetGroups().Contains("Player")) {
			PauseGame();
			PauseScreen.GetNode<Label>("DrinkingProgress").Text = "YOU DROWNED.";
			PauseScreen.GetNode<Button>("Restart").Visible = true;
			PauseScreen.GetNode<Button>("Menu").Visible = true;
		}
	}

	void _on_restart_button_up() {
		GetTree().CallDeferred("reload_current_scene");
		PauseGame();
	} 

	void _on_menu_button_up() {
		//TODO
	}
}
