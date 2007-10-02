use ExtUtils::MakeMaker;

my $axis2_libpath;
my $axis2_incpath;

my @replacement_args;

foreach( @ARGV ) {
	if( /AXIS2_(LIB|INC)_PATH=(.+)/ ) {
		if( $1 eq "LIB" ) {
			$axis2_libpath = $2;
		} else {
			$axis2_incpath = $2;
		}
	} else {
		push @replacement_args, $_;
	}
}

@ARGV = @replacement_args;


$libs = "-L$axis2_libpath " if( defined( $axis2_libpath ) );

$libs .= '-laxutil -laxis2_minizip -lperl -laxis2_parser -laxis2_libxml2 -laxis2_axiom -laxis2_engine -laxis2_http_common -laxis2_http_sender -laxis2_http_receiver';

@options;

push @options, ( LIBS => [ $libs ], ); 

push @options, ( INC => "-I$axis2_incpath", ) if( defined( $axis2_incpath ) );

WriteMakefile(
        'NAME'    => 'WSO2::WSF::C',
	'AUTHOR'  => 'Chintana Wilamuna <chintana@wso2.com>',
	'OBJECT'  => 'WSFC_wrap.o',
	@options
);
