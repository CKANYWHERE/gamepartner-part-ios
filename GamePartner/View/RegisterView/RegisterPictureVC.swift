//
//  RegisterPictureVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/24.
//

import UIKit
import MobileCoreServices

class RegisterPitureVC : UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        if imgView.image == nil{
            alert("값을 입력해주세요!", message: "사진을 등록해주세요!")
        }
    }
    
    private func initControl(){
        self.btnNext.alpha = 0.0
        self.lblMain.font = UIFont.boldSystemFont(ofSize: 30)
        
    }
    
    @IBAction func btnCapturePhoto(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        else{
            alert("inaccessalbe", message: "Application can not access to camera")
        }
    }
    
    @IBAction func btnGetPhoto(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else{
            alert("inaccessalbe", message: "Application can not access to photo")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            // 사진을 가져옴
            let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if flagImageSave { // flagImageSave가 true일 때
                // 사진을 포토 라이브러리에 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message
                                      ,preferredStyle:UIAlertController.Style.alert)
        let action = UIAlertAction(title:"OK", style: UIAlertAction.Style.default,handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }

}
