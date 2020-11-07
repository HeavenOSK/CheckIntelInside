//
//  ContentView.swift
//  CheckIntelInsideApp
//
//  Created by 渡邉龍之介 on 2020/11/07.
//

import SwiftUI

extension String {
    var intelInside: Bool {
        get {
            return starts(with: "Intel")
        }
    }
}

struct ContentView: View {
    @State var loading = false
    @State var processName = ""
    
    var body: some View {
        ZStack(content: {
            if loading{
                Text("...")
            }
            else {
                VStack(
                    spacing: 8,
                    content: {
                        HStack(alignment: .center, spacing: 8, content: {
                            Text("intel").font(.largeTitle)
                            if processName.intelInside {
                                Text("still").font(.largeTitle)
                            }else {
                                Text("NOT").font(.largeTitle).bold()
                            }
                            if processName.intelInside {
                                Text("inside...").font(.largeTitle)
                            } else {
                                Text("inside!!!🍎").font(.largeTitle)
                            }
                        })
                    })

            }
            VStack(
                content: {
                    Spacer()
                    HStack(
                        content: {
                            Spacer()
                            Text(processName).padding(8)
                        }
                    )
                })
            
        }).onAppear(perform: {
            processName = getProcessorBrand()
            loading = false
        }).frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func getProcessorBrand() -> String {
        var size : Int = 0
        let string = "machdep.cpu.brand_string"
        sysctlbyname(string, nil, &size, nil, 0)
        var processorBrandName = [CChar](repeating: 0, count: Int(size))
        sysctlbyname(string, &processorBrandName, &size, nil, 0)
        return String(cString:processorBrandName)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
