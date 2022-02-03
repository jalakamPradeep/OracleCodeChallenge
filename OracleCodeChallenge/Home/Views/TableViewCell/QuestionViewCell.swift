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
    
    func cellConfigure(item: Item) {
        questionTitle.text = item.title.htmlToString
        item.tags.forEach({ tag in
            questionTags.text =  (questionTags.text ?? "") + tag + ", "
        })
        
        questionTime.text = "Asked on" + item.last_activity_date.localDateString
        questionViews.setTitle(item.view_count.roundedWithAbbreviations, for: .normal)
        questionComments.setTitle(String(item.answer_count), for: .normal)
        questionUpvote.setTitle(String(item.score), for: .normal)
    }
    
    
}
