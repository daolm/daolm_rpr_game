/// <summary>
/// Attribute.cs
/// Lai Minh Dao
/// Nov 14 2013
/// 
/// This is the class for all of the character attributes in game
/// </summary>
public class Attribute : BaseStat {
	// This is the starting cost for all of our attributes
	public const int STARTING_EXP_COST = 50;
	
	// this is the name of the attribute
	private string _name;
	
	/// <summary>
	/// Initializes a new instance of the <see cref="Attribute"/> class.
	/// </summary>
	public Attribute() {
		_name = "";
		ExpToLevel = STARTING_EXP_COST;
		LevelModifier = 1.05f;
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
}

/// <summary>
/// This is a list of the attributes that we will have in-game for our character
/// </summary>
public enum AttributeName{
	Might,
	Constituion,
	Nimbleness,
	Speed,
	Concentration,
	Willpower,
	Charisma
}
