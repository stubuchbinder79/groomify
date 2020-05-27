using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class MainController : Singleton<MainController>
{
    #region iOS Plugin

#if UNITY_IOS && !UNITY_EDITOR
    [System.Runtime.InteropServices.DllImport("__Internal")]
    extern static public int unityLoadProgress(string progress);
    
    [System.Runtime.InteropServices.DllImport("__Internal")]
    extern static public int unityLoadComplete();
#endif

    #endregion

    #region Variables

    [Tooltip("where should the bundles be loaded from? \n" +
             "LOCAL: loads prefabs from 'Assets/Resources/Prefabs \n " +
             "REMOTE: loads from a url ** use this for production builds ** \n ")]
    [SerializeField] private BundleLocation loadBundleFrom = BundleLocation.Local;

    [Tooltip("component responsible for updating transform and blendshape data on the prefab ")]
    [SerializeField] private ARFaceManager _arFaceManager;

    [SerializeField] private ARSessionManager _arSessionManager;
    
    public GameObject currentPrefab { get; private set; }
    private BundleLoader bundleLoader;

    #endregion
    
    #region Lifecycle
    protected override void Awake()
    {
        base.Awake();
        _arFaceManager = _arFaceManager ?? FindObjectOfType<ARFaceManager>();
        _arSessionManager = _arSessionManager ?? FindObjectOfType<ARSessionManager>();
    }

    private void Start()
    {
        bundleLoader = new BundleLoader(loadBundleFrom);
        string zeusBeardUrl =
            "https://www.stubuchbinder.com/groomify/ios/zeus_beard.unity3d";
        LoadUrl(zeusBeardUrl);
    }

    private void OnEnable()
    {
        BundleLoader.OnLoadComplete += BundleLoader_OnLoadComplete;
        BundleLoader.OnLoadError += BundleLoader_OnLoadError;
        BundleLoader.OnLoadProgress += BundleLoader_OnLoadProgress;
    }
    
    private void OnDisable()
    {
        BundleLoader.OnLoadComplete -= BundleLoader_OnLoadComplete;
        BundleLoader.OnLoadError -= BundleLoader_OnLoadError;
        BundleLoader.OnLoadProgress -= BundleLoader_OnLoadProgress;
        StopAllCoroutines();
    }

    

    #endregion

    #region  Bundle Loading

    private void BundleLoader_OnLoadProgress(float obj)
    {
        Debug.LogFormat("MainController.BundleLoader_OnLoadProgress: {0}", obj);
        
#if UNITY_IOS && !UNITY_EDITOR
        unityLoadProgress(obj.ToString());
#endif
    }

    private void BundleLoader_OnLoadComplete(GameObject obj)
    {
        currentPrefab = Instantiate(obj, Vector3.zero, Quaternion.identity);
        _arFaceManager.facePrefab = currentPrefab;
        _arSessionManager.StartSession();
#if UNITY_IOS && !UNITY_EDITOR
         unityLoadComplete();
#endif
    }
    
    private void BundleLoader_OnLoadError(string obj)
    {
        Debug.LogFormat("BundleManagerBundleLoader_OnLoadError: {0}", obj);
    }


    #endregion

    #region Public 

    public void LoadUrl(string url)
    {
        if (currentPrefab != null)
        {
            Unload();
        }
        
        StartCoroutine(bundleLoader.Load(url));
    }

    public void Unload()
    {
        _arSessionManager.StopSession();
        Destroy(currentPrefab);
    }
    #endregion
}

 

