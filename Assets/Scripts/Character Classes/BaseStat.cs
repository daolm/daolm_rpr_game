/// <summary>
/// Base stat.
/// Lai Minh Dao
/// Nov 14 2013
/// 
/// This is base class for stats in game
/// </summary>

using UnityEngine;

public class BaseStat {
	// Publicly accesable value for all base stats to start at
	public const int STARTING_EXP_COST = 100;
	
	// The base value of this stat
	private int _baseValue;
	// The amount of the buff to this stat
	private int _buffValue;
	// The total of exp needed to raise this skill
	private int _expToLevel;
	// The modifier applied to the exp needed to raise the skill
	private float _levelModifier;
	
	// this is the name of the attribute
	private string _name;
	
	/// <summary>
	/// Initializes a new instance of the <see cref="BaseStat"/> class.
	/// </summary>
	public BaseStat() {
		Debug.Log("Base stat created");
		_baseValue = 0;
		_buffValue = 0;
		_levelModifier = 1.1f;
		_expToLevel = STARTING_EXP_COST;
		_name = "";
	}
	
#region Basic Getters and Setters
	/// <summary>
	/// Gets or sets the _baseValue.
	/// </summary>
	/// <value>
	/// The _baseValue.
	/// </value>
	public int BaseValue {
		get{ return _baseValue; }
		set{ _baseValue = value; }
	}
	
	/// <summary>
	/// Gets or sets the _buffValue.
	/// </summary>
	/// <value>
	/// The _buffValue.
	/// </value>
	public int BuffValue {
		get{ return _buffValue; }
		set{ _buffValue = value; }
	}
	
	/// <summary>
	/// Gets or sets the _levelModifier.
	/// </summary>
	/// <value>
	/// The _levelModifier.
	/// </value>
	public float LevelModifier {
		get{ return _levelModifier; }
		set{ _levelModifier = value; }
	}
	
	/// <summary>
	/// Gets or sets the _expToLevel.
	/// </summary>
	/// <value>
	/// The _expToLevel.
	/// </value>
	public int ExpToLevel {
		get{ return _expToLevel; }
		set{ _expToLevel = value; }
	}
	
	/// <summary>
	/// Gets or sets the _name.
	/// </summary>
	/// <value>
	/// The _name.
	/// </value>
	public string Name {
		get{ return _name; }
		set{ _name = value; }
	}
#endregion
	
	/// <summary>
	/// Calculates the exp to level.
	/// </summary>
	/// <returns>
	/// The exp to level.
	/// </returns>
	private int CalculateExpToLevel() {
		return (int)(_expToLevel * _levelModifier);
	}
	
	/// <summary>
	/// Assign the new value to _expToLevel and then increase the _baseValue by one.
	/// </summary>
	public void LevelUp() {
		_expToLevel = CalculateExpToLevel();
		_baseValue++;
	}
	
	/// <summary>
	/// Recalculate the adjusted base value and return it
	/// </summary>
	/// <value>
	/// The adjusted base value.
	/// </value>
	public int AdjustedBaseValue {
		get{ return _baseValue + _buffValue; }
	}
}
