//
//  ListBadgeIcon.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2023-05-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This view mimics the color badge icons that can be found in
 e.g. System Settings lists on iOS.
 
 The original image will be used if you provide `nil` as the
 `iconColor`. If that image is an SF Symbol, you can apply a
 `.symbolRenderingMode` and `.foregroundStyle` view modifier
 to apply any custom style to the icon, e.g. a palette style.
 
 Note that icon modification, like applying foreground color
 and symbol variant, works best with SF Symbols.
 */
@available(iOS 16.0, *)
public struct ListBadgeIcon: View {
    
    /**
     Create a system settings-like badge icon, with a custom
     badge color and a white, filled icon.
     
     - Parameters:
       - image: The image to use.
       - color: The badge color to apply.
       - height: The icon height, by default `30`.
     */
    public init(
        image: Image,
        badgeColor: Color,
        height: CGFloat? = 30
    ) {
        self.image = image
        self.badgeColor = badgeColor
        self.badgeStrokeColor = .clear
        self.iconColor = .white
        self.iconGradient = false
        self.height = height
    }
    
    /**
     Create a system settings-like badge icon, with a custom
     badge color and a custom colored, filled icon.
     
     - Parameters:
       - image: The image to use.
       - badgeColor: The badge color to apply.
       - iconColor: The icon color to apply, if any.
       - iconGradient: Whether or not to apply a gradient to the icon, by default `true`.
       - height: The icon height, by default `30`.
     */
    public init(
        image: Image,
        badgeColor: Color,
        iconColor: Color?,
        iconGradient: Bool = true,
        height: CGFloat? = 30
    ) {
        self.image = image
        self.badgeColor = badgeColor
        self.badgeStrokeColor = badgeColor == .white ? .hex(0xeeeeee) : .clear
        self.iconColor = iconColor
        self.iconGradient = iconGradient
        self.height = height
    }

    private let image: Image
    private let badgeColor: Color
    private let badgeStrokeColor: Color
    private let iconColor: Color?
    private let iconGradient: Bool
    private let height: CGFloat?

    public var body: some View {
        ZStack {
            badgeColor
                .asGradientBackground()
                .withStrokeColor(badgeStrokeColor)
                .aspectRatio(1, contentMode: .fit)
            image.symbolVariant(.fill)
                .padding(5)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(iconColor, gradientIf: iconGradient)
        }
        .backgroundStyle(badgeColor.gradient)
        .frame(minHeight: height, maxHeight: height)
    }
}

@available(iOS 16.0, *)
public extension ListBadgeIcon {
    
    /// A gray settings icon.
    static var multicolorPalette: some View {
        ListBadgeIcon.white(
            withIcon: .symbol("paintpalette"),
            iconColor: nil
        ).multiColor()
    }
    
    /// A white, red heard badge icon.
    static var redHeart: ListBadgeIcon {
        .white(
            withIcon: .symbol("heart"),
            iconColor: .red
        )
    }
    
    /// A gray settings icon.
    static var settings: ListBadgeIcon {
        ListBadgeIcon(
            image: .symbol("gearshape"),
            badgeColor: .gray,
            iconColor: .white
        )
    }
    
    /// A white, yellow star badge icon.
    static var yellowStar: ListBadgeIcon {
        .white(
            withIcon: .symbol("star"),
            iconColor: .yellow
        )
    }
    
    /// A white badge icon with a colored icon.
    static func white(
        withIcon icon: Image,
        iconColor: Color?
    ) -> ListBadgeIcon {
        ListBadgeIcon(
            image: icon,
            badgeColor: .white,
            iconColor: iconColor
        )
    }
    
    /// Apply a multi-color symbol rendering mode.
    func multiColor() -> some View {
        self.symbolRenderingMode(.multicolor)
    }
}

@available(iOS 16.0, *)
private extension Color {
    
    func asGradientBackground() -> some View {
        Color.clear.overlay(self.gradient)
    }
}

@available(iOS 16.0, *)
private extension View {
    
    @ViewBuilder
    func foregroundColor(
        _ color: Color?,
        gradientIf condition: Bool
    ) -> some View {
        if let color, condition {
            self.foregroundStyle(color.gradient)
        } else if let color {
            self.foregroundStyle(color)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func withStrokeColor(
        _ color: Color
    ) -> some View {
        self.cornerRadius(7)
            .padding(0.6)
            .background(color.cornerRadius(7.6))
    }
}

@available(iOS 16.0, *)
struct ListBadgeIcon_Previews: PreviewProvider {

    static var previews: some View {
        List {
            ListBadgeIcon(
                image: .symbol("exclamationmark.triangle"),
                badgeColor: .orange
            )
            ListBadgeIcon(
                image: .symbol("exclamationmark.triangle"),
                badgeColor: .orange,
                iconColor: .red
            )
            ListBadgeIcon.settings
            ListBadgeIcon.multicolorPalette
            ListBadgeIcon.redHeart
            ListBadgeIcon.yellowStar
        }
    }
}
#endif