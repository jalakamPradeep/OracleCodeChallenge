//
//  QuestionViewCell.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation
import UIKit

// the view configuration of QuestionViewCell
class QuestionViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionTags: UILabel!
    @IBOutlet weak var questionTime: UILabel!
    @IBOutlet weak var questionUpvote: UIButton!
    @IBOutlet weak var questionComments: UIButton!
    @IBOutlet weak var questionViews: UIButton!
}
