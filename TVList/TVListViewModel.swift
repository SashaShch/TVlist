//
//  TVListViewModel.swift
//  TVList
//
//  Created by SashaShch on 04.01.2021.
//

import Foundation

protocol TVListViewModelDelegate {
    func didStartFetching()
    func didFinishFetcing()
}

class TVListViewModel {
    var delegate:TVListViewModelDelegate?
    var programmList =  ProgrammList()
    
    func loadProgramms(borderId: Int = 0, direction: String = "0") {
        delegate?.didStartFetching()
        if let url = URL(string: "http://oll.tv/demo?serial_number=C02V54HEHV27&borderId=\(borderId)&direction=\(direction)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let result = try? JSONDecoder().decode(ProgrammList.self, from: data) {
                        if direction == "-1" {
                            self.programmList.items.insert(contentsOf: result.items, at: 0)
                        } else {
                            self.programmList.items.append(contentsOf: result.items)
                        }
                    }
                }
                self.delegate?.didFinishFetcing()
            }
            task.resume()
        }
    }
}

