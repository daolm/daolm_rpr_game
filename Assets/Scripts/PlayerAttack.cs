using UnityEngine;
using System.Collections;

public class PlayerAttack : MonoBehaviour {
	public GameObject target;
	public float attackTimer;
	public float coolDown;

	// Use this for initialization
	void Start () {
		attackTimer = 0;
		coolDown = 2.0f;
	}
	
	// Update is called once per frame
	void Update () {
		if(attackTimer > 0)
			attackTimer -= Time.deltaTime;
		
		if(attackTimer < 0)
			attackTimer = 0;
		
		if(Input.GetKeyUp(KeyCode.F)){
			if(attackTimer == 0) {
				Attack();
				attackTimer = coolDown;
			}
		}	
	}
	
	private void Attack() {
		float distance = Vector3.Distance(target.transform.position, transform.position);
		
		Vector3 dir = (target.transform.position -  transform.position).normalized;
		
		// Cho vector bình thường Dot trả về 1 nếu họ chỉ chính xác trong cùng một hướng, 
		// -1 nếu họ chỉ theo các hướng hoàn toàn ngược lại và 0 nếu các vectơ vuông góc.
		float direction = Vector3.Dot(dir, transform.forward);
		
		Debug.Log(direction);
		
		if(distance < 2.5f) {
			if(direction > 0) {
				EnemyHealth eh = (EnemyHealth)target.GetComponent("EnemyHealth");
				eh.AddjustCurrentHealth(-10);
			}
		}
	}
}
