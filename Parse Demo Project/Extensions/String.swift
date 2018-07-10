//
//  String.swift
//  SUB Chat
//
//  Created by Marius Ilie on 28/03/17.
//  Copyright © 2017 Marius Ilie. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(forFont font: UIFont) -> CGFloat{
        let attributes = NSDictionary(object: font, forKey:NSAttributedStringKey.font as NSCopying)
        let sizeOfText = self.size(withAttributes: (attributes as! [NSAttributedStringKey : AnyObject]))
        
        return sizeOfText.width
    }
}
