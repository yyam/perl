perl
====
validation付きオブジェクトの作例)

* Box.pm
* Item.pm

TestBox.t


Itemは、自分が保持しているデータの妥当性を確認するための _check_code(R/O)を持っており、_check_codeはnewまたはvalidate()メソッドが呼ばれたときにチェックした結果のハッシュ値である。
