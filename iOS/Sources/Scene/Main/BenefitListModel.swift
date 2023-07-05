import Foundation

struct BenefitListModel: Codable {
    let benefitList: [Benefits]

    enum CodingKeys: String, CodingKey {
        case benefitList = "benefit_list"
    }
}

struct Benefits: Codable {
    let id: Int
    let title: String
    let control: String
    let content: String
    let userCategory: String
    let benefitCategory: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case control
        case content
        case userCategory = "user_category"
        case benefitCategory = "benefit_category"
    }
}
