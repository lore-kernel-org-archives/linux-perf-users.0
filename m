From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf call stacks on 32bit ARM v7
Date: Sun, 02 Oct 2016 23:12:17 +0200
Message-ID: <2583963.6LxZiVeVan@agathebauer>
References: <4233607.GXAFRqVoOG@agathebauer> <1679528.gn0OXkLKrD@agathebauer> <CAORVsuUtLUVbAQfZgkZrzJihyreHjyD4S-b+aRypi9aNbNEozQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5882775.EPO9Y1pq7l"; micalg="sha1"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43276 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbcJBVMZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 2 Oct 2016 17:12:25 -0400
In-Reply-To: <CAORVsuUtLUVbAQfZgkZrzJihyreHjyD4S-b+aRypi9aNbNEozQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, hekuang 00206996 <hekuang@huawei.com>

--nextPart5882775.EPO9Y1pq7l
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 30. September 2016 09:32:44 CEST Jean Pihet wrote:
> Hi,
> 
> On Thu, Sep 29, 2016 at 12:33 PM, Milian Wolff <milian.wolff@kdab.com> 
wrote:
> > On Donnerstag, 29. September 2016 09:39:51 CEST Jean Pihet wrote:
> >> Hi Milian, Wangnan,
> >> 
> >> I am pretty busy this week. Let me check and come back to you next week.
> > 
> > Sure, take your time - much appreciated!
> > 
> >> PS: did you check the detailed instructions from the Linaro wiki pages?
> >> These are linked from the Fosdem presentation slides.
> > 
> > You mean this page, right:
> > 
> > https://wiki.linaro.org/KenWerner/Sandbox/libunwind
> 
> I mean
> https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding
> where the details about installation, compilation etc. are found.
> 
> In short, DWARF unwinding on ARMv7 should work out of the box. You
> need libunwind, the correct kernel config options and perf installed.
> As you are mentioning the downside is the size of the generated trace
> which can be a limitation on embedded systems. Some parameters can be
> used to control the size of the generated trace (-F).

No, I mean the size of the application code when debug symbols are added:

tmp$ du -hs libQt5Core.so.5.7.1 
63M     libQt5Core.so.5.7.1
tmp$ strip libQt5Core.so.5.7.1 
tmp$ du -hs libQt5Core.so.5.7.1 
4.8M    libQt5Core.so.5.7.1

And this is just one library involved of many in the applications I have to 
deal with regularly. I just had a case where the target platform had about 
50MB storage space free. I resorted to connecting an USB drive to load the 
application code with debug symbols from. But this changes the performance 
behavior of the application, as the code is not loaded anymore from the often 
excruciatingly slow on-board flash drive.

> > That does not mention perf at all, and only talks about libunwind. Note
> > how
> > your talk, and the wiki, say .exidx unwinding using libunwind works. But
> > your slides also explicitly say that this mechanism is not supported by
> > perf, yet. I would like to know the reason for that, or whether this is
> > outdated information.
> 
> I do not recall the details but .exidx is not supported on ARM,
> because of the compiler that does not generate the info in the
> binaries (you can check the ELF sections for it)

If I compile with -funwind-tables, then I do get the .exidx section, see this 
link I posted earlier:

https://wiki.linaro.org/KenWerner/Sandbox/libunwind

> or the kernel does not unwind the info.

That sounds more like the culprit - can someone confirm, that:

- for frame-pointer based unwinding, perf unwinds the stacks in kernel space
- whereas dwarf-based unwinding copies the stack together with the samples 
into the perf.data, and does the unwinding later on

So one would need to either

- add .exidx unwinding support into the kernel
- copy whatever is required into perf.data and do the unwinding later on
  can someone clarify what is actually required to do that?

> > Thanks!
> 
> I hope this helps!

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart5882775.EPO9Y1pq7l
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
DTE2MTAwMjIxMTIxN1owIwYJKoZIhvcNAQkEMRYEFHyjMO++tjkiiu7uOk/I8PKyuXkyMCgGCSqG
SIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAHF4
oUYOqL5cjxNImrwNxjBIYXmALLHdru5SuDJYbdpP6gnQ2S7gRrqZ22td2NQEz5X89MIxnZunrB+C
2hWaWdiJ77DFeMOCQY8c3eNTXmfXa+IrY9TUgfdJtUoeyjr37Vgf77g6H8MUx2+DSndKgQMjEwqs
2hM2gBum8DuikhyxhRjghXGp8ujTBXrtstPjm6yHbM9cd3XfH+yeG6m/c84rb5AuinSakVcmdD6L
53tg6UdnJiRpBGnTMboYFU7ptCwxctacft7p02XvGSeY0Gmh/ew+ySUwbQSppa0o5Ogx7xRpv6Uk
5xaihj9Ix9m/NChJ6z/pFbuFDhz2TnikhCUAAAAAAAA=


--nextPart5882775.EPO9Y1pq7l--
