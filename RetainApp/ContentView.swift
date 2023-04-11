//
//  ContentView.swift
//  RetainApp
//
//  Created by Tim Bueno on 4/11/23.
//

import CasePaths
import SwiftUI

struct ContentView: View {
  
  @State var isPresented = false
  
  var body: some View {
    Button("Present") {
      self.isPresented = true
    }
    .sheet(isPresented: self.$isPresented) {
      NavigationView {
        SheetView(model: .init())
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button("Cancel") {
                self.isPresented = false
              }
            }
          }
      }
    }
  }
}


@MainActor
class SheetViewModel: ObservableObject {
  @Published var myText = "My Text"
  
  deinit {
    print("### Deinit: SheetViewModel")
  }
}

struct SheetView: View {
  
  @ObservedObject var model: SheetViewModel
  
  var body: some View {
    List {
      Section("Stuff") {
        TextField("Placeholder", text: self.$model.myText)
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
