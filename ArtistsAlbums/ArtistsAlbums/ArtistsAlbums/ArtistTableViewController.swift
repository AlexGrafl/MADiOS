//
//  ArtistTableViewController.swift
//  ArtistsAlbums
//
//  Created by Mokepon on 09/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class ArtistTableViewController: UITableViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet var artistTable: UITableView!

    lazy var managedContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        } else {
            return nil
        }
    }()

    lazy var artistController: NSFetchedResultsController = {
        // Define what to be fetched
        let fetchRequest = NSFetchRequest(entityName: "Artist")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // Set controller
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest
            , managedObjectContext: self.managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.performFetch(nil)
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.artistTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ArtistCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        artistTable.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return artistController.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ArtistCell", forIndexPath: indexPath) as UITableViewCell
        let artist = artistController.objectAtIndexPath(indexPath) as Artist

        cell.textLabel.text = artist.name
        
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let delArtist: Artist = artistController.objectAtIndexPath(indexPath) as Artist
        self.managedContext!.deleteObject(delArtist)
        self.managedContext!.save(nil)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAlbum", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showAlbum") {
            let index = artistTable.indexPathForSelectedRow()         
            let artist:Artist = artistController.objectAtIndexPath(index!) as Artist
            var albumController = segue.destinationViewController as AlbumTableViewController
            albumController.artist = artist
        }
    }
}