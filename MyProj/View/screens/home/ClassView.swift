//
//  ClassView.swift
//  MyProj
//
//  Created by Adam Zapiór on 27/07/2023.
//

import Foundation
import SwiftUI
import SwiftDate

enum ClassState {
    case future
    case ongoing
    case past
}



struct ClassView: View {
    
    let klass: ClassModel
    let state: ClassState

    init(klass: ClassModel, time: Date) {
        self.klass = klass

        if klass.startDate > time {
            state = .future
        } else if klass.endDate < time {
            state = .past
        } else {
            state = .ongoing
        }
    }

    private func dateToTimeString(_ date: Date) -> String {
        date.in(region: .current).toFormat("H:mm")
    }

    var body: some View {
        HStack(
            alignment: .top,
            spacing: 24
        ) {
            VStack(
                alignment: .trailing,
                spacing: 8
            ) {
                Text(dateToTimeString(klass.startDate))
                    .foregroundColor(
                        state == .ongoing
                            ? .brown
                            : state == .future
                                ? .primary
                                : .secondary
                    )
                Text(dateToTimeString(klass.endDate))
                    .foregroundColor(
                        state == .ongoing
                            ? .green
                            : state == .future
                                ? .primary
                                : .secondary
                    )
                    .fontWeight(state == .ongoing ? .medium : .regular)
            }
            .font(.callout)
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text(klass.name)
                    .font(.body)
                Text(klass.type)
                    .font(.caption)
            }
        }
        .padding()
    }
}


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date()
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-ongoing")
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date() + 1.days
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-past")
        ClassView(
            klass: ClassModel(
                name: "Math 101",
                type: "lecture",
                startDate: Date(),
                endDate: Date() + 90.minutes
            ),
            time: Date() - 1.days
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("ClassView-future")
    }
}
