//
//  MatrixTapCell.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/13/26.
//

import SwiftUI

struct CellData {
    let current: (Int, Int)
    var isOrange: Bool
}

struct MatrixTapCell: View {
    @State var matrix: [[CellData]] = []
    let rows = 8
    let cols = 8
    
    private func prepareMatrix() -> [[CellData]] {
        var res : [[CellData]] = []
        for i in 0...rows {
            var temp : [CellData] = []
            for j in 0...cols {
                temp.append(.init(current: (i,j), isOrange: Bool.random()))
            }
            res.append(temp)
        }
        return res
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Button("Reset", role: .destructive) {
                matrix = prepareMatrix()
            }
            .padding(.bottom, 20)
            .buttonStyle(.glassProminent)
            
            if !matrix.isEmpty {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: 4) {
                        ForEach(0..<cols, id: \.self) { col in
                            Button {
                                dfs(row: row, col: col)
                            } label: {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(matrix[row][col].isOrange ? Color.orange : Color.primary)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .onAppear {
            matrix = prepareMatrix()
        }
    }
}

#Preview {
    MatrixTapCell()
}

extension MatrixTapCell {
    private func dfs(row: Int, col: Int) {
        if matrix[row][col].isOrange {
            matrix[row][col].isOrange = false
        } else {
            return
        }
        
        var stack: [CellData] = []
        stack.append(matrix[row][col])
        
        Task { @MainActor in
            
            while !stack.isEmpty {
                let poppedCell = stack.removeFirst()
                
                // UP
                if poppedCell.current.0 > 0 {
                    var upCell = matrix[poppedCell.current.0-1][poppedCell.current.1]
                    
                    if upCell.isOrange {
                        upCell.isOrange = false
                        matrix[poppedCell.current.0-1][poppedCell.current.1] = upCell
                        
                        stack.append(upCell)
                    }
                }
                
                // DOWN
                if poppedCell.current.0 + 1 < rows {
                    var downCell = matrix[poppedCell.current.0+1][poppedCell.current.1]
                    
                    if downCell.isOrange {
                        downCell.isOrange = false
                        matrix[poppedCell.current.0+1][poppedCell.current.1] = downCell
                        
                        stack.append(downCell)
                    }
                }
                
                // LEFT
                if poppedCell.current.1 > 0 {
                    var leftCell = matrix[poppedCell.current.0][poppedCell.current.1-1]
                    
                    if leftCell.isOrange {
                        leftCell.isOrange = false
                        matrix[poppedCell.current.0][poppedCell.current.1-1] = leftCell
                        
                        stack.append(leftCell)
                    }
                }
                
                // RIGHT
                if poppedCell.current.1 + 1 < cols {
                    var rightCell = matrix[poppedCell.current.0][poppedCell.current.1+1]
                    
                    if rightCell.isOrange {
                        rightCell.isOrange = false
                        matrix[poppedCell.current.0][poppedCell.current.1+1] = rightCell
                        
                        stack.append(rightCell)
                    }
                }
                
                try? await Task.sleep(nanoseconds: 300_000_00)
            }
        }
    }
}
