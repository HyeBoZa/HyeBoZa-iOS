//
//  DetailVC.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/06.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailVC: BaseVC {
    private let viewModel = PostDetailVM()
    private let getDetail = BehaviorRelay<Void>(value: ())
    var postID = BehaviorRelay<Int>(value: 0)

    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
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
    private let postTitle = UILabel().then {
        $0.textColor = UIColor(named: "Title")
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    private let userLabel = UILabel().then {
        $0.text = "익명"
        $0.textColor = UIColor(named: "Sub")
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    private let contentLabel = UILabel().then {
        $0.textColor = UIColor(named: "Condition")
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }

    override func bind() {
        let input = PostDetailVM.Input(getDetail: getDetail.asDriver(), postID: postID.asDriver(onErrorJustReturn: 0))
        let output = self.viewModel.transform(input)
        output.post.asObservable()
            .subscribe(onNext: {
                self.postTitle.text = $0.title
                self.contentLabel.text = $0.content
            }).disposed(by: disposeBag)

        backButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: false)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        view.layer.contents = UIImage(imageLiteralResourceName: "Template").cgImage
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            backButton,
            postTitle,
            userLabel,
            contentLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.left.right.equalTo(scrollView.frameLayoutGuide).inset(30)
            if contentLabel.countCurrentLines() * 19 > 150 {
                $0.height.equalTo((contentLabel.countCurrentLines())*19)
            } else {
                $0.top.bottom.equalToSuperview().inset(110)
            }
        }
        backButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(18)
            $0.width.height.equalTo(30)
        }
        postTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.left.right.equalToSuperview().inset(55)
        }
        userLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(postTitle.snp.bottom).offset(16)
        }
        contentLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.top.equalTo(userLabel.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().inset(75)
        }
    }
}
