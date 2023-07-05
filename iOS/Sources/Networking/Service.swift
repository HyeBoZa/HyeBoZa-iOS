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
    func searchBenenfitWithTitle(_ title: String) -> Single<(BenefitListModel?, NetworkingResult)> {
        return provider.rx.request(.searchBenenfitWithTitle(title))
            .map(BenefitListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func searchBenenfitWithUserAndTitle(
        _ user: String, _ title: String
    ) -> Single<(BenefitListModel?, NetworkingResult)> {
        return provider.rx.request(.searchBenenfitWithUserAndTitle(user, title))
            .map(BenefitListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func searchBenenfitWithCategoryAndTitle(
        _ category: String, _ title: String
    ) -> Single<(BenefitListModel?, NetworkingResult)> {
        return provider.rx.request(.searchBenenfitWithCategoryAndTitle(category, title))
            .map(BenefitListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func searchBenenfit(
        _ user: String,
        _ category: String,
        _ title: String
    ) -> Single<(BenefitListModel?, NetworkingResult)> {
        return provider.rx.request(.searchBenenfit(user, category, title))
            .map(BenefitListModel.self)
            .map { return ($0, .getOk) }
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

    // PostList
    func getBoards() -> Single<(PostListModel?, NetworkingResult)> {
        return provider.rx.request(.getBoards)
            .map(PostListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func getPostDetail(_ id: Int) -> Single<(Posts?, NetworkingResult)> {
        return provider.rx.request(.getPostDetail(id))
            .map(Posts.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func searchPost(_ title: String) -> Single<(PostListModel?, NetworkingResult)> {
        return provider.rx.request(.searchPost(title))
            .map(PostListModel.self)
            .map { return ($0, .getOk) }
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }

    // NewPost
    func postNewBoard(_ title: String, _ content: String) -> Single<NetworkingResult> {
        return provider.rx.request(.postNewBoard(title, content))
            .map { _ -> NetworkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }

    func setNetworkError(_ error: Error) -> NetworkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (NetworkingResult(rawValue: status) ?? .fault)
    }
}
