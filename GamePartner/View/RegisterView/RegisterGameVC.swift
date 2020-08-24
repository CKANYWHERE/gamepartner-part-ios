//
//  RegisterGameVC.swift
//  GamePartner
//
//  Created by 민창경 on 2020/08/24.
//

import UIKit

class RegisterGameVC : UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 1
    var gameList = ["리그오브레전드","오버워치","배틀그라운드","피파온라인","메이플스토리","던전앤파이터","하스스톤","카트라이더","콜오브듀티","기타"]
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    
    private func initControl(){
        self.btnNext.alpha = 0.0
        self.lblMain.font = UIFont.boldSystemFont(ofSize: 30)
        pickerView.delegate = self
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        performSegue(withIdentifier: "moveToDetailRegister", sender: nil)
    }
    
    private func animate(){
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration:0.3, animations: {
                self.btnNext.alpha = 1.0
            })
        },completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameList[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //피커뷰 선택한 부분 들고옴 
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
}
