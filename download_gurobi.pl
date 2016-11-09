#!/usr/bin/perl

# Requires HTML::Form, LWP::UserAgent, and LWP::Protocol::https and either
# Tk::DialogBox and Tk::LabEntry or Term::ReadKey.

use HTML::Form;
use LWP::UserAgent;
use Term::ReadKey;
use Config;

local $| = 1;  # autoflush stdout
my $filename;

my @forms;
my $response;
my $mech = LWP::UserAgent->new();
$mech->cookie_jar({});

while (1) {
  if (eval "require Tk::LabEntry;\n require Tk::DialogBox;") {
    my $mw = MainWindow->new();
    $mw->withdraw();

    my $db = $mw->DialogBox(
      -title => 'gurobi.com',
      -buttons => ['Ok', 'Cancel'],
      -default_button => 'Ok');

    $db->Label(-text => 'Enter your user email and password for gurobi.com')->pack();

    $db->add('LabEntry',
      -textvariable => \$email,
      -width => 30,
      -label => 'User Email',
      -labelPack => [-side => 'left'])->pack();

    $db->add('LabEntry',
      -textvariable => \$password,
      -width => 30,
      -label => 'Password ',
      -show => '*',
      -labelPack => [-side => 'left'])->pack();

    if ($db->Show() ne 'Ok') {
      exit(1);
    }
  } else {
    print 'Enter your user email for gurobi.com: ';

    chomp(my $email = <>);

    print 'Enter your password for gurobi.com: ';

    ReadMode('noecho');
    chomp(my $password = <>);
    ReadMode('restore');

  }

  $response = $mech->get('https://www.gurobi.com/login');
  @forms = HTML::Form->parse($response);

  $form = shift(@forms);  # search form
  $form = shift(@forms);  # login form

  $form->value('email', $email);
  $form->value('password', $password);

  $response = $mech->request($form->click);
  $response = $mech->get('https://user.gurobi.com/download/gurobi-optimizer');

  @forms = HTML::Form->parse($response, 'https://user.gurobi.com');

  my $numforms = scalar @forms;

  if ($numforms > 2) {  # login failed page has two forms
    last;
  }

  print "Login failed. Please try again.\n";
}

$form = shift(@forms);  # search form
$form = shift(@forms);  # login form
$form = shift(@forms);  # download form

if ($^O eq 'darwin') {
  $filename = 'gurobi6.0.5a_mac64.pkg';
} elsif ($^O eq 'linux') {
  $filename = 'gurobi6.0.5_linux64.tar.gz';
}

$form->value('filename','6.0.5/'.$filename);

print "\nDownloading $filename ... ";

$response = $mech->request($form->click , $filename);

print "done\n";
print $response->content();
