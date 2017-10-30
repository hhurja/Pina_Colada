//
//  ViewController.swift
//  CameraApp
//
//  Created by Hunter Hurja on 10/4/17.
//  Copyright © 2017 Pina_Colada. All rights reserved.
//

import UIKit

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

