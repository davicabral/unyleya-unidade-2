//
//  FormViewController.swift
//  Unidade3
//
//  Created by Davi Oliveira on 2024-04-14.
//

import UIKit
import PhotosUI

protocol FormViewControllerDelegate: AnyObject {
    func didSaveIssue(_ issue: Issue?)
}

class FormViewController: UIViewController {

    private let coreDataManager: CoreDataManager = CoreDataManager()

    @IBOutlet weak var textVIew: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var photoButton: UIButton!

    var issue: Issue?
    weak var delegate: FormViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        textVIew.layer.borderColor = color
        textVIew.layer.borderWidth = 0.5
        textVIew.layer.cornerRadius = 5

        if let issue {
            textVIew.text = issue.explanation
            nameTextField.text = issue.name
            addressTextField.text = issue.location

            if let photoData = issue.photo {
                let image = UIImage(data: photoData)
                photoButton.setBackgroundImage(image, for: .normal)
                photoButton.setTitle(nil, for: .normal)
            }
        }
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didTapSaveButton(_ sender: Any) {
        
        let handledIssue = issue ?? Issue(context: coreDataManager.context)
        handledIssue.name = nameTextField.text
        handledIssue.location = addressTextField.text
        handledIssue.explanation = textVIew.text
        handledIssue.photo = photoButton.backgroundImage(for: .normal)?.jpegData(compressionQuality: 0.2)
        handledIssue.createdAt = handledIssue.createdAt ?? Date()
        
        delegate?.didSaveIssue(handledIssue)
        coreDataManager.saveContext()
        dismiss(animated: true)
    }

    @IBAction func didTapPhotoButton(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
}

extension FormViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemProvider = results.first?.itemProvider{

            if itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let error{
                        print(error)
                    }
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async { [weak self] in
                            self?.photoButton.setBackgroundImage(selectedImage, for: .normal)
                            self?.photoButton.setTitle(nil, for: .normal)
                        }
                    }
                }
            }

        }
    }
}
