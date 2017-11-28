//
//  ViewController.swift
//  CameraApp
//
//  Created by Hunter Hurja on 10/4/17.
//  Copyright © 2017 Pina_Colada. All rights reserved.
//

import UIKit

class mainViewController: UIViewController{
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "How do you use parkit?", message: "1. Take pictures of the parking signs \n \n2. Choose from given templates if \n image cannot be read \n \n3. App will tell you parking availability \n \n 4. Set the timer and we'll remind you \n when it's time to move your car!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func libraryButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func saveButton(_ sender: UIButton) {
//        let image = pickedImageView.image
        let imageData = UIImageJPEGRepresentation(pickedImageView.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editinginfo: [NSObject: AnyObject]!) {
//        pickedImage.image = image
//        self.dismiss(animated: true, completion: nil);
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedImageView.contentMode = .scaleAspectFit
            pickedImageView.image = pickedImage
//            savedPickedImage = pickedImage
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    
}

class timerViewController: UIViewController{
  
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var stepper: UIStepper!
    
    var initialTime = 0
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        initialTime = Int(sender.value)
        setTimer()
    }
    
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    func setTimer(){
        timer.invalidate()
        seconds = initialTime*60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(timerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = initialTime*60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            // timerLabel.text = String(seconds)
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         pauseButton.isEnabled = false
    }
}



