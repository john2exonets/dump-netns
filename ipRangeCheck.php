<?php
//
//  ipCheckRange.php -- check to see if the given IP range falls within
//    the given subnet.
//
//  Usage:
//     php -f ipRangeCheck.php 10.1.2.3 10.1.2.3.0/24
//
//  Results:
//     'Yes' - it does
//     'No'  - it does not
//
//  John D. Allen
//  Sept 2013
//
$checkip = $argv[1];
$range = $argv[2];
@list($ip, $len) = explode('/', $range);

if (($min = ip2long($ip)) !== false && !is_null($len)) {
  $clong = ip2long($checkip);
  $max = ($min | (1<<(32-$len))-1);
  if ($clong > $min && $clong < $max) {
    echo "Yes\n";
  } else {
    echo "No\n";
  }
}
?>
