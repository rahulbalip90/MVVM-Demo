//
//  videoTableViewCell.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import UIKit
import Kingfisher

class videoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var containerView: DesignableView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    
    let placeholderImage = UIImage(named: "placeholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellId() -> String{
        return "videoTableViewCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bindData(data : Video){
        self.labelTitle.text = data.title
        
        let x : Int = calculate(views: data.views ?? 0)
        let myString = String(x)
        self.labelView.text = myString + " K"
        
        self.labelDuration.text = data.durationFormatted ?? "00" + " hr"
        
        if let url = URL(string:data.thumbnail?.url ?? ""){
            imgView.kf.indicatorType = .activity
            imgView.kf.setImage(with: url)
        }
    }
    
    
    func calculate(views : Int) -> Int{
        return views / 1000;
    }
}
