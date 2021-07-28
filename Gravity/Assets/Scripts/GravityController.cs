using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GravityController : MonoBehaviour
{
    public float gravity = 50f;

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.W)){
            Physics2D.gravity = new Vector2(0f, gravity);
        }
        else if(Input.GetKey(KeyCode.A)){
            Physics2D.gravity = new Vector2(-gravity, 0f);
        }
        else if(Input.GetKey(KeyCode.S)){
            Physics2D.gravity = new Vector2(0f, -gravity);
        }
        else if(Input.GetKey(KeyCode.D)){
            Physics2D.gravity = new Vector2(gravity, 0f);
        }
    }
}
