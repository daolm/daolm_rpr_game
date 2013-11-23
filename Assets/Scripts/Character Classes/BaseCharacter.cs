using UnityEngine;
using System.Collections;
using System;

public class BaseCharacter : MonoBehaviour {
	private string _name;
	private int _level;
	private uint _freeExp;
	
	private Attribute[] _primaryAttribute;
	private Vital[] _vital;
	private Skill[] _skill;
	
	public void Awake() {
		_name = string.Empty;
		_level = 0;
		_freeExp = 0;
		
		_primaryAttribute = new Attribute[Enum.GetValues(typeof(AttributeName)).Length];
		_vital = new Vital[Enum.GetValues(typeof(VitalName)).Length];
		_skill = new Skill[Enum.GetValues(typeof(SkillName)).Length];
		
		SetupPrimaryAttributes();
		SetupVitals();
		SetupSkills();
	}
	
#region Basic Getters and Setters	
	public string Name {
		get{ return _name; }
		set{ _name = value; }
	}
	
	public int Level {
		get{ return _level; }
		set{ _level = value; }
	}
	
	public uint FreeExp {
		get{ return _freeExp; }
		set{ _freeExp = value; }
	}
#endregion
	
	public void AddExp(uint exp) {
		_freeExp += exp;
		
		CalculateLevel();
	}
	
	// Take avg of all the player skills and assign that as the player level
	public void CalculateLevel() {
	}
	
	private void SetupPrimaryAttributes() {
		for(int cnt = 0; cnt < _primaryAttribute.Length; cnt++) {
			_primaryAttribute[cnt] = new Attribute();
			_primaryAttribute[cnt].Name = ((AttributeName)cnt).ToString();
		}
	}
	
	private void SetupVitals() {
		for(int cnt = 0; cnt < _vital.Length; cnt++) {
			_vital[cnt] = new Vital();
		}
		SetupVitalModifiers();
	}
	
	private void SetupSkills() {
		for(int cnt = 0; cnt < _skill.Length; cnt++) {
			_skill[cnt] = new Skill();
		}
		SetupSkillModifiers();
	}
	
	// Get object from List by index
	public Attribute GetPrimaryAttribute(int index) {
		return _primaryAttribute[index];
	}
	
	public Vital GetVital(int index) {
		return _vital[index];
	}
	
	public Skill GetSkill(int index) {
		return _skill[index];
	}
	
	// Modify vital value
	private void SetupVitalModifiers() {
		// health
		ModifyingAttribute healthModifier = new ModifyingAttribute();
		healthModifier.attribute = GetPrimaryAttribute((int)AttributeName.Constituion);
		healthModifier.ratio = .5f;
		
		GetVital((int)VitalName.Health).AddModifier(healthModifier);
		// energy
		ModifyingAttribute energyModifier = new ModifyingAttribute();
		energyModifier.attribute = GetPrimaryAttribute((int)AttributeName.Constituion);
		energyModifier.ratio = 1;
		
		GetVital((int)VitalName.Energy).AddModifier(energyModifier);
		
		// Mana
		ModifyingAttribute manaModifier = new ModifyingAttribute();
		manaModifier.attribute = GetPrimaryAttribute((int)AttributeName.Willpower);
		manaModifier.ratio = 1;
		
		GetVital((int)VitalName.Mana).AddModifier(manaModifier);
	}
	
	// Modify Skill value
	private void SetupSkillModifiers() {
		// Melee offence
		GetSkill((int)SkillName.Melee_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Might), .33f));
		GetSkill((int)SkillName.Melee_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Nimbleness), .33f));
		
		// Melee defence
		GetSkill((int)SkillName.Melee_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Speed), .33f));
		GetSkill((int)SkillName.Melee_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Constituion), .33f));
		
		// magic offence
		GetSkill((int)SkillName.Magic_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Concentration), .33f));
		GetSkill((int)SkillName.Magic_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Willpower), .33f));
		
		// magic defence
		GetSkill((int)SkillName.Magic_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Concentration), .33f));
		GetSkill((int)SkillName.Magic_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Willpower), .33f));
		
		// Ranged offence
		GetSkill((int)SkillName.Ranged_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Concentration), .33f));
		GetSkill((int)SkillName.Ranged_Offence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Speed), .33f));
		
		// Ranged defence
		GetSkill((int)SkillName.Ranged_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Speed), .33f));
		GetSkill((int)SkillName.Ranged_Defence).AddModifier(new ModifyingAttribute(
			GetPrimaryAttribute((int)AttributeName.Nimbleness), .33f));
	}
	
	public void StatUpdate() {
		for (int cnt = 0; cnt < _vital.Length; cnt++) {
			_vital[cnt].Update();
		}
		
		for (int cnt = 0; cnt < _skill.Length; cnt++) {
			_skill[cnt].Update();
		}
	}
}
