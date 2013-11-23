﻿/// <summary>
/// VitalBar.cs
/// Nov 14 2013
/// Lai Minh Dao
/// 
/// This class is reponsible for displaying a vital for the player character or a mob
/// </summary>
using UnityEngine;
using System.Collections;

public class VitalBar : MonoBehaviour {
	public bool _isPlayerHealthBar;		// This boolean value tells us if this is the player healthbar or mob healthbar
	
	private int _maxBarLength;				// This is how large the vital bar can be if the target is at  100% health
	private int _curBarLength;				// This is the current langth of vital bar
	
	private GUITexture _display;
	
	void Awake() {
		_display = gameObject.GetComponent<GUITexture>();
	}
	
	// Use this for initialization
	void Start () {
//		_isPlayerHealthBar = true;
		
		_maxBarLength = (int) _display.pixelInset.width;
		
		_curBarLength = _maxBarLength;
		_display.pixelInset = CalculatePosition();
		
		OnEnable();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	// This code is called when the gameobject is enabled
	public void OnEnable() {
		if(_isPlayerHealthBar) {
			Messenger<int, int>.AddListener("player health update", OnChangeHealthBarSize);
		}
		else {
			ToggleDisplay(false);
			Messenger<int, int>.AddListener("mod health update",OnChangeHealthBarSize);
			Messenger<bool>.AddListener("show mobs vitalbars",ToggleDisplay);
		}
	}
	
	// this code is called when the gameobject is disabled
	public void  OnDisable() {
		if(_isPlayerHealthBar) {
			Messenger<int, int>.RemoveListener("player health update", OnChangeHealthBarSize);
		}
		else {
			Messenger<int, int>.RemoveListener("mod health update", OnChangeHealthBarSize);
			Messenger<bool>.RemoveListener("show mobs vitalbars",ToggleDisplay);
		}
	}
	
	// This method will calculate the total size of the health bar
	// in relation to the % of health bar the targer has left
	public void OnChangeHealthBarSize(int curHealth, int maxHealth) {
//		Debug.Log("We heard an event : curHealth = " + curHealth + " - maxHealth = " + maxHealth);
		// This calculates the current bar length based on the player health %
		_curBarLength = (int)((curHealth / (float)maxHealth) * _maxBarLength);
//		_display.pixelInset = new Rect(_display.pixelInset.x, _display.pixelInset.y,_curBarLength, _display.pixelInset.height);
		_display.pixelInset = CalculatePosition();
	}
	
	// Set player heathbar  to the player or mob
	public void setPlayerHealth(bool b) {
		_isPlayerHealthBar = b;
	}
	
	private Rect CalculatePosition() {
		float yPos = _display.pixelInset.y / 2 - 10;
		
		if(!_isPlayerHealthBar) {
			float xPos = (_maxBarLength - _curBarLength) - (_maxBarLength /4 + 10);
			return new Rect(xPos, yPos, _curBarLength, _display.pixelInset.height);
		}
		
		return new Rect(_display.pixelInset.x, yPos,_curBarLength, _display.pixelInset.height);
	}
	
	public void ToggleDisplay(bool show) {
		_display.enabled = show;
	}
}
