
import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tab = .FirstGameView
    
    enum Tab {
        case FirstGameView
        case SecondGameView
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            FirstGameView()
                .tabItem {
                    Label("P v P", systemImage: "person.line.dotted.person")
                }
                .tag(Tab.FirstGameView)
            
            SecondGameView()
                .tabItem{
                    Label("P v E", systemImage: "rectangle.inset.filled.and.person.filled")
                        
                }
                .tag(Tab.SecondGameView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
