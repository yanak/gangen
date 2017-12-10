//
//  ViewController.swift
//  Gangen
//
//  Created by Yasunori Tanaka on 2017/12/10.
//  Copyright © 2017 Yasunori Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlets
    @IBOutlet weak var handWrittenImage: HandwrittenImage!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Button
  @IBAction func pushButton(_ sender: UIButton) {
    handWrittenImage.setNeedsDisplay()
  }
  
}

// MARK: - IBActions
extension ViewController {
  
  @IBAction func pickImage(_ sender: Any) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .savedPhotosAlbum
    present(pickerController, animated: true)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true)
  }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
