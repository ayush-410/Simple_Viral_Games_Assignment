//
//  APIError.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 09/02/24.
//

import Foundation

enum APIError: String,Error {
    case invalidURL = "The URL provided is invalid. Please check the URL"
    case invalidData = "The data received from the server is invalid. Please try again later"
    case invalidResponse = "Invalid Response from the server. Please try again later"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
}
