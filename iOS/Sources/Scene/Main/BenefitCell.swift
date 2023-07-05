//
//  BenefitCell.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/05.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit

class MainCell: BaseTC {
    let categoryImage = UIImageView().then {
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "BENEFIT")
    }
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = UIColor(named: "Title")
        $0.textAlignment = .right
    }
    let condition = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .light)
        $0.textColor = UIColor(named: "Condition")
        $0.textAlignment = .right
    }
    let content = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor(named: "Content")
        $0.textAlignment = .right
    }

    override func addView() {
        [
            categoryImage,
            title,
            condition,
            content
        ].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        categoryImage.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(180)
            $0.right.equalToSuperview().inset(20)
        }
        condition.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(7)
            $0.left.equalTo(categoryImage.snp.right).offset(24)
            $0.right.equalToSuperview().inset(20)
        }
        content.snp.makeConstraints {
            $0.top.equalTo(condition.snp.bottom).offset(7)
            $0.left.equalTo(categoryImage.snp.right).offset(24)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
