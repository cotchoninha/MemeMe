//
//  ViewController.swift
//  MemeMe
//
//  Created by Marcela Ceneviva Auslenter on 16/04/2018.
//  Copyright © 2018 Marcela Ceneviva Auslenter. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var cancelButtonOutlet: UIBarButtonItem!
    
    
   
    
    override func viewDidLoad() {
        shareButtonOutlet.isEnabled = false
        super.viewDidLoad()
        configure(topTextField, with: "TOP")
        configure(bottomTextField, with: "BOTTOM")
        
    }
    
    func configure(_ textField: UITextField, with defaultText: String) {
        textField.text = defaultText
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //subscribeToKeyboardNotifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide , object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //unsubscribeFromKeyboardNotifications
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: CGFloat(-3.0)]
    
    
    func choseAnImage(from source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func choseFromLibrary(_ sender: Any) {
        choseAnImage(from: .photoLibrary)
    }
    
    @IBAction func choseFromCamera(_ sender: Any) {
       choseAnImage(from: .camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let topText = topTextField.text{
            if let bottomText = bottomTextField.text{
                if topText == "TOP" || bottomText == "BOTTOM"{
                    textField.text = ""
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        // só executa as linhas abaixo (empurrar a tela pra cima quando keyboard aparecer) quando o bottomTextField for clicado
        if bottomTextField.isFirstResponder{
        let heightOfTheKeyboard = getKeyboardHeight(notification)
        view.frame.origin.y -= heightOfTheKeyboard
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
        shareButtonOutlet.isEnabled = true
    }
    
    func hideToolBar(toolBar: UIToolbar, otherToolBar: UIToolbar, isHidden: Bool){
        toolBar.isHidden = isHidden
        otherToolBar.isHidden = isHidden
    }
    func generateMemedImage() -> UIImage {
        
        hideToolBar(toolBar: topToolBar, otherToolBar: toolBar, isHidden: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideToolBar(toolBar: topToolBar, otherToolBar: toolBar, isHidden: false)
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        if let selectedImage = imagePickerView.image{
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: selectedImage, memedImage: generateMemedImage())
            
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            self.dismiss(animated: true, completion: nil)
        }
       
    }

    @IBAction func shareButton(_ sender: Any) {
        let imageChosen = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [imageChosen], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.save()
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        if let topText = topTextField.text{
            if let bottomText = bottomTextField.text{
                if topText == "TOP" && bottomText == "BOTTOM" && imagePickerView.image == nil{
                    dismiss(animated: true, completion: nil)
                }else{
                    topTextField.text = "TOP"
                    bottomTextField.text = "BOTTOM"
                    imagePickerView.image = nil
                }
            }
        }
    }
    
    
}

