//
//  Continuation.swift
//  OneBook
//
//  Created by weixin on 2024/2/21.
//

import Foundation

struct Continuation {
    
    func helloAsync() async -> Int {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                continuation.resume(returning: Int(arc4random()))
            }
        }
    }
    
    func test() {
        Task.detached {
            print(await helloAsync())
        }
        
        Task {
            print(await helloAsync())
        }
        
        // 主线程等待 1s，防止程序提前退出导致异步任务没有执行
        Thread.sleep(forTimeInterval: 1)
    }
    
    func main() async throws {
            print(await helloAsync())

            let detachedTask = Task.detached { () -> Int in
                print(await helloAsync())
                return 1
            }

            let task = Task { () -> Int in
                print(await helloAsync())
                return 2
            }

            print("detached task result: \(await detachedTask.value)")
            print("task result: \(await task.value)")
        }
}
