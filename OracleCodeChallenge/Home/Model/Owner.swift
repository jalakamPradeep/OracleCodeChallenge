//
//  Owner.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/3/22.
//

import Foundation

struct Owner: Decodable {
    var reputation : Int
    var user_id : Int
    var user_type : String
    var profile_image : String
    var display_name : String
    var link : String
}
