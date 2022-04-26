//
//  ViewController.swift
//  ContentfulDemo
//
//  Created by Anuraag Shakya on 26.04.22.
//

import Contentful
import UIKit

struct ContentfulConstants {
    static let spaceId = "214q1nptnllb"
    static let environmentId = "contenful-demo"
    static let accessToken = "TwxSKwE4keDKODcnk_r5Ld_TAE-OxXkk7w1YRbmiiaI"
}

class ViewController: UIViewController {

    let client = Client(spaceId: ContentfulConstants.spaceId,
                        environmentId: ContentfulConstants.environmentId,
                        accessToken: ContentfulConstants.accessToken,
                        contentTypeClasses: [
                            DemoArticleContent.self,
                            DemoArticle.self
                        ])

    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticles()
    }

    private func loadArticles() {
        let query = QueryOn<DemoArticle>
            .where(valueAtKeyPath: "sys.id[in]", .equals("4IyqcJxLwBPl8cxgiKPgRi"))
            .localizeResults(withLocaleCode: "de-DE")
            .include(10)

        client.fetchArray(of: DemoArticle.self, matching: query) { result in
            switch result {
            case .success(let articles):
                print(articles.items[0])
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }

}

