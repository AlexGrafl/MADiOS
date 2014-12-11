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
    var artist: Artist? = nil

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
        if artist != nil {
            artistLabel.text = artist?.label
            artistName.text = artist?.name
        }
    }

    func createArtist() {
        let artist = NSEntityDescription.insertNewObjectForEntityForName("Album", inManagedObjectContext: self.managedContext!) as Artist
        // Set new values
        artist.name = artistName.text
        artist.label = artistLabel.text
        // Persisting
        self.managedContext!.save(nil)
    }
    
    func editArtist() {
        // Set new values
        artist?.name = artistName.text
        artist?.label = artistLabel.text
        // Persisting
        self.managedContext!.save(nil)
    }

    @IBAction func addArtist(sender: AnyObject) {
        // Check if fields are empty
        if artistLabel.text.isEmpty || artistName.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        // Check if in edit mode
        if artist != nil {
            editArtist()
        } else {
            createArtist()
        }
        navigationController?.popViewControllerAnimated(true)
    }
}

