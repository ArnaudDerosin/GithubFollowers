//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Arnaud DEROSIN on 2021/02/11.
//  Copyright © 2021 Arnaud Derosin. All rights reserved.
//

import Foundation

extension Date
{
    func convertToMonthYearFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    
}
