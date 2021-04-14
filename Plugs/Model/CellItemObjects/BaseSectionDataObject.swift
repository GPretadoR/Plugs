//
//  BaseSectionDataObject.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 11/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

class BaseSectionDataObject {
    let title: String
    var data: [BaseCellItemObject]

    internal init(title: String, data: [BaseCellItemObject]) {
        self.title = title
        self.data = data
    }

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> BaseCellItemObject {
        return data[index]
    }
}
