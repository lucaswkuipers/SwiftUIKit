import SwiftUI

public extension ListActionRow {
    
    @available(*, deprecated, message: "Use the new action-based initializer instead.")
    init<TrailingView: View>(
        title: String,
        text: String,
        hideIfEmpty: Bool = false,
        trailingView: @escaping () -> TrailingView
    ) {
        self.init(title: title, text: text, action: nil, hideIfEmpty: hideIfEmpty)
    }
}

public extension ListCard {
    
    @available(*, deprecated, message: "A style must now be applied with .listCardStyle instead.")
    init(
        style: ListCardStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder
    ) where ContextMenuView == EmptyView {
        self.init(content: content)
    }

    @available(*, deprecated, message: "A style must now be applied with .listCardStyle instead.")
    init(
        style: ListCardStyle = .standard,
        @ViewBuilder content: @escaping ContentBuilder,
        @ViewBuilder contextMenu: @escaping ContextMenuBuilder
    ) {
        self.init(content: content, contextMenu: contextMenu)
    }
}

public extension ListShelfSection {
    
    @available(*, deprecated, message: "A style must now be applied with .listShelfSectionStyle instead.")
    init(
        style: ListShelfSectionStyle = .standard,
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(title: title, content: content)
    }
}
