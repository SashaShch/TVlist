//
//  TVListCell.swift
//  TVList
//
//  Created by SashaShch on 04.01.2021.
//

import UIKit

class TVListCell: UITableViewCell {

    @IBOutlet weak var programmTitle: UILabel!
    @IBOutlet weak var programmIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
