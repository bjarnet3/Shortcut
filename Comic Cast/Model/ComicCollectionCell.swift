//
//  ComicCollectionCell.swift
//  Comic Cast
//
//  Created by Bjarne Tvedten on 20/01/2019.
//  Copyright © 2019 Digital Mood. All rights reserved.
//

import UIKit

class ComicCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitleLbl: UILabel!
    @IBOutlet weak var comicAltLbl: UILabel!
    @IBOutlet weak var comicFav: UIButton!
    
    public var comic: Comic?
    public var selectMultipleItems = false
    
    public var favorite = false {
        didSet {
            self.comic?.fav = favorite
            
            let color = favorite == true ? UIColor.red : UIColor.lightGray
            self.comicFav.alpha = favorite == true ? 0.9 : 0.7
            self.comicFav.titleLabel?.textColor = color
            self.comicFav.setTitleColor(color, for: .normal)
            
            self.layoutIfNeeded()
            print("layutIfNeeded")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 18.0
        self.layer.borderWidth = 0.60
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        self.favorite = !favorite
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected /* && selectMultipleItems */ {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.48, initialSpringVelocity: 0.32, options: .curveEaseInOut, animations: { () in
                    
                    self.alpha = 0.45
                })
            } else {
                UIView.animate(withDuration: 0.40, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.30, options: .curveEaseOut, animations: { () in
                    
                    self.alpha = 1.0
                })
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.48, initialSpringVelocity: 0.32, options: .curveEaseInOut, animations: { () in
                    
                    self.alpha = 0.85
                    self.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
                    hapticButton(.selection)
                })
            } else {
                UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: { () in
                    
                    self.alpha = 1.0
                    self.transform = CGAffineTransform(scaleX: 1.00, y: 1.00)
                })
            }
        }
    }
    
    public func loadCell(comic: Comic) {
        if let urlString = comic.img {
            if !comic.local {
                self.comicImageView.loadImageUsingCacheWith(urlString: urlString)
            } else {
                self.comicImageView.image = UIImage(named: urlString)
            }
        }
        self.comicTitleLbl.text = comic.title ?? "No Comic Title"
        self.comicAltLbl.text = comic.alt ?? "No Alt Text"
        
        self.favorite = comic.fav
        self.comic = comic
    }
}