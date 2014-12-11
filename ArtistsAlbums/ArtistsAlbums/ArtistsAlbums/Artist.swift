//
//  Artist.swift
//  ArtistsAlbums
//
//  Created by phips m on 10/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import Foundation
import CoreData

class Artist: NSManagedObject {

    @NSManaged var label: String
    @NSManaged var name: String
    @NSManaged var relationship: NSSet

}

extension Artist {
    func addAlbum(album: Album) {
        var albums = self.mutableArrayValueForKey("relationship")
        albums.addObject(album)
    }

    func removeAlbum(album: Album) {
        var albums = self.mutableArrayValueForKey("relationship")
        albums.removeObject(album)
    }
}