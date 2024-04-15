//
//  DetailViewController.swift
//  Unidade3
//
//  Created by Davi Oliveira on 2024-04-14.
//

import UIKit

class DetailViewController: UIViewController {

    var issue: Issue?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: issue)
    }

    private func configure(with issue: Issue?) {
        if let photoData = issue?.photo {
            imageView.image = UIImage(data: photoData)
        }

        nameLabel.text = issue?.name
        addressLabel.text = issue?.location
        descriptionLabel.text = issue?.explanation
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
           let topViewController = navigationController.topViewController as? FormViewController {
            topViewController.issue = issue
            topViewController.delegate = self
        }
    }
}

extension DetailViewController: FormViewControllerDelegate {
    func didSaveIssue(_ issue: Issue?) {
        configure(with: issue)
    }
}
