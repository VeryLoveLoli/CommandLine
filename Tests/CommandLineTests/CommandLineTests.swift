    import XCTest
    @testable import CommandLine

    final class CommandLineTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
//            XCTAssertEqual(CommandLine().text, "Hello, World!")
        }
        
        func testTerminalAnalog() {
            
            let (status, output, error) = terminalAnalog("~", argument: "ls -a")
            
            print("terminalAnalog status \(status)")
            
            if !output.isEmpty {
                
                print("output:")
                print(output)
            }
            
            if !error.isEmpty {
                
                print("error:")
                print(error)
            }
        }
        
        func testRunCommand() {
            
            let (status, output, error) = runCommand("/bin/sh", currentDirectoryPath: "~", arguments: ["-c", "ls -a"])
            
            print("runCommand status \(status)")
            
            if !output.isEmpty {
                
                print("output:")
                print(output)
            }
            
            if !error.isEmpty {
                
                print("error:")
                print(error)
            }
        }
    }
