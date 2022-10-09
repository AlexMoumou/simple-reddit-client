//
//  Endpoint.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import Foundation

protocol Endpoint {
    var url: URL { get }
}

/// BaseUrl of Rick and Morty API Endpoint
private let baseURL = URL(string: "https://www.reddit.com")

private let baseURL_OAUTH = URL(string: "https://oauth.reddit.com")

private let clientID = "wpepFDfBaBStgSalONwunQ"

private let redirectURI = "simpleclient://test"

private let scopes = ["identity", "edit", "flair", "history", "modconfig", "modflair", "modlog", "modposts", "modwiki", "mysubreddits", "privatemessages", "read", "report", "save", "submit", "subscribe", "vote", "wikiedit", "wikiread"]

/// API Endpoints
enum RedditApiEndpoint: Endpoint {
    
    case best
    case login
    case characters(Int)
    case character(Int)
    case locations
    case location(Int)

    var url: URL {
        switch self {
        case .best: return URL(string: "best.json", relativeTo: baseURL)!
        case .login: return URL(string: "/api/v1/authorize?client_id=\(clientID)&response_type=token&state=unique&redirect_uri=\(redirectURI)&scope=\(scopes.joined(separator: ","))", relativeTo: baseURL)!
        case .characters(let page): return URL(string: "character/?page=\(page)", relativeTo: baseURL)!
        case .character(let id): return URL(string: "character/\(id)", relativeTo: baseURL)!
        case .locations: return URL(string: "location", relativeTo: baseURL)!
        case .location(let id): return URL(string: "location/\(id)", relativeTo: baseURL)!
        }
    }
}
