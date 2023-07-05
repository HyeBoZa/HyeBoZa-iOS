import Foundation

struct PostListModel: Codable {
    let postList: [Posts]

    enum CodingKeys: String, CodingKey {
        case postList = "board_list"
    }
}

struct Posts: Codable {
    let id: Int
    let title: String
    let content: String
}
