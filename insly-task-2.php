<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <script type="text/javascript" src="script.js"></script>
    </head>
    <body>
        <form method="post" action="" onsubmit="return getUserTime();">
            <label>Estimated value of the car (100 - 100,000 EUR)</label>
            <input type="number" required min="100" max="100000" name="estimated" /><br>

            <label>Tax percentage (0 - 100%)</label>
            <input type="number" required min="0" max="100" name="tax" /><br>

            <label>Number of instalments (count of payments in which client wants to pay for the policy (1 - 12))</label>
            <input type="number" required min="1" max="12" name="instalments" /><br>
            <input type="hidden" name="user_time" id="user-time" />

            <input type="submit" value="Calculate" />
        </form>

        <?php
        if(!empty($_POST)) {
            $calculation = new Calculation($_POST['estimated'], $_POST['user_time'], $_POST['tax'], $_POST['instalments']);
            $result = $calculation->calculate();
            if(!empty($result)) { ?>
            <table>
                <tr>
                    <th></th>
                    <th>Policy</th>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <th><?php echo $i; ?> instalment</th>
                    <?php } ?>
                </tr>
                <tr>
                    <td>Value</td>
                    <td><?php echo $result['value']; ?></td>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <td></td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>Base Premium (<?php echo $result['base_policy_price']; ?>%)</td>
                    <td><?php echo $result['base_premium']; ?></td>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <td><?php echo $result['instalment_base_premium']; ?></td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>Commission (<?php echo $result['commission']; ?>%)</td>
                    <td><?php echo $result['after_commission']; ?></td>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <td><?php echo $result['instalment_after_commission']; ?></td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>Tax (<?php echo $result['tax']; ?>%)</td>
                    <td><?php echo $result['after_tax']; ?></td>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <td><?php echo $result['instalment_after_tax']; ?></td>
                    <?php } ?>
                </tr>
                <tr>
                    <th>Total cost</th>
                    <th><?php echo $result['total']; ?></th>
                    <?php for($i = 1; $i <= $result['instalments']; $i++) { ?>
                    <td><?php echo $result['instalment_total']; ?></td>
                    <?php } ?>
                </tr>
            </table>
        <?php }
        }?>
    </body>
</html>

<?php
class Calculation {
    private $value;

    private $basePolicyPrice = 11;

    private $commission = 17;

    private $tax = 0;

    private $userTime;

    private $instalments = 1;

    function __construct($value, $userTime, $tax, $instalments) {
        $this->value = $value;
        $this->userTime = strtotime($userTime);
        $this->tax = $tax;
        $this->instalments = $instalments;

        if(date('l', $this->userTime) == 'Friday' && date('H', $this->userTime) >= 15 && date('H', $this->userTime) <= 20) {
            $this->basePolicyPrice = 13;
        }
    }

    function calculate() {
        $basePremium = $this->value * $this->basePolicyPrice / 100;
        $afterCommision = $basePremium * $this->commission / 100;
        $afterTax = $basePremium * $this->tax / 100;
        $total = $basePremium + $afterCommision + $afterTax;

        return [
            'value' => number_format($this->value, 2),
            'base_policy_price' => $this->basePolicyPrice,
            'base_premium' => number_format($basePremium, 2),
            'commission' => $this->commission,
            'after_commission' => number_format($afterCommision, 2),
            'tax' => $this->tax,
            'after_tax' => number_format($afterTax, 2),
            'total' => number_format($total, 2),
            'instalments' => $this->instalments,
            'instalment_base_premium' => number_format($basePremium/$this->instalments, 2),
            'instalment_after_commission' => number_format($afterCommision/$this->instalments, 2),
            'instalment_after_tax' => number_format($afterTax/$this->instalments, 2),
            'instalment_total' => number_format($total/$this->instalments, 2)
        ];
    }
}
?>