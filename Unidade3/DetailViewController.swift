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
        if let photoData = issue?.photo {
            imageView.image = UIImage(data: photoData)
        }
        
        nameLabel.text = issue?.name
        addressLabel.text = issue?.location
        descriptionLabel.text = issue?.explanation
    }

}
