using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class MobGenerator : MonoBehaviour {
	public enum State {
		Idle,
		Initialize,
		Setup,
		SpawnMob
	}
	
	public GameObject[] mobPrefabs;			// an array to hold all of the prefabs of mobs we want to spawn
	public GameObject[] spawnPoints;		// this array will hold a reference to all of spawnponts in teh scene
	
	public State state;						// This is out local variable that holds out current state
	
	public void Awake() {
		state = MobGenerator.State.Initialize;
	}
	
	// Use this for initialization
	IEnumerator Start () {
		while(true) {
			switch(state) {
			case State.Initialize:
				Initialize();
				break;
			case State.Setup:
				Setup();
				break;
			case State.SpawnMob:
				SpawnMob();
				break;
			}
			
			yield return 0;
		}
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public void Initialize() {
		Debug.Log("*** We are in Initialize function ***");
		
		if(!CheckForMobPrefab())
			return;
		
		if(!CheckForSpawnPoints())
			return;
		
		
		
		state = MobGenerator.State.Setup;
	}
	
	public void Setup() {
		Debug.Log("*** We are in Setup function ***");
		
		state = MobGenerator.State.SpawnMob;
	}
	
	private void SpawnMob() {
		Debug.Log("*** Spawn mob ***");
		
		GameObject[] gos = AvailableSpawnPoints();
		
		for(int i = 0; i < gos.Length; i++) {
			GameObject go = Instantiate(mobPrefabs[Random.Range(0, mobPrefabs.Length)],
										gos[i].transform.position,
										Quaternion.identity
										) as GameObject;
			
			go.transform.parent = gos[i].transform;
		}
		
		state = MobGenerator.State.Idle;
	}
	
	// check to see that we have at least one mob prefab to spawn
	private bool CheckForMobPrefab() {
		if(mobPrefabs.Length > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	// check to see if we have at least one spawnpoint to spawn mobs at
	private bool CheckForSpawnPoints() {
		if(spawnPoints.Length > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	// generate a list of available spawnpoints that do not have any mobs childed to it 
	private GameObject[] AvailableSpawnPoints() {
		List<GameObject> gos = new List<GameObject>();
		
		for(int i = 0; i < spawnPoints.Length; i++) {
			if(spawnPoints[i].transform.childCount == 0) {
				Debug.Log("*** Spawn point available ***");
				gos.Add(spawnPoints[i]);
			}
		}
		
		return gos.ToArray();
	}
}
