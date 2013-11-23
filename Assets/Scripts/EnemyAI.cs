﻿using UnityEngine;
using System.Collections;

public class EnemyAI : MonoBehaviour {
	public Transform target;
	public int moveSpeed;
	public int rotationSpeed;
	public int maxDistance;
	
	private Transform myTransform;
	
	void Awake() {
		myTransform = transform;
	}

	// Use this for initialization
	void Start () {
		GameObject go = GameObject.FindGameObjectWithTag("Player");
		
		target = go.transform;
		
		maxDistance = 2;
	}
	
	// Update is called once per frame
	void Update () {
		Debug.DrawLine(target.transform.position, myTransform.position);
		
		// Look at target
		myTransform.rotation = Quaternion.Slerp(myTransform.rotation, 
			Quaternion.LookRotation(target.position - myTransform.position), 
			rotationSpeed * Time.deltaTime);
		
		// Neu khoang cach lon hon 2 moi chay den target
		if(Vector3.Distance(target.transform.position, myTransform.position) > maxDistance){
			// Move towards target
			myTransform.position += myTransform.forward * moveSpeed * Time.deltaTime;
		}
	}
}