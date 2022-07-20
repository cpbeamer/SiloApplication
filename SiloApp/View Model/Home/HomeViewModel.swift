//
//  HomeViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class HomeViewModel: NSObject {
    
    private (set) var coin: CoinMarketCap
    private (set) var service: WebServices
    
    override init() {
        self.coin = CoinMarketCap(apiKey: AppConstants.coinMarketCapAPIKey)
        self.service = WebServices()
    }
    
    var showAlertMessage: ((String?) -> ())?
    var supporedCurrencyCallback: (() -> ())?
    var updateChart: (() -> ())?
    private var currencies: [CryptoCurrency] = []
    
    func getSupporedCryptoInfo(loader: Bool = true) {
        coin.exchangeRatesListBy(currencies: Defaults.loggedInUser?.cryptocurrencies?.compactMap({ $0.assetId }), localCurrency: Defaults.localCurrency, loader: loader) { (data, error) in
            guard error == nil else {
                debugPrint(error?.localizedDescription as Any)
                self.showAlertMessage?(nil)
                return
            }
            guard let data = data else { return }
            self.currencies = data.data?.currencies ?? []
            self.supporedCurrencyCallback?()
            self.getWalletBalance()
        }
    }
    
    func getWalletBalance() {
        if let eth = Defaults.loggedInUser?.allCryptocurrencies?.filter({$0.assetId == "ETH"}).first?.walletAddress {
            service.getWalletBalance(addresses: ["ETH": eth], loader: false) { [weak self] (model: WalletBalances?) in
                if let model = model, model.statusCode == ApiCode.success {
//                    if var currencies = Defaults.loggedInUser?.allCryptocurrencies {
//                        for index in 0..<currencies.count {
//                            currencies[index].walletBalance = model.balance(assetId: currencies[index].assetId ?? "")
//                        }
//                        Defaults.loggedInUser?.allCryptocurrencies = currencies
//                    }
                    for index in 0..<(self?.currencies.count ?? 0) {
                        self?.currencies[index].balance = model.balance(assetId: self?.currencies[index].assetId ?? "")
                    }
                    self?.supporedCurrencyCallback?()
                    self?.updateChart?()
                } else {
                    self?.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
                }
            } failure: { (_, errorData) in
                self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
            }
        }
    }
    
    func supportedCurrencies() -> [CryptoCurrency] {
        return self.currencies
    }
    
    var calculateChartAmount: ChartData {
        var data = ChartData()
        for item in currencies {
            if let balance = Double(item.balance), balance > 0 {
                if let price = item.quote?.localCurrency?.price, let change = item.quote?.localCurrency?.percentChange24h {
                    data.totalAmount += balance * price
                    data.changedAmount += (balance * change * price)/100
                }
            }
        }
        if data.totalAmount > 0 {
            data.changedPercent = (data.changedAmount * 100)/data.totalAmount
        }
        for item in currencies {
            if let balance = Double(item.balance), balance > 0, let price = item.quote?.localCurrency?.price {
                item.walletPercent = (balance * price * 100)/data.totalAmount
                continue
            }
            item.walletPercent = 0
        }
        return data
    }
    
    struct ChartData {
        var totalAmount: Double = 0.0
        var changedAmount: Double = 0.0
        var changedPercent: Double = 0.0
        var totalAmountValue: String {
            return "\(Defaults.localCurrency.currencyCode)\(totalAmount.format())"
        }
        var changedAmountValue: String {
            if changedAmount < 0 {
                return "-\(Defaults.localCurrency.currencyCode)\((-changedAmount).format())"
            }
            return "+\(Defaults.localCurrency.currencyCode)\(changedAmount.format())"
        }
        var changedPercentValue: String {
            if changedPercent < 0 {
                return "(\((-changedPercent).format())%)"
            }
            return "(\(changedPercent.format())%)"
        }
        var color: UIColor {
            if changedAmount < 0 {
                return AppColors.warning ?? .red
            }
            return AppColors.authorise ?? .green
        }
    }
}
