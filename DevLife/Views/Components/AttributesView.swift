//
//  AttributesView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//
import SwiftUI

struct Attribute {
    var name: String
    var value: Int
}

struct AttributesView: View {
    var attributes: [Attribute]

    var body: some View {
        HStack {
            ForEach(attributes, id: \.name) { attribute in
                CircularAttributeView(attribute: attribute)
            }
        }
        .padding()
    }
}

struct CircularAttributeView: View {
    var attribute: Attribute

    var body: some View {
        VStack {
            ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(Color.blue)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(attribute.value, 100)) / 100)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .foregroundColor(Color.blue)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.linear, value: attribute.value)

                    Text("\(attribute.value)%")
                        .font(.caption)
            }
            .frame(width: 60, height: 60)
            .padding()

            Text(attribute.name)
                .font(.headline)
        }
    }
}
