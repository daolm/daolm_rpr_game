using UnityEngine;
using System.Collections;

public class GameMaster : MonoBehaviour {
	public GameObject playerCharacter;
	public GameObject gameSettings;
	public Camera mainCamera;
	
	public float xOffset;
	public float zOffset;
	public float yOffset;
	public float xRotOffset;
	public float yRotOffset;
	public float zRotOffset;
	
	private GameObject _pc;
	private PlayerCharacter _pcScript;
	
	// This is the place in 3d space where I want my player spawn
	private Vector3 _playerSpawnPointPos;

	// Use this for initialization
	void Start () {
		// The default position for our player spawn point
		_playerSpawnPointPos = new Vector3(240, 1, 116);
		GameObject go = GameObject.Find(GameSettings.PLAYER_SPAWN_POINT);
		
		if(go == null) {
			Debug.LogWarning("Can't find Player Spawn point");
			go = new GameObject(GameSettings.PLAYER_SPAWN_POINT);
			Debug.Log("Created Player Spawn Point");
			
			go.transform.position = _playerSpawnPointPos;
			Debug.Log("Moved Player Spawn Point");
		}
		
		// Quaternions are used to represent rotations
		// Quaternion.identity : The identity rotation (Read Only). This quaternion corresponds to "no rotation": the object
		// Instantiate : Clones the object original and returns the clone
		_pc = Instantiate(playerCharacter, go.transform.position, Quaternion.identity) as GameObject;
		_pc.name = "pc";
		
		_pcScript = _pc.GetComponent<PlayerCharacter>();
		
		xOffset =  0.7f;
		yOffset =  1.7f;
		zOffset = -2.9f;
		xRotOffset = 10;
		yRotOffset = 350;
		zRotOffset = 359;
		
		// Change main camera position and rotate to character
		mainCamera.transform.position = new Vector3(_pc.transform.position.x + xOffset,
													_pc.transform.position.y + yOffset,
													_pc.transform.position.z + zOffset);
		mainCamera.transform.rotation = Quaternion.Euler(xRotOffset, yRotOffset, zRotOffset);
		
		LoadCharacter();
	}
	
	public void LoadCharacter() {
		GameObject gs = GameObject.Find("__GameSettings");
		
		if(gs == null) {
			GameObject gs1 =  Instantiate(gameSettings, Vector3.zero, Quaternion.identity) as GameObject;
			gs1.name = "__GameSettings";
		}
			
		GameSettings gsScript = GameObject.Find("__GameSettings").GetComponent<GameSettings>();
		
		// Loading character data
		gsScript.LoadCharacterData();
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
