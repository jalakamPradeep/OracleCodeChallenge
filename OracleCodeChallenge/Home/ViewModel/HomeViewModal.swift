//
//  HomeViewModal.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/3/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    @Published var items:[Item] = []
    @Published var errorString = String()
    func getHomeData(getItemCount: Int) {
        let baseUrl = "https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize="+"\(getItemCount)"
        NetworkManager.shared.getData(baseUrl: baseUrl, endpoint: .items, type: Items.self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    self?.errorString = err.localizedDescription
                case .finished:
                    self?.errorString = String() //To make sure errorString is updated once we get data
                }
            }
            receiveValue: { [weak self] itemsData in
                self?.items = itemsData.items
            }
            .store(in: &cancellables)
        }
}
