From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Not finding symbol information
Date: Fri, 02 Feb 2018 15:31:08 +0100
Message-ID: <1590706.6giPFGD14k@milian-kdab2>
References: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1748164.5ZpibyB6VV";
 micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:23255 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeBBObM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Feb 2018 09:31:12 -0500
In-Reply-To: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

--nextPart1748164.5ZpibyB6VV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, February 2, 2018 3:06:32 PM CET Vuille, Martin (Martin) wrote:
> We are using 'perf record' to collect information on an embedded ARM board
> (the target) and then using 'perf report' on a PC (the host) to interpret
> the data.
> 
> The host has a copy of the rootfs of the target that also includes debug
> info. We pass the '--symfs' option to 'perf report' to point to the rootfs.
> 
> Whenever an event in the data corresponds to a DSO that exists on the host,
> 'perf report' complains that the debug info is not available, even though
> that info is in fact available in the rootfs.
> 
> What seems to be happening is that 'perf report' "sees" the host's copy of
> the DSO first, "remembers" this DSO's buildid (which is incorrect), then
> "sees" the debug info in the rootfs but rejects it because it doesn't match
> the buildid "remembered" earlier, and then concludes that there is no debug
> info available.

`perf record` (not `perf report`) is "remembering" build-ids in ~/.debug.

> Using /bin/bash as an example, selected output from 'perf report -v':
> 
> ...
> build id event received for /bin/bash:
> a35856957f6f165a1ca4ea98afbd1a986dfa785c ...
> symsrc__init: build id mismatch for
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
> symsrc__init: build id mismatch for
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
> symsrc__init: build id mismatch for
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> bash. /bin/bash with build id 04eca96c5bf3e9a300952a29ef3218f00487d37b not
> found, continuing without symbols ...
> 
> $ file /bin/bash
> /bin/bash: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically
> linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32,
> BuildID[sha1]=04eca96c5bf3e9a300952a29ef3218f00487d37b, stripped
> 
> $ file
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash:
> ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked,
> interpreter /lib/ld-linux.so.3, for GNU/Linux 3.2.0,
> BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, stripped
> 
> $ file
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> bash
> sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> bash: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically
> linked, interpreter *empty*, for GNU/Linux 3.2.0,
> BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, not stripped

This indeed looks like a bug in the build id matching algorithm. I suggest you 
debug it to figure out why it thinks the build id mismatches. I.e. expand the 
debug output and write the build id it has read and compare that to what file 
sees and what the perf file expects.

> We are using Linux 4.4-11 on the target and 4.4.0-109-generic (Ubuntu 16.04)
> on the host.
> 
> Is this a known issue? Has it been addressed in a more recent kernel?

This should not be part of the kernel, but rather part of the userland perf 
tools. You can easily build the latest versions of those yourself, without 
having to build a new kernel. So on your host, try this:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git -b 
perf/core
cd tools/perf
make # make sure you have all the required dependencies, most notably 
elfutils, libiberty, ...
/perf report -i <path to perf.data>

Hope that helps

PS: You could also try to use our hotspot GUI:
https://github.com/KDAB/hotspot
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart1748164.5ZpibyB6VV
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMjAyMTQzMTA4WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg0IZYxEdU5AkyMd0m/ytRa5ySNvdC
igxeVxkqQ3gXc9swDQYJKoZIhvcNAQEBBQAEggEAmePF9Jw3Q0ncsD0QRiCQfLjR5WqH7x+rYL37
VFjAUCfcyemTRRCnrwfgKREsGCqVg9xD+jTgHQWOL0rDhjPhe9zVNnWi98YAwOyiDHKzTb8eXZ0W
BACu3J0E0rIh/Mtv45Bh8oWeFHIK6K62yPk8i9sDD8K9miWDwVv2lyYEyDJTQbZxiLaaHfy0B4+w
1RJu/ZokzbnH0maoEADu4X5I9iRnmtXSHwaCBZfz1ZGTg6lU7Mu/LddaKzcyaqqAtGJ1AFaeZBKx
rCBC2NbYrYclmLzTol6wPM6DPZwP4Rdc9RddKPghkIGxdXadVy3F5eEuVUEYRTtgIaz8v0ocgA2A
TAAAAAAAAA==


--nextPart1748164.5ZpibyB6VV--
