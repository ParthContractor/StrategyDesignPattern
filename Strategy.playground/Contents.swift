/// The Strategy interface declares pay  method because at runtime payment option/algorithm could be through different payment options. .
protocol PaymentStrategy {
    func pay(_ amount: String,_ currency: String)
}


/// The Payment Context defines the interface of interest to clients.
struct Payment {

    /// The Payment Context maintains a reference to one of the Strategy objects. The
    /// Context does not know the concrete class/struct of a strategy. It should work
    /// with all strategies via the Strategy interface.
    private var strategy: PaymentStrategy

    /// Usually, the Context accepts a strategy through the initilisation, but
    /// also provides a seperate setter method to change it at runtime.
    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    /// Usually, the Context allows replacing a Strategy object at runtime.
    mutating func update(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    /// The Context delegates some work to the Strategy object instead of
    /// implementing multiple versions of the algorithm on its own.
    func performPaymentAction() {
        let _ = strategy.pay("1200", "AUD")
        print("payment initiated with selected strategy..")
    }
}


/// Concrete Strategies implement the algorithm while following the base
/// Strategy. The interface makes them interchangeable in the Payment Context.
struct DebitCard: PaymentStrategy {
    
    func pay(_ amount: String,_ currency: String) {
        print("pay via Debit Card..")
    }

}

struct CreditCard: PaymentStrategy {
    
    func pay(_ amount: String,_ currency: String) {
        print("pay via Credit Card..")
    }

}

struct ComboCard: PaymentStrategy {
    
    func pay(_ amount: String,_ currency: String) {
        print("pay via Combo Card(Credit+Debit) Card..")
    }

}

struct AmazonPay: PaymentStrategy {
    
    func pay(_ amount: String,_ currency: String) {
        print("pay via AmazonPay..")
    }

}

struct Paypal: PaymentStrategy {
    
    func pay(_ amount: String,_ currency: String) {
        print("pay via Paypal..")
    }

}


/// Testing...
var paymentContext = Payment(strategy: Paypal())
paymentContext.performPaymentAction()

paymentContext.update(strategy: CreditCard())
paymentContext.performPaymentAction()

