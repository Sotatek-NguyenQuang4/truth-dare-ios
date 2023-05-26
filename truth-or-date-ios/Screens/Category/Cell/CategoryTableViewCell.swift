//
//  CategoryTableViewCell.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import AlamofireImage

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        categoryImageView.image = nil
    }
    
    func configCell(model: Topic) {
        nameLabel.text = model.name
        lockButton.isHidden = model.isLock
        categoryImageView.image = UIImage(named: model.url_icon)
    }
    
}
