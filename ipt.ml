module Foo = struct
    type rule = {
        bar : int;
    };;
end

type tableType =
    | Nat
    | Raw
    | Filter
    | Mangle
    | Security;;

module Parser = struct
    type line =
        | Table of tableType
        | Chain
        | Rule;;

    let parse text =
        let lines = Regexp.split (Regexp.regexp "\n") text in
        let lines = List.filter (fun l -> (String.length l) > 0) lines in
        let lines = List.filter (fun l -> l.[0] != '#') lines in

        lines;;
end

let r = {Foo.bar = 777};;

Printf.printf "abc %d\n" r.Foo.bar;;

let xxxabc (x: int) (y: int) =
    Printf.printf "one %d %d\n" x y;
    Printf.printf "two\n";;

let s = "# Generated by iptables-save v1.6.0 on Sat Dec 24 22:17:26 2016
*nat
:PREROUTING ACCEPT [1986:465174]
:INPUT ACCEPT [656:99384]
:OUTPUT ACCEPT [19134:3690779]
:POSTROUTING ACCEPT [19131:3690659]
:DOCKER - [0:0]
-A PREROUTING -m addrtype --dst-type LOCAL -j DOCKER
-A OUTPUT ! -d 127.0.0.0/8 -m addrtype --dst-type LOCAL -j DOCKER
-A POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE
-A DOCKER -i docker0 -j RETURN
COMMIT
# Completed on Sat Dec 24 22:17:26 2016
# Generated by iptables-save v1.6.0 on Sat Dec 24 22:17:26 2016
*filter
:INPUT ACCEPT [6717430:2380091707]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [13470053:18821978560]
:DOCKER - [0:0]
:DOCKER-ISOLATION - [0:0]
-A FORWARD -j DOCKER-ISOLATION
-A FORWARD -o docker0 -j DOCKER
-A FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i docker0 ! -o docker0 -j ACCEPT
-A FORWARD -i docker0 -o docker0 -j ACCEPT
-A DOCKER-ISOLATION -j RETURN
COMMIT
# Completed on Sat Dec 24 22:17:26 2016";;

let rec p x =
    match x with
    | [] -> ()
    | hd::tl -> Printf.printf ": %s\n" hd; p tl;;

p (Parser.parse s);;