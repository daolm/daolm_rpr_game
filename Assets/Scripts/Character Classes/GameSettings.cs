using UnityEngine;
using System.Collections;
using System;

public class GameSettings : MonoBehaviour {
	// This is the name of the gameobject that the player will spawn on at start of the level
	public const string PLAYER_SPAWN_POINT = "Player Spawn Point";		
	
	void Awake() {
		// Makes the object target not be destroyed automatically when loading a new scene
		DontDestroyOnLoad(this);
	}
	
	public void SaveCharacterData() {
		GameObject pc = GameObject.Find("pc");
		
		PlayerCharacter pcClass = pc.GetComponent<PlayerCharacter>();
		
		PlayerPrefs.DeleteAll();
		
		PlayerPrefs.SetString("Player Name", pcClass.Name);
		
		// Save Attribute
		for(int cnt = 0; cnt < Enum.GetValues(typeof(AttributeName)).Length; cnt++) {
			PlayerPrefs.SetInt(((AttributeName)cnt).ToString() + " - Base Value", pcClass.GetPrimaryAttribute(cnt).BaseValue);
			PlayerPrefs.SetInt(((AttributeName)cnt).ToString() + " - Exp to Level", pcClass.GetPrimaryAttribute(cnt).ExpToLevel);
		}
		
		// Save Vital
		for(int cnt = 0; cnt < Enum.GetValues(typeof(VitalName)).Length; cnt++) {
			PlayerPrefs.SetInt(((VitalName)cnt).ToString() + " - Base Value", pcClass.GetVital(cnt).BaseValue);
			PlayerPrefs.SetInt(((VitalName)cnt).ToString() + " - Exp to Level", pcClass.GetVital(cnt).ExpToLevel);
			PlayerPrefs.SetInt(((VitalName)cnt).ToString() + " - Cur Value", pcClass.GetVital(cnt).CurValue);
			
//			PlayerPrefs.SetString(((VitalName)cnt).ToString() + " - Mods", pcClass.GetVital(cnt).GetModifyingAttributesString());
			
//			pcClass.GetVital(cnt).GetModifyingAttributesString();
		}
		
		// Save Skill
		for(int cnt = 0; cnt < Enum.GetValues(typeof(SkillName)).Length; cnt++) {
			PlayerPrefs.SetInt(((SkillName)cnt).ToString() + " - Base Value", pcClass.GetSkill(cnt).BaseValue);
			PlayerPrefs.SetInt(((SkillName)cnt).ToString() + " - Exp to Level", pcClass.GetSkill(cnt).ExpToLevel);
			
//			PlayerPrefs.SetString(((SkillName)cnt).ToString() + " - Mods", pcClass.GetSkill(cnt).GetModifyingAttributesString());
			
//			pcClass.GetSkill(cnt).GetModifyingAttributesString();
		}
	}
	
	public void LoadCharacterData() {
		GameObject pc = GameObject.Find("pc");
		
		PlayerCharacter pcClass = pc.GetComponent<PlayerCharacter>();
	
		pcClass.Name = PlayerPrefs.GetString("Player Name", "Name Me");
		
		for(int cnt = 0; cnt < Enum.GetValues(typeof(AttributeName)).Length; cnt++) {
			pcClass.GetPrimaryAttribute(cnt).BaseValue = PlayerPrefs.GetInt(((AttributeName)cnt).ToString() + " - Base Value", 0);
			pcClass.GetPrimaryAttribute(cnt).ExpToLevel = PlayerPrefs.GetInt(((AttributeName)cnt).ToString() + " - Exp to Level", Attribute.STARTING_EXP_COST);
		}	
		
		for(int cnt = 0; cnt < Enum.GetValues(typeof(VitalName)).Length; cnt++) {
			pcClass.GetVital(cnt).BaseValue = PlayerPrefs.GetInt(((VitalName)cnt).ToString() + " - Base Value", 0);
			pcClass.GetVital(cnt).ExpToLevel = PlayerPrefs.GetInt(((VitalName)cnt).ToString() + " - Exp to Level", 0);
			
			// Make sure you call this so that the AdjustBaseValue will be updated before you try to call to get the curValue
			pcClass.GetVital(cnt).Update();
			
			pcClass.GetVital(cnt).CurValue = PlayerPrefs.GetInt(((VitalName)cnt).ToString() + " - Cur Value", 1);
		}
		
		for(int cnt = 0; cnt < Enum.GetValues(typeof(SkillName)).Length; cnt++) {
			pcClass.GetSkill(cnt).BaseValue = PlayerPrefs.GetInt(((SkillName)cnt).ToString() + " - Base Value", 0);
			pcClass.GetSkill(cnt).ExpToLevel = PlayerPrefs.GetInt(((SkillName)cnt).ToString() + " - Exp to Level", 0);
		}
		
		// output the curValue for each the vitals
		for(int cnt = 0; cnt < Enum.GetValues(typeof(SkillName)).Length; cnt++) {
			Debug.Log(((SkillName)cnt).ToString() + ": " + pcClass.GetSkill(cnt).BaseValue + " - " + pcClass.GetSkill(cnt).ExpToLevel);
		}
	}
}
