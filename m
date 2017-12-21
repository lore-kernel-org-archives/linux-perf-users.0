From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Thu, 21 Dec 2017 10:54:29 +0100
Message-ID: <9831756.pFeoWVMjH9@milian-kdab2>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17402136.FOIXgBjO0K"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:47104 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbdLUJyf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Dec 2017 04:54:35 -0500
In-Reply-To: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hadrien Grasland <grasland@lal.in2p3.fr>
Cc: linux-perf-users@vger.kernel.org

--nextPart17402136.FOIXgBjO0K
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, December 20, 2017 10:39:07 AM CET Hadrien Grasland wrote:
> Hi all,

Hey Hadrien!

> I am currently trying to get a reliable perf setup for a new codebase
> that I am working on. The software is rather big and complex (particle
> physics framework from the Belle 2 experiment), and architected in a way
> that makes it hard to break it down in smaller chunks, which brings some
> new issues that I do not usually encounter in my smaller software
> projects. I thought you might be able to help me understand some of the
> oddities that I observe in perf's output.
> 
> -----
> 
> I am running perf 4.14.3 on top of Linux 4.14.6 and a Haswell machine
> (Intel(R) Xeon(R) E5-1620 v3).

Is this a self-build perf, or whatever you get from openSUSE? Is it using 
libunwind for unwinding, or libdw? Try do to a `ldd` on `perf` to see what it 
links against.

> My Linux distribution, openSUSE
> Tumbleweed, has the nasty but sadly widespread habit of building
> everything using -fomit-frame-pointer, which makes FP-based call graphs
> impractical. And some parts of the code produce rather huge stack traces
> (> 100 frames, most likely originating from recursion) which preclude
> use of LBR-based profiling. So as far as I understand, my only option is
> to use DWARF with stack samples that are as large as possible ( 65528 ),
> and hope that the remaining truncated traces do not bias my profile too
> much. I estimated by analyzing the output of perf script (more about
> that below) that they are < 2%, so the impact shouldn't be too bad.
> 
> Since these big stack semples cause quite a lot of perf.data I/O, I keep
> the sampling rate reasonable (1 kHz) and store my perf.data on a ramdisk
> during sampling. With these final tweaks, my perf record command ends up
> looking like this:
> 
> $ perf record -a --call-graph=dwarf,65528 -F 1000 -o /dev/shm/perf.data
> basf2 02_fit.py -i simulated.root && mv /dev/shm/perf.data /tmp/perf.data

Why do you run record with `-a`? basf2 launches your simulation, right? So 
just recording it and its children should be enough for you, no?

> Due to the aforementioned huge stack traces, I also had to increase perf
> report's stack limit to avoid systematic statistical bias against large
> stack traces. I did not find an "unlimited" option, so I just made it
> large enough to encompass any possible stack trace:
> 
> $ perf report --max-stack=65535 -i /tmp/perf.data
> 
> -----
> 
> Now, my problem is that the aforementioned perf report command only
> attributes ~84% of the samples to the top-level function of the program
> (here __libc_start_main), which seems a little low to me. In an attempt
> to understand this, I started analyzing the perf script output, and
> noticed a number of anomalous samples which I would like to discuss
> further with you.
> 
> ~0.7% of samples have no stack trace at all. I'm not sure if this is
> expected, my guess was that this could possibly happen if the PMU
> interrupt fires at a time where the system is in an idle state. You tell
> me. In that case, perf script only displays a header like this:
> 
> .   irqbalance  1497 [001]   275.010584:    1320760 cycles:uppp:

This is probably a side-effect of you using `-a`, try removing it.

> ~ 1.6% of stack traces end with the ffffffffffffffff pointer. I had a
> little chat about those with Jiri on IRC, who suggested that a common
> reason for this is when the stack sample is not large enough. It
> certainly seems true for some samples, but I am not sure if this is
> always the right explanation as I get it even for very short stacks like
> the following one:
> 
> .   basf2  3272 [007]   300.526376:    3571762 cycles:uppp:
> .   	           27be5 __ieee754_pow_sse2 (/lib64/libm-2.26.so)
> .   	ffffffffffffffff [unknown] ([unknown])

Do you have debug symbols installed for libm/libc? Do you see other frames 
where unwinding through __ieee754_pow_sse2 works properly? I've personally 
also encountered issues similar to this one, and haven't found an explanation. 
I guess there can be many problems, my current hunch is buggy DWARF 
interpretation by libunwind, or alternatively wrong/limited information 
emitted by the compiler.

> However, it might be the case that some functions allocate very large
> stack objects, or that this invalid pointer is used in other cases. I
> welcome additional explanations here.
> 
> ~0.6% of samples look mostly normal, but end with a DSO like
> "/tmp/perf-<PID>.map". A web search suggests that this happens when perf
> detected JIT-compiled code, but did not get DWARF information from the
> JIT. And in most cases this explanation looks accurate to me as the next
> DSO in the stack is typically libmozjs or similar.
> 
> ~0.2% of samples are full of "[unknown]" symbols and end up somewhere in
> a DSO with "nvidia" in its name. I understand this as originating from
> the fact that DWARF call graphs cannot work well with proprietary code
> that does not have debug info, and that's fine by me considering the low
> amount of samples.

The proprietary nvidia libs have neither frame pointers, nor DWARF 
information, so unwinding is often impossible there and thus ends up in 
[unknown].

> Now, these are the anomalous samples which I think I understand. But as
> you can see, they are far from accounting for all of my 16% of "missing"
> samples. For the remaining ones, I can explain ~2.8% as originating from
> other system activity (other running programs, syscalls, etc), but that
> still leaves a good 10.2% of samples for which I have absolutely no idea
> what's going on.
> 
> In the majority of the cases (~9.7%), the stack traces just suddenly go
> someplace weird for no apparent reason:
> 
> .   basf2  3272 [007]   300.560379:    3571034 cycles:uppp:
> .   	          1a7036 G4PolyconeSide::DistanceAway
> (/home/hadrien/Software/Belle2/externals/development/Linux_x86_64/opt/lib/l
> ibG4geometry.so) .   	               1 [unknown] ([unknown])
> 
> While in the remaining cases (~0.6%), the stack traces start fine but
> end up rather abruptly:
> 
> .   basf2  3272 [007]   300.541377:    3571664 cycles:uppp:
> .   	            e4a9 Belle2::G4SafeNavigator::LocateGlobalPointAndSetup
> (/home/hadrien/Software/Belle2/tests-release/modules/Linux_x86_64/opt/libge
> nfitUtilities.so)

In both cases, do you have full dwarf information available for these 
libraries? What compiler did you use for compilation? How deep into the stack 
trace does this happen?

> Can you help me check if my understanding of the other samples is
> correct, and give me some clues about what could happen for these last
> few weird ones?
> 
> I can provide perf.data files and archives on demand, but since the
> original is a rather big upload/download ( 2.7 GB ), I thought I would
> wait until you can give me some specific requests or a way to produce
> skimmed datasets with only the samples that you are looking for.

The perf.data file wouldn't be enough, we'd need access to all of the so/dbg 
files too. perf archive could be used for that purpose, but I've seen many 
situations where not all DSOs encountered had a build-id, and thus where not 
put into the archive...

Bye

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart17402136.FOIXgBjO0K
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMjIxMDk1NDI5WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgW9oSMumezCRIcm7dLwHTdoKPZw9m
RiP3ytWZBLq+8IQwDQYJKoZIhvcNAQEBBQAEggEAI5+w2mAi3VrcUDZ8nf9RST8pSkY7/QsHgXUT
vSPrYskk1qCnHNbXpqTagew97aWJ6Pa5UE3XZLmrDHNLKJ+p54rkbmUCPCQ4wEE1i5tSBhGFfoJx
I6LA7wNKngdmxeFx84bSoIUOrfPdbz+JbKVruJpUUhN5yWM7d9+4BCXJFPBK+MEbvuyKnPz/bSgE
B4ahcIZVJP+X3qUDxB+uYCx/cOxiDuaQU2Asmf5QEdP7yicEnbBCyJNysINas2anmKfb34geqSFO
vh1YYPc8zK6AwlSNDtSn3ewNO+PH/uCNTpQb9we8C2xXWX80dYDrZZYyOHWVA5EaIxkhL/1hVCYv
mQAAAAAAAA==


--nextPart17402136.FOIXgBjO0K--
