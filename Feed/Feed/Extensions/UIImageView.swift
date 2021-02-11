//
// Created by Иван Лизогуб on 10.02.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        self.kf.setImage(with: url)
    }
}
