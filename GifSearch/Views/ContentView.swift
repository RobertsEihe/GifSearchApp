import SwiftUI

struct ContentView: View {
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            VStack{
                Button(action: {navigationPath.append(Destination.searchView)}, label: {
                    Text("Search GIFs")
                        .frame(width: 200, height: 45)
                })
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                Button(action: {navigationPath.append(Destination.trendingView)}, label: {
                    Text("Trending GIFs")
                        .frame(width: 200, height: 45)
                })
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            .navigationTitle("Giphy Search")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .searchView:
                    SearchView()
                case .trendingView:
                    TrendingView()
                }
            }
        }
    }
}

enum Destination: Hashable {
    case searchView
    case trendingView
}
