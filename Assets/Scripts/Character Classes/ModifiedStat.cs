/// <summary>
/// ModifiedStat.cs
/// Lai Minh Dao
/// Nov 14 2013
/// 
/// This is the base class for all stats that will be modifiable by attribute
/// </summary>
using System.Collections.Generic;

public class ModifiedStat : BaseStat {
	// A list of Attributes that modify stat
	private List<ModifyingAttribute> _mods;
	// The amount added to baseValue from modifier
	private int _modValue;						
	
	/// <summary>
	/// Initializes a new instance of the <see cref="ModifiedStat"/> class.
	/// </summary>
	public ModifiedStat() {
		UnityEngine.Debug.Log("Modified Created");
		_mods = new List<ModifyingAttribute>();
		_modValue = 0;
	}
	
	/// <summary>
	/// Adds the ModifyingAttribute to our list of mod for this modifiedStat.
	/// </summary>
	/// <param name='mod'>
	/// Mod.
	/// </param>
	public void AddModifier( ModifyingAttribute mod ) {
		_mods.Add(mod);
	}
	
	/// <summary>
	/// Reset _modValue to 0
	/// Check to see if we have at least one ModifyingAttribute in our list of mods
	/// If we do, then interate through the list and add the AdjustedBaseValue * ratio to our mod
	/// </summary>
	private void CalculateModValue() {
		_modValue = 0;
		
		if(_mods.Count > 0){
			foreach(ModifyingAttribute att in _mods)
				_modValue += (int)(att.attribute.AdjustedBaseValue * att.ratio);
		}
	}
	
	/// <summary>
	/// this function is overriding the AdjustedBaseValue in BaseStat class
	/// Calculate the AdjustedBaseValue from the BaseValue + BuffValue + _modValue
	/// </summary>
	/// <value>
	/// The adjusted base value.
	/// </value>
	public new int AdjustedBaseValue {
		get{ return BaseValue + BuffValue + _modValue; }
	}
	
	// Update value
	public void Update() {
		CalculateModValue();
	}
	
	public string GetModifyingAttributesString() {
		string temp = "";
		
		for (int cnt = 0; cnt < _mods.Count; cnt++) {
			temp += _mods[cnt].attribute.Name;
			temp += "_";
			temp += _mods[cnt].ratio;
			
			if(cnt < _mods.Count - 1)
				temp += "|";
		}
		UnityEngine.Debug.Log(temp);
		
		return temp;
	}
}

/// <summary>
/// A Structure that will hold an Attribute and a ratio that 
/// will be added as a modifying  attribute to our ModifiedStats
/// </summary>
public struct ModifyingAttribute {
	public Attribute attribute;		// The attribute to be used as modifier
	public float ratio;				// the percent of the attributes AdjustedBaseValue that will applied to the ModifiedStat
	
	/// <summary>
	/// Initializes a new instance of the <see cref="ModifyingAttribute"/> struct.
	/// </summary>
	/// <param name='att'>
	/// Att. The attribute to be used
	/// </param>
	/// <param name='rat'>
	/// Rat. The ratio to be used
	/// </param>
	public ModifyingAttribute(Attribute att, float rat) {
		UnityEngine.Debug.Log("Modifying Attribute Created");
		attribute = att;
		ratio = rat;
	}
}
