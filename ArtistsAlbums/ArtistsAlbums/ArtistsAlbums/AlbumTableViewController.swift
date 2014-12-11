//
//  AlbumTableViewController.swift
//  ArtistsAlbums
//
//  Created by Mokepon on 09/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import UIKit
import CoreData

class AlbumTableViewController: UITableViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet var albumTable: UITableView!
    var artist: Artist? = nil
    
    lazy var managedContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        } else {
            return nil
        }
    }()
    
    lazy var albumController: NSFetchedResultsController = {
        // Define what to be fetched
        let fetchRequest = NSFetchRequest(entityName: "Album")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let predicate = NSPredicate(format: "artist == %@", self.artist!)
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

        self.albumTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "AlbmuCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        albumTable.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return albumController.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as UITableViewCell
        let album = albumController.objectAtIndexPath(indexPath) as Album
        
        cell.textLabel!.text = album.name
        
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let delAlbum: Album = albumController.objectAtIndexPath(indexPath) as Album
        self.managedContext!.deleteObject(delAlbum)
        self.managedContext!.save(nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller
        if (segue.identifier == "editAlbum") {
            let index = albumTable.indexPathForSelectedRow()
            let album = albumController.objectAtIndexPath(index!) as Album
            var editAlbumController = segue.destinationViewController as AddAlbumViewController
            editAlbumController.artist = self.artist!
            editAlbumController.album = album
        }
    }
}
