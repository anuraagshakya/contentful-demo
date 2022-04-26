//
//  DemoArticleContent.swift
//  ContentfulDemo
//
//  Created by Anuraag Shakya on 26.04.22.
//

import Contentful

class DemoArticle: EntryDecodable, FieldKeysQueryable {

    static var contentTypeId: ContentTypeId = "demoArticle"

    // Default properties of Contentful's content entities
    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    // Custom proporties
    var body: RichTextDocument?

    enum FieldKeys: String, CodingKey {
        case body
    }

    required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
        try fields.resolveLink(forKey: .body, decoder: decoder) { [weak self] body in
          self?.body = body as? RichTextDocument
        }
    }

}
