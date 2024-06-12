//
//  GameViewController.swift
//  ningenpiramiddo
//  Created by 菊地桃々 on 2024/05/08.
//

import UIKit
import SpriteKit
import Vision

class GameViewController: UIViewController,UINavigationControllerDelegate,CameraViewControllerDelegate  {
    
    @IBOutlet weak var skView: SKView!
    
    var scene: GameScene!
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GameSceneのインスタンスを作成
                scene = GameScene(size: skView.bounds.size)
                
                // Sceneのスケールモードを設定
                scene.scaleMode = .aspectFill
                
                // SKViewにGameSceneを表示
                skView.presentScene(scene)
                
                // デバッグ情報の表示
                skView.showsFPS = true
                skView.showsNodeCount = true

        // Do any additional setup after loading the view.
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let cameraViewController = CameraViewController()
        cameraViewController.delegate = self
        
//        scene.add(image: image)
        
        present(cameraViewController,animated: true)
       
    }
    func didCapturePhoto(_ image: UIImage) {
        scene.add(image: image)
        count = count + 1
        if count % 2 == 0{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                self.scene.addBoard()
            }
        }
    }
   
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage{
//            print("test")
//            let image = try! ImageSegmenter.getForegroundImage(from: image)
//            scene.add(image: image)
//            count = count + 1
//            if count % 2 == 0{
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
//                    self.scene.addBoard()
////                    self.count
//                }
//            }
//        } else {
//            print("testsssss")
//        }
//        picker.dismiss(animated: true)
//    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
