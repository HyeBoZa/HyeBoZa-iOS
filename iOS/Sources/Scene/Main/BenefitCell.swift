//
//  BenefitCell.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/05.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit

class MainCell: BaseTC {
    public var categoryID = ""
    private var image = ""
    
    private let categoryImage = UIImageView().then {
        $0.image = HyeBoZaIOSAsset.
    }
    
    override func configureVC() {
        switch categoryID {
        case "카드":
            image = "CARD"
        case "혜택":
            image = "BENEFIT"
        case "제도":
            image = "ROYAL"
        case "정책":
            image = "BOOK"
        default:
            image = ""
        }
    }
}
