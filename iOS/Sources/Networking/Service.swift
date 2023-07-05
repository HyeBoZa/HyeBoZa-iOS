import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])

    // Main
    func getBenefits(_ user: String, _ category: String) -> Single<(BenefitListModel?, NetworkingResult)> {
        return provider.rx.request(.getBenefits(user, category))
            .map(BenefitListModel.self)
            .map { return ($0, .getOk)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }

    // Detail
    func getDetail(_ id: Int) -> Single<(Benefits?, NetworkingResult)> {
        return provider.rx.request(.getDetail(id))
            .map(Benefits.self)
            .map { return ($0, .getOk)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
}
