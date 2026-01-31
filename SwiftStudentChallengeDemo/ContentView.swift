//
//  ContentView.swift
//  SwiftStudentChallengeDemo
//
//  Created by Soham Bhattacharya on 30/01/26.
//

import SwiftUI

struct Card: Identifiable,Hashable {
    let id: Int
    let title: String
    let color: Color
    let textColor: Color
}

struct ContentView: View {
    @Namespace var namespace
    @State var cards: [Card] = [
        Card(id: 0,
             title: "Do!",
             color: .blue,
             textColor: .white),
        Card(id: 1,
             title: "Doing",
             color: .orange,
             textColor: .white),
        Card(id: 2,
             title: "Done",
             color: .green,
             textColor: .white)
    ]
    @State var highlightedCard: Card? = nil
    var body: some View {//viewDidLoad()
        NavigationStack{
            ScrollView {
                ForEach(cards) { card in
                    CardCell(card: card,
                             highlightedCard: $highlightedCard,
                             namespace:namespace
                    )
                }
            }
            
            .navigationTitle("Onboarding")
            .toolbar{
                Button("Start",systemImage: "play"){
                    startAnimation()
                }
                .buttonStyle(.borderedProminent)
                }
            }
        }
            
        
        func startAnimation(){
            var nextIndex: Int
            if let highlightedCard = highlightedCard,
               let currentIndex = cards.firstIndex(of: highlightedCard) {
                nextIndex = (currentIndex + 1) % cards.count
            } else {
                nextIndex = .zero
            }
            withAnimation(.bouncy){
                highlightedCard = cards[nextIndex]
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                startAnimation()
            
            }
        }
    }
            


struct CardCell : View { //UI Collection view cell
    
    let card : Card
    @Binding var highlightedCard: Card?
    let namespace: Namespace.ID
    var body: some View{
        VStack(alignment: .leading){
            Text(card.title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(card.textColor)
                .clipShape(Capsule())
            if card == highlightedCard{
                TaskCell()
                    .matchedGeometryEffect(id: "aviral", in: namespace)
            }
            Text("Some hidden task title")
                .redacted(reason: .placeholder)
        
        }
        .padding()
        .background(card.color)
        .cornerRadius(16)
    }
}
struct TaskCell: View{
    var body: some View{
        Text("My task that will animate")
            .foregroundStyle(.black)
            .padding()
            .background(Color.white)
            .background(Color.white)
            .cornerRadius(16)
        
    }
}
