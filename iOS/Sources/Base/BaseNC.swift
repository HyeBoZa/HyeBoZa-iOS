//
//  BaseNC.swift
//  HyeBoZa-iOS
//
//  Created by 강인혜 on 2023/07/04.
//  Copyright © 2023 com.HyeBoZa. All rights reserved.
//

import UIKit

class BaseNC: UINavigationController {
    private var backButtonImage: UIImage? {
        return UIImage(systemName: "chevron.backward")!
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 0.0, right: 0.0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    static func makeNavigationController(rootViewController: UIViewController) -> BaseNC {
        let navigationController = BaseNC(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
