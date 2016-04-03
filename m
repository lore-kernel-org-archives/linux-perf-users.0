From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf trace report with time consumed
Date: Sun, 03 Apr 2016 20:46:19 +0200
Message-ID: <4309725.73SKaCNb55@agathebauer>
References: <1894563.GPSC8z33rH@agathebauer> <20160330215832.GG3420@kernel.org> <11979280.sfXiZ5YTfG@agathebauer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1636561.KyS6l1Lsqt"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:52885 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbcDCSqX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 3 Apr 2016 14:46:23 -0400
In-Reply-To: <11979280.sfXiZ5YTfG@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: perf group <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>

--nextPart1636561.KyS6l1Lsqt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Jiri, see my mail below for the WIP patch below that triggers the crash whe=
n=20
DWARF callchains are enabled for `perf trace`.

Would be great if you could tell me what I'm missing.

Thanks!

On Freitag, 1. April 2016 00:34:44 CEST Milian Wolff wrote:
> On Mittwoch, 30. M=E4rz 2016 18:58:33 CEST Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 30, 2016 at 11:24:17PM +0200, Milian Wolff escreveu:
> > > On Mittwoch, 30. M=E4rz 2016 11:53:14 CEST Arnaldo Carvalho de Melo w=
rote:
> > > > Em Tue, Mar 29, 2016 at 10:39:36PM +0200, Milian Wolff escreveu:
> > > > > with "perf trace record --call-graph dwarf" I get a nice data file
> > > > > with
> > > > > potentially everything required to find slow syscalls in user spa=
ce
> > > > > applications. But I'm missing a way to rewrite the data file to l=
et
> > > > > "perf
> > > > > report" attribute samples with the time spent as cost, instead of
> > > > > the
> > > > > raw
> > > > > number of syscalls, i.e. samples.
> >=20
> > <SNIP>
> >=20
> > > > There is even:
> > > >=20
> > > > [root@jouet ~]# trace --duration 1000 -i perf.data
> > > >=20
> > > >   1000.423 (1000.056 ms): sleep/1139 nanosleep(rqtp: 0x7ffebed266c0=
) =3D
> > > >   0
> > > >=20
> > > > [root@jouet ~]#
> > > >=20
> > > > Having that with callgraph from userspace is what you're asking for,
> > > > no?
> > > >=20
> > > > 'trace' here is just an alias for 'perf trace'.
> > >=20
> > > Yep, I think having the individual trace entries annotated with their
> > > backtrace would be a useful addition and also brings perf trace closer
> > > to
> > > strace, cf. it's -k option.
> >=20
> > Humm, I was unaware of that:
> >        -k          Print the execution stack trace of the traced
> > 		  =20
> > 		   processes after each system call (experimental).
> > 		   This option is available only if strace is built with
> > 		   libunwind.
> >=20
> > Which is not the case in fedora23 :-\
>=20
> I tried playing around with the source code to add that feature and have =
hit
> some issues and need some guidance.
>=20
> My WIP patch currently is:
>=20
> ~~~~~~~~~~~~~~~~~
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 69960c3..cc3df97 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -34,6 +34,7 @@
>  #include "trace-event.h"
>  #include "util/parse-events.h"
>  #include "util/bpf-loader.h"
> +#include "util/callchain.h"
>=20
>  #include <libaudit.h>
>  #include <stdlib.h>
> @@ -2161,6 +2162,18 @@ signed_print:
>  		goto signed_print;
>=20
>  	fputc('\n', trace->output);
> +
> +	if (sample->callchain) {
> +		struct addr_location al;
> +		if (machine__resolve(trace->host, &al, sample) < 0) {
> +			pr_err("problem processing %d event, skipping it.\n",
> +			    event->header.type);
> +			return -1;
> +		}
> +
> +		perf_evsel__print_ip(evsel, sample, &al, PRINT_IP_OPT_IP |
> PRINT_IP_OPT_DSO | PRINT_IP_OPT_SYM /* TODO print_opts*/,
> +				     scripting_max_stack);
> +	}
>  out:
>  	ttrace->entry_pending =3D false;
>  	err =3D 0;
> @@ -3221,6 +3234,9 @@ int cmd_trace(int argc, const char **argv, const ch=
ar
> *prefix __maybe_unused)
>  		     "Trace pagefaults", parse_pagefaults, "maj"),
>  	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
>  	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
> +	OPT_CALLBACK(0, "call-graph", &trace.opts,
> +		     "record_mode[,record_size]", record_callchain_help,
> +		     &record_parse_callchain_opt),
>  	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
>  			"per thread proc mmap processing timeout in ms"),
>  	OPT_END()
> @@ -3248,6 +3264,11 @@ int cmd_trace(int argc, const char **argv, const c=
har
> *prefix __maybe_unused)
>  		trace.opts.sample_time =3D true;
>  	}
>=20
> +	if (trace.opts.callgraph_set) {
> +		symbol_conf.use_callchain =3D true;
> +		callchain_param.enabled =3D true;
> +	}
> +
>  	if (trace.evlist->nr_entries > 0)
>  		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
> ~~~~~~~~~~~~~~~~~
>=20
> Which gives me something when doing
>=20
> ~~~~~~~~~~~~~~~~~
> perf trace -e nanosleep --call-graph fp path/to/ex_sleep
>   1000.177 (1000.177 ms): ex_sleep/7965 nanosleep(rqtp: 0x7ffd123d3470,
> rmtp: 0x7ffd123d3470                  ) =3D 0
>                   20379e syscall_slow_exit_work ([kernel.kallsyms])
>                   203bc4 syscall_return_slowpath ([kernel.kallsyms])
>                   797248 int_ret_from_sys_call ([kernel.kallsyms])
>                    b7600 __nanosleep (/usr/lib/libc-2.23.so)
>          1fe258d4c544155 [unknown] ([unknown])
> ~~~~~~~~~~~~~~~~~
>=20
> Nice, so the frame point unwinding seems to work already. But I'm a
> user-space person and none of my tools have that. So let's try dwarf:
>=20
> ~~~~~~~~~~~~~~~~~
> perf trace -e nanosleep --call-graph dwarf path/to/ex_sleep
> perf: Segmentation fault
> Obtained 10 stack frames.
> perf(sighandler_dump_stack+0x4f) [0x5637fdcfc85f]
> /usr/lib/libc.so.6(+0x3332f) [0x7fe888b2132f]
> /usr/lib/libc.so.6(__vsnprintf_chk+0x6b) [0x7fe888be38db]
> perf(+0xb3f93) [0x5637fdc56f93]
> perf(+0xb8fec) [0x5637fdc5bfec]
> perf(cmd_trace+0x1c14) [0x5637fdc5e5c4]
> perf(+0xe6bae) [0x5637fdc89bae]
> perf(main+0x6e3) [0x5637fdc23a83]
> /usr/lib/libc.so.6(__libc_start_main+0xef) [0x7fe888b0e70f]
> perf(_start+0x28) [0x5637fdc23bc8]
> Segmentation fault (core dumped)
> ~~~~~~~~~~~~~~~~~
>=20
> Ouch :( Valgrind gives me:
>=20
> ~~~~~~~~~~~~~~~~~
> =3D=3D8053=3D=3D Syscall param msync(start) points to uninitialised byte(=
s)
> =3D=3D8053=3D=3D    at 0x528A700: __msync_nocancel (in /usr/lib/libpthrea=
d-2.23.so)
> =3D=3D8053=3D=3D    by 0x4E396D6: validate_mem (Ginit.c:137)
> =3D=3D8053=3D=3D    by 0x4E396D6: access_mem (Ginit.c:171)
> =3D=3D8053=3D=3D    by 0x4E3F79D: dwarf_get (libunwind_i.h:168)
> =3D=3D8053=3D=3D    by 0x4E3F79D: apply_reg_state (Gparser.c:819)
> =3D=3D8053=3D=3D    by 0x4E3EE72: _ULx86_64_dwarf_find_save_locs (Gparser=
=2Ec:907)
> =3D=3D8053=3D=3D    by 0x4E4126A: _ULx86_64_dwarf_step (Gstep.c:34)
> =3D=3D8053=3D=3D    by 0x4E3A873: _ULx86_64_step (Gstep.c:71)
> =3D=3D8053=3D=3D    by 0x4E3B9CF: trace_init_addr (Gtrace.c:248)
> =3D=3D8053=3D=3D    by 0x4E3B9CF: trace_lookup (Gtrace.c:330)
> =3D=3D8053=3D=3D    by 0x4E3B9CF: _ULx86_64_tdep_trace (Gtrace.c:447)
> =3D=3D8053=3D=3D    by 0x4E38C8F: backtrace (backtrace.c:69)
> =3D=3D8053=3D=3D    by 0x26185F: dump_stack (util.c:338)
> =3D=3D8053=3D=3D    by 0x26185F: sighandler_dump_stack (util.c:356)
> =3D=3D8053=3D=3D    by 0x69B232F: ??? (in /usr/lib/libc-2.23.so)
> =3D=3D8053=3D=3D    by 0x6A748DA: __vsnprintf_chk (in /usr/lib/libc-2.23.=
so)
> =3D=3D8053=3D=3D    by 0x1BBF93: vsnprintf (stdio2.h:77)
> =3D=3D8053=3D=3D    by 0x1BBF93: scnprintf (kernel.h:91)
> =3D=3D8053=3D=3D  Address 0xffeffa000 is on thread 1's stack
> =3D=3D8053=3D=3D  in frame #7, created by backtrace (backtrace.c:59)
> ~~~~~~~~~~~~~~~~
>=20
> Any idea what I'm missing in the setup routine? It works fine for `perf
> trace record --call-graph dwarf`.
>=20
> Thanks


=2D-=20
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1636561.KyS6l1Lsqt
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUdzCCBGYw
ggNOoAMCAQICEFEmCpMc4n+cw6VfeeByroIwDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMRswGQYDVQQD
ExJVVE4gLSBEQVRBQ29ycCBTR0MwHhcNMDUwNjA3MDgwOTEwWhcNMTkwNjI0MTkwNjMwWjBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVy
bmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/caM+byAAQtOeBOW+0fvGwPzbX6I7bO3psRM5ek
KUx9k5+9SryT7QMa44/P5W1QWtaXKZRagLBJetsulf24yr83OC0ePpFBrXBWx/BPP+gynnTKyJBU
6cZfD3idmkA8Dqxhql4Uj56HoWpQ3NeaTq8Fs6ZxlJxxs1BgCscTnTgHhgKo6ahpJhiQq0ywTyOr
Ok+E2N/On+Fpb7vXQtdrROTHre5tQV9yWnEIN7N5ZaRZoJQ39wAvDcKSctrQOHLbFKhFxF0qfbe0
1sTurM0TRLfJK91DACX6YblpalgjEbenM49WdVn1zSnXRrcKK2W200JvFbK4e/vv6V1T1TRaJwID
AQABo4HYMIHVMB8GA1UdIwQYMBaAFFMy0bPPf/rg8aBdhU6S0p5FHbRPMB0GA1UdDgQWBBStvZh6
NLQm9/rEJlTvA73gJMtUGjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zARBglghkgB
hvhCAQEEBAMCAQIwIAYDVR0lBBkwFwYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMD0GA1UdHwQ2MDQw
MqAwoC6GLGh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tREFUQUNvcnBTR0MuY3JsMA0GCSqG
SIb3DQEBBQUAA4IBAQDG7lMXaBSyUSIekFgNlP298XDlhi3DNjGPVEhG5y0IN7xsCmDhDq1RNOAS
k+m+uKu4JrTplj0oj65kB/7gAezF45HrGKDxdX7bCuafkduvrnXfI5Fo3RcAWkv/ZGxw6wEa0JDZ
x6bWbfYT5P+1ydIeKsuxJUMmeNkwm04NHr5p79/q/i2zzPmw3bUUypHUsrWl+wEZo0d5n52MlYc0
+B84kto2phH6a+tr6dxFeBU5BtdNQeQhyNwvh9G3v0hgdaViyyTeO2GgKSCmvsVsnMTpCmki75E6
+iav0VtBpzri+DgHQqvBW/jObboPBD8yNKzcBCjXcDAUJgbE5JuY1c94MIIEnTCCA4WgAwIBAgIQ
ND3pK6wnNP+PyzSU+8xwVDANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChML
QWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYD
VQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYwNzA4MDkxMFoXDTIwMDUzMDEw
NDgzOFowga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENp
dHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51
c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgRW1haWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyOYWk8n2rQTtiRjeu
zcFgdbw5ZflKGkeiucxIzGqY1U01GbmkQuXOSeKKLx580jEHx060g2SdLinVomTEhb2FUTV5pE5o
kHsceqSSqBfymBXyk8zJpDKVuwxPML2YoAuL5W4bokb6eLyib6tZXqUvz8rabaov66yhs2qqty5n
NYt54R5piOLmRs2gpeq+C852OnoOm+r82idbPXMfIuZIYcZM82mxqC4bttQxICy8goqOpA6l14lD
/BZarx1x1xFZ2rqHDa/68+HC8KTFZ4zW1lQ63gqkugN3s2XI/R7TdGKqGMpokx6hhX71R2XL+E1X
KHTSNP8wtu72YjAUjCzrAgMBAAGjgfQwgfEwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTL
VBowHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGA1UdIAQKMAgwBgYEVR0gADBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5hbENBUm9vdC5jcmwwNQYIKwYBBQUHAQEEKTAn
MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBBQUAA4IB
AQABvJzjYyiw8zEBwt973WKgAZ0jMQ+cknNTUeofTPrWn8TKL2d+eDMPdBa5kYeR9Yom+mRwANge
+QsEYlCHk4HU2vUj2zS7hVa0cDRueIM3HoUcxREVkl+HF72sav3xwtHMiV+xfPA+UfI183zsYJhr
Oivg79+zfYbrtRv1W+yifJgT1wBQudEtc94DeHThBYUxXsuauZ2UxrmUN3Vy3ET7Z+jw+iUeUqfa
JelH4KDHPKBOsQo2+3dIn++Xivu0/uOUFKiDvFwtP9JgcWDuwnGCDOmINuPaILSjoGyqlku4gI51
ykkH9jsUut/cBdmf2+Cy5k2geCbn5y1uf1/GHogVMIIFGjCCBAKgAwIBAgIQbRnqpxlPajMi5iIy
eqpx3jANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQH
Ew5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQL
ExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0xMTA0MjgwMDAwMDBaFw0yMDA1MzAxMDQ4Mzha
MIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkoSEW0tXmNReL4uk4UDIo1NYX2Zl8TJO958yfVXQeExVt0KU4PkncQfFxmmk
uTLE8UAakMwnVmJ/F7Vxaa7lIBvky2NeYMqiQfZq4aP/uN8fSG1lQ4wqLitjOHffsReswtqCAtbU
MmrUZ28gE49cNfrlVICv2HEKHTcKAlBTbJUdqRAUtJmVWRIx/wmi0kzcUtve4kABW0ho3cVKtODt
JB86r3FfB+OsvxQ7sCVxaD30D9YXWEYVgTxoi4uDD216IVfmNLDbMn7jSuGlUnJkJpFOpZIP/+Cx
YP0ab2hRmWONGoulzEKbm30iY9OpoPzOnpDfRBn0XFs1uhbzp5v/wQIDAQABo4IBSzCCAUcwHwYD
VR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFHoTTgB0W8Z4Y2QnwS/ioFu8
ecV7MA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0g
ADBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJz
dC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0BggrBgEFBQcBAQRoMGYwPQYIKwYB
BQUHMAKGMWh0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRUcnVzdENsaWVudF9DQS5jcnQw
JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEB
AIXWvnhXVW0zf0RS/kLVBqgBA4CK+w2y/Uq/9q9BSfUbWsXSrRtzbj7pJnzmTJjBMCjfy/tCPKEl
Pgp11tA9OYZm0aGbtU2bb68obB2v5ep0WqjascDxdXovnrqTecr+4pEeVnSy+I3T4ENyG+2P/WA5
IEf7i686ZUg8mD2lJb+972DgSeUWyOs/Q4Pw4O4NwdPNM1+b0L1garM7/vrUyTo8H+2b/5tJM75C
KTmD7jNpLoKdRU2oadqAGx490hpdfEeZpZsIbRKZhtZdVwcbpzC+S0lEuJB+ytF5OOu0M/qgOl0m
WJ5hVRi0IdWZ1eBDQEIwvuql55TSsP7zdfl/bucwggZKMIIFMqADAgECAhByCOhbkTwXiJtaa0d5
K5u0MA0GCSqGSIb3DQEBBQUAMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcG
A1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4X
DTE0MDYwMjAwMDAwMFoXDTE3MDYwMTIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0GA1UEERMG
NjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNVBAkTD05v
cnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRhbGVucyBE
YXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNVBAsMOklz
c3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1hbmFnZXIx
HzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBXb2xmZjEk
MCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAwirYPAOcWQk9jaCoEAn84PwINg/NDs3PxsEd34f27AfCqJepwIF+ikMuBBxt
mm1pieQwU9fcFrE4CXPCdYxfFOdcbJJ58Xzog5aFrJHnYGEFIL8KVvdBvAFeP/AJPaY2lg1JWnVI
1jwO74VmUGMyvMG286wpwW3hWO3sepZZQN3tvXyd9EgD72AiImkvw43+BW4xy8ptOd3TvEwCJ+uN
x8v+uILsRLvKcmSrUsLpo7No2HoifWX1doKHKSwYVVqmOT/rjJWxF98j4w2kTKRsWdQ4ENlqNpjW
zlbtB6TM2mrnInefzALbIoLLQ2E2NFCaMVsczf7RFsMxUepM9KQQ5QIDAQABo4IBzzCCAcswHwYD
VR0jBBgwFoAUehNOAHRbxnhjZCfBL+KgW7x5xXswHQYDVR0OBBYEFGSjHixs9BD9OyGskYjMX7mi
P+fiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1odHRwczov
L3NlY3VyZS5jb21vZG8ubmV0L0NQUzBXBgNVHR8EUDBOMEygSqBIhkZodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGI
BggrBgEFBQcBAQR8MHowUgYIKwYBBQUHMAKGRmh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T0NsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0
dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29sZmZAa2RhYi5jb20w
DQYJKoZIhvcNAQEFBQADggEBAFvi067uXCOkiUH/D6rv4gV0/e+e8DzcvbbsUxAC5nwDXBv+47ds
l7j8NrZstZraVz35WEWgksNmnyghcuBKzKcN3kY1KNn/ERc9wvns/0dI+yj39L0eSMzchUZoV6GY
MtPfmLofPvUBbDesl97JQXF9vpk8FIVsI1UKKrLzfoKhue5abQHXurSFa0ts1UPmSh2Y8/QCQlFN
lCv8ISyEwVCAkhdIqxRc3hslooBhcRVUrYhRdCLlNN6Od8yuLE9sKWH/K4wg/BpnjCJmGp4GQhU8
DUG2r0CbOa+iZQKTWUgwdGU3Jr+WcOan/JaNzBuKk1GM3D+WcljoU7ZWtoqXPzgxggJaMIICVgIB
ATCBqDCBkzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQcgjoW5E8F4ibWmtHeSub
tDAJBgUrDgMCGgUAoIGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTE2MDQwMzE4NDYxOVowIwYJKoZIhvcNAQkEMRYEFKUzsvNtDMl9/5rC4oXCUBo8fMbZMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAAbv
VJqWJmdZskpabLiNLqOjirjOWshRtLyo6+1rHtnJe0kibccSYiCODED3M3YF1r0plcUo9rvo9arc
HX+7qRULHMv5AkuZGSNkPIXTvcSnJfYdm7YgKOOR9wSbfw/eJ+AqfaPDDAx+0uYCruzK+cyt1/Xy
LQwxfylrm5wmxwC6++EhhLCUyj9FRyfwi4C8eYfIb3ESc620vRmLHRf2QSj67RbHcVFlQDMEsFLS
j6855kC8MKWXSgOh0DFV8+1fI8F3FPULPjQhHOiuhDzvagAz2jkl+bwjFggnkanBEuvPlR1WvQiA
YbZLyAh3/CxfJpX8K+1ewQFwLp/h2SPEX2QAAAAAAAA=


--nextPart1636561.KyS6l1Lsqt--
