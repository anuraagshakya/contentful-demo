//
//  DemoArticleContent.swift
//  ContentfulDemo
//
//  Created by Anuraag Shakya on 26.04.22.
//

import Contentful

class DemoArticleContent: EntryDecodable, FieldKeysQueryable {

    static var contentTypeId: ContentTypeId = "demoArticleContent"

    // Default properties of Contentful's content entities
    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    // Custom proporties
    let content: String

    enum FieldKeys: String, CodingKey {
        case content
    }

    required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
        content = try fields.decode(String.self, forKey: .content)
    }

}
