import Common

struct WorkspaceBackAndForthCommand: Command {
    let info: CmdStaticInfo = WorkspaceBackAndForthCmdArgs.info

    func _run(_ subject: inout CommandSubject, stdin: String, stdout: inout [String]) -> Bool {
        check(Thread.current.isMainThread)
        guard let previousFocusedWorkspaceName else { return false }
        return WorkspaceCommand(args: WorkspaceCmdArgs(
            target: .workspaceName(name: previousFocusedWorkspaceName, autoBackAndForth: false)
        )).run(&subject, stdout: &stdout)
    }
}
