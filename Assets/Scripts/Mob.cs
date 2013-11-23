using UnityEngine;
using System.Collections;

public class Mob : BaseCharacter {
	public int curHealth;
	public int maxHealth;

	// Use this for initialization
	void Start () {
//		GetPrimaryAttribute((int)AttributeName.Constituion).BaseValue = 100;
//		GetVital((int)VitalName.Health).Update();
		animation.Play();
		
		Name = "Slug Mob";
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	public void DisplayHealth() {
		Messenger<int, int>.Broadcast("mod health update", curHealth, maxHealth);
	}
}
