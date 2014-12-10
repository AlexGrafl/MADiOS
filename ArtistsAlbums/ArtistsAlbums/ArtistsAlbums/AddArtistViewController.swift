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
        let entity = NSEntityDescription.entityForName("Artist", inManagedObjectContext: managedContext)
        let artist = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // Check if fields are empty
        if artistName.text.isEmpty || artistLabel.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))

            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // Set new values
            artist.setValue(artistName.text, forKey: "name")
            artist.setValue(artistLabel.text, forKey: "label")

            // Persisting and Error Handling
            var error: NSError? = nil
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
                let alertController = UIAlertController(title: "Error", message: "Couldn not save Artist!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                var artistName = artist.valueForKey("name") as String
                let alertController = UIAlertController(title: "Success", message: "Artist \"\(artistName)\" saved successfully!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
}

