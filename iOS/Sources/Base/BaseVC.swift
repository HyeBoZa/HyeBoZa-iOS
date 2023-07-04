//
//  BaseVC.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/04.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    let bound = UIScreen.main.bounds
    typealias HyeBoZaColor = HyeBoZaIOSColors.Color
    typealias HyeBoZaImage = HyeBoZaIOSAsset
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        configureVC()
        bind()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bind() {}
}
