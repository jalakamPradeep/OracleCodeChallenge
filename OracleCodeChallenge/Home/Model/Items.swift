//
//  Items.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation

struct Items: Decodable {
    var items: [Item]
}


struct Item: Decodable {
    var tags: [String]
    var view_count: Int
    var answer_count: Int
    var score: Int
    var last_activity_date: Int
    var question_id: Int
    var title: String
}
