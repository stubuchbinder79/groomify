using System;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

[RequireComponent((typeof(ARSession)))]
public class ARSessionManager : Singleton<ARSessionManager
>
{
    [SerializeField]
    private ARSession _arSession;

    private void Awake()
    {
        _arSession = _arSession ?? GetComponent<ARSession>();
    }

    private void Start()
    {
        StopSession();
    }

    public void StopSession()
    {
        if (_arSession == null)
        {
            return;
        }
        _arSession.subsystem.Stop();
    }

    public void StartSession()
    {
        _arSession.subsystem.Reset();
        _arSession.subsystem.Start();
    }
}
