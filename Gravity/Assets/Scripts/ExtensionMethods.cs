using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class ExtensionMethods
{
    //Not so sure what it do
    public static T GetOrAddComponent<T>(this GameObject gameObject) where T: Component
    {
        if(gameObject.TryGetComponent(out T requestedComponent)){
            return requestedComponent;
        }
        return gameObject.AddComponent<T>();
    }

    //The Anakin method
    public static void DestroyChildren(this Transform transform){
        foreach(Transform child in transform){
            Object.Destroy(child.gameObject);
        }
    }
}
