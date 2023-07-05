//
//  DetailVC.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/05.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailVC: BaseVC {
    private let viewModel = DetailVM()
    private let getDetail = BehaviorRelay<Void>(value: ())
    var benefitID = BehaviorRelay<Int>(value: 0)

    private let backView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.2)
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    private let backButton = UIButton().then {
        $0.tintColor = UIColor(named: "Main")
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let xImage = UIImage(systemName: "xmark", withConfiguration: imageConfig.self)
        $0.setImage(xImage, for: .normal)
    }
    private let benefitTitle = UILabel().then {
        $0.textColor = UIColor(named: "Title")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    private let categoryImage = UIImageView().then {
        $0.backgroundColor = .clear
    }
    private let conditionDetail = UILabel().then {
        $0.text = "<해당 조건>"
        $0.textColor = UIColor(named: "Condition")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    private let conditionLabel = UILabel().then {
        $0.textColor = UIColor(named: "Condition")
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 0
    }
    private let contentDetail = UILabel().then {
        $0.text = "<혜택 상세>"
        $0.textColor = UIColor(named: "Condition")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    private let contentLabel = UILabel().then {
        $0.textColor = UIColor(named: "Condition")
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.numberOfLines = 0
    }

    override func bind() {
        let input = DetailVM.Input(getDetail: getDetail.asDriver(), benefitID: benefitID.asDriver())
        let output = self.viewModel.transform(input)
        output.benefits.asObservable()
            .subscribe(onNext: {
                print("no", $0)
                self.benefitTitle.text = $0.title
                switch $0.benefitCategory {
                case "카드":
                    self.categoryImage.image = UIImage(named: "CARD")
                case "혜택":
                    self.categoryImage.image = UIImage(named: "BENEFIT")
                case "제도":
                    self.categoryImage.image = UIImage(named: "ROYAL")
                case "정책":
                    self.categoryImage.image = UIImage(named: "BOOK")
                default:
                    print("이미지 선택 불가")
                }
                self.conditionLabel.text = $0.control
                self.contentLabel.text = $0.content
            }).disposed(by: disposeBag)

        backButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        view.layer.contents = UIImage(imageLiteralResourceName: "Template").cgImage
        view.addSubview(backView)
        backView.addSubview(contentView)
        [
            backButton,
            benefitTitle,
            categoryImage,
            conditionDetail,
            conditionLabel,
            contentDetail,
            contentLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.bottom.equalToSuperview().inset(113)
        }
        backButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(18)
            $0.width.height.equalTo(34)
        }
        benefitTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(90)
        }
        categoryImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(215)
            $0.top.equalTo(benefitTitle.snp.bottom).offset(28)
        }
        conditionDetail.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryImage.snp.bottom).offset(56)
        }
        conditionLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.top.equalTo(conditionDetail.snp.bottom).offset(7)
        }
        contentDetail.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(conditionLabel.snp.bottom).offset(36)
        }
        contentLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(33)
            $0.top.equalTo(contentDetail.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(90)
        }
    }
}
