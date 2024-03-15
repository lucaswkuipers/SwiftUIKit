//
//  FormText.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2021-08-03.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This view can be used to present action rows in a `List`.
 
 If `hideIfEmpty` is `true` and the text is empty, this view
 is rendered as an `EmptyView`.
 */
public struct ListActionRow<TrailingView: View>: View {

    /**
     Create a form text view.

     - Parameters:
       - title: The view title.
       - text: The long text text.
       - hideIfEmpty: Whether or not to hide the view if the text is empty, by default `false`.
       - trailingView: An optional trailing view to apply to the view.
     */
    public init(
        title: String,
        text: String,
        hideIfEmpty: Bool = false,
        trailingView: @escaping TrailingViewBuilder
    ) {
        self.title = title
        self.text = text
        self.hideIfEmpty = hideIfEmpty
        self.trailingView = trailingView
    }

    /**
     Create a form text view.

     - Parameters:
       - title: The footnote text title.
       - text: The long text text.
       - hideIfEmpty: Whether or not to hide the view if the text is empty, by default `false`.
     */
    public init(
        title: String,
        text: String,
        hideIfEmpty: Bool = false
    ) where TrailingView == EmptyView {
        self.title = title
        self.text = text
        self.hideIfEmpty = hideIfEmpty
        self.trailingView = nil
    }
    
    public let text: String
    
    private let title: String
    private let hideIfEmpty: Bool
    private let trailingView: TrailingViewBuilder?
    
    public typealias TrailingViewBuilder = () -> TrailingView
    
    public var body: some View {
        if hasEmptyText && hideIfEmpty {
            EmptyView()
        } else {
            stack
        }
    }
}

private extension ListActionRow {

    var hasEmptyText: Bool {
        text.trimmingCharacters(in: .whitespaces)
            .isEmpty
    }
    
    var stack: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .lineLimit(1)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(text)
            }
            
            if let trailing = trailingView {
                Spacer()
                trailing()
            }
        }
        .padding(.vertical, 3)
    }
}

#Preview {
    
    List {
        ListActionRow(
            title: "title 1",
            text: "Text value")
        ListActionRow(
            title: "title 2",
            text: "A looong text value with a trailing view."
        ) {
            ListAction.call(phoneNumber: "1234").button
        }
            .buttonStyle(.borderedProminent)
        ListActionRow(
            title: "title 2",
            text: "A looong text value with a trailing view."
        ) {
            ListAction.copy("").button
        }.buttonStyle(.borderedProminent)
        ListActionRow(
            title: "title 3",
            text: "Long\nmultuline\ntext that could have been entered in a text editor.")
        ListActionRow(
            title: "title 4",
            text: "",
            hideIfEmpty: true)
        ListActionRow(
            title: "title 5",
            text: "",
            hideIfEmpty: false)
    }
}
#endif