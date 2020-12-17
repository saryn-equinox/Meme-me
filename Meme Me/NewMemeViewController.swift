//
//  NewMemeViewController.swift
//  Meme Me
//
//  Created by 邱浩庭 on 16/12/2020.
//

import UIKit

class NewMemeViewController: UIViewController {

    @IBOutlet weak var pickImageFromCamera: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    private var topTextFiledDelegate: MemeTextFieldDelegate!
    private var bottomTextFiledDelegate: MemeTextFieldDelegate!
    private var memeImagePickerDelegate: ImagePickerDelegate!
    

    
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0 // set to negative otherwise foregroundColor won't apply
        // https://stackoverflow.com/questions/47774748/swift-nsattributedstringkey-not-applying-foreground-color-correctly
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickImageFromCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextFiledDelegate = MemeTextFieldDelegate()
        bottomTextFiledDelegate = MemeTextFieldDelegate()
        memeImagePickerDelegate = ImagePickerDelegate(self)
        setTextFieldParameters(topText, topTextFiledDelegate, "ENTER TOP")
        setTextFieldParameters(bottomText, bottomTextFiledDelegate, "ENTER BOTTOM")
        
        imageView.contentMode = .scaleAspectFit
        shareButton.isEnabled = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe the keyboard
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // un-subscribe the keyboard
        unsubscribeFromKeyboardNotifications()
    }
    
    /**
     A helper function to set the configuration parameters for the view
     */
    private func setTextFieldParameters(_ textField: UITextField, _ delegate: UITextFieldDelegate, _ text: String){
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = delegate
        textField.textAlignment = .center
        textField.alpha = 0
        textField.borderStyle = .none
        textField.text = text
        textField.autocapitalizationType = .allCharacters // auto capitalized
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
    Pick an image from album
    */
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImageFromSource(.photoLibrary)
    }
       
    /**
    Pick an image from camera- taking photo
    */
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImageFromSource(.camera)
    }
       
    /**
    Helper function for picking Images
    */
    private func pickImageFromSource(_ source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = memeImagePickerDelegate
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
     Save meme
     */
    private func save(_ memedImage: UIImage) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(Meme(topText.text!, bottomText.text!, imageView.image!, memedImage))
    }
    
    /**
     Generate a meme
     */
    private func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Draw the image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        return memedImage
    }
    
    /**
     Share our meme
     */
    @IBAction func shareMeme(_ sender: Any) {
        let generatedMeme = generateMemedImage()
        let activityVC  = UIActivityViewController(activityItems: [generatedMeme], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = UIView() // Ipad need to set the soucreView, I don't why it's different with iphone
        
        activityVC.completionWithItemsHandler = { [weak self] type, completed, items, error in
            if completed {
                self?.save(generatedMeme)
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil) // post an reload event
            }

            activityVC.dismiss(animated: true, completion: nil)
        }

        present(activityVC, animated: true, completion: nil)
    }
    
    
    
    // Mark: Add and Remove listeners for keyboard events
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.bottomText.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    /**
     Called when keyboardWillHide
     */
    @objc func keyboardWillHide(_ notification: Notification) {
//        let temp = getKeyboardHeight(notification)
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notificatoin: Notification) -> CGFloat {
        let userInfo = notificatoin.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
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
