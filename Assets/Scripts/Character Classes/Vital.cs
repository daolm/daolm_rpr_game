/// <summary>
/// Vital.cs
/// Nov 18, 2013
/// DaolM
/// 
/// This class contain all the extra functions for a characters vitals
/// </summary>
public class Vital : ModifiedStat {
	private int _curValue;		// This is the current vital if this vital
	
	/// <summary>
	/// Initializes a new instance of the <see cref="Vital"/> class.
	/// </summary>
	public Vital() {
		UnityEngine.Debug.Log("Vital Created");
		_curValue = 0;
		ExpToLevel = 40;
		LevelModifier = 1.1f;
	}
	
	/// <summary>
	/// Gets or sets the _curValue. Make sure that it is not greater than AdjustedBaseValue
	/// If it is, make it  the same as our AdjustedBaseValue
	/// </summary>
	/// <value>
	/// The current value.
	/// </value>
	public int CurValue {
		get{
			if(_curValue > AdjustedBaseValue) {
				_curValue = AdjustedBaseValue;
			}
			return _curValue;
		}
		set{ _curValue = value; }
	}
}

/// <summary>
/// This enumerations is just a list of vitals our character will have.  
/// </summary>
public enum VitalName {
	Health,
	Energy,
	Mana
}
