From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf trace report with time consumed
Date: Mon, 04 Apr 2016 23:17:11 +0200
Message-ID: <2600188.8x2NmCkWJL@agathebauer>
References: <1894563.GPSC8z33rH@agathebauer> <4309725.73SKaCNb55@agathebauer> <20160404061408.GA2137@krava.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2340992.bd486ZQUgj"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:53587 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbcDDVRR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Apr 2016 17:17:17 -0400
In-Reply-To: <20160404061408.GA2137@krava.local>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, perf group <linux-perf-users@vger.kernel.org>

--nextPart2340992.bd486ZQUgj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 4. April 2016 08:14:08 CEST Jiri Olsa wrote:
> On Sun, Apr 03, 2016 at 08:46:19PM +0200, Milian Wolff wrote:
> > Jiri, see my mail below for the WIP patch below that triggers the crash
> > when DWARF callchains are enabled for `perf trace`.
> > 
> > Would be great if you could tell me what I'm missing.
> 
> would you please resend, I can't apply the one you posted
> 
> [jolsa@krava linux-perf]$ patch -p1 < /tmp/w
> patching file tools/perf/builtin-trace.c
> Hunk #1 FAILED at 34.
> patch: **** malformed patch at line 126: PRINT_IP_OPT_DSO | PRINT_IP_OPT_SYM
> /* TODO print_opts*/,

I send Jiri the patch off-list to which he replied:

> > so by enabling call graph you enabled code in unwind__prepare_access
> > which will set thread->priv which perf trace is already using for
> > some other stuff..
> > 
> > the thread__trace will think the thread->priv is already allocated
> > and rest of the code will access thread->priv as struct thread_trace
> > while it's allocated as unw_addr_space_t
> > 
> > I guess either perf trace or the unwind code need to change
> > another location for its private data in the thread..
> > we could move that dwarf private stuff to separate location
> > 
> > I'll prepare patch this week if I dont see anyone else doing that ;-)

This is indeed the reason, my naive approach of adding a `priv2` to `thread` 
and adding a "2" suffix to all uses of `thread__{set,}priv` in `builtin-
trace.c` makes it work:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     0.174 ( 0.002 ms): ex_sleep/4390 close(fd: 3                                                           
) = 0
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a8c7e07 close (/usr/lib/ld-2.23.so)
            7f688a8bf20b _dl_sysdep_read_whole_file (/usr/lib/ld-2.23.so)
            7f688a8c5446 _dl_load_cache_lookup (/usr/lib/ld-2.23.so)
            7f688a8b79ba _dl_map_object (/usr/lib/ld-2.23.so)
            7f688a8bbcb2 openaux (/usr/lib/ld-2.23.so)
            7f688a8be264 _dl_catch_error (/usr/lib/ld-2.23.so)
            7f688a8bbf23 _dl_map_object_deps (/usr/lib/ld-2.23.so)
            7f688a8b2033 dl_main (/usr/lib/ld-2.23.so)
            7f688a8c629c _dl_sysdep_start (/usr/lib/ld-2.23.so)
            7f688a8b3d4a _dl_start (/usr/lib/ld-2.23.so)
            7f688a8afd98 _dl_start_user (/usr/lib/ld-2.23.so)
     0.200 ( 0.004 ms): ex_sleep/4390 open(filename: 0x8aad10b0, flags: 
CLOEXEC                             ) = 3
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a8c7d07 open64 (/usr/lib/ld-2.23.so)
            7f688a8b58d8 open_verify.constprop.7 (/usr/lib/ld-2.23.so)
     0.204 ( 0.003 ms): ex_sleep/4390 read(fd: 3, buf: 0x7ffe4d16e7a8, count: 
832                           ) = 832
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a8c7d27 read (/usr/lib/ld-2.23.so)
            7f688a8b591c open_verify.constprop.7 (/usr/lib/ld-2.23.so)
     0.210 ( 0.002 ms): ex_sleep/4390 fstat(fd: 3, statbuf: 0x7ffe4d16e640                                  
) = 0
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a8c7c94 _fxstat (/usr/lib/ld-2.23.so)
            7f688a8b44f2 _dl_map_object_from_fd (/usr/lib/ld-2.23.so)
LOST 1 events!
LOST 2 events!
LOST 2 events!
LOST 2 events!
LOST 4 events!
LOST 2 events!
LOST 4 events!
LOST 2 events!
LOST 2 events!
LOST 4 events!
  1000.525 (1000.317 ms): ex_sleep/4390  ... [continued]: nanosleep()) = 0
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
  1001.637 ( 1.091 ms): ex_sleep/4390 nanosleep(rqtp: 0x7ffe4d16eec0                                        
) = 0
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a5c5600 __nanosleep (/usr/lib/libc-2.23.so)
            7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
            5582244227cd main (/tmp/ex_sleep)
  1001.702 ( 0.059 ms): ex_sleep/4390 nanosleep(rqtp: 0x7ffe4d16eec0                                        
) = 0
                  20379e syscall_slow_exit_work ([kernel.kallsyms])
                  203bc4 syscall_return_slowpath ([kernel.kallsyms])
                  797248 int_ret_from_sys_call ([kernel.kallsyms])
            7f688a5c5600 __nanosleep (/usr/lib/libc-2.23.so)
            7f688a5ef0c4 usleep (/usr/lib/libc-2.23.so)
            5582244227d7 main (/tmp/ex_sleep)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Is there a way to increase the event buffer or something like that to not lose 
events when the costly dwarf unwinding happens for the first time? Consecutive 
unwinding is cached by libunwind and much faster.

Alternatively, I could try to unwind in the `sys_enter`, but then I'd need to 
buffer the output to print the trace after the duration line...

How would you guys handle this situation?

Also, Jiri, Arnaldo - what would be your suggestion on how to handle the 
`thread::priv` situation - I doubt my naive `priv2` approach is acceptable.

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart2340992.bd486ZQUgj
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
DTE2MDQwNDIxMTcxMVowIwYJKoZIhvcNAQkEMRYEFP8O/4p/hYLlAdOAcQTEoXxISOuZMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAIge
GNpe+vfWM5zx0Y1azYokeHcfhOWCZJpLocI7DGU1HLVqdmk7Yp4G67fdSOcXwNG/l8vZkzL3jPLN
xwpbwq+I7li2FGy1QWByQiewEfOu4f95T278281hsFzPVMMfdWr5T0J7uVRkZks5WDHcWkYV9g8Q
UiOh5rt18APReoI9Og1mX3EsXoloy63NZKYKtcjsdVOnrK/9ZlNVN+I0ViQrWB8U8EZ+MQFCWiSX
pfMSBi0zWOy7oIBgNFITCBIAYNm7Cu6HevQDa+dC7sRrxEKwjBsyqqE5VDXy+XmwkwGBySO6Czqe
U/MmbDHUFxsNIAj3CnYyVr8lCLvZ6HXlupkAAAAAAAA=


--nextPart2340992.bd486ZQUgj--
