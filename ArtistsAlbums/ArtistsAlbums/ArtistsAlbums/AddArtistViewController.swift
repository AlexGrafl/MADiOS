//
//  ViewController.swift
//  ArtistsAlbums
//
//  Created by Alexander Grafl on 09/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class AddArtistViewController: UIViewController {
    

    @IBOutlet weak var addButton: UIButton!	
    @IBOutlet weak var artistLabel: UITextField!
    @IBOutlet weak var artistName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addArtist(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // Get new Artist Object from CoreData
        var artist = NSEntityDescription.insertNewObjectForEntityForName("Artist", inManagedObjectContext: managedContext) as Artist

        
        // Check if fields are empty
        if artistName.text.isEmpty || artistLabel.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Set new values
            artist.name = artistName.text
            artist.label = artistLabel.text

            // Persisting and Error Handling
            var error: NSError? = nil
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
}

