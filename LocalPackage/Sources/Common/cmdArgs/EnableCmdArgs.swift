public struct EnableCmdArgs: CmdArgs, RawCmdArgs {
    public static let parser: CmdParser<Self> = cmdParser(
        kind: .enable,
        allowInConfig: true,
        help: """
              USAGE: enable [-h|--help] \(EnableCmdArgs.State.unionLiteral)

              OPTIONS:
                -h, --help   Print help
              """,
        options: [:],
        arguments: [ArgParser(\.targetState, parseState, argPlaceholderIfMandatory: EnableCmdArgs.State.unionLiteral)]
    )
    @Lateinit public var targetState: State

    fileprivate init() {}

    public init(targetState: State) {
        self.targetState = targetState
    }

    public enum State: String, CaseIterable {
        case on, off, toggle
    }
}

public func parseEnableCmdArgs(_ args: [String]) -> ParsedCmd<EnableCmdArgs> {
    parseRawCmdArgs(EnableCmdArgs(), args)
}

private func parseState(arg: String, nextArgs: inout [String]) -> Parsed<EnableCmdArgs.State> {
    parseEnum(arg, EnableCmdArgs.State.self)
}
