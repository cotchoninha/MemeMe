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
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")!
        let memeSquare = memes[indexPath.row]
        
        cell.imageView?.image = memeSquare.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "mainController") as! ViewController
        detailController.imagePickerView.image = memes[indexPath.row].memedImage
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}
