//
//  AddAlbumViewController.swift
//  ArtistsAlbums
//
//  Created by Mokepon on 09/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class AddAlbumViewController: UIViewController {
    
    
    @IBOutlet weak var albumYear: UITextField!
    @IBOutlet weak var albumName: UITextField!
    @IBOutlet weak var albumFormat: UITextField!
    @IBOutlet weak var addButton: UIButton!
    var artist: Artist? = nil
    var album:Album? = nil

    lazy var managedContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        } else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set values in edit mode
        if album != nil {
            albumName.text = album?.name
            albumFormat.text = album?.format
            albumYear.text = album?.year
        }
    }

    func createAlbum() {
        let album = NSEntityDescription.insertNewObjectForEntityForName("Album", inManagedObjectContext: self.managedContext!) as Album
        // Set new values
        album.name = albumName.text
        album.format = albumFormat.text
        album.year = albumYear.text
        album.artist = self.artist!
        
        // Persisting
        self.managedContext!.save(nil)
    }

    func editAlbum() {
        // Set new values
        album?.name = albumName.text
        album?.format = albumFormat.text
        album?.year = albumYear.text
        album?.artist = self.artist!
        // Persisting
        self.managedContext!.save(nil)
    }

    @IBAction func addAlbum(sender: AnyObject) {
        // Check if fields are empty
        if albumName.text.isEmpty || albumFormat.text.isEmpty || albumYear.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        // Check if in edit mode
        if album != nil {
            editAlbum()
        } else {
            createAlbum()
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
