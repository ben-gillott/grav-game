using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(InputController))]
public class GravityController : MonoBehaviour
{
    [SerializeField] private float gravity;
    private InputController inputController;

    private void Awake(){
        inputController = GetComponent<InputController>();
    }

    // Update is called once per frame
    void Update()
    {
        Physics2D.gravity = inputController.fallDirection * gravity;
    }
}
