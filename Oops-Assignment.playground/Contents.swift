import UIKit
protocol PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool) throws -> ()
}

enum PaymentError: Error {
    case invalidCardDetails
    case insufficientFunds
    case exceededLimit
    case otherCases
}

class CreditCardProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool) throws -> () {
        if isValid {
            print("Payment of \(amount) processed successfully using Credit Card.")
        } else {
            throw PaymentError.invalidCardDetails
        }

    }
}

class CashProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool = true) throws -> () {
        if amount < 100 {
            throw PaymentError.insufficientFunds
        } else {
            print("Payment of \(amount) processed successfully using Cash.")
        }
    }
}

class ChequeProcessor: PaymentProcessor {
    func processPayment(amount: Double, isValid: Bool = true) throws -> () {
        if amount > 10000 {
            throw PaymentError.exceededLimit
        } else {
            print("Payment of \(amount) processed successfully using Cheque.")
        }
    }
}

func main_function() {

    let creditCardProcessor = CreditCardProcessor()
    let cashProcessor = CashProcessor()
    let chequeProcessor = ChequeProcessor()

    do {
        try creditCardProcessor.processPayment(amount: 3000, isValid: true)
        try creditCardProcessor.processPayment(amount: 3000, isValid: false)
    } catch PaymentError.invalidCardDetails {
        print("Error: Invalid card details. Please try again.\n")
    } catch {
        print("Error in Processing Payment")
    }

    do {
        try cashProcessor.processPayment(amount: 5000)
        try cashProcessor.processPayment(amount: 50)
    } catch  PaymentError.insufficientFunds {
        print("Make sure to have sufficient funds for the payment. \n")
    } catch {
        print("Error in Processing Payment")
    }

    
    do {
        try chequeProcessor.processPayment(amount: 500)
        try chequeProcessor.processPayment(amount: 20000)
    } catch  PaymentError.exceededLimit {
        print("Please don't exceed the limit. \n")
    } catch {
        print("Error in Processing Payment")
    }
}

main_function()
