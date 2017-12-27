From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Wed, 27 Dec 2017 23:21:42 +0100
Message-ID: <6163851.pr6yA0HVPA@agathebauer>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr> <2337765.oK3dqqyzHo@milian-kdab2> <9c47802d-a568-1a39-bfa4-6a12d0622a4e@lal.in2p3.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1562539.GIrOsdbFJm"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:49762 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbdL0WVt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Dec 2017 17:21:49 -0500
In-Reply-To: <9c47802d-a568-1a39-bfa4-6a12d0622a4e@lal.in2p3.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hadrien Grasland <grasland@lal.in2p3.fr>
Cc: linux-perf-users@vger.kernel.org

--nextPart1562539.GIrOsdbFJm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 21, 2017 5:02:09 PM CET Hadrien Grasland wrote:
> Hey,
> 
> First of all, let me be even more aggressive with e-mail quote removal :)
> 
> > <snip>
> > 
> >>>> Can you help me check if my understanding of the other samples is
> >>>> correct, and give me some clues about what could happen for these last
> >>>> few weird ones?
> >>>> 
> >>>> I can provide perf.data files and archives on demand, but since the
> >>>> original is a rather big upload/download ( 2.7 GB ), I thought I would
> >>>> wait until you can give me some specific requests or a way to produce
> >>>> skimmed datasets with only the samples that you are looking for.
> >>> 
> >>> The perf.data file wouldn't be enough, we'd need access to all of the
> >>> so/dbg files too. perf archive could be used for that purpose, but I've
> >>> seen many situations where not all DSOs encountered had a build-id, and
> >>> thus where not put into the archive...
> >> 
> >> Yes, back when I discussed the ffffffffffffffff samples with Jiri on
> >> IRC, we had this problem that perf archive failed to include all
> >> necessary DSOs for analysis. So I'm not sure if it would work here.
> >> 
> >> If there is anything else which I can do to help you here, just tell me!
> > 
> > I never took the time to debug this, but I personally consider this a big
> > problem with perf. These broken backtraces make analysis often much harder
> > compared to others tools like VTune which apparently do not suffer from
> > this issue. At least there, I have never seen it - maybe it's just less
> > of a problem there for some reason.
> > 
> > So to debug this, I guess we need to sit down and actually find a way to
> > reproduce the issue with a smaller test case. I actually have something
> > that is much smaller than your code base and also shows this issue
> > sometimes:
> > 
> > https://github.com/KDAB/hotspot/blob/master/tests/test-clients/cpp-inlinin
> > g/ main.cpp
> > 
> > perf record --call-graph dwarf -c 1000000 ./a.out
> > ..
> > 
> > cpp-inlining 25448 258803.904661:     100000 cycles:uppp:
> >          ffffffff815fd197 [unknown] ([unknown])
> > 
> > ..
> > 
> > cpp-inlining 25448 258803.907014:     100000 cycles:uppp:
> >                     23783 __hypot_finite (/usr/lib/libm-2.26.so)
> >          
> >          40e3491ebf75199b [unknown] ([unknown])
> > 
> > ..
> > 
> > cpp-inlining 25448 258804.312048:     100000 cycles:uppp:
> >                     23783 __hypot_finite (/usr/lib/libm-2.26.so)
> >          
> >          40f204e9aa06ab79 [unknown] ([unknown])
> > 
> > Interestingly, the last broken state repeats, and the address in libm is
> > always the same (0x23783). So that's why I believe that the problem might
> > be in libunwind/libdw or in the DWARF emitter in GCC/Clang... We'd have
> > to debug this. I guess for that we'd have to do something along the
> > following:
> > 
> > - build a minimal "unwinder" application for libunwind e.g.
> > - notify libunwind about all mmap events
> > - install the register and stack state from the per.data file
> > - try to unwind, see what happens
> > 
> > This should give us a MWE that we could also show to Dave Watson and
> > others
> > from libunwind. Similarly, we can easily check what libdwfl does there and
> > could show it to Mark Wielaard and others from elfutils. I'm pretty sure
> > that together we can then figure out what to blame:
> > 
> > - are the register values correct?
> > - is the stack state correct?
> > - is the DWARF info correct?
> > - ...?
> > 
> > It sounds like a lot of work, but it's certainly doable. Fixing this issue
> > would make me very happy, and I bet a lot of other users would appreciate
> > this too. Right now, I often have to tell people who use perf "deal with
> > broken backtraces, try to guesstimate from the surroundings what actually
> > happened". But this is of course far from optimal!
> 
> This discussion is getting a bit far from my technological comfort zone,
> and I am very likely to say something stupid or repeat what you just
> said in a different way. But if I look at the libunwind documentation, I
> see that there seems to be a way to attach to a process and generate a
> backtrace of it like a debugger would.
> 
> If so, couldn't we bisect the issue and discriminate whether this is
> perf's fault by just using this capability to build a minimal poor man
> profiler, which uses libunwind to print a stack trace of an application
> at regular intervals? To the best of my understanding, if we get broken
> stack traces there, the blame would lie on the side of libunwind or the
> compiler-generated DWARF info, whereas if we get correct stack traces,
> the blame would lie on perf's facilities for copying register and stack
> state.
> 
> Am I overlooking something here?

No, this is pretty much what I had in mind too. The only difference is where 
to get the stack from for unwinding. Attaching with libunwind is one option, 
but I'm unsure whether we can "hit" the troublesome addresses in libm e.g. 
easily. My idea was to take the stack copy we have in perf.data attached to 
the sample event. Anyhow, both approaches sound useful, and having both would 
of course be the ideal scenario as we could where it breaks.

Bye

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart1562539.GIrOsdbFJm
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMjI3MjIyMTQyWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgKJKdhEP0zBOwpzxQISjGDC93xLZd
5vFIsW5KWgOzZgwwDQYJKoZIhvcNAQEBBQAEggEATHwaxlZtGnDfTxPpW1qg2fspsoZMC7THvIqu
1CnWpQ9LM8QUhxr5FJnM2EeQfjwiKnp8fpcUrrxuW5p15wkNPJtkF+LRQdIAqeB/PktBBWsk8qek
y+FmHHAFk4XQzqi4VrpZTrlntbW3wGPv9lhNbRKfuvtodY8GKgkF4+Cgdm180Iwh+SItDi8zdx+N
XFU98/L/1DSIbxZ6c1EA1pLEU5mnrlJq4iFTUFOP06EBvd9GcIiH32W+wR/4UEIFiskgFU77MFhS
8OLG9cucmHa48e+m5eQeYCSNhHCsxq8u9aPVe/EGOVwREtUcP7KVvrCtvorPYgJDxpLe7x4FQjVc
MgAAAAAAAA==


--nextPart1562539.GIrOsdbFJm--
