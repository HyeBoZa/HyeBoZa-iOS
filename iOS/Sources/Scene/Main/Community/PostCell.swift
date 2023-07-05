//
//  BenefitCell.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/06.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit

class PostCell: BaseTC {
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = UIColor(named: "Title")
    }
    let user = UILabel().then {
        $0.text = "익명"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor(named: "Sub")
    }

    override func addView() {
        [
            title,
            user
        ].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        title.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
        }
        user.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}
