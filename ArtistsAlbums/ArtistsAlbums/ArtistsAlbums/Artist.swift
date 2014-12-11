//
//  ArtistsAlbums.swift
//  ArtistsAlbums
//
//  Created by Alexander Grafl on 11/12/14.
//  Copyright (c) 2014 Alexander Grafl. All rights reserved.
//

import Foundation
import CoreData

class Artist: NSManagedObject {

    @NSManaged var label: String
    @NSManaged var name: String
    @NSManaged var albums: NSSet

}
