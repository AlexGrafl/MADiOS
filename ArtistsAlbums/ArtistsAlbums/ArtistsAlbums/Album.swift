//
//  ArtistsAlbums.swift
//  ArtistsAlbums
//
//  Created by Alexander Grafl on 11/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import Foundation
import CoreData

class Album: NSManagedObject {

    @NSManaged var format: String
    @NSManaged var name: String
    @NSManaged var year: String
    @NSManaged var artist: Artist

}
