//
//  TodoTableViewCell.swift
//  TodoApp
//
//  Created by 이정은 on 8/16/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var toggleDone: (() -> Void)?
    var toggleFavorite: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func didTapDone(_ sender: Any) {
        toggleDone?()
        print("done!")
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        toggleFavorite?()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
