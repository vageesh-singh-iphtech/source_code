import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!

    var firstOperand: Double? = nil
    var secondOperand: Double? = nil
    var operation: String? = nil
    var currentInput: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        resetCalculator()
    }

    func resetCalculator() {
        firstOperand = nil
        secondOperand = nil
        operation = nil
        currentInput = ""
        updateDisplay(value: "0")
    }

    func updateDisplay(value: String) {
        displayLabel.text = value
    }


    @IBAction func clear_btn(_ sender: Any) {
        resetCalculator()
    }

    @IBAction func divide_btn(_ sender: Any) {
        handleOperation("/")
    }

    @IBAction func multiply_btn(_ sender: Any) {
        handleOperation("*")
    }

    @IBAction func substract_btn(_ sender: Any) {
        handleOperation("-")
    }

    @IBAction func add_btn(_ sender: Any) {
        handleOperation("+")
    }

    @IBAction func result_btn(_ sender: Any) {
        calculateResult()
    }

    @IBAction func zero_btn(_ sender: Any) {
        handleNumberInput("0")
    }

    @IBAction func one_btn(_ sender: Any) {
        handleNumberInput("1")
    }

    @IBAction func two_btn(_ sender: Any) {
        handleNumberInput("2")
    }

    @IBAction func three_btn(_ sender: Any) {
        handleNumberInput("3")
    }

    @IBAction func four_btn(_ sender: Any) {
        handleNumberInput("4")
    }

    @IBAction func five_btn(_ sender: Any) {
        handleNumberInput("5")
    }

    @IBAction func six_btn(_ sender: Any) {
        handleNumberInput("6")
    }

    @IBAction func seven_btn(_ sender: Any) {
        handleNumberInput("7")
    }

    @IBAction func eight_btn(_ sender: Any) {
        handleNumberInput("8")
    }

    @IBAction func nine_btn(_ sender: Any) {
        handleNumberInput("9")
    }

    func handleNumberInput(_ number: String) {
        if currentInput.count < 9 { // Limit input to 9 digits (adjust as needed)
            currentInput += number
            updateDisplay(value: currentInput)
        }
    }

    func handleOperation(_ selectedOperation: String) {
        if let currentInputValue = Double(currentInput) {
            if firstOperand == nil {
                firstOperand = currentInputValue
            } else {
                secondOperand = currentInputValue
                calculateResult()
              //  firstOperand = Double(displayLabel.text!) //Moved to calculateResult
              //  secondOperand = nil //Moved to calculateResult

            }
            operation = selectedOperation
            currentInput = ""
        }
    }

    func calculateResult() {
        guard let first = firstOperand, let operationSymbol = operation, let second = secondOperand ?? Double(currentInput) else { return } // Use currentInput if no second operand

        var result: Double = 0.0

        switch operationSymbol {
        case "+":
            result = first + second
        case "-":
            result = first - second
        case "*":
            result = first * second
        case "/":
            if second != 0 {
                result = first / second
            } else {
                updateDisplay(value: "Error")
                resetCalculator()
                return
            }
        default:
            break
        }

        let formattedResult = String(format: "%g", result) // Remove trailing zeros
        updateDisplay(value: formattedResult)

        firstOperand = Double(formattedResult) // Store the result as the first operand for subsequent calculations
        secondOperand = nil
        operation = nil
        currentInput = ""

    }
}
