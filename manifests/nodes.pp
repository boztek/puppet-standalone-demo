node "default" {
    include php52
    include mysql
    include aegir
}

class d6 {
}

class d7 {
    include php
    class { mysql: root_password => $db_root } # facter
}

node "d6.boztek.net" {
}

node "d7.boztek.net" {
}

node "hostmaster.localdomain" {
    include d7
}