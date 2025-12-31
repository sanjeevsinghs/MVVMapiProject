//
//  ProductCell.swift
//  MVVMapiProject
//
//  Created by bd01 on 30/12/25.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {

    @IBOutlet var imgViewO: UIImageView!
    @IBOutlet var ProBGViewO: UIView!
    @IBOutlet var ProTitleLbl: UILabel!
    @IBOutlet var ProCategoryLbl:UILabel!
    @IBOutlet var RateBtn: UIButton!
    @IBOutlet var DescriptionLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var buyBtn: UIButton!
    
    var product: Product? {
        didSet { // propObserver
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProBGViewO.layer.cornerRadius = 15
        ProBGViewO.clipsToBounds = false
        ProBGViewO.backgroundColor = .systemGray6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailConfiguration() {
        guard let product else { return }
        ProTitleLbl.text = product.title
        ProCategoryLbl.text = product.category
        DescriptionLbl.text = product.description
        priceLbl.text = "$\(product.price)"
        RateBtn.setTitle("\(product.rating.rate)", for: .normal)
        imgViewO.setImage(with: product.image)
//        imgViewO.kf.setImage(with: URL(string: product.image))
    }
    
}
