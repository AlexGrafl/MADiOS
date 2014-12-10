//
//  ArtistTableViewController.swift
//  ArtistsAlbums
//
//  Created by Mokepon on 09/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class ArtistTableViewController: UITableViewController, UITableViewDataSource {

    @IBOutlet var artistTable: UITableView!
    var artists = [NSManagedObject]()
    var artistDetails:NSManagedObject = NSManagedObject()

    override func viewDidLoad() {
        super.viewDidLoad()

        getAllArtists()

        self.artistTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ArtistCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllArtists()
        artistTable.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.artists.count
    }

    func getAllArtists() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // Define what to be fetched
        let fetchRequest = NSFetchRequest(entityName:"Artist")
        
        // Fetch Data from CoreData
        var error: NSError? = nil
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        // Set result as artists array
        if let results = fetchedResults {
            self.artists = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.artistTable.dequeueReusableCellWithIdentifier("ArtistCell") as UITableViewCell
        let artist = artists[indexPath.row]
            
        cell.textLabel.text = artist.valueForKey("name") as? String
            
        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let artistDetails = artists[indexPath.row]
        self.performSegueWithIdentifier("showAlbums", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showAlbums") {
            var albumController = segue.destinationViewController as AlbumTableViewController
            albumController.artist = artistDetails
        }
    }
}
