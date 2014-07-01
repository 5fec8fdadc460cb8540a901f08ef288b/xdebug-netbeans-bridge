<?php
/**
 * RUN MANUALLY WITH:
 * 
 * php -S localhost:9004 /usr/local/bin/xdebug-nb-bridge/xdebug-nb-bridge.php
 * 
 */
$logfile = '/var/log/xdebug-nb-bridge.log';
$time = date("m-d-Y H:i:s");
exec("echo '$time xdebug-nb-bridge.php activated...' >> $logfile");

$cmd = "find /usr/local -name netbeans";
exec($cmd,$output);
$netbeans_path = false;
foreach($output as $key=>$val){
    if(strpos($val,"/bin/netbeans") !== FALSE){
        $netbeans_path = $val;
        break;
    }
}
if($netbeans_path === FALSE){
    exec("echo '$time ERROR: Could find path to Netbeans' >> $logfile");
    exit;
}

$file = (!empty($_GET['file'])) ? $_GET['file'] : null;
$line = (!empty($_GET['line'])) ? $_GET['line'] : null;

if($file === null || $line === null){
    exec("echo '$time ERROR: Could find line number or file' >> $logfile");
    exit;
}

//GET USER NETBEANS IS RUNNING UNDER
$cmd1 = "ps aux | grep 'netbeans' | grep '/lib/nbexec'";
exec($cmd1,$o);
$r = explode(" ",$o[0]);
$user = $r[0];

if(empty($user)){
    
    $logcmd =  "echo 'Netbeans does not seem to be running' << $logfile";
    system($logcmd);
    exit;
}

exec("echo '$time Trying file $file, line $line @ $netbeans_path' run as $user >> $logfile");

$cmd1 = "sh ".$netbeans_path." '".$file.":".$line."'";
$cmd2 = 'su -c "'.$cmd1.'" -s /bin/sh ' . $user;

//echo $cmd2; exit;

/**/
//OPEN NETBEANS
exec($cmd2,$output);

if(!empty($_SERVER['HTTP_REFERER'])){
    header("location: " . $_SERVER['HTTP_REFERER']);
}
else{
    $logcmd = "echo '$time HTTP REFERER COULD NOT BE FOUND.' >> $logfile";
    exec($logcmd);
}