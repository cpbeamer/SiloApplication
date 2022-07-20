

import Foundation

enum AppStrings: String {
    
    case appTitle = "appTitle"
    
    //MARK:- Login
    case login = "login"
    case enterLoginDetails = "enterLoginDetails"
    case userName = "userName"
    case password = "password"
    case forgotPasswordWithQuestionMark = "forgotPasswordWithQuestionMark"
    case dontHaveAccount = "dontHaveAccount"
    case signUp = "signUp"
    case enterUserName = "enterUserName"
    case enterPassword = "enterPassword"
    case identifyYourself = "identifyYourself"
    case authenticationFailed = "authenticationFailed"
    case notVerifiedTryAgain = "notVerifiedTryAgain"
    case biometryUnavailable = "biometryUnavailable"
    case biometricNotConfigured = "biometricNotConfigured"
    
    //MARK:- SignUp
    case fillDetailstoCreateAccount = "fillDetailstoCreateAccount"
    case nameAsterisk = "nameAsterisk"
    case fullNameAsterisk = "fullNameAsterisk"
    case userNameAsterisk = "userNameAsterisk"
    case emailAddress = "emailAddress"
    case mobileNumberAsterisk = "mobileNumberAsterisk"
    case passwordAsterisk = "passwordAsterisk"
    case acceptPrivacyPolicy = "acceptPrivacyPolicy"
    case alredyHaveAccount = "alredyHaveAccount"
    case alredyTaken = "alredyTaken"
    case enterName = "enterName"
    case enterValidName = "enterValidName"
    case enterValidFullName = "enterValidFullName"
    case enterUniqueUserName = "enterUniqueUserName"
    case enterValidUserName = "enterValidUserName"
    case enterEmail = "enterEmail"
    case enterValidEmail = "enterValidEmail"
    case enterMobileNumber = "enterMobileNumber"
    case enterValidMobileNumber = "enterValidMobileNumber"
    case enterValidPassowrd = "enterValidPassowrd"
    case acceptPrivacyWarning = "acceptPrivacyWarning"
    
    //MARK:- Forgot Password
    case forgotPassword = "forgotPassword"
    case enterRegisteredNumber = "enterRegisteredNumber"
    case resetPassword = "resetPassword"
    case mobileNumber = "mobileNumber"
    
    //MARK:- OTP Verifcation
    case phoneNumberVerification = "phoneNumberVerification"
    case shareOTPRecievedOnMObile = "shareOTPRecievedOnMObile"
    case notRecievedYet = "notRecievedYet"
    case resend = "resend"
    case confirm = "confirm"
    
    //MARK:- Reset Password
    case resetPasswordDescription = "resetPasswordDescription"
    case confirmPassword = "confirmPassword"
    
    //MARK:- Complete Profile Step 1
    case completeYourProfile = "completeYourProfile"
    case stepOneRecoveryPhrase = "stepOneRecoveryPhrase"
    case yourRecoveryPhraseDescription = "yourRecoveryPhraseDescription"
    case tapToRevealRecoveryPhrase = "tapToRevealRecoveryPhrase"
    case copy = "copy"
    case neverSharePhrase = "neverSharePhrase"
    case iUnderstandLooseMyRecoveryWords = "iUnderstandLooseMyRecoveryWords"
    case continueValue = "continueValue"
    case info = "info"
    case recoveryPhraseSensitiveDescription = "recoveryPhraseSensitiveDescription"
    case copiedPhrase = "copiedPhrase"
    case revealPhraseWarning = "revealPhraseWarning"
    case acceptCondition = "acceptCondition"
    
    //MARK:- Complete Profile Step 2
    case stepTwoSetUpPin = "stepTwoSetUpPin"
    case yourPinUsedDescription = "yourPinUsedDescription"
    case fourDigit = "fourDigit"
    case sixDigit = "sixDigit"
    case createPIN = "createPIN"
    case confirmPIN = "confirmPIN"
    case pinNotMatch = "pinNotMatch"
    case activateBiometrics = "activateBiometrics"
    case resetPin = "resetPin"
    
    //MARK:- Complete Profile Step 3
    case stepThreeSelectCurrency = "stepThreeSelectCurrency"
    case selectCurrencyDescription = "selectCurrencyDescription"
    case done = "done"
    
    //MARK:- Complete Profile Step 4
    case stepFourKYC = "stepFourKYC"
    case kyc = "kyc"
    case uploadDocForKYC = "uploadDocForKYC"
    case fileSizeDesc = "fileSizeDesc"
    case selectGovernmentId = "selectGovernmentId"
    case selectAddressProof = "selectAddressProof"
    case uploadDocument = "uploadDocument"
    case governmentID = "governmentID"
    case drivingLicense = "drivingLicense"
    case passportCard = "passportCard"
    case passport = "passport"
    case maxKYCFileSizeWarning = "maxKYCFileSizeWarning"
    case dob = "dob"
    case country = "country"
    case state = "state"
    case city = "city"
    case postalCode = "postalCode"
    case street1 = "street1"
    case street2 = "street2"
    
    //MARK:- Tutorial Screen
    case tradeCrypto = "tradeCrypto"
    case tradeCryptoDescription = "tradeCryptoDescription"
    case trackValueChanges = "trackValueChanges"
    case trackValueChangesDescription = "trackValueChangesDescription"
    case safelyStoreCrypto = "safelyStoreCrypto"
    case safelyStoreCryptoDescription = "safelyStoreCryptoDescription"
    case next = "next"
    case skip = "skip"
    case getStarted = "getStarted"
    
    //MARK:- Confirm Recovery Phrase
    case word = "word"
    case confirmRecoveryPhrase = "confirmRecoveryPhrase"
    case tapWordInSameOrder = "tapWordInSameOrder"
    case phraseNotMatched = "phraseNotMatched"
    
    //MARK:- Some Common Strings
    case somethingWentWrong = "somethingWentWrong"
    case chooseOptions = "chooseOptions"
    case camera = "camera"
    case gallery = "gallery"
    case documents = "documents"
    case selectOption = "selectOption"
    case cameraNotAvailable = "cameraNotAvailable"
    case chooseImage = "chooseImage"
    case chooseFromGallery = "chooseFromGallery"
    case takePhoto = "takePhoto"
    case cancel = "cancel"
    case alert = "alert"
    case settings = "settings"
    case restrictedFromUsingCamera = "restrictedFromUsingCamera"
    case changePrivacySettingAndAllowAccessToCamera = "changePrivacySettingAndAllowAccessToCamera"
    case restrictedFromUsingLibrary = "restrictedFromUsingLibrary"
    case changePrivacySettingAndAllowAccessToLibrary = "changePrivacySettingAndAllowAccessToLibrary"
    case ok = "ok"
    case yes = "yes"
    case no  = "no"
    case pleaseCheckInternetConnection  = "pleaseCheckInternetConnection"
    case requestTimeOut = "requestTimeOut"
    case accountBlocked = "accountBlocked"
    case sessionExpired = "sessionExpired"
    
    //MARK:- Reset Pin
    case resetPinRestore = "resetPinRestore"
    case noWalletWithMnemonic = "noWalletWithMnemonic"
    case resetPinDescription = "resetPinDescription"
    case restorePinDescription = "restorePinDescription"
    
    //MARK:- Passcode View
    case logout = "logout"
    case areYouSureLogout = "areYouSureLogout"
    case invalidPin = "invalidPin"
    
    //MARK:- Home
    case send = "send"
    case receive = "receive"
    case request = "request"
    case assets = "assets"
    case showHideAssets = "showHideAssets"
    
    //MARK:- Update Currencies
    case selectCurrency = "selectCurrency"
    case addCurrency = "addCurrency"
    case searchCurrencies = "searchCurrencies"
    case selectLocalCurrency = "selectLocalCurrency"
    case selectYourLocalCurrency = "selectYourLocalCurrency"
    case noCurrenciesFound = "noCurrenciesFound"
    
    //MARK:- Currency Details
    case buy = "buy"
    case walletTransaction = "walletTransaction"
    case walletBalance = "walletBalance"
    case coins = "coins"
    case In = "In"
    
    //MARK:- Profile
    case menu = "menu"
    case searchUsers = "searchUsers"
    case notifications = "notifications"
    case transactionsHistory = "transactionsHistory"
    case paymentMethods = "paymentMethods"
    case friends = "friends"
    case requests = "requests"
    case profile = "profile"
    case security = "security"
    case contactUs = "contactUs"
    case privacyPolicy = "privacyPolicy"
    case termsConditions = "termsConditions"
    case kycPending = "kycPending"
    case kycInProgress = "kycInProgress"
    case kycCompleted = "kycCompleted"
    
    //MARK:- Select Transaction
    case selectTransactionType = "selectTransactionType"
    case sell = "sell"
    case exchange = "exchange"
    case buyCryptoWithCash = "buyCryptoWithCash"
    case sellCryptoWithCash = "sellCryptoWithCash"
    case changeOneCryptoToOther = "changeOneCryptoToOther"
    
    //MARK:- Receive
    case requestResc = "requestResc"
    case scanAboveQR = "scanAboveQR"
    case downloadQR = "downloadQR"
    case share = "share"
    case copied = "copied"
    case imageSaved = "imageSaved"
    
    //MARK:- Contact Us
    case message = "message"
    case enterMessageHere = "enterMessageHere"
    case submit = "submit"
    case contactUsSuccess = "contactUsSuccess"
    
    //MARK:- Settings
    case notificationDesc = "notificationDesc"
    case restore = "restore"
    case restoreDesc = "restoreDesc"
    
    //MARK:- Securuty Settings
    case securitySettings = "securitySettings"
    case viewBackupPhrase = "viewBackupPhrase"
    case viewBackupPhraseDesc = "viewBackupPhraseDesc"
    case enablePasscode = "enablePasscode"
    case enablePasscodeDesc = "enablePasscodeDesc"
    case enableFaceId = "enableFaceId"
    case enableFaceIdDesc = "enableFaceIdDesc"
    case changePin = "changePin"
    case changePinDesc = "changePinDesc"
    case changePassword = "changePassword"
    case changePasswordDesc = "changePasswordDesc"
    
    //MARK:- Change PIN
    case currentPinDesc = "currentPinDesc"
    case newPinDesc = "newPinDesc"
    case confirmPinDesc = "confirmPinDesc"
    case enterPin = "enterPin"
    case pinUpdated = "pinUpdated"
    case success = "success"
    case failed = "failed"
    case setNewPin = "setNewPin"
    
    //MARK:- Edit Profile
    case firstNameAsterisk = "firstNameAsterisk"
    case lastNameAsterisk = "lastNameAsterisk"
    case enterFirstName = "enterFirstName"
    case enterLastName = "enterLastName"
    case save = "save"
    case profileUpdated = "profileUpdated"
    case editProfileWarning = "editProfileWarning"
    
    //MARK:- Decrypt Phrase
    case decryptPhrase = "decryptPhrase"
    case enterPinToDecryptPhrase = "enterPinToDecryptPhrase"
    case recoveryPhrase = "recoveryPhrase"
    
    //MARK:- Assets
    case searchCurrencyWallets = "searchCurrencyWallets"
    case currenciesUpdated = "currenciesUpdated"
    
    //MARK:- Change Password
    case changePasswordPageDesc = "changePasswordPageDesc"
    case oldPassword = "oldPassword"
    case newPassword = "newPassword"
    case passwordChangeSuccess = "passwordChangeSuccess"
    
    //MARK:- Friends & Search
    case onThePlatform = "onThePlatform"
    case externalWallet = "externalWallet"
    case search = "search"
    case noResultFound = "noResultFound"
    
    //MARK:- Scanner
    case scanningNotSupported = "scanningNotSupported"
    case deviceNotSupprtsScanning = "deviceNotSupprtsScanning"
    case result = "result"
    case scanning = "scanning"
    case scanCompleted = "scanCompleted"
    case requestedUserBlocked = "requestedUserBlocked"
    
    //MARK:- Add External Wallet
    case addExternalWallet = "addExternalWallet"
    case walletName = "walletName"
    case pasteAddress = "pasteAddress"
    case enterWalletName = "enterWalletName"
    case enterWalletAddress = "enterWalletAddress"
    
    //MARK:- Confirmed Failed Details
    case recoveryFailed = "recoveryFailed"
    case recoveryFailedDesc = "recoveryFailedDesc"
    case backToHome = "backToHome"
    case recoverySuccessDesc = "recoverySuccessDesc"
    
    //MARK:- Sell Buy Send & Request
    case enterCoinToBeSold = "enterCoinToBeSold"
    case enterAmount = "enterAmount"
    case equivalentAmount = "equivalentAmount"
    case bankAccount = "bankAccount"
    case select = "select"
    case enterCoinToBePurchased = "enterCoinToBePurchased"
    case modeOfPayment = "modeOfPayment"
    case advancedOption = "advancedOption"
    case addPersonalMessage = "addPersonalMessage"
    case selectUser = "selectUser"
    case add = "add"
    case noUserSelected = "noUserSelected"
    case noRecipientSelected = "noRecipientSelected"
    case paste = "paste"
    
    //MARK:- Bank Card Selection
    case selectBankAccount = "selectBankAccount"
    case addBankAccount = "addBankAccount"
    case makePayment = "makePayment"
    case addCard = "addCard"
    
    //MARK:- Add Recipient
    case addRecipient = "addRecipient"
    case contacts = "contacts"
    case showingResultFor = "showingResultFor"
    
    //MARK:- Review Details
    case review = "review"
    case totalCoins = "totalCoins"
    case totalCoinAmount = "totalCoinAmount"
    case requestSent = "requestSent"
    case transferRequest = "transferRequest"
    case youSend = "youSend"
    case youReceive = "youReceive"
    case half = "half"
    case max = "max"
    case minerFee = "minerFee"
    case networkFee = "networkFee"
    case exchangeFee = "exchangeFee"
    case estimatedTime = "estimatedTime"
    case purchase = "purchase"
    case swipeUpToSell = "swipeUpToSell"
    case swipeUpToBuy = "swipeUpToBuy"
    case swipeUpToSend = "swipeUpToSend"
    case swipeUpToRequest = "swipeUpToRequest"
    case swipeUpToExchange = "swipeUpToExchange"
    case transactionID = "transactionID"
    
    //MARK:- Requests
    case pending = "pending"
    case completed = "completed"
    case less = "less"
    case more = "more"
    
    //MARK:- Add Bank & Card
    case enterBankFirstName = "enterBankFirstName"
    case enterBankLastName = "enterBankLastName"
    case enterAccountNumber = "enterAccountNumber"
    case enterRoutingNumber = "enterRoutingNumber"
    case selectAccountType = "selectAccountType"
    case selectBeneficiaryType = "selectBeneficiaryType"
    case selectCountry = "selectCountry"
    case saveBankDetails = "saveBankDetails"
    case enterCardNumber = "enterCardNumber"
    case expiryMonth = "expiryMonth"
    case securityCode = "securityCode"
    case billingAddressLineOne = "billingAddressLineOne"
    case billingAddressLineTwo = "billingAddressLineTwo"
    case saveCardDetails = "saveCardDetails"
    case cantRequestYourSelf = "cantRequestYourSelf"
    case invalidQRCode = "invalidResult"
    case checking = "checking"
    case savings = "savings"
    case individual = "individual"
    case corporate = "corporate"
    
    //MARK:- Payment Methods
    case delete = "delete"
    case creditDebitCard = "creditDebitCard"
    case addPaymentMethod = "addPaymentMethod"
    case selectPaymentMethod = "selectPaymentMethod"
    case yourKYCPending = "yourKYCPending"
    case yourKYCInProgress = "yourKYCInProgress"
    case yourKYCCompleted = "yourKYCCompleted"
    case documentUploaded = "documentUploaded"
    case uploadDocumenet = "uploadDocumenet"
    case inProgress = "inProgress"
    case active = "active"
    case accountAddedSuccessfully = "accountAddedSuccessfully"
    case documentUploadedSuccessfully = "documentUploadedSuccessfully"
    
    //MARK:- Filters
    case filters = "filters"
    case close = "close"
    case apply = "apply"
    case reset = "reset"
    case transactionType = "transactionType"
    case currencyType = "currencyType"
    case transactionDate = "transactionDate"
    case all = "all"
    
    //MARK:- Notification List
    case complete = "complete"
    case decline = "decline"
    case declined = "declined"
    case requested = "requested"
    case joined = "joined"
    case received = "received"
    case sent = "sent"
    case exchanged = "exchanged"
    case addedToWallet = "addedToWallet"
    case transfered = "transfered"
    case admin = "admin"
    case none = "none"
    case na = "na"
    case sureClearNotification = "sureClearNotification"
    case clearAll = "clearAll"
    
    //MARK:- Card OTP And 2FA
    case verifyCard = "verifyCard"
    case enterSMSOTP = "enterSMSOTP"
    case enter2FAOTP = "enter2FAOTP"
}

extension AppStrings {
    var localized : String {
        return self.rawValue.localized
    }
}
