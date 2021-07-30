using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InputController : MonoBehaviour
{
    public Vector2 fallDirection {get; private set;} //Movement
    public bool interacted {get; private set;} //Interaction

    private void Awake(){
        fallDirection = new Vector2(0f, -1f); //Default to falling down
    }

    private void Update()
    {
        //Direction keys block//
        //Up
        if (Input.GetKeyDown(KeyCode.W) || Input.GetKeyDown(KeyCode.UpArrow)){
            fallDirection = new Vector2(0f, 1f);
        }
        //Down
        else if (Input.GetKeyDown(KeyCode.S) || Input.GetKeyDown(KeyCode.DownArrow)){
            fallDirection = new Vector2(0f, -1f);
        }
        //Left
        else if (Input.GetKeyDown(KeyCode.A) || Input.GetKeyDown(KeyCode.LeftArrow)){
            fallDirection = new Vector2(-1f, 0f);
        }
        //Right
        else if (Input.GetKeyDown(KeyCode.D) || Input.GetKeyDown(KeyCode.RightArrow)){
            fallDirection = new Vector2(1f, 0f);
        }


        //Interact
        if (Input.GetKeyDown(KeyCode.Return)){
            interacted = true;
        }else{
            interacted = false;
        }
        
    }
}
