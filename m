From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Thu, 21 Dec 2017 13:47:21 +0100
Message-ID: <2337765.oK3dqqyzHo@milian-kdab2>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr> <9831756.pFeoWVMjH9@milian-kdab2> <6d2adf7a-b181-a8ed-2069-6063abadf6a1@lal.in2p3.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2036319.lFtsd9jBeP"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:40854 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbdLUMra (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Dec 2017 07:47:30 -0500
In-Reply-To: <6d2adf7a-b181-a8ed-2069-6063abadf6a1@lal.in2p3.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hadrien Grasland <grasland@lal.in2p3.fr>
Cc: linux-perf-users@vger.kernel.org

--nextPart2036319.lFtsd9jBeP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 21, 2017 11:46:15 AM CET Hadrien Grasland wrote:
> Hi Milian!

Hey, thanks for the answers. I'll snip some parts out so we don't get lost in 
the long mail.

<snip>

> >> $ perf record -a --call-graph=dwarf,65528 -F 1000 -o /dev/shm/perf.data
> >> basf2 02_fit.py -i simulated.root && mv /dev/shm/perf.data /tmp/perf.data
> > 
> > Why do you run record with `-a`? basf2 launches your simulation, right? So
> > just recording it and its children should be enough for you, no?
> 
> I like to run with -a as a default, because it gives me a broader
> picture by telling me about the background system activity during a
> measurement: other CPU-hungry applications which I forgot to close (I
> unfortunately cannot afford the luxury of a dedicated node for
> performance measurements), the overhead of perf itself when I get too
> greedy with DWARF call graphs, etc.

OK, interesting.

> IIRC, running with -a is also necessary to get a representative picture
> of kernel-side overhead in applications that perform a lot of syscalls.
> I was recently experimenting with a system monitoring library that would
> put some heavy load on procfs, and from memory the perf record/report
> picture was totally different in "normal" mode and with -a on.

When you sample on cycles without limiting yourself to userspace (`:u`), then 
you'll also see kernel-space cost. But if it's async and a context switch 
happens, then of course you wouldn't see it. I usually handle this by doing 
sleep-time profiling, but that is currently not as easy as I'd like it to be. 
Something I'm working on for the hotspot GUI though, hopefully I'll have 
something available in January.

> However, you are correct that I do not need it any of these capabilities
> here, and that it introduces unnecessary complexity in our discussion,
> so I re-did a run without it.

You raise valid points, I was merely interested in why you chose `-a` here.

> With that change...
> 
>   * I don't get any samples without a stack trace anymore
>   * Obviously the nvidia samples are gone as well (the way it should be,
>     since this code is not supposed to do graphics)
>   * I still get 1.6% of stack traces ending with ffffffffffffffff
>   * I still get a negligible amount of /tmp/perf-<PID>.map samples
>     (expected, the ROOT toolkit from HEP does some C++ JIT compilation
>     for persistence of arbitrary objects)
>   * I still get 10.6% of stack traces ending in the "[unknown]" DSO for
>     no clear reason.
>   * I still get 0.6% of stack traces ending abruptly.
> 
> Obviously, the behaviour which I am most interesting in is the one that
> introduces the highest bias in my profile (~11% starts to be enough to
> bias the conclusions of a performance analysis if it is all grouped in a
> single place), so it is fine by me if we focus on that one :)

Yep.

<snip>

> >> ~ 1.6% of stack traces end with the ffffffffffffffff pointer. I had a
> >> little chat about those with Jiri on IRC, who suggested that a common
> >> reason for this is when the stack sample is not large enough. It
> >> certainly seems true for some samples, but I am not sure if this is
> >> always the right explanation as I get it even for very short stacks like
> >> the following one:
> >> 
> >> .   basf2  3272 [007]   300.526376:    3571762 cycles:uppp:
> >> .   	           27be5 __ieee754_pow_sse2 (/lib64/libm-2.26.so)
> >> .   	ffffffffffffffff [unknown] ([unknown])
> > 
> > Do you have debug symbols installed for libm/libc? Do you see other frames
> > where unwinding through __ieee754_pow_sse2 works properly? I've personally
> > also encountered issues similar to this one, and haven't found an
> > explanation. I guess there can be many problems, my current hunch is
> > buggy DWARF interpretation by libunwind, or alternatively wrong/limited
> > information emitted by the compiler.
> 
> I have debug symbols for libm/libc, and also for the other DSOs which
> produce similarly broken stacks (libstdc++, ROOT, libpython, Geant4...).
> 
> If there is anything I can do to help you with investigating that
> anomaly, be my guest :)

I guess this is the same problem as you are seeing below then.

<snip>

> >> Now, these are the anomalous samples which I think I understand. But as
> >> you can see, they are far from accounting for all of my 16% of "missing"
> >> samples. For the remaining ones, I can explain ~2.8% as originating from
> >> other system activity (other running programs, syscalls, etc), but that
> >> still leaves a good 10.2% of samples for which I have absolutely no idea
> >> what's going on.
> >> 
> >> In the majority of the cases (~9.7%), the stack traces just suddenly go
> >> someplace weird for no apparent reason:
> >> 
> >> .   basf2  3272 [007]   300.560379:    3571034 cycles:uppp:
> >> .   	          1a7036 G4PolyconeSide::DistanceAway
> >> (/home/hadrien/Software/Belle2/externals/development/Linux_x86_64/opt/lib
> >> /l
> >> ibG4geometry.so) .   	               1 [unknown] ([unknown])
> >> 
> >> While in the remaining cases (~0.6%), the stack traces start fine but
> >> end up rather abruptly:
> >> 
> >> .   basf2  3272 [007]   300.541377:    3571664 cycles:uppp:
> >> .   	            e4a9 
Belle2::G4SafeNavigator::LocateGlobalPointAndSetup
> >> (/home/hadrien/Software/Belle2/tests-release/modules/Linux_x86_64/opt/lib
> >> ge
> >> nfitUtilities.so)
> > 
> > In both cases, do you have full dwarf information available for these
> > libraries? What compiler did you use for compilation? How deep into the
> > stack trace does this happen?
> 
> I have the DWARF information for these libraries. Since I have had to
> build some of them myself, I thought it might have been a build system
> misconfiguration, but as far as I know ELF debugging sections never lie:

<snip>

> Everything was compiled using GCC 7.2.0, and as you can see in the perf
> script samples which I provided you in my initial mail, the problem
> tends to happen very early in the stack trace, typically at the first or
> second frame.

The sections are there, the question is whether the information on the given 
address is there. See also below for more.

> >> Can you help me check if my understanding of the other samples is
> >> correct, and give me some clues about what could happen for these last
> >> few weird ones?
> >> 
> >> I can provide perf.data files and archives on demand, but since the
> >> original is a rather big upload/download ( 2.7 GB ), I thought I would
> >> wait until you can give me some specific requests or a way to produce
> >> skimmed datasets with only the samples that you are looking for.
> > 
> > The perf.data file wouldn't be enough, we'd need access to all of the
> > so/dbg files too. perf archive could be used for that purpose, but I've
> > seen many situations where not all DSOs encountered had a build-id, and
> > thus where not put into the archive...
> 
> Yes, back when I discussed the ffffffffffffffff samples with Jiri on
> IRC, we had this problem that perf archive failed to include all
> necessary DSOs for analysis. So I'm not sure if it would work here.
> 
> If there is anything else which I can do to help you here, just tell me!

I never took the time to debug this, but I personally consider this a big 
problem with perf. These broken backtraces make analysis often much harder 
compared to others tools like VTune which apparently do not suffer from this 
issue. At least there, I have never seen it - maybe it's just less of a 
problem there for some reason.

So to debug this, I guess we need to sit down and actually find a way to 
reproduce the issue with a smaller test case. I actually have something that 
is much smaller than your code base and also shows this issue sometimes:

https://github.com/KDAB/hotspot/blob/master/tests/test-clients/cpp-inlining/
main.cpp

perf record --call-graph dwarf -c 1000000 ./a.out
..
cpp-inlining 25448 258803.904661:     100000 cycles:uppp: 
        ffffffff815fd197 [unknown] ([unknown])
..
cpp-inlining 25448 258803.907014:     100000 cycles:uppp: 
                   23783 __hypot_finite (/usr/lib/libm-2.26.so)
        40e3491ebf75199b [unknown] ([unknown])
..
cpp-inlining 25448 258804.312048:     100000 cycles:uppp: 
                   23783 __hypot_finite (/usr/lib/libm-2.26.so)
        40f204e9aa06ab79 [unknown] ([unknown])

Interestingly, the last broken state repeats, and the address in libm is 
always the same (0x23783). So that's why I believe that the problem might be 
in libunwind/libdw or in the DWARF emitter in GCC/Clang... We'd have to debug 
this. I guess for that we'd have to do something along the following:

- build a minimal "unwinder" application for libunwind e.g.
- notify libunwind about all mmap events
- install the register and stack state from the per.data file
- try to unwind, see what happens

This should give us a MWE that we could also show to Dave Watson and others 
from libunwind. Similarly, we can easily check what libdwfl does there and 
could show it to Mark Wielaard and others from elfutils. I'm pretty sure that 
together we can then figure out what to blame:

- are the register values correct?
- is the stack state correct?
- is the DWARF info correct?
- ...?

It sounds like a lot of work, but it's certainly doable. Fixing this issue 
would make me very happy, and I bet a lot of other users would appreciate this 
too. Right now, I often have to tell people who use perf "deal with broken 
backtraces, try to guesstimate from the surroundings what actually happened". 
But this is of course far from optimal!

Bye

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2036319.lFtsd9jBeP
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMjIxMTI0NzIxWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgdKjhAuiynAazl2ZpGCvizmVfrf41
rdU58Dlt7JbWcfIwDQYJKoZIhvcNAQEBBQAEggEAljGoNKdoGQWAdQT5HmR2w/n7VW5N9V9gi1TQ
y1DDVvFkFhhu3gIUPEV44BD/Wp+73uQtRlJnoaW32WyvFJH2GVXRccH0YTFDoVJHkw57BA/w8iT0
47nR/FLFriFD7Qlowa9sWjunmq9JplUc5bCcoZ6/b95ZgMkYkzR26OZGsh5HHfg+aeUyjfS7fLib
BkLQuVAz0it7Yx6V9UiIdZGDpCJNIqLpcm536+6yYbr7OignO4fl3nPg7c1HbA5ynmtrp17RsNI4
Pf+abhUVf4fu41EgcKK2Y+2VGFmHFOdAWGCwz6DyML6V/VMgGCpOO40e4SqMwHzNkOE3jUy5tGli
FAAAAAAAAA==


--nextPart2036319.lFtsd9jBeP--
