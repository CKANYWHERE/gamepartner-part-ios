//
//  FriendInfoSection.swift
//  GamePartner
//
//  Created by 민창경 on 2020/10/13.
//
import RxDataSources

struct FriendInfoSection {
    var header: String
    var items: [Item]
}

public protocol FriendInfoSectionType
{
    associatedtype Item
    var items: [Item] { get }
    init(original: Self, items: [Item])
}


extension FriendInfoSection : SectionModelType {
  typealias Item = FriendModel

   init(original: FriendInfoSection, items: [Item]) {
    self = original
    self.items = items
  }
}
