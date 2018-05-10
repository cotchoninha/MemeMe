//
//  memeTableViewController.swift
//  MemeMe
//
//  Created by Marcela Ceneviva Auslenter on 08/05/2018.
//  Copyright © 2018 Marcela Ceneviva Auslenter. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{
    
    var memes: [Meme]! {
//        let object = UIApplication.shared.delegate
//        let appDelegate = object as! AppDelegate
//        return appDelegate.memes
//        
        let meme1 = Meme(topText: "dabhfa lk jdsf nlakjsdnf lkas djnfa sdjfnasdfna", bottomText: "kdhfs sdjfhaslkdj sdjfhasdkj jsdfsad dfjd djfdnsalk", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
        let meme2 = Meme(topText: "2", bottomText: "2", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
        let meme3 = Meme(topText: "3", bottomText: "3", originalImage: #imageLiteral(resourceName: "me"), memedImage: #imageLiteral(resourceName: "me"))
        return [meme1, meme2, meme3]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MemeTableViewCell
        let memeSquare = memes[indexPath.row]
        
        cell.memeCollectionImage.image = memeSquare.memedImage
        cell.memeDetailText.text = memeSquare.topText + memeSquare.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "mainController") as! ViewController
        detailController.imagePickerView.image = memes[indexPath.row].memedImage
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}
