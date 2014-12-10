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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addAlbum(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // Get new Artist Object from CoreData
        var album = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: managedContext) as Album
        
        // Check if fields are empty
        if albumName.text.isEmpty || albumFormat.text.isEmpty || albumYear.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            
            // Set new values
            album.name = albumName.text
            album.format = albumFormat.text
            album.year = albumYear.text
            
            // Persisting and Error Handling
            var error: NSError? = nil
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
}
