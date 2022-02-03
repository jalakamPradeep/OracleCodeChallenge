//
//  QuestionDescriptionCell.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation
import UIKit

// the view configuration of QuestionViewCell
final class QuestionDescriptionCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var questionDescription: UILabel!
    @IBOutlet weak var questionerImage: UIImageView!
    @IBOutlet weak var questionerName: UILabel!
    @IBOutlet weak var questionerRating: UILabel!
    
    func cellConfigure(item: Item) {
        if let urlString = URL(string: item.owner.profile_image) {
            questionerImage.lazyLoadImage(link: urlString, contentMode: .scaleAspectFit)
        }
        questionerName.text = item.owner.display_name
        questionerRating.text = String(item.owner.reputation)
        questionDescription.text = item.body?.htmlToString
    }
}
