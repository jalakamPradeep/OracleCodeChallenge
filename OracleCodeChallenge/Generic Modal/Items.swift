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
    var owner: Owner
    var view_count: Int
    var answer_count: Int
    var score: Int
    var last_activity_date: Int
    var question_id: Int
    var title: String
    var body: String? // by declaring body as optional we can use same modal for both questions and question detail api
}
