node "default" {
    $mysql_root_password = '123456789'
    include php52
    include mysql
    include aegir
}
