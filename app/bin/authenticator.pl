#!/usr/local/bin/perl --  # -*-Perl-*-
'di';
'ig00';
# authenticator.pl	-- Joe Edmonds
#
# $Log$
$RCSHEADER = '$Header$';	#'
'$Revision$'  =~ /^\$\w+:\s+([.1234567890]+)\s+\$$/;	#'
$VERSION = $1;

print "palace authentication daemon started\n";

($port) = @ARGV;
$port = 2345 unless $port;

use Socket;

# This function takes the username in $_[0] and the password in $_[1].
# It should return a list of strings to be sent to the server if
# authentication succeeds.
# If authentication fails, it should return the null list "()".
# This function is all that needs to be replaced in order to support
# alternative authentication engines (e.g. database-driven)

$passwd_file = "palace_passwd";
sub confirm {
  my($id, $crc, $username, $password) = @_;
  open(PASSWD,$passwd_file);
  while (<PASSWD>) {
    my @tokens = split(/:/,$_);
    print "Checking againt $tokens[0]/$tokens[1]\n";
    if (("$tokens[0]" eq "$username") && ("$tokens[1]" eq "$password")) {
	  shift @tokens; shift @tokens;
	  return join(':', $id, $crc, '1', @tokens);
    }
  }
  return join(':', $id, $crc, '0', ());
}

$sockaddr = 'S n a4 x8';

($name, $aliases, $proto) = getprotobyname('tcp');
($name, $aliases, $port) = getservbyname($port, 'tcp')
  unless $port =~ /^\d+$/;

$this = pack($sockaddr, AF_INET, $port, "\0\0\0\0");

select(NS); $| = 1; select(stdout);

socket(S, PF_INET, SOCK_STREAM, $proto) || die "socket: $!";
# allows fast rebinds
setsockopt(S, SOL_SOCKET, SO_REUSEADDR, 1);
bind(S, $this) || die "bind: $!";
listen(S, 5) || die "connect: $!";

select(S); $| = 1; select(stdout);

for (;;) {
  print "\n\n[LISTENING]\n";
  ($addr = accept(NS,S)) || die $!;
  print "[ACCEPT OK]\n";

  ($af,$port,$inetaddr) = unpack($sockaddr,$addr);
  @inetaddr = unpack('C4',$inetaddr);
  print "[CONNECT: $af $port @inetaddr]\n";

  # main event loop
  while (<NS>) {
    chop;
    @input = split(/:/);
	if ($input[2] eq 'LOGOUT' && $input[3] == undef) {
			print "LOGGING OFF\n============\nUserID: $input[0]\npuidCRC: $input[1]\n\n";
	} else {
			print "userID: $input[0]\npuidCRC: $input[1]\nusername: $input[2]\npassword: $input[3]\n";
			$rval = &confirm(@input);
			print NS pack('C',length($rval)),$rval;
			print "Answer:", $rval, "\n\n";
	}
  }
}

