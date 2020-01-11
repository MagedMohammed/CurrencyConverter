//
//  DownloadRequestExtension.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//
import Foundation
import Alamofire

extension DownloadRequest {
    open class func suggestedDownloadDestination(
        for directory: FileManager.SearchPathDirectory = .documentDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        with options: DownloadOptions)
        -> DownloadFileDestination
    {
        return { temporaryURL, response in
            let destination = DownloadRequest.suggestedDownloadDestination(for: directory, in: domain)(temporaryURL, response)
            return (destination.destinationURL, options)
        }
    }
}
