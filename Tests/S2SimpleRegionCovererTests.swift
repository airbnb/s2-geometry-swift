//
//  S2SimpleRegionCovererTests.swift
//  S2GeometrySwift
//
//  Created by jacob_rice on 7/5/22.
//  Copyright © 2022 jacob_rice. MIT License.
//

@testable import S2GeometrySwift
import XCTest

class S2SimpleRegionCovererTests: XCTestCase {

  func testAtNorthPole() {
    let latLngHi = S2LatLng.fromDegrees(lat: 84, lng: 20)
    let latLngLo = S2LatLng.fromDegrees(lat: 83, lng: -20)
    let latLngRect = S2LatLngRect(lo: latLngLo, hi: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 2)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    let expectedTokens: Set<String> = ["5b", "4f", "51", "45"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }

  func testSouthWestHemisphere() {
    let latLngHi = S2LatLng.fromDegrees(lat: -52.042169, lng: -68.605687)
    let latLngLo = S2LatLng.fromDegrees(lat: -54.860922, lng: -72.525903)
    let latLngRect = S2LatLngRect(p1: latLngLo, p2: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 3)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    // "bcc" doesn't appear like it should belong, but matches https://s2.sidewalklabs.com/regioncoverer
    let expectedTokens: Set<String> = ["bc4", "bdc", "bcc"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }

  func testSouthEastHemisphere() {
    let latLngHi = S2LatLng.fromDegrees(lat: -40.633311, lng: 148.513249)
    let latLngLo = S2LatLng.fromDegrees(lat: -43.571182, lng: 144.737661)
    let latLngRect = S2LatLngRect(p1: latLngLo, p2: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 4)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    // Seemingly only "aa7" should belong, but others are returned.
    // Same is true when checking https://s2.sidewalklabs.com/regioncoverer
    let expectedTokens: Set<String> = ["6b3", "aa5", "aa1", "aa9", "aa7"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }

  func testNorthEastHemisphere() {
    let latLngHi = S2LatLng.fromDegrees(lat: 31.132386, lng: 129.504296)
    let latLngLo = S2LatLng.fromDegrees(lat: 41.345531, lng: 142.201872)
    let latLngRect = S2LatLngRect(p1: latLngLo, p2: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 5)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    let expectedTokens: Set<String> = ["5fdc", "6024", "354c", "3544", "3514", "605c", "5f84", "603c", "601c", "5fd4", "5ffc", "5fc4", "606c", "353c", "3534", "5fcc", "5fbc", "5f8c", "600c", "3564", "5ff4", "356c", "6044", "6074", "5fec", "5fe4", "6014", "5f74", "3554", "5f9c", "351c", "355c", "6004", "5f94"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }

  func testNewYorkCityCoverage() {
    let latLngHi = S2LatLng.fromDegrees(lat: 40.847066, lng: -73.923754)
    let latLngLo = S2LatLng.fromDegrees(lat: 40.702708, lng: -74.017230)
    let latLngRect = S2LatLngRect(lo: latLngLo, hi: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 10)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    let expectedTokens: Set<String> = ["89c259","89c25b","89c25d","89c25f","89c2f5","89c2f7"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }

  func testSanFranciscoCoverage() {
    let latLngHi = S2LatLng.fromDegrees(lat: 38.243717, lng: -122.089404)
    let latLngLo = S2LatLng.fromDegrees(lat: 37.697793, lng: -123.003567)
    let latLngRect = S2LatLngRect(lo: latLngLo, hi: latLngHi)

    let coveringCellIDs = S2SimpleRegionCoverer.getSimpleCovering(region: latLngRect, level: 11)
    let actualTokens: Set<String> = Set(coveringCellIDs.map { $0.token })
    let expectedTokens: Set<String> = ["808580c", "8085fb4", "808f854", "808586c", "8085e74", "8085a54", "8085944", "8085c6c", "80858bc", "808f61c", "808f804", "80842bc", "80842d4", "8085784", "808f8fc", "80858f4", "8085e84", "8085c8c", "808585c", "808563c", "80858c4", "80859a4", "8085c3c", "80859bc", "808432c", "8085b1c", "8085814", "8085d6c", "8085a4c", "8085a7c", "8085eb4", "8085f0c", "8085f6c", "8085bfc", "8085d04", "808f864", "8085b44", "8085eac", "808f85c", "80858d4", "8085d14", "8085f04", "8085ebc", "8085c1c", "8085d2c", "8085cd4", "80858dc", "8085624", "8085c34", "80856dc", "80859c4", "80850bc", "808f78c", "808f87c", "8085bb4", "8085cec", "80858fc", "8085e14", "8085f14", "808583c", "8085f2c", "80856fc", "808f7ec", "80857bc", "808f8f4", "8085904", "8085af4", "8085f34", "8085c14", "8085764", "8085834", "8085a14", "808570c", "808592c", "8085dc4", "8085cfc", "8085bdc", "8085f1c", "8085084", "808581c", "808f81c", "80850ac", "808564c", "8085974", "80857c4", "80850cc", "80858ac", "8085b84", "80859d4", "80859f4", "8085ee4", "808f894", "8085ea4", "80850ec", "80850c4", "808594c", "808584c", "8085e94", "808597c", "8085754", "8085edc", "80858e4", "808587c", "80859dc", "8085bcc", "8085e9c", "8085704", "80856d4", "8085bc4", "8085a74", "8085efc", "808562c", "8085e54", "808f794", "808565c", "8085ecc", "8085c94", "80850f4", "8085984", "80857ac", "8085f4c", "8085cac", "8085cbc", "8085134", "8085ba4", "808f62c", "8085c0c", "808f84c", "8085cf4", "8085dd4", "8085d94", "80856f4", "8085b0c", "8085ec4", "8085fc4", "80856ec", "808595c", "80858a4", "80859cc", "808573c", "8085874", "80857f4", "8085c04", "8085f54", "8085a8c", "8085854", "80857ec", "80858b4", "8085924", "8085cdc", "80859ec", "8085b9c", "8085124", "8085b64", "8085914", "80850b4", "8085ae4", "8085db4", "80859e4", "808508c", "8085e4c", "808f86c", "808575c", "80856cc", "808f89c", "8085b6c", "808572c", "8085fcc", "8085ef4", "8085864", "8085dbc", "808f844", "8085c64", "8085ed4", "808509c", "8085fa4", "8085bbc", "8085e6c", "8085de4", "8085ce4", "8085b7c", "808579c", "8085c44", "8085fac", "80857e4", "8085934", "80850a4", "8085774", "808f8e4", "8085d1c", "8085e34", "8085c2c", "8085a3c", "8085c74", "8085724", "8085e8c", "8085844", "808f624", "8085e5c", "808f7e4", "80857a4", "8085e64", "8085ccc", "8085b5c", "8085734", "8085c9c", "808f91c", "8085d0c", "8085794", "80857b4", "8085d9c", "80858cc", "8085b8c", "8085bf4", "808f7c4", "80857fc", "808577c", "80850e4", "8085c54", "808582c", "8085f9c", "80850dc", "8085a64", "8085afc", "8085f74", "8085a6c", "8085b04", "8085bd4", "808f83c", "808599c", "808591c", "8085744", "8085da4", "808589c", "808f884", "8085b14", "8085714", "8085654", "808574c", "808f7d4", "8085b94", "8085aec", "808593c", "80850d4", "80859fc", "80859ac", "808511c", "8085cb4", "8085ddc", "8085a0c", "80857cc", "8085c4c", "808f7f4", "808596c", "80859b4", "8085094", "8085d34", "8085dec", "80842c4", "8085894", "8085be4", "808588c", "808f80c", "8085e7c", "8085c24", "8085d3c", "8085824", "8085cc4", "8085954", "8085644", "8085994", "8085d44", "808f8ec", "8085b74", "80842b4", "8085d24", "808f7fc", "8085bec", "808f834", "8085bac", "80858ec", "8085dcc", "8085a1c", "8085dac", "8085634", "8085f44", "8085f3c", "8085e44", "8085c84", "8085a44", "8085eec", "8085d74", "8085e0c", "808513c", "80857dc", "8085a34", "80842cc", "8085f5c", "80857d4", "808578c", "8085d4c", "8085a84", "808f7dc", "8085c7c", "8085ca4", "80856c4", "808576c", "8085804", "8085e3c", "80856e4", "808f874", "8085a5c", "8085a2c", "8085114", "8085fbc", "808f7cc", "808590c", "808f814", "8085a24", "808f824", "808598c", "8085884", "808512c", "808f904", "808f88c", "8085964", "8085b3c", "8085f24", "8085a04", "8085c5c", "808571c"]
    XCTAssertEqual(expectedTokens, actualTokens)
  }
}
