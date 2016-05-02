From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: No source code for static library (compiled with -g -ggdb)
Date: Mon, 02 May 2016 09:58:39 +0200
Message-ID: <7356064.n03a6Iq7TP@agathebauer>
References: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com> <CAPe7T+_UbFVFWpfcM8VrGQ_yXKcMcK1CDMVrPKZ4NY5ac-VyCA@mail.gmail.com> <CAPe7T+9mjYs3QWtjCUmOVNmVeEYyV8qV9CDUicqndcLk_itrQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2449475.hNmcvZFNpM"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:37023 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbcEBH6p (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 May 2016 03:58:45 -0400
In-Reply-To: <CAPe7T+9mjYs3QWtjCUmOVNmVeEYyV8qV9CDUicqndcLk_itrQw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org

--nextPart2449475.hNmcvZFNpM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Freitag, 29. April 2016 09:26:44 CEST Mark Davis wrote:
> It turns out that I was incorrect about diagnosing this problem, and
> this is probably just due to my misunderstanding of how to use
> annotations in perf. (Sorry, I'm a new user to perf and trying to get
> my head around it.) I do have a question below.
>=20
> Recall my example from above:
>=20
> execute_native_thread_routine
> std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
> Thread*)>::operator()()
> main(int, char**)
> my_func_A
> my_func_B
> malloc
>=20
> I was trying to jump into my_func_B to see the annotation of it, and
> it kept jumping me into the annotation of malloc. That is, I wanted to
> see *where* malloc was being called from my_func_B, and the hottest
> areas of my_func_B. But, when I type "a" when on my_func_B (or drill
> in with the arrows or enter key), it always takes me to the annotation
> of malloc (i.e., the leaf node in the callchain). I figured this out
> by filtering to the DSO of my system (which made the leaf node always
> be a symbol in my system as opposed to some system library, etc.) and
> it shows that my symbols have debug info, etc.
>=20
> But if I wanted to see the annotation of my_func_B, how would I? Is it
> possible that I'm not able to see this simply because I don't have
> enough samples of it (and all the real time is spent down in malloc)?
> Or is there some other reason? Arnaldo, what exactly determines if
> your arrows show up when pressing V in perf v4.1?

I'm not really sure, but I seem to remember this "bug" in older perf versio=
ns.=20
I see in the other thread that you manually installed a newer perf, but cou=
ld=20
you check whether the following works with the older versions:

=2D navigate to the function you want to annotate (my_func_B)
=2D instead of pressing 'a', press 'arrow right'
=2D in the menu that shows up, select "annotate"

I /think/ that 'a' used to be the "annotate sample entry point" hotkey as y=
ou=20
encounter, whereas the submenu always allowed one to annotate individual=20
frames of the sample callstack.

> Furthermore, is there some other feature of perf_events that I should
> try (perhaps tracing?) to get more fidelity? My programs are
> relatively short-running, so I can afford to wait a bit longer.

Tracing will require you to add tracepoints via uprobe manually, which is=20
super time consuming - the changeset for Systemtap trace point support in p=
erf=20
has not yet been merged (bummer!).

I suggest you try to increase the sampling rate if you are interested in mo=
re=20
details of short-running apps.

> Thank you for any input you can provide as I'm learning perf_events.

On more suggestion from my side: In your original mail you said you compile=
=20
your code with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer". I think=
=20
this will produce potentially extremely misleading results, due to you=20
disabling the arguably most useful optimization feature of a compiler there=
=20
is: "-fno-inline"

I /really/ urge you to remove this check and actually profile a "real" worl=
d=20
example that is build with "-g -O2", i.e. with inlining enabled. Yes, the=20
callstacks /may/ be harder to grasp, but at the same time you actually prof=
ile=20
what the real app is doing. In C++ code, esp. with templates, I've seen=20
hotspots disappear just due to inlining and the avalanche effect they can=20
trigger in a good optimizer, e.g. by enabling deadcode elimination etc.=20

Cheers

> On Fri, Apr 29, 2016 at 8:28 AM, Mark Davis <markdavisinboston@gmail.com>=
=20
wrote:
> > Arnaldo, that's a really nice feature. Unfortunately, I'm currently
> > running on an older version of perf (3.13.11-ckt18) and it's a bit of
> > a pain to modify things like this on the cluster I'm running on
> > (although I can if I have something I absolutely need). So, for me
> > when I run verbose mode I simply get the DSO names in the callchains,
> > but no arrows. I would assume, if I had a newer version of perf, that
> > I would get no arrows for the symbols I want to annotate, given the
> > behavior I'm seeing.
> >=20
> > Anything else I can try? Does anyone have any ideas about why this may
> > be happening? Again, this is only happening for symbols in my static
> > library, and I'm creating this library using:
> >=20
> > ar -cvrs $@ $(OBJS)
> >=20
> > (I'm not an expert on ar, so I could be doing this wrong?)
> >=20
> > On Thu, Apr 28, 2016 at 6:16 PM, Arnaldo Carvalho de Melo
> >=20
> > <arnaldo.melo@gmail.com> wrote:
> >> Em Thu, Apr 28, 2016 at 01:44:16PM -0400, Mark Davis escreveu:
> >>> Hello, I'm using perf record and perf report to profile an application
> >>> which is made from a static (.a) library file that I made as well as a
> >>> handful of C++ files that are not in the static library. They are all
> >>> compiled with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer" and
> >>> all linked together to create the application.
> >>>=20
> >>> When I use perf report (in interactive/tui mode), when I annotate the
> >>> symbols that are in the C++ files (not the static library), I see the
> >>> source code intermingled with the assembly (this is what I want). I
> >>> can do this at any layer of the call stack. However, when I drill into
> >>> the symbols that are from the static library, I just see the assembly
> >>> of the leaf symbol. I don't expect to see the source in this case, as
> >>> the leaf symbol is a low-level library from libc; but, perf report
> >>> won't let me drill into (i.e., annotate) any non-leaf symbols.
> >>>=20
> >>> Example:
> >>> execute_native_thread_routine
> >>> std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
> >>> Thread*)>::operator()()
> >>> main(int, char**)
> >>> my_func_A
> >>> my_func_B
> >>> malloc
> >>=20
> >> What happens when you press 'V'? Here, say for this callchain:
> >>=20
> >> -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.]
> >> handlers_find>>=20
> >>    - handlers_find
> >>   =20
> >>       - 0.68% signal_handlers_foreach_matched_R
> >>      =20
> >>            g_signal_handlers_disconnect_matched
> >>            0x7f71fe809a80
> >>            g_object_unref
> >>         =20
> >>          - st_widget_get_theme_node
> >>         =20
> >>               0.58% 0x7f71fe813429
> >>=20
> >> And I press V, I get:
> >>=20
> >> -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.]
> >> handlers_find>>=20
> >>    -=E2=86=92handlers_find libgobject-2.0.so.0.4600.2
> >>   =20
> >>       - 0.68% signal_handlers_foreach_matched_R
> >>       libgobject-2.0.so.0.4600.2
> >>      =20
> >>            g_signal_handlers_disconnect_matched
> >>            libgobject-2.0.so.0.4600.2
> >>            0x7f71fe809a80 libgnome-shell.so
> >>          =20
> >>           =E2=86=92g_object_unref libgobject-2.0.so.0.4600.2
> >>         =20
> >>          -=E2=86=92st_widget_get_theme_node libgnome-shell.so
> >>         =20
> >>               0.58% 0x7f71fe813429 libgnome-shell.so
> >>=20
> >> See those arrows? They point to the places where you can annotate, the
> >> others can't because they had no samples or were unresolved.
> >>=20
> >> With some changes I think we can show the ones without samples, but th=
at
> >> remains to be done.
> >>=20
> >> Also, this is with:
> >>=20
> >> [root@jouet ~]# perf --version
> >> perf version 4.6.rc4.ga453697
> >>=20
> >> This feature was introduced in:
> >>=20
> >> commit 70e972788888315851a5c1b4982efbcafcd03b5b
> >> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> Date:   Thu Mar 19 16:07:21 2015 -0300
> >>=20
> >>     perf hists browser: Indicate which callchain entries are annotated
> >>    =20
> >>     Now that we can annotate entries in a callchain, show which ones h=
ave
> >>     an
> >>     associated symbol and samples, by adding a right arrow just before
> >>     the
> >>     symbol name when in verbose mode.
> >>    =20
> >>     To toggle verbose mode press 'V'.
> >>=20
> >> ---------------------------------
> >>=20
> >> Which is:
> >>=20
> >> [acme@jouet linux]$ git tag --contains
> >> 70e972788888315851a5c1b4982efbcafcd03b5b | grep ^v4 | head -1 v4.1
> >> [acme@jouet linux]$
> >>=20
> >> Thanks,
> >>=20
> >> - Arnaldo
> >>=20
> >>> When I annotate my_func_A and my_func_B, it just jumps to the
> >>> annotation of malloc (I see this listed at the top of the annotation
> >>> view). Note that my_func_A and my_func_B are both defined in the
> >>> static library that I'm linking in. However, when I do a similar thing
> >>> with a different stack where I'm annotating a function that's not from
> >>> the static library (but in the regular C++ files), it works fine.
> >>>=20
> >>> Here's what I'm doing to create my static lib:
> >>> ar -cvrs $@ $(OBJS)
> >>>=20
> >>>=20
> >>> I did confirm with nm --debug-syms that my static lib has debugging
> >>> symbols in it:
> >>>=20
> >>> U __assert_fail
> >>> 0000000000000000 b .bss
> >>> 0000000000000000 n .comment
> >>> U __cxa_atexit
> >>> 0000000000000000 d .data
> >>> 0000000000000000 N .debug_abbrev
> >>> 0000000000000000 N .debug_aranges
> >>> 0000000000000000 N .debug_info
> >>> 0000000000000000 N .debug_line
> >>> 0000000000000000 N .debug_loc
> >>> 0000000000000000 N .debug_ranges
> >>> 0000000000000000 N .debug_str
> >>> U __dso_handle
> >>> 0000000000000000 r .eh_frame
> >>> U exit
> >>>=20
> >>>=20
> >>> How can I compile and link my application and configure perf report so
> >>> I can drill in like this on functions defined in a static library with
> >>> debug symbols?
> >>>=20
> >>> Thank you,
> >>> Mark



=2D-=20
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart2449475.hNmcvZFNpM
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
DTE2MDUwMjA3NTgzOVowIwYJKoZIhvcNAQkEMRYEFLIEo5jvD6tzbCWRFEHKGJ0g7A/SMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAHD5
5L+ZVksegdL5DV6rv1cKvUhZ/d1EtZeyC5OlrQrAiGB0B4LU4k1E5MMaVaBlFXvGBkytW+BZyhYQ
j8YmOlS6+DsvT/HlMRqm2BcKiciMnL99LGyowigiZCCwdlwYjRgKWHjk+LrP+qroXRb61q7+l+Q3
1LO1rkOvNzp3krkFVycXK2ushzvhhYqPAhHoBH2dyHmKPue6mzyEC1TDXELvvPfh5QjGxu4QPZGG
HE945jOsf0e1HvK9h4amkmX3xlsr/ntZJd5DbVq5FbVoj+ZkXDwvX2da2Y7L3/fvJCgrh7/uTh5J
snDixEiecWEmgUTmWu+aoHIk9M1HKFsSSVEAAAAAAAA=


--nextPart2449475.hNmcvZFNpM--
