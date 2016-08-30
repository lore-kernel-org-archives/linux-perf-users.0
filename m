From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: regression: perf script IP address format
Date: Wed, 31 Aug 2016 00:20:58 +0200
Message-ID: <38753481.JuEQVUs1HP@agathebauer>
References: <3089144.akJYgxmlqy@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3114274.7iKPofmN31"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:48548 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754673AbcH3WVG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2016 18:21:06 -0400
In-Reply-To: <3089144.akJYgxmlqy@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

--nextPart3114274.7iKPofmN31
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 30. August 2016 17:42:47 CEST Milian Wolff wrote:
> Hey all,
> 
> I'm encountering an issue related to the one I reported a few days ago,
> where the `-g address` feature was broken due to the wrong address being
> used.
> 
> We fixed this by using al.addr instead of ip, but this now breaks the output
> of perf script:
> 
> Before 67540759151aefafddade3e27c4671ab7b3d230f was applied:
> 
> lab_mandelbrot 28224 13656.319122:     995647 cycles:ppp:
>                   403a8a _start+0x2a (/ssd/milian/projects/kdab/training-
> material/addon/profiling/build/lab_mandelbrot/src/lab_mandelbrot)
>             7f8a88e1c291 __libc_start_main+0xf1 (/usr/lib/libc-2.24.so)
>                   40307a main+0x4a (/ssd/milian/projects/kdab/training-
> material/addon/profiling/build/lab_mandelbrot/src/lab_mandelbrot)
>             7f8a8ae39ae9 QApplicationPrivate::init+0x9 (/usr/lib/
> libQt5Widgets.so.5.7.0)
>             7f8a8a69e7af QGuiApplicationPrivate::init+0x2f (/usr/lib/
> libQt5Gui.so.5.7.0)
>             7f8a8a15b3bf QCoreApplicationPrivate::init+0xaaf (/usr/lib/
> libQt5Core.so.5.7.0)
>             7f8a8a69cced QGuiApplicationPrivate::createEventDispatcher+0x2d
> (/ usr/lib/libQt5Gui.so.5.7.0)
>             7f8a8a69c252 QGuiApplicationPrivate::createPlatformIntegration
> +0x5c2 (/usr/lib/libQt5Gui.so.5.7.0)
>             7f8a8a68e01f QPlatformIntegrationFactory::create+0xef (/usr/lib/
> libQt5Gui.so.5.7.0)
>             7f8a8a13f9c2 QFactoryLoader::instance+0x112 (/usr/lib/
> libQt5Core.so.5.7.0)
>             7f8a8a14a6a5 [unknown] (/usr/lib/libQt5Core.so.5.7.0)
>             7f8a8a15121e [unknown] (/usr/lib/libQt5Core.so.5.7.0)
>             7f8a87aa5f82 dlopen+0x32 (/usr/lib/libdl-2.24.so)
>             7f8a87aa6521 [unknown] (/usr/lib/libdl-2.24.so)
>             7f8a8b5493a4 _dl_catch_error+0x74 (/usr/lib/ld-2.24.so)
>             7f8a87aa5ee9 [unknown] (/usr/lib/libdl-2.24.so)
>             7f8a8b54d2d9 _dl_open+0xc9 (/usr/lib/ld-2.24.so)
>             7f8a8b5493a4 _dl_catch_error+0x74 (/usr/lib/ld-2.24.so)
>             7f8a8b54d85d dl_open_worker+0x11d (/usr/lib/ld-2.24.so)
>             7f8a8b547005 _dl_map_object_deps+0x275 (/usr/lib/ld-2.24.so)
>             7f8a8b5493a4 _dl_catch_error+0x74 (/usr/lib/ld-2.24.so)
>             7f8a8b546d80 openaux+0x30 (/usr/lib/ld-2.24.so)
>             7f8a8b5423fd _dl_map_object+0x8d (/usr/lib/ld-2.24.so)
>             7f8a8b54a5d4 _dl_name_match_p+0x44 (/usr/lib/ld-2.24.so)
>             7f8a8b55364c strcmp+0xc (/usr/lib/ld-2.24.so)
> 
> After it got applied:
> 
> lab_mandelbrot 28224 13656.319122:     995647 cycles:ppp:
>                     3a8a _start+0xffffffffff80002a
> (/ssd/milian/projects/kdab/
> training-material/addon/profiling/build/lab_mandelbrot/src/lab_mandelbrot)
> 20291 __libc_start_main+0xffff00eaee4080f1 (/usr/lib/ libc-2.24.so)
>                     307a main+0xffffffffff80004a (/ssd/milian/projects/kdab/
> training-material/addon/profiling/build/lab_mandelbrot/src/lab_mandelbrot)
> 158ae9 QApplicationPrivate::init+0xffff00eaea63e009 (/usr/
> lib/libQt5Widgets.so.5.7.0)
>                    f97af QGuiApplicationPrivate::init+0xffff00eaeb4b602f (/
> usr/lib/libQt5Gui.so.5.7.0)
>                   28d3bf QCoreApplicationPrivate::init+0xffff00eaec264aaf (/
> usr/lib/libQt5Core.so.5.7.0)
>                    f7ced QGuiApplicationPrivate::createEventDispatcher
> +0xffff00eaeb4b602d (/usr/lib/libQt5Gui.so.5.7.0)
>                    f7252 QGuiApplicationPrivate::createPlatformIntegration
> +0xffff00eaeb4b65c2 (/usr/lib/libQt5Gui.so.5.7.0)
>                    e901f QPlatformIntegrationFactory::create
> +0xffff00eaeb4b60ef (/usr/lib/libQt5Gui.so.5.7.0)
>                   2719c2 QFactoryLoader::instance+0xffff00eaec264112 (/usr/
> lib/libQt5Core.so.5.7.0)
>                   27c6a5 [unknown] (/usr/lib/libQt5Core.so.5.7.0)
>                   28321e [unknown] (/usr/lib/libQt5Core.so.5.7.0)
>                      f82 dlopen+0xffff00eaf0ab6032 (/usr/lib/libdl-2.24.so)
>                     1521 [unknown] (/usr/lib/libdl-2.24.so)
>                     f3a4 _dl_catch_error+0xffff00eae958c074 (/usr/lib/
> ld-2.24.so)
>                      ee9 [unknown] (/usr/lib/libdl-2.24.so)
>                    132d9 _dl_open+0xffff00eae958c0c9 (/usr/lib/ld-2.24.so)
>                     f3a4 _dl_catch_error+0xffff00eae958c074 (/usr/lib/
> ld-2.24.so)
>                    1385d dl_open_worker+0xffff00eae958c11d (/usr/lib/
> ld-2.24.so)
>                     d005 _dl_map_object_deps+0xffff00eae958c275 (/usr/lib/
> ld-2.24.so)
>                     f3a4 _dl_catch_error+0xffff00eae958c074 (/usr/lib/
> ld-2.24.so)
>                     cd80 openaux+0xffff00eae958c030 (/usr/lib/ld-2.24.so)
>                     83fd _dl_map_object+0xffff00eae958c08d (/usr/lib/
> ld-2.24.so)
>                    105d4 _dl_name_match_p+0xffff00eae958c044 (/usr/lib/
> ld-2.24.so)
>                    1964c strcmp+0xffff00eae958c00c (/usr/lib/ld-2.24.so)
> 
> This breaks consumers of the `perf script` output who want to feed the IP
> address into addr2line, most notably stackcollapse-perf.
> 
> Namhyung, how do you propose to fix this issue, while keeping `-g address`
> function in reports?

This is odd... On a different machine of mine which runs the same distribution 
I get very different results... I'm compiling my test binary with the same gcc 
(GCC) 6.1.1 20160802, against the same libraries.

One one machine I see:

$ dwarfdump /home/milian/projects/kdab/training-material/addon/profiling/
build/lab_mandelbrot/src/lab_mandelbrot | grep low_pc | awk '{print $2}'  | 
head -n 10

0x00000000
0x00403c50
0x00403ca1
0x00403ca1
0x00403cb5
0x00403cbb
0x00403cbb
0x00403cbb
0x00403cbb
0x00403cbb

^-- here, addr2line won't work when we pass e.g. just 3c50, we must pass 
403c50 and that is currently broken in the perf script output.

But on my laptop I see this:

$ dwarfdump /home/milian/projects/kdab/training-material/addon/profiling/
build/lab_mandelbrot/src/lab_mandelbrot | grep low_pc | awk '{print $2}'  | 
head -n 10

0x00000000
0x000039f0
0x00003a50
0x00003a50
0x00003a65
0x00003a6b
0x00003a6b
0x00003a6b
0x00003a6b
0x00003a6b

^-- here, the current perf script output is OK and we can simply pass e.g. 
39f0...

I've checked, the compiler flags are also the same on both platforms... Can 
someone explain me why I'm seeing this? I was trying to fix the issue by 
adding `node->map->start` to the IP reported in `sample__fprintf_callchain`. 
But considering it currently works on one machine and is broken on a second, 
I'm not sure which version is correct...

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart3114274.7iKPofmN31
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
DTE2MDgzMDIyMjA1OFowIwYJKoZIhvcNAQkEMRYEFG5UhFIqUChRG1/Y2kRXZHKJkm9JMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAB1o
zz7NS1UMlHu74ywrX8ycsn12mXYlkic3OThBGDkEOkEtOhxRXMgVuPRjAXFN6saR7hw9LzmTWCDC
DcyBgRkgsWEL41Pn7zg+u+fAtJ8RWyvSWh4RZsAyXYQJ8ExHz2E/3Vf/q4jOu/8tTMjXaoCTEcg1
wAyTJfwWg8hEh6mmqfT99Ank3YwOwp5Pn3xo0cE3Vpzq1tG8XExKBJPCYFjEe+yEF1dVKvF7CQo3
wddpGfNc2OSQKjA+qrsQVif2cK043ncGUBqMf5qIlWPNgX2OCKJ7k6sl00iKRgtQMTp8v4HMDBJv
+GGMyhm1w6tTsevRkyOKKNQKqXuI62ECWnMAAAAAAAA=


--nextPart3114274.7iKPofmN31--
