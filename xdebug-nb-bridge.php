<?php
/**
 * RUN MANUALLY WITH:
 * 
 * php -S localhost:9004 /usr/local/bin/xdebug-nb-bridge/xdebug-nb-bridge.php
 * 
 */
$logfile = '/var/log/xdebug-nb-bridge.log';
exec("xdebug-nb-bridge.php activated... >> $logfile");

$netbeans_path = "/usr/local/netbeans-8.0/bin/netbeans";
$file = (!empty($_GET['file'])) ? $_GET['file'] : null;
$line = (!empty($_GET['line'])) ? $_GET['line'] : null;

if($file === null || $line === null) return;


exec("echo 'Trying file $file, line $line' >> $logfile");

//GET USER NETBEANS IS RUNNING UNDER
$cmd1 = "ps aux | grep 'netbeans'";
exec($cmd1,$output);
$r = explode(" ",$output[0]);
$user = $r[0];

if(empty($user)){
    
    $logcmd =  "echo 'Netbeans does not seem to be running' << $logfile";
    system($logcmd);
    exit;
}

$cmd1 = "sh ".$netbeans_path." '".$file.":".$line."'";
$cmd2 = 'su -c "'.$cmd1.'" -s /bin/sh ' . $user;

//echo $cmd2; exit;

/**/
//OPEN NETBEANS
system($cmd2);

if(!empty($_SERVER['HTTP_REFERER'])){
    header("location: " . $_SERVER['HTTP_REFERER']);
}
else{
    $logcmd = "echo 'HTTP REFERER COULD NOT BE FOUND.' >> $logfile";
    system($logcmd);
}

echo 'bye';