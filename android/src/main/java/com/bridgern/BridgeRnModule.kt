package com.bridgern

import android.content.Intent
import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.teamta.editor_android.VideoEditor
import com.teamta.editor_android.VideoPlayerActivity

class BridgeRnModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  private val videoEditorInstance = VideoEditor()

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun passTextToAAR(text: String, promise: Promise) {
    try {
      val result = videoEditorInstance.processVideo(text)
      promise.resolve(result)
    } catch (e: Exception) {
      promise.reject("Error", e)
    }
  }

  @ReactMethod
  fun launchVideoEditor(videoUrl1: String, videoUrl2: String?) {
    val intent = Intent(reactApplicationContext, VideoPlayerActivity::class.java)
    intent.putExtra("VIDEO_URL1", videoUrl1)

    videoUrl2?.let {  // Use safe call and let for null safety
      intent.putExtra("VIDEO_URL2", it)
    }

    Log.d("Malavika", "launchVideoEditor: $videoUrl1 $videoUrl2")

    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    reactApplicationContext.startActivity(intent)
  }

  companion object {
    const val NAME = "BridgeRn"
  }
}
