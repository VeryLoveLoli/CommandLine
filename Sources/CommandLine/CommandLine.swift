import Foundation

/**
 模拟终端命令
 
 - parameter    currentDirectoryPath:   设置当前目录
 - parameter    argument:               命令和参数
 
 returns: 命令行执行结果
 */
func terminalAnalog(_ currentDirectoryPath: String? = nil, argument: String) -> (Int32, String, String) {
    
    return runCommand("/bin/sh", currentDirectoryPath: currentDirectoryPath, arguments: ["-c", argument])
}

/**
 命令行
 
 - parameter    launchPath:                 命令路径
 - parameter    currentDirectoryPath:       设置当前目录
 - parameter    arguments:                  参数
 
 returns: 命令行执行结果
 */
func runCommand(_ launchPath: String, currentDirectoryPath: String? = nil, arguments: [String]) -> (Int32, String, String) {
    
    /// 进程
    let process = Process()
    
    process.launchPath = launchPath
    process.arguments = arguments
    
    if let path = currentDirectoryPath {
        
        process.currentDirectoryPath = path
    }
    
    /// 输出管道
    let outPipe = Pipe()
    process.standardOutput = outPipe
    
    /// 错误管道
    let errorPipe = Pipe()
    process.standardError = errorPipe
    
    /// 启动
    process.launch()
    
    let outData = outPipe.fileHandleForReading.readDataToEndOfFile()
    let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
    
    /// 等待直到退出（不加这个会只读到一行数据）
    process.waitUntilExit()
    
    /// 状态
    let status = process.terminationStatus
    /// 输出
    let output = String(data: outData, encoding: .utf8) ?? ""
    /// 错误
    let error = String(data: errorData, encoding: .utf8) ?? ""
    
    return (status, output, error)
}
