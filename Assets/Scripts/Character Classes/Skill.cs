/// <summary>
/// Skill.cs
/// Nov 18, 2013
/// DaolM
/// 
/// This class contain all the extra functions that needed for a skills
/// </summary>
public class Skill : ModifiedStat {
	private bool _known;		// a boolean variable to toggle if a character knows a skill
	
	/// <summary>
	/// Initializes a new instance of the <see cref="Skill"/> class.
	/// </summary>
	public Skill() {
		UnityEngine.Debug.Log("Skill created");
		_known = false;
		ExpToLevel = 25;
		LevelModifier = 1.1f;
	}
	
	/// <summary>
	/// Gets or sets a value indicating whether this <see cref="Skill"/> is known.
	/// </summary>
	/// <value>
	/// <c>true</c> if known; otherwise, <c>false</c>.
	/// </value>
	public bool Known {
		get{ return _known; }
		set{ _known = value;}
	}
}

/// <summary>
/// This enumerations is just a list of skills that character can learn.  
/// </summary>
public enum SkillName {
	Melee_Offence,
	Melee_Defence,
	Ranged_Offence,
	Ranged_Defence,
	Magic_Offence,
	Magic_Defence
}