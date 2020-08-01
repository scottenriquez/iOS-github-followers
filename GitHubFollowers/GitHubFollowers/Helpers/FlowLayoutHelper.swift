//
//  FlowLayoutHelper.swift
//  GitHubFollowers
//
//  Created by Scott Enriquez on 8/1/20.
//  Copyright © 2020 Scott Enriquez. All rights reserved.
//

import UIKit

struct FlowLayoutHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let screenWidth = view.bounds.width
        let defaultPadding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = screenWidth - (defaultPadding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: defaultPadding, right: defaultPadding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
}
