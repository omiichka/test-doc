//
//  Extension + UIView.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

extension UIView {
    
    func mapConstraint(
        for child: UIView,
        topConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        rightConstant: CGFloat = 0
    ) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            child.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftConstant),
            child.trailingAnchor.constraint(equalTo: trailingAnchor, constant: rightConstant),
            child.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant)
        ])
    }
}
