import Foundation
import UIKit
import Moya

enum API {
    // Main
    case getBenefits(_ user: String, _ category: String)
    case searchBenenfit(_ user: String, _ category: String, _ title: String)
    case searchBenenfitWithTitle(_ title: String)
    case searchBenenfitWithUserAndTitle(_ user: String, _ title: String)
    case searchBenenfitWithCategoryAndTitle(_ category: String, _ title: String)

    // Detail
    case getDetail(_ id: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.209.13.166:8080")!
    }

    var path: String {
        switch self {
        case .getBenefits, .searchBenenfit, .searchBenenfitWithTitle,
                .searchBenenfitWithUserAndTitle, .searchBenenfitWithCategoryAndTitle:
            return "/benefit"
        case .getDetail(let id):
            return "/benefit/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getBenefits, .searchBenenfit, .searchBenenfitWithTitle,
                .searchBenenfitWithUserAndTitle, .searchBenenfitWithCategoryAndTitle, .getDetail:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getBenefits(let user, let category):
            return .requestParameters(
                parameters: [
                    "user": user,
                    "benefit": category
                ],
                encoding: URLEncoding.default
            )
        case .searchBenenfit(let user, let category, let title):
            return .requestParameters(
                parameters: [
                    "user": user,
                    "benefit": category,
                    "title": title
                ],
                encoding: URLEncoding.default
            )
        case .searchBenenfitWithTitle(let title):
            return .requestParameters(
                parameters: [
                    "title": title
                ],
                encoding: URLEncoding.default
            )
        case .searchBenenfitWithUserAndTitle(let user, let title):
            return .requestParameters(
                parameters: [
                    "user": user,
                    "title": title
                ],
                encoding: URLEncoding.default
            )
        case .searchBenenfitWithCategoryAndTitle(let category, let title):
            return .requestParameters(
                parameters: [
                    "benefit": category,
                    "title": title
                ],
                encoding: URLEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
