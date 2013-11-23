/// <summary>
/// TargetMob.cs
/// Nov 19, 2013
/// DaolM
/// 
/// This script can be attached to any permanent gameobject, and is responsible
/// for allowing the player to target diffirence mobs that are with in range
/// </summary>
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TargetMob : MonoBehaviour {
	public List<Transform> targets;
	public Transform selectedTarget;
	
	private Transform myTransform;
	
	// Use this for initialization
	void Start () {
		targets = new List<Transform>();
		selectedTarget = null;
		myTransform = transform;
		
		AddAllEnemies();
	}
	
	// Find all enemy by tag and add to List od enemy
	public void AddAllEnemies() {
		GameObject[] go = GameObject.FindGameObjectsWithTag("Enemy");
		
		foreach(GameObject enemy in go) {
			AddTarget(enemy.transform);
		}
	}
	
	// Add all enemy to List
	public void AddTarget(Transform enemy) {
		targets.Add(enemy);
	}
	
	// Sort List of enemy by distance
	public void SortTargetsByDistance() {
		targets.Sort(delegate(Transform t1, Transform t2) {
			return (Vector3.Distance(t1.position, myTransform.position)
				.CompareTo(Vector3.Distance(t2.position, myTransform.position)));
		});
	}
	
	// Select target to attack
	private void TargetEnemy() {
		if(selectedTarget == null) {
			SortTargetsByDistance();
			selectedTarget = targets[0];	
		}else {
			int index = targets.IndexOf(selectedTarget);
			
			if(index < targets.Count -1) {
				index++;
			}else {
				index = 0;
			}
			DeSelectTarget();
			selectedTarget = targets[index];
		}
		SelectTarget();
	}
	
	// Change color of selected target
	private void SelectTarget() {
		Transform name = selectedTarget.FindChild("Name");
		
		if(name == null) {
			Debug.LogError("Could not find the name on " + selectedTarget.name);
			return;
		}
		
		name.GetComponent<TextMesh>().text = selectedTarget.GetComponent<Mob>().Name;
		name.GetComponent<MeshRenderer>().enabled = true;
		selectedTarget.GetComponent<Mob>().DisplayHealth();
		
		Messenger<bool>.Broadcast("show mobs vitalbars", true);
	}
	
	private void DeSelectTarget() {
		selectedTarget.FindChild("Name").GetComponent<MeshRenderer>().enabled = false;
		selectedTarget = null;
		Messenger<bool>.Broadcast("show mobs vitalbars", false);
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Tab)) {
			TargetEnemy();
		}
	}
}
