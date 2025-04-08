using Godot;
using System;

public partial class CharacterMovement : CharacterBody2D
{
	public const float Speed = 500.0f;
	public const float JumpVelocity = -800.0f;
	private float CoyoteTimer = 0.0f;
	private float JumpInputTimer = 0.0f;

	private bool needJump = false;
	private bool jumped = false;

	Label _timer1;

	public override void _Ready() {
		_timer1 = GetNode<Label>("Timer1");
	}
	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		if(IsOnFloor()) {
			jumped = false;
		}

		// Add the gravity.
		if (!IsOnFloor())
		{
			if(!jumped) {
				CoyoteTimer = 1f;
			} 
			velocity += GetGravity() * (float)delta;
		}

		if(Input.IsActionJustPressed("Jump")) {
			needJump = true;
			JumpInputTimer = 1f;
		}

		// Handle Jump.
		if (needJump && IsOnFloor() || needJump && CoyoteTimer != 0.0f)
		{
			jumped = true;
			velocity.Y = JumpVelocity;
			needJump = false;
			CoyoteTimer = 0.0f;
		}

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 direction = Input.GetVector("Left", "Right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			velocity.X = direction.X * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
		}

		Velocity = velocity;
		MoveAndSlide();

		if(CoyoteTimer > 0) {
			CoyoteTimer -= (float)(10f * delta);
		}

		if(JumpInputTimer > 0) {
			JumpInputTimer -= (float)(10f * delta);
		} else if (JumpInputTimer == 0) {
			needJump = false;
		}

		_timer1.Text = "JumpInp Timer = " + JumpInputTimer;
	}
}
