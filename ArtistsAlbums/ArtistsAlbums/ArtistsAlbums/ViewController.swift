//
//  ViewController.swift
//  ArtistsAlbums
//
//  Created by Alexander Grafl on 27/11/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var artistTable: UITableView!
    var artists = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addArtist()
        getAllArtists()
        self.artistTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ArtistCell")
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

    func getAllArtists() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!

        // Define what to be fetched
        let fetchRequest = NSFetchRequest(entityName:"Artist")
        
        // Fetch Data from CoreData
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?

        // Set result as artists array
        if let results = fetchedResults {
            artists = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.artistTable.dequeueReusableCellWithIdentifier("ArtistCell") as UITableViewCell
        let artist = artists[indexPath.row]
        
        cell.textLabel.text = artist.valueForKey("name") as? String
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}

