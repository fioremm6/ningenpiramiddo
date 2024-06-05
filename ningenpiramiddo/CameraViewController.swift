//
//  CameraViewController.swift
//  ningenpiramiddo
//
//  Created by 菊地桃々 on 2024/06/05.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession!
        var photoOutput: AVCapturePhotoOutput!
        var previewLayer: AVCaptureVideoPreviewLayer!
        var timerLabel: UILabel!
        var countdownTimer: Timer!
        var countdown: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        startCaptureSession()
        setupTimerLabel()
        
        
           }
    override func viewDidAppear(_ animated: Bool) {
        startCountdown()
    }
    func setupCamera() {
           captureSession = AVCaptureSession()
           captureSession.sessionPreset = .photo
           
           guard let backCamera = AVCaptureDevice.default(for: .video) else {
               print("カメラが利用できません。")
               return
           }
           
           do {
               let input = try AVCaptureDeviceInput(device: backCamera)
               if captureSession.canAddInput(input) {
                   captureSession.addInput(input)
               }
               photoOutput = AVCapturePhotoOutput()
                           if captureSession.canAddOutput(photoOutput) {
                               captureSession.addOutput(photoOutput)
                           }
                           
                           previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                           previewLayer.videoGravity = .resizeAspectFill
                           previewLayer.connection?.videoOrientation = .portrait
                           previewLayer.frame = view.frame
                           view.layer.insertSublayer(previewLayer, at: 0)
                       } catch {
                           print("カメラの設定中にエラーが発生しました: \(error)")
                       }
                   }
                   
     func startCaptureSession() {
                       DispatchQueue.global(qos: .userInitiated).async {
                           self.captureSession.startRunning()
                       }
                   }
    func startCountdown() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    @objc func updateTimer() {
           if countdown > 0 {
               countdown -= 1
               timerLabel.text = "\(countdown)"
           } else {
               countdownTimer.invalidate()
               takePhoto()
           }
       }
    func setupTimerLabel() {
            timerLabel = UILabel()
            timerLabel.text = "\(countdown)"
            timerLabel.font = UIFont.systemFont(ofSize: 64)
            timerLabel.textColor = .white
            timerLabel.textAlignment = .center
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(timerLabel)
            
            NSLayoutConstraint.activate([
                timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    @objc func takePhoto() {
        print("take")
            let settings = AVCapturePhotoSettings()
            photoOutput.capturePhoto(with: settings, delegate: self)
       
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print("写真のキャプチャ中にエラーが発生しました: \(error)")
                return
            }
            
            guard let imageData = photo.fileDataRepresentation() else {
                print("写真データを取得できませんでした。")
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                print("写真データをUIImageに変換できませんでした。")
                return
            }
            
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
           dismiss(animated: true)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
