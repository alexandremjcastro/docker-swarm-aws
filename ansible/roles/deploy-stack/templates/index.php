<head>
<title>Hello World!</title>
</head>

<body>
<h1>Hello World!</h1>
<p><?php echo 'We are running PHP, version: ' . phpversion(); ?></p>
<?php

$database = "{{ db_database_name }}";
$user = "{{ db_user }}";
$password = "{{ db_pass }}";
$host = "mysql";

$db = mysql_connect("$host","$user","$password");

if (!$db) {
  echo "Cannot connect to the database server";
}elseif ($db && !(mysql_select_db($SQL_DBASE, $db))) {
  echo "Sucessfully connected to the database server! User $user and $database selected!";
}

?>
</body>
