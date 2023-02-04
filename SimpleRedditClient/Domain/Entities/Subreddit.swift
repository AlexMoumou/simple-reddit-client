//
//  Subreddit.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation

struct Subreddit: Equatable, Identifiable {
    let id: String
    let title: String
    let name: String
    let display_name_prefixed: String
    let header_img: String
    let public_description: String
    let description_html: String
    let over18: Bool
}

extension Subreddit {
    static func example() -> Subreddit {
        return Subreddit(id: "33apz",
                    title: "Floof",
                    name: "t5_33apz",
                    display_name_prefixed: "r/Floof",
                    header_img: "https://a.thumbs.redditmedia.com/uNGS2EMF_E9zioRHXXuudcvNykqWHY16OIJDodHk9G0.png",
                    public_description: "r/interestingasfuck",
                    description_html: "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;&lt;strong&gt;Rules:&lt;/strong&gt; &lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Post floofy animals. Non-cat floofs are welcome too!&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Please don&amp;#39;t post your fat short-haired cats (or any obese pets) here. They&amp;#39;re cute and all but we need to stop glorifying something that unhealthy.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;No animal abuse or dead animals.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;&lt;strong&gt;Please source images you find online.&lt;/strong&gt;&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Fake or misidentified animals will be removed. Feel free to repost with the correct ID though.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Be respectful. Don&amp;#39;t post things degrading to women, people of color, cultural minorities, those with disabilities, and gender and sexual minorities.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Help &lt;a href=\"/r/Floof\"&gt;/r/Floof&lt;/a&gt; become huge! If you see a floof in another subreddit, comment and tell them to xpost here!&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;",
                    over18: false)
    }
    
    func copyWith(
        id: String? = nil,
        title: String? = nil,
        name: String? = nil,
        display_name_prefixed: String? = nil,
        header_img: String? = nil,
        public_description: String? = nil,
        description_html: String? = nil,
        over18: Bool? = nil
    ) -> Subreddit {
        return Subreddit(id: id ?? self.id,
                         title: title ?? self.title,
                         name: name ?? self.name,
                         display_name_prefixed: display_name_prefixed ?? self.display_name_prefixed,
                         header_img: header_img ?? self.header_img,
                         public_description: public_description ?? self.public_description,
                         description_html: description_html ?? self.description_html,
                         over18: over18 ?? self.over18
        )
    }
}
