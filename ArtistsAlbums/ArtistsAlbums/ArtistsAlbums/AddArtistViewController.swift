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
        addArtist()
    }
    
    func addArtist() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // Get new Artist Object from CoreData
        let entity =  NSEntityDescription.entityForName("Artist",
            inManagedObjectContext:
            managedContext)
        let artist = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        // Set new values
        artist.setValue("Artist1", forKey: "name")
        
        // Error Handling
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
}

