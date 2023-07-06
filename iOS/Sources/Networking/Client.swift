import Foundation
import UIKit
import Moya

enum API {
    // Main
    case searchBenenfit(_ user: String, _ category: String, _ title: String)

    // Detail
    case getDetail(_ id: Int)

    // PostList
    case getBoards
    case getPostDetail(_ id: Int)
    case searchPost(_ title: String)

    // NewPost
    case postNewBoard(_ title: String, _ content: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.209.13.166:8080")!
    }

    var path: String {
        switch self {
        case .searchBenenfit:
            return "/benefit"
        case .getDetail(let id):
            return "/benefit/\(id)"
        case .getBoards, .postNewBoard:
            return "/board"
        case .getPostDetail(let id):
            return "/board/\(id)"
        case .searchPost:
            return "/board/search"
        }
    }
    var method: Moya.Method {
        switch self {
        case .searchBenenfit, .getDetail, .getBoards, .getPostDetail, .searchPost:
            return .get
        case .postNewBoard:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .searchBenenfit(let user, let category, let title):
            return .requestParameters(
                parameters: [
                    "user": user,
                    "benefit": category,
                    "title": title
                ],
                encoding: URLEncoding.default
            )
        case .postNewBoard(let title, let content):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "content": content
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .searchPost(let title):
            return .requestParameters(
                parameters: [
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
