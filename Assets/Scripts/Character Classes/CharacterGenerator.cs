﻿using UnityEngine;
using System.Collections;
using System;		// used for the Enum class

public class CharacterGenerator : MonoBehaviour {
	private PlayerCharacter _toon;
	private const int STARTING_POINTS = 350;
	private const int MIN_STARTING_ATTRIBUTE_VALUE = 10;
	private const int STARTING_VALUE = 50;
	private int pointsLeft;
	
	private const int OFFSET = 5;
	private const int LINE_HEIGHT = 20;
	private const int STAT_LABEL_WIDTH = 100;
	private const int BASEVALUE_LABEL_WIDTH  = 30;
	private const int BUTTON_WIDTH = 20;
	private const int BUTTON_HEIGHT = 20;
	
	private int statStartingPos = 40;
	
	public GUIStyle myStyle;
	public GUISkin mySkin;
	
	public GameObject playerPrefab;

	// Use this for initialization
	void Start () {
		// Quaternions are used to represent rotations
		// Quaternion.identity : The identity rotation (Read Only). This quaternion corresponds to "no rotation": the object
		// Instantiate : Clones the object original and returns the clone
		GameObject pc = Instantiate(playerPrefab, Vector3.zero, Quaternion.identity) as GameObject;
		pc.name = "pc";
		
//		_toon = new PlayerCharacter();
//		_toon.Awake();
		_toon = pc.GetComponent<PlayerCharacter>();
		pointsLeft = STARTING_POINTS;
		for(int cnt = 0; cnt < Enum.GetValues(typeof(AttributeName)).Length; cnt++) {
			_toon.GetPrimaryAttribute(cnt).BaseValue = STARTING_VALUE;
			pointsLeft -= (STARTING_VALUE - MIN_STARTING_ATTRIBUTE_VALUE);
		}
		_toon.StatUpdate();
	}
	
	// Update is called once per frame
	void Update () {
	}
	
	// Draw GUI
	void OnGUI() {
		GUI.skin = mySkin;
		DisplayName();
		DisplayPointsLeft();
		DisplayAttributes();
		DisplayVitals();
		DisplaySkills();
		
		if((_toon.Name == "")||(pointsLeft > 0))
			DisplayCreateLabel();
		else
			DisplayCreateButton();
	}
	
	private void DisplayName() {
		GUI.Label(new Rect(10, 10, 50, 25) , "Name:");
		_toon.Name = GUI.TextField(new Rect(65, 10, 100, 25), _toon.Name);
	}
	
	// Draw Attributes and values
	private void DisplayAttributes() {
		for(int cnt = 0; cnt < Enum.GetValues(typeof(AttributeName)).Length; cnt++) {
			GUI.Label(new Rect(	OFFSET,									//x 	
								statStartingPos + (cnt * LINE_HEIGHT), 	//y
								STAT_LABEL_WIDTH, 						//width
								LINE_HEIGHT								//height
				), ((AttributeName)cnt).ToString());
			
			GUI.Label(new Rect(	STAT_LABEL_WIDTH + OFFSET, 				//x
								statStartingPos + (cnt * LINE_HEIGHT), 	//y
								BASEVALUE_LABEL_WIDTH, 					//width
								LINE_HEIGHT								//height
				), _toon.GetPrimaryAttribute(cnt).AdjustedBaseValue.ToString());
			
			if(GUI.Button(new Rect(	OFFSET + STAT_LABEL_WIDTH + BASEVALUE_LABEL_WIDTH,	//x 
									statStartingPos + (cnt * BUTTON_HEIGHT), 			//y
									BUTTON_WIDTH, 										//width
									BUTTON_HEIGHT										//height
				), "-")) {								
				if(_toon.GetPrimaryAttribute(cnt).BaseValue > MIN_STARTING_ATTRIBUTE_VALUE) {
					_toon.GetPrimaryAttribute(cnt).BaseValue--;
					pointsLeft++;
					_toon.StatUpdate();
				}
			}
			if(GUI.Button(new Rect(	OFFSET + STAT_LABEL_WIDTH + BASEVALUE_LABEL_WIDTH + BUTTON_WIDTH,	//x 
									statStartingPos + (cnt * BUTTON_HEIGHT), 							//y
									BUTTON_WIDTH, 														//width
									BUTTON_HEIGHT														//height
				), "+")) {	
				if(pointsLeft > 0) {
					_toon.GetPrimaryAttribute(cnt).BaseValue++;
					pointsLeft--;
					_toon.StatUpdate();
				}
			}
		}
	}
	
	// Draw Vitals and values
	private void DisplayVitals() {
		for(int cnt = 0; cnt < Enum.GetValues(typeof(VitalName)).Length; cnt++) {
			GUI.Label(new Rect(	OFFSET, 										//x
								statStartingPos + ((cnt + 7) * LINE_HEIGHT), 	//y
								STAT_LABEL_WIDTH, 								//width
								LINE_HEIGHT										//height
				), ((VitalName)cnt).ToString());
			
			GUI.Label(new Rect(	OFFSET + STAT_LABEL_WIDTH, 						//x
								statStartingPos + ((cnt + 7) * LINE_HEIGHT), 	//y
								BASEVALUE_LABEL_WIDTH, 							//width
								LINE_HEIGHT										//height
				), _toon.GetVital(cnt).AdjustedBaseValue.ToString());
		}
	}
	
	// Draw Skills and values
	private void DisplaySkills() {
		for(int cnt = 0; cnt < Enum.GetValues(typeof(SkillName)).Length; cnt++) {
			GUI.Label(new Rect(	OFFSET + STAT_LABEL_WIDTH + BASEVALUE_LABEL_WIDTH + BUTTON_WIDTH * 2 + OFFSET * 2,	//x 
								statStartingPos + (cnt * LINE_HEIGHT), 												//y
								STAT_LABEL_WIDTH, 																	//width
								LINE_HEIGHT																			//height
				), ((SkillName)cnt).ToString());
			
			GUI.Label(new Rect(	OFFSET + STAT_LABEL_WIDTH + BASEVALUE_LABEL_WIDTH + BUTTON_WIDTH * 2 + OFFSET * 2 + STAT_LABEL_WIDTH,	//x
								statStartingPos + (cnt * LINE_HEIGHT), 																	//y
								BASEVALUE_LABEL_WIDTH, 																					//width
								LINE_HEIGHT																								//height			
				), _toon.GetSkill(cnt).AdjustedBaseValue.ToString());
		}
	}
	
	// Draw Points left
	private void DisplayPointsLeft() {
		GUI.Label(new Rect(250, 10, 100, 25) , "Points Left: " + pointsLeft.ToString());
	}
	
	// Draw create button
	private void DisplayCreateButton() {
		if( GUI.Button(new Rect( Screen.width / 2 - 50, 					//x
							 statStartingPos + (10 * LINE_HEIGHT), 			//y
							 100, 											//width
							 LINE_HEIGHT									//height
			), "Create")) {
			GameSettings gsScript = GameObject.Find("__GameSettings").GetComponent<GameSettings>();
			
			// Change the cur value of the vitals to the max modified value of that vital
			UpdateCurVitalValue();
			
			// Save the Character data
			gsScript.SaveCharacterData();
			
			Application.LoadLevel(1);
		}
	}
	
	private void DisplayCreateLabel() {
		GUI.Label(	new Rect(Screen.width / 2 - 50,
					statStartingPos + (10 * LINE_HEIGHT), 
					100, 
					LINE_HEIGHT
				) , "Creating...", "Button");
	}
	
	// Update vital value
	private void UpdateCurVitalValue() {
		for(int cnt = 0; cnt < Enum.GetValues(typeof(VitalName)).Length; cnt++) {
			_toon.GetVital(cnt).CurValue = _toon.GetVital(cnt).AdjustedBaseValue;
		}
	}
}
