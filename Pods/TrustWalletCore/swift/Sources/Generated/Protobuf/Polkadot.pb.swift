// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Polkadot.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public enum TW_Polkadot_Proto_Network: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case polkadot // = 0
  case kusama // = 2
  case UNRECOGNIZED(Int)

  public init() {
    self = .polkadot
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .polkadot
    case 2: self = .kusama
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .polkadot: return 0
    case .kusama: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension TW_Polkadot_Proto_Network: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [TW_Polkadot_Proto_Network] = [
    .polkadot,
    .kusama,
  ]
}

#endif  // swift(>=4.2)

public enum TW_Polkadot_Proto_RewardDestination: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case staked // = 0
  case stash // = 1
  case controller // = 2
  case UNRECOGNIZED(Int)

  public init() {
    self = .staked
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .staked
    case 1: self = .stash
    case 2: self = .controller
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .staked: return 0
    case .stash: return 1
    case .controller: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension TW_Polkadot_Proto_RewardDestination: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [TW_Polkadot_Proto_RewardDestination] = [
    .staked,
    .stash,
    .controller,
  ]
}

#endif  // swift(>=4.2)

public struct TW_Polkadot_Proto_Era {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// calculated from block number
  public var period: UInt64 = 0

  public var phase: UInt64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct TW_Polkadot_Proto_Balance {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var messageOneof: TW_Polkadot_Proto_Balance.OneOf_MessageOneof? = nil

  public var transfer: TW_Polkadot_Proto_Balance.Transfer {
    get {
      if case .transfer(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Balance.Transfer()
    }
    set {messageOneof = .transfer(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_MessageOneof: Equatable {
    case transfer(TW_Polkadot_Proto_Balance.Transfer)

  #if !swift(>=4.1)
    public static func ==(lhs: TW_Polkadot_Proto_Balance.OneOf_MessageOneof, rhs: TW_Polkadot_Proto_Balance.OneOf_MessageOneof) -> Bool {
      switch (lhs, rhs) {
      case (.transfer(let l), .transfer(let r)): return l == r
      }
    }
  #endif
  }

  public struct Transfer {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var toAddress: String = String()

    /// big integer
    public var value: Data = SwiftProtobuf.Internal.emptyData

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}
}

public struct TW_Polkadot_Proto_Staking {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var messageOneof: TW_Polkadot_Proto_Staking.OneOf_MessageOneof? = nil

  public var bond: TW_Polkadot_Proto_Staking.Bond {
    get {
      if case .bond(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.Bond()
    }
    set {messageOneof = .bond(newValue)}
  }

  public var bondExtra: TW_Polkadot_Proto_Staking.BondExtra {
    get {
      if case .bondExtra(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.BondExtra()
    }
    set {messageOneof = .bondExtra(newValue)}
  }

  public var unbond: TW_Polkadot_Proto_Staking.Unbond {
    get {
      if case .unbond(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.Unbond()
    }
    set {messageOneof = .unbond(newValue)}
  }

  public var withdrawUnbonded: TW_Polkadot_Proto_Staking.WithdrawUnbonded {
    get {
      if case .withdrawUnbonded(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.WithdrawUnbonded()
    }
    set {messageOneof = .withdrawUnbonded(newValue)}
  }

  public var nominate: TW_Polkadot_Proto_Staking.Nominate {
    get {
      if case .nominate(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.Nominate()
    }
    set {messageOneof = .nominate(newValue)}
  }

  public var chill: TW_Polkadot_Proto_Staking.Chill {
    get {
      if case .chill(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking.Chill()
    }
    set {messageOneof = .chill(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_MessageOneof: Equatable {
    case bond(TW_Polkadot_Proto_Staking.Bond)
    case bondExtra(TW_Polkadot_Proto_Staking.BondExtra)
    case unbond(TW_Polkadot_Proto_Staking.Unbond)
    case withdrawUnbonded(TW_Polkadot_Proto_Staking.WithdrawUnbonded)
    case nominate(TW_Polkadot_Proto_Staking.Nominate)
    case chill(TW_Polkadot_Proto_Staking.Chill)

  #if !swift(>=4.1)
    public static func ==(lhs: TW_Polkadot_Proto_Staking.OneOf_MessageOneof, rhs: TW_Polkadot_Proto_Staking.OneOf_MessageOneof) -> Bool {
      switch (lhs, rhs) {
      case (.bond(let l), .bond(let r)): return l == r
      case (.bondExtra(let l), .bondExtra(let r)): return l == r
      case (.unbond(let l), .unbond(let r)): return l == r
      case (.withdrawUnbonded(let l), .withdrawUnbonded(let r)): return l == r
      case (.nominate(let l), .nominate(let r)): return l == r
      case (.chill(let l), .chill(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  public struct Bond {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var controller: String = String()

    public var value: Data = SwiftProtobuf.Internal.emptyData

    public var rewardDestination: TW_Polkadot_Proto_RewardDestination = .staked

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct BondExtra {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var value: Data = SwiftProtobuf.Internal.emptyData

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct Unbond {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var value: Data = SwiftProtobuf.Internal.emptyData

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct WithdrawUnbonded {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var slashingSpans: Int32 = 0

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct Nominate {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var nominators: [String] = []

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct Chill {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}
}

/// Input data necessary to create a signed transaction.
public struct TW_Polkadot_Proto_SigningInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var blockHash: Data = SwiftProtobuf.Internal.emptyData

  public var genesisHash: Data = SwiftProtobuf.Internal.emptyData

  public var nonce: UInt64 = 0

  public var specVersion: UInt32 = 0

  public var transactionVersion: UInt32 = 0

  /// big integer
  public var tip: Data = SwiftProtobuf.Internal.emptyData

  /// empty means Immortal
  public var era: TW_Polkadot_Proto_Era {
    get {return _era ?? TW_Polkadot_Proto_Era()}
    set {_era = newValue}
  }
  /// Returns true if `era` has been explicitly set.
  public var hasEra: Bool {return self._era != nil}
  /// Clears the value of `era`. Subsequent reads from it will return its default value.
  public mutating func clearEra() {self._era = nil}

  public var privateKey: Data = SwiftProtobuf.Internal.emptyData

  public var network: TW_Polkadot_Proto_Network = .polkadot

  public var messageOneof: TW_Polkadot_Proto_SigningInput.OneOf_MessageOneof? = nil

  public var balanceCall: TW_Polkadot_Proto_Balance {
    get {
      if case .balanceCall(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Balance()
    }
    set {messageOneof = .balanceCall(newValue)}
  }

  public var stakingCall: TW_Polkadot_Proto_Staking {
    get {
      if case .stakingCall(let v)? = messageOneof {return v}
      return TW_Polkadot_Proto_Staking()
    }
    set {messageOneof = .stakingCall(newValue)}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum OneOf_MessageOneof: Equatable {
    case balanceCall(TW_Polkadot_Proto_Balance)
    case stakingCall(TW_Polkadot_Proto_Staking)

  #if !swift(>=4.1)
    public static func ==(lhs: TW_Polkadot_Proto_SigningInput.OneOf_MessageOneof, rhs: TW_Polkadot_Proto_SigningInput.OneOf_MessageOneof) -> Bool {
      switch (lhs, rhs) {
      case (.balanceCall(let l), .balanceCall(let r)): return l == r
      case (.stakingCall(let l), .stakingCall(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  public init() {}

  fileprivate var _era: TW_Polkadot_Proto_Era? = nil
}

/// Transaction signing output.
public struct TW_Polkadot_Proto_SigningOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Signed and encoded transaction bytes.
  public var encoded: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "TW.Polkadot.Proto"

extension TW_Polkadot_Proto_Network: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "POLKADOT"),
    2: .same(proto: "KUSAMA"),
  ]
}

extension TW_Polkadot_Proto_RewardDestination: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "STAKED"),
    1: .same(proto: "STASH"),
    2: .same(proto: "CONTROLLER"),
  ]
}

extension TW_Polkadot_Proto_Era: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Era"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "period"),
    2: .same(proto: "phase"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt64Field(value: &self.period)
      case 2: try decoder.decodeSingularUInt64Field(value: &self.phase)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.period != 0 {
      try visitor.visitSingularUInt64Field(value: self.period, fieldNumber: 1)
    }
    if self.phase != 0 {
      try visitor.visitSingularUInt64Field(value: self.phase, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Era, rhs: TW_Polkadot_Proto_Era) -> Bool {
    if lhs.period != rhs.period {return false}
    if lhs.phase != rhs.phase {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Balance: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Balance"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "transfer"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1:
        var v: TW_Polkadot_Proto_Balance.Transfer?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .transfer(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .transfer(v)}
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if case .transfer(let v)? = self.messageOneof {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Balance, rhs: TW_Polkadot_Proto_Balance) -> Bool {
    if lhs.messageOneof != rhs.messageOneof {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Balance.Transfer: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Balance.protoMessageName + ".Transfer"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "to_address"),
    2: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.toAddress)
      case 2: try decoder.decodeSingularBytesField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.toAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.toAddress, fieldNumber: 1)
    }
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Balance.Transfer, rhs: TW_Polkadot_Proto_Balance.Transfer) -> Bool {
    if lhs.toAddress != rhs.toAddress {return false}
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Staking"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "bond"),
    2: .standard(proto: "bond_extra"),
    3: .same(proto: "unbond"),
    4: .standard(proto: "withdraw_unbonded"),
    5: .same(proto: "nominate"),
    6: .same(proto: "chill"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1:
        var v: TW_Polkadot_Proto_Staking.Bond?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .bond(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .bond(v)}
      case 2:
        var v: TW_Polkadot_Proto_Staking.BondExtra?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .bondExtra(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .bondExtra(v)}
      case 3:
        var v: TW_Polkadot_Proto_Staking.Unbond?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .unbond(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .unbond(v)}
      case 4:
        var v: TW_Polkadot_Proto_Staking.WithdrawUnbonded?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .withdrawUnbonded(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .withdrawUnbonded(v)}
      case 5:
        var v: TW_Polkadot_Proto_Staking.Nominate?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .nominate(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .nominate(v)}
      case 6:
        var v: TW_Polkadot_Proto_Staking.Chill?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .chill(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .chill(v)}
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    switch self.messageOneof {
    case .bond(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    case .bondExtra(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    case .unbond(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    case .withdrawUnbonded(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    case .nominate(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    case .chill(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking, rhs: TW_Polkadot_Proto_Staking) -> Bool {
    if lhs.messageOneof != rhs.messageOneof {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.Bond: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".Bond"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "controller"),
    2: .same(proto: "value"),
    3: .standard(proto: "reward_destination"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.controller)
      case 2: try decoder.decodeSingularBytesField(value: &self.value)
      case 3: try decoder.decodeSingularEnumField(value: &self.rewardDestination)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.controller.isEmpty {
      try visitor.visitSingularStringField(value: self.controller, fieldNumber: 1)
    }
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 2)
    }
    if self.rewardDestination != .staked {
      try visitor.visitSingularEnumField(value: self.rewardDestination, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.Bond, rhs: TW_Polkadot_Proto_Staking.Bond) -> Bool {
    if lhs.controller != rhs.controller {return false}
    if lhs.value != rhs.value {return false}
    if lhs.rewardDestination != rhs.rewardDestination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.BondExtra: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".BondExtra"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.BondExtra, rhs: TW_Polkadot_Proto_Staking.BondExtra) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.Unbond: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".Unbond"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.Unbond, rhs: TW_Polkadot_Proto_Staking.Unbond) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.WithdrawUnbonded: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".WithdrawUnbonded"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "slashing_spans"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.slashingSpans)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.slashingSpans != 0 {
      try visitor.visitSingularInt32Field(value: self.slashingSpans, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.WithdrawUnbonded, rhs: TW_Polkadot_Proto_Staking.WithdrawUnbonded) -> Bool {
    if lhs.slashingSpans != rhs.slashingSpans {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.Nominate: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".Nominate"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "nominators"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedStringField(value: &self.nominators)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.nominators.isEmpty {
      try visitor.visitRepeatedStringField(value: self.nominators, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.Nominate, rhs: TW_Polkadot_Proto_Staking.Nominate) -> Bool {
    if lhs.nominators != rhs.nominators {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_Staking.Chill: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = TW_Polkadot_Proto_Staking.protoMessageName + ".Chill"
  public static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_Staking.Chill, rhs: TW_Polkadot_Proto_Staking.Chill) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_SigningInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningInput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_hash"),
    2: .standard(proto: "genesis_hash"),
    3: .same(proto: "nonce"),
    4: .standard(proto: "spec_version"),
    5: .standard(proto: "transaction_version"),
    6: .same(proto: "tip"),
    7: .same(proto: "era"),
    8: .standard(proto: "private_key"),
    9: .same(proto: "network"),
    10: .standard(proto: "balance_call"),
    11: .standard(proto: "staking_call"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.blockHash)
      case 2: try decoder.decodeSingularBytesField(value: &self.genesisHash)
      case 3: try decoder.decodeSingularUInt64Field(value: &self.nonce)
      case 4: try decoder.decodeSingularUInt32Field(value: &self.specVersion)
      case 5: try decoder.decodeSingularUInt32Field(value: &self.transactionVersion)
      case 6: try decoder.decodeSingularBytesField(value: &self.tip)
      case 7: try decoder.decodeSingularMessageField(value: &self._era)
      case 8: try decoder.decodeSingularBytesField(value: &self.privateKey)
      case 9: try decoder.decodeSingularEnumField(value: &self.network)
      case 10:
        var v: TW_Polkadot_Proto_Balance?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .balanceCall(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .balanceCall(v)}
      case 11:
        var v: TW_Polkadot_Proto_Staking?
        if let current = self.messageOneof {
          try decoder.handleConflictingOneOf()
          if case .stakingCall(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.messageOneof = .stakingCall(v)}
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.blockHash, fieldNumber: 1)
    }
    if !self.genesisHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.genesisHash, fieldNumber: 2)
    }
    if self.nonce != 0 {
      try visitor.visitSingularUInt64Field(value: self.nonce, fieldNumber: 3)
    }
    if self.specVersion != 0 {
      try visitor.visitSingularUInt32Field(value: self.specVersion, fieldNumber: 4)
    }
    if self.transactionVersion != 0 {
      try visitor.visitSingularUInt32Field(value: self.transactionVersion, fieldNumber: 5)
    }
    if !self.tip.isEmpty {
      try visitor.visitSingularBytesField(value: self.tip, fieldNumber: 6)
    }
    if let v = self._era {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }
    if !self.privateKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.privateKey, fieldNumber: 8)
    }
    if self.network != .polkadot {
      try visitor.visitSingularEnumField(value: self.network, fieldNumber: 9)
    }
    switch self.messageOneof {
    case .balanceCall(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
    case .stakingCall(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 11)
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_SigningInput, rhs: TW_Polkadot_Proto_SigningInput) -> Bool {
    if lhs.blockHash != rhs.blockHash {return false}
    if lhs.genesisHash != rhs.genesisHash {return false}
    if lhs.nonce != rhs.nonce {return false}
    if lhs.specVersion != rhs.specVersion {return false}
    if lhs.transactionVersion != rhs.transactionVersion {return false}
    if lhs.tip != rhs.tip {return false}
    if lhs._era != rhs._era {return false}
    if lhs.privateKey != rhs.privateKey {return false}
    if lhs.network != rhs.network {return false}
    if lhs.messageOneof != rhs.messageOneof {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Polkadot_Proto_SigningOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "encoded"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.encoded)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.encoded.isEmpty {
      try visitor.visitSingularBytesField(value: self.encoded, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Polkadot_Proto_SigningOutput, rhs: TW_Polkadot_Proto_SigningOutput) -> Bool {
    if lhs.encoded != rhs.encoded {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
