using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Networking;


public class BundleLoader
{
   public BundleLocation bundleLocation { get; private set; }
   
   public static event Action<float> OnLoadProgress = delegate { };
   public static event Action<string> OnLoadError = delegate { };
   public static event Action<GameObject> OnLoadComplete = delegate { };

   public BundleLoader(BundleLocation arg0)
   {
       bundleLocation = arg0;
   }

   public IEnumerator Load(string url)
   {
       Debug.LogFormat("BundleLoader.Load: {0}", url);

       switch (bundleLocation)
       {
           case BundleLocation.Local:
               GameObject go = Resources.Load(url) as GameObject;
               
               OnLoadComplete(go);
               break;
           
           case BundleLocation.Remote:
               using (UnityWebRequest uwr = UnityWebRequestAssetBundle.GetAssetBundle(url))
               {
                   AsyncOperation request = uwr.SendWebRequest();

                   while (!request.isDone)
                   {
                       OnLoadProgress(request.progress);
                       yield return null;
                   }

                   if (uwr.isNetworkError || uwr.isHttpError)
                   {
                       OnLoadError(uwr.error);
                   }
                   else
                   {
                       AssetBundle bundle = DownloadHandlerAssetBundle.GetContent(uwr);
                       
                       // load asynchronously
                       AssetBundleRequest abr = bundle.LoadAllAssetsAsync<GameObject>();
                       yield return abr;
                       
                       bundle.Unload(false);
                       uwr.Dispose();

                       GameObject obj = (GameObject) abr.asset;
                       OnLoadComplete(obj);

                   }
               }
               break;
       }

       yield return null;
   }
}
