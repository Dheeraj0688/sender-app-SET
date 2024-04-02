package com.example.hello_example;

import androidx.annotation.NonNull;

<<<<<<< HEAD
import com.example.hello_example.CameraAndroid;
=======
import com.example.hello.CameraAndroid;
>>>>>>> a4876d9 ([first commit])

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
      private static final String CHANNEL = "hello";

   @Override
   public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
<<<<<<< HEAD
        super.configureFlutterEngine(flutterEngine);
=======

>>>>>>> a4876d9 ([first commit])

       new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
               .setMethodCallHandler(
                       (call, result) -> {
                           if (call.method.equals("startRecording")) {
                               // Call your native method here
                                String dataPath=call.argument("path");
                            System.out.println("got data from flutter: "+dataPath);
                                CameraAndroid ca =new CameraAndroid(dataPath, this);
<<<<<<< HEAD
                                ca.capturePhoto();
=======
                                ca.startRecording();
>>>>>>> a4876d9 ([first commit])
                            String path=ca.getSavedVideoFilePath();
                                result.success("Video file Path:" + path);
                           } else {
                               result.notImplemented();
                           }
                       }
               );
   }
}
