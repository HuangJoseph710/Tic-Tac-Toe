
import SwiftUI

struct FirstGameView: View
{
    @StateObject var gameState = FirstGameState()
    
    var body: some View 
    {
        
        let gameStop = gameState.showAlert
        let borderSize = CGFloat(20)
        
        VStack{
            VStack{
                Text(gameState.turnText())
                    .font(.title)
                    .bold()
                    .padding()
                Image(systemName: "arrowtriangle.down.fill")
                    .padding(.top,-25)
            }
            .offset(x: CGFloat(gameState.distance), y: 0)
            .animation(.easeOut(duration: 0.75), value: gameState.distance)
            .padding(.bottom,-30)
            .opacity(gameStop ? 0 : 1)

            HStack{
                VStack{
//                    Text("Crosses")
                    Text("Player A")
                    Text(String(gameState.crossesScore))
                }.padding()
                VStack{
//                    Text("Noughts")
                    Text("Player B")
                    Text(String(gameState.noughtsScore))
                }.padding()
            }
            .font(.title)
            .bold()
            .padding()
            
            VStack(spacing: borderSize) {
                
                ForEach(0...2, id: \.self){ row in
                    HStack(spacing: borderSize) {
                        ForEach(0...2, id: \.self) { column in
                            
                            let cell = gameState.board[row][column]
                                
                            Button {
                                if (gameState.canPlace(row, column)){
                                    withAnimation{
                                        gameState.distance *= (-1)
                                    }
                                    gameState.placeTile(row, column)
                                }
                            } label: {
                                Text(cell.displayTile())
                                    .font(.system(size: 60))
                                    .foregroundColor(Color.white)
                                    .bold()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(cell.tileColor())
                                    .cornerRadius(7)
                                    .shadow(radius: 4)
                            }
                        }
                    }
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
            .animation(.easeInOut(duration: 0.65), value: gameStop)
            
//            .alert(isPresented: $gameState.showAlert)
//            {
//                Alert(
//                    title: Text(gameState.alertMessage),
//                    dismissButton: .default(Text("Next Game"))
//                    {
//                        gameState.resetBoard()
//                    }
//                )
//            }
            
            if (gameStop){
                Text(gameState.alertMessage)
                    .foregroundColor(gameState.alertMessage == "Draw" ? .orange : .green)
                    .bold()
                    .scaleEffect(2.5)
                    .animation(.linear(duration: 0.5), value: gameStop)
                    .padding(.vertical,50)
                
                Spacer()
            }
                
            Spacer()
            
            HStack(){
                Button("Restart") {
                    gameState.restartGame()
                }
                .padding()
                .font(.title2)
                
                if gameState.showAlert{
                    Button("Next Game") {
                        gameState.resetBoard()
                    }
                    .padding()
                    .font(.title2)
                    .transition(.slide)
                }
                
            }
        }
    }
}

struct FirstGameView_Previews: PreviewProvider {
    static var previews: some View {
        FirstGameView()
    }
}
