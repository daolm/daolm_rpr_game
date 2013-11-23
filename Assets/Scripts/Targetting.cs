using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Targetting : MonoBehaviour {
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
		selectedTarget.renderer.material.color = Color.red;
		
		PlayerAttack pa = (PlayerAttack)GetComponent("PlayerAttack");
		
		pa.target = selectedTarget.gameObject;
	}
	
	private void DeSelectTarget() {
		selectedTarget.renderer.material.color = Color.blue;
		selectedTarget = null;
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Tab)) {
			TargetEnemy();
		}
	}
}
