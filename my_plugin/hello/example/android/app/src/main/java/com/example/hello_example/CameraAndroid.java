package com.example.hello_example;

import android.content.Context;



import android.media.CamcorderProfile;
import android.media.MediaRecorder;
import android.os.Environment;

<<<<<<< HEAD
import androidx.annotation.NonNull;
import androidx.camera.core.Camera;
import androidx.camera.core.CameraSelector;
import androidx.camera.core.ImageCapture;
import androidx.camera.core.ImageCaptureException;
import androidx.camera.core.Preview;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.lifecycle.LifecycleOwner;
=======
import androidx.camera.core.Camera;
import androidx.camera.lifecycle.ProcessCameraProvider;
>>>>>>> a4876d9 ([first commit])


import com.google.common.util.concurrent.ListenableFuture;

<<<<<<< HEAD
import java.io.File;
import java.util.concurrent.Executor;

public class CameraAndroid {
//    private MediaRecorder recorder;
//    private boolean recording = false;

private String dataPath;
private String filePath;
//private Camera camera;
    private boolean stop=true;
private ListenableFuture<ProcessCameraProvider> cameraProviderFuture;
    Context ctx;
    ImageCapture imageCapture;
    public CameraAndroid(String path, Context ct) {
        ctx=ct;
dataPath=path;
filePath=dataPath+"/camerax_photo.jpg";
=======
import java.util.concurrent.Executor;

public class CameraAndroid {
    private MediaRecorder recorder;
    private boolean recording = false;

private String dataPath;
private String filePath;
private Camera camera;
private ListenableFuture<ProcessCameraProvider> cameraProviderFuture;
    Context ctx;
    public CameraAndroid(String path, Context ct) {
        ctx=ct;
dataPath=path;
filePath=dataPath+"/videocapture_example.mp4";
>>>>>>> a4876d9 ([first commit])
        System.out.println("[CameraAndroid] Starting");
        System.out.println("[CameraAndroid] storageDir:"+dataPath);
        // Check if permission is granted


<<<<<<< HEAD
//        recorder = new MediaRecorder();
//        recorder.setOnInfoListener((mediaRecorder, what, i1) -> {
//            System.out.println("[CameraAndroid] event occured and code:"+what);
//            if (what == MediaRecorder.MEDIA_RECORDER_INFO_MAX_DURATION_REACHED) {
//                // Stop recording or take necessary actions
//                stopRecording();
//            }
//
//        });
=======
        recorder = new MediaRecorder();
        recorder.setOnInfoListener((mediaRecorder, what, i1) -> {
            System.out.println("[CameraAndroid] event occured and code:"+what);
            if (what == MediaRecorder.MEDIA_RECORDER_INFO_MAX_DURATION_REACHED) {
                // Stop recording or take necessary actions
                stopRecording();
            }

        });
>>>>>>> a4876d9 ([first commit])
        cameraProviderFuture = ProcessCameraProvider.getInstance(ctx);
        cameraProviderFuture.addListener(() -> {
            try {
                ProcessCameraProvider cameraProvider = cameraProviderFuture.get();
<<<<<<< HEAD
                startCameraX(cameraProvider);
=======
>>>>>>> a4876d9 ([first commit])

            } catch (Exception e) {
                e.printStackTrace();
            }
<<<<<<< HEAD
        }, getExecutor());
       // initRecorder();
    }

    private Executor getExecutor() {
=======
        }, getMainExecutor());
        initRecorder();
    }

    private Executor getMainExecutor() {
>>>>>>> a4876d9 ([first commit])
        return ctx.getMainExecutor();
    }
    private void startCameraX(ProcessCameraProvider processCameraProvider){
        processCameraProvider.unbindAll();
<<<<<<< HEAD

        //camera selector usecase
         CameraSelector cameraSelector= new CameraSelector.Builder().requireLensFacing(CameraSelector.LENS_FACING_FRONT).build();

         //preview usecase
         Preview preview = new Preview.Builder().build();

         //image capture
        imageCapture= new ImageCapture.Builder().setCaptureMode(ImageCapture.CAPTURE_MODE_MINIMIZE_LATENCY).build();

        processCameraProvider.bindToLifecycle((LifecycleOwner) ctx,cameraSelector,preview,imageCapture);
        stop=false;
    }

    public void capturePhoto(){
        while (stop){
            System.out.println("startCamerax yet to return");
        }

        File photoFile= new File(filePath);
        imageCapture.takePicture(
                new ImageCapture.OutputFileOptions.Builder(photoFile).build(),
                getExecutor(),
                new ImageCapture.OnImageSavedCallback() {
                    @Override
                    public void onImageSaved(@NonNull ImageCapture.OutputFileResults outputFileResults) {
                        System.out.println("image saved at"+filePath);
                    }

                    @Override
                    public void onError(@NonNull ImageCaptureException exception) {
System.out.println("Error while saving image "+exception.toString());
                    }
                }
        );
    }
//    private void initRecorder() {
//        System.out.println("Starting init");
//
//        recorder.setAudioSource(MediaRecorder.AudioSource.MIC);
//        recorder.setVideoSource(MediaRecorder.VideoSource.DEFAULT);
//
//        recorder.setOutputFile(filePath);
//        CamcorderProfile cp480 = CamcorderProfile.get(CamcorderProfile.QUALITY_LOW);
//        recorder.setProfile(cp480);
//        recorder.setVideoFrameRate(30);
//       // Specify your desired file path
//        recorder.setMaxDuration(50000); // 50 seconds
//        recorder.setMaxFileSize(5000000);
//
//       // Approximately 5 megabytes
//    }
//
//    public void startRecording() {
//        if (!recording) {
//            try {
//                recorder.prepare();
//                recorder.start();
//                recording = true;
//            }catch (Exception e){
//                System.out.println("[CameraAndroid.startRecording] caught exception "+e.toString());
//            }
//
//        }
//    }
//
//    public void stopRecording() {
//        System.out.println("Stopping recording");
//        if (recording) {
//            recorder.stop();
//            recorder.reset();
//            initRecorder(); // Reinitialize the recorder for subsequent recordings
//            recording = false;
//
//        }
//    }
=======
    }

    private void initRecorder() {
        System.out.println("Starting init");

        recorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        recorder.setVideoSource(MediaRecorder.VideoSource.DEFAULT);

        recorder.setOutputFile(filePath);
        CamcorderProfile cp480 = CamcorderProfile.get(CamcorderProfile.QUALITY_LOW);
        recorder.setProfile(cp480);
        recorder.setVideoFrameRate(30);
       // Specify your desired file path
        recorder.setMaxDuration(50000); // 50 seconds
        recorder.setMaxFileSize(5000000);

       // Approximately 5 megabytes
    }

    public void startRecording() {
        if (!recording) {
            try {
                recorder.prepare();
                recorder.start();
                recording = true;
            }catch (Exception e){
                System.out.println("[CameraAndroid.startRecording] caught exception "+e.toString());
            }

        }
    }

    public void stopRecording() {
        System.out.println("Stopping recording");
        if (recording) {
            recorder.stop();
            recorder.reset();
            initRecorder(); // Reinitialize the recorder for subsequent recordings
            recording = false;

        }
    }
>>>>>>> a4876d9 ([first commit])

    // Getter method for the saved video file path
    public String getSavedVideoFilePath() {
        return filePath; // Replace with the actual path
    }
}
