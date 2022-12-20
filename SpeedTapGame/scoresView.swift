//
//  scoresView.swift
//  SpeedTapGame
//
//  Created by  on 12/6/22.
//

import SwiftUI

struct scoresView: View {
    @State var scores:[Int] = []
    var body: some View {
        VStack
        {
            List {
                ForEach(scores, id: \.self)
                {
                    score in
                    Text("\(score)")
                }
            }
            .navigationTitle("Scores")
        }
    }
}

struct scoresView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            scoresView()
        }
        
    }
}
