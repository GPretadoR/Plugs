//
//  HTMLBuilder.swift
//  YerevanRide
//
//  Created by Garnik Ghazaryan on 5/6/19.
//  Copyright © 2019 Garnik Ghazaryan. All rights reserved.
//

import Foundation

class HTMLBuilder: NSObject {
    var header = ""
    var style = ""

    private func header(headerContent: String) -> String {
        return "<header>" + headerContent + "</header>"
    }

    private func style(style: String) -> String {
        return "<style>" + style + "</style>"
    }

    private func body(bodyContent: String) -> String {
        return "<body>" + bodyContent + "</body>"
    }

    func buildHTMLString(bodyString: String, defaultConfigs: Bool) -> String {
        if defaultConfigs {
            header = """
                <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'>
                <link rel="stylesheet" type="text/css" href="font-face.css">
            """
        }
        return buildHTMLString(bodyString: bodyString)
    }

    func buildHTMLString(bodyString: String) -> String {
        var htmlString = ""

        htmlString.append(header(headerContent: header))
        htmlString.append(style(style: style))
        htmlString.append(body(bodyContent: bodyString))

        return htmlString
    }
}
