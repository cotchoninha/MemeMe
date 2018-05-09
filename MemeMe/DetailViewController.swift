//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Marcela Ceneviva Auslenter on 09/05/2018.
//  Copyright © 2018 Marcela Ceneviva Auslenter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var memes: Meme!
    
    @IBOutlet weak var detailedImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailedImage.image = memes.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
