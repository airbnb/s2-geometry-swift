//
//  S2SimpleRegionCoverer.swift
//  S2GeometrySwift
//
//  Created by jacob_rice on 7/5/22.
//  Copyright © 2022 jacob_rice. MIT License.
//

/**
  Similar to S2RegionCoverer, S2SimpleRegionCoverer is a class that
  allows arbitrary regions to be approximated as unions of cells (S2CellUnion)
  but does not contain the overhead like min/max level and max cell.
 */
public class S2SimpleRegionCoverer {

  /**
   Given a connected region and a starting point on the boundary or inside the
   region, returns a set of cells at the given level that cover the region.
   The output cells are returned in arbitrary order.
   */
  static func getSimpleCovering(region: S2Region, level: Int) -> [S2CellId] {
    let startingCell = S2CellId(latlng: region.rectBound.center).parent(level: level)
    var result: [S2CellId] = []
    var all: Set<S2CellId> = [startingCell]
    var queue: [S2CellId] = [startingCell]

    while let cellId = queue.popLast() {
      if !region.mayIntersect(cell: S2Cell(cellId: cellId)) {
        continue
      }
      result.append(cellId)
      for neighbor in cellId.getEdgeNeighbors() {
        if !all.contains(neighbor) {
          queue.append(neighbor)
          all.insert(neighbor)
        }
      }
    }

    return result
  }
}
