//
//  memeCollectionViewController.swift
//  MemeMe
//
//  Created by Marcela Ceneviva Auslenter on 04/05/2018.
//  Copyright © 2018 Marcela Ceneviva Auslenter. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
//        let meme1 = Meme(topText: "dabhfa lk jdsf nlakjsdnf lkas djnfa sdjfnasdfna", bottomText: "kdhfs sdjfhaslkdj sdjfhasdkj jsdfsad dfjd djfdnsalk", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
//        let meme2 = Meme(topText: "2", bottomText: "2", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
//        let meme3 = Meme(topText: "3", bottomText: "3", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
//        return [meme1, meme2, meme3]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 1.0
        let dimention = (view.frame.size.width - (2 * space))/3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimention, height: dimention)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let memeSquare = self.memes[indexPath.row]
        cell.memeCollectionImage.image = memeSquare.memedImage
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
         detailVC.memes = memes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
