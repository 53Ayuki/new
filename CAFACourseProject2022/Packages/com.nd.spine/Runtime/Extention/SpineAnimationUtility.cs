using Spine;
using Spine.Unity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Animation = Spine.Animation;

public class SpineAnimationUtility : MonoBehaviour
{
    public static SpineAnimationUtility Instance;
    public int spineMeshUpdateFrameInterval = 1;

    [SerializeField]
    public Material defaultUIMat;

    [HideInInspector]
    public float timeScale = 1;

    [HideInInspector]
    public List<string> loadedSpineKey = new List<string>();

    private void Awake()
    {
        if (Instance != null)
        {
            return;
        }
        Instance = this;
        SkeletonRenderer.updateFrameInterval = spineMeshUpdateFrameInterval;
    }
    public bool PlayAnimation(SkeletonAnimation animation, string name, bool loop, Action cb = null)
    {
        bool bPlay = false;
        if (!animation || (animation.AnimationName == name && animation.state.GetCurrent(0).IsComplete == false))
            return bPlay;
        if (!HasAnimation(animation, name))
            return bPlay;
        animation.state.TimeScale = this.timeScale;
        TrackEntry entry = animation.state.SetAnimation(0, name, loop);
        animation.loop = loop;
        entry.MixDuration = 0.0f;
        entry.TrackTime = 0.0f;
        bPlay = true;
        entry.Complete += delegate (TrackEntry curEntry)
        {
            cb?.Invoke();
        };
        return bPlay;
    }
    public bool PlayAnimation(SkeletonGraphic animation, string name, bool loop,Action cb = null)
    {
        bool bPlay = false;
        if (animation.AnimationState != null && animation.AnimationState.Data != null && animation.AnimationState.Data.SkeletonData != null)
        {
            Animation ani = animation.AnimationState.Data.SkeletonData.FindAnimation(name);
            if(ani != null)
            {
                TrackEntry entry = animation.AnimationState.SetAnimation(0, name, loop);
                entry.Complete += delegate (TrackEntry curEntry)
                {
                    cb?.Invoke();
                };
                bPlay = true;
            }
        }
        return bPlay;
    }

    public void JumpToStart(SkeletonGraphic animation, string name, int frameIndex, int track = 0, bool ignoreEvent = true)
    {
        TrackEntry entry = animation.AnimationState.SetAnimation(track, name, false);
        entry.TrackTime = frameIndex / 30;
    }

    public void SetupPose(SkeletonAnimation animation, string name, int frameIndex, int track = 0, bool ignoreEvent = true)
    {
        animation.skeleton.SetToSetupPose();
        animation.state.ClearTrack(track);
        TrackEntry entry = animation.state.SetAnimation(track, name, false);
        entry.TrackTime = frameIndex / 30;
        entry.AnimationEnd = (frameIndex + 1) / 30;
        if (ignoreEvent)
            entry.AnimationLast = frameIndex / 30;
    }

    public void SetupPose(SkeletonGraphic animation, string name, int frameIndex, int track = 0, bool ignoreEvent = true)
    {
        animation.Skeleton.SetToSetupPose();
        animation.AnimationState.ClearTrack(track);
        TrackEntry entry = animation.AnimationState.SetAnimation(track, name, false);
        entry.TrackTime = frameIndex / 30;
        entry.AnimationEnd = (frameIndex + 1) / 30;
        if (ignoreEvent)
            entry.AnimationLast = frameIndex / 30;
    }

    public void SetFinalPose(SkeletonAnimation animation, string name, int track = 0, bool ignoreEvent = true)
    {
        animation.skeleton.SetToSetupPose();
        animation.state.ClearTrack(track);
        TrackEntry entry = animation.state.SetAnimation(track, name, false);
        float duration = entry.Animation.Duration;
        entry.TrackTime = duration - (1 / 30);
        entry.AnimationEnd = duration;
        if (ignoreEvent)
            entry.AnimationLast = duration - (1 / 30);
    }

    public void SwitchSkin(SkeletonAnimation animation,string skinName)
    {
        if (animation && skinName != "")
        {
            var skin = animation.state.Data.SkeletonData.FindSkin(skinName);
            if(skin != null)
            {
                animation.Skeleton.SetSkin(skinName);
                animation.Skeleton.SetSlotsToSetupPose();
                ((SkeletonAnimation)animation).Update(0f);
                animation.initialSkinName = skinName;
            }
        }
    }
    public void SwitchUiSkin(SkeletonGraphic animation, string skinName)
    {
        if (animation && skinName != "")
        {
            var skin = animation.SkeletonData.FindSkin(skinName);
            if (skin != null)
            {
                animation.Skeleton.SetSkin(skinName);
                animation.Skeleton.SetSlotsToSetupPose();
                ((SkeletonGraphic)animation).Update(0f);
                animation.initialSkinName = skinName;
            }
        }
    }
    public void AttachDecoration(SkeletonAnimation parentAni,GameObject attachObject,string boneName)
    {
        BoneFollower follower = attachObject.AddComponent<BoneFollower>();
        if(follower)
        {
            follower.skeletonRenderer = parentAni;
            follower.boneName = boneName;
            attachObject.transform.parent = parentAni.transform.parent;
        }
    }
    public void DetachDecoration(SkeletonAnimation parentAni,string boneName)
    {
        BoneFollower[] follwers = parentAni.GetComponentsInChildren<BoneFollower>();
        int count = follwers.Length;
        for (int i = 0; i < count; i++)
        {
            if(follwers[i].boneName == boneName)
            {
                Destroy(follwers[i].gameObject);
                break;
            }
        }
    }

    public void ChangeDecoration(SkeletonAnimation animation, string skinName, string animationName = "", bool loop = false)
    {
        if(animation)
        {
            SwitchSkin(animation, skinName);
            if(animationName != "")
            {
                PlayAnimation(animation, animationName, loop);
            }
        }
    }
    public bool CreateSpine(SkeletonDataAsset asset, ref SkeletonAnimation animation)
    {
        animation = SkeletonAnimation.NewSkeletonAnimationGameObject(asset);
        animation.maskInteraction = SpriteMaskInteraction.VisibleOutsideMask;
        animation.clearStateOnDisable = true;
        animation.singleSubmesh = true;
        animation.immutableTriangles = true;
        animation.addNormals = false;
        Renderer renderer = animation.gameObject.GetComponent<Renderer>();
        if (renderer.sharedMaterial)
            renderer.sharedMaterial.SetInt("_StraightAlphaInput", 1);
        renderer.receiveShadows = false;
        renderer.lightProbeUsage = UnityEngine.Rendering.LightProbeUsage.Off;
        renderer.reflectionProbeUsage = UnityEngine.Rendering.ReflectionProbeUsage.Off;
        renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
        return true;
    }
    public bool CreateUiSpine(SkeletonDataAsset asset, GameObject gameObject, ref SkeletonGraphic animation)
    {
        if (gameObject == null || asset == null)
            return false;
        animation = SkeletonGraphic.AddSkeletonGraphicComponent(gameObject, asset, defaultUIMat);
        if (animation != null)
            return true;
        return false;
    }
    public bool HasAnimation(SkeletonAnimation animation, string animationName)
    {
        if (animation == null || animationName == null || animation.state == null)
            return false;
        Animation ani = animation.state.Data.SkeletonData.FindAnimation(animationName);
        if (ani != null)
            return true;
        return false;
    }
    public void ResetMaterial(SkeletonAnimation animation)
    {
        if (animation == null)
            return;
        animation.OnEnable();
    }

#if UNITY_EDITOR
    private void OnValidate()
    {
        SkeletonRenderer.updateFrameInterval = spineMeshUpdateFrameInterval;
    }
#endif
}
