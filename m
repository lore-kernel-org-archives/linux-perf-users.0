From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: Callgraphs split at the kernel boundary
Date: Mon, 04 Sep 2017 18:44:23 +0200
Message-ID: <4314827.rDNsEPmXDr@milian-kdab2>
References: <20170903094913.ddk52e4zd44zz3vn@kazak> <15526878.WJkr8vPO1G@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3196984.TOXpVT1YzZ"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:49072 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752687AbdIDQo2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 12:44:28 -0400
In-Reply-To: <15526878.WJkr8vPO1G@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Ralph =?ISO-8859-1?Q?B=F6hme?= <slow@samba.org>, linux-perf-users@vger.kernel.org

--nextPart3196984.TOXpVT1YzZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, September 4, 2017 6:26:21 PM CEST Milian Wolff wrote:
> On Sunday, September 3, 2017 11:49:13 AM CEST Ralph B=F6hme wrote:
> > Hi!
> >=20
> > I'm noticing split callgraphs at the kernel boundary when recording
> > callgraphs with perf record. This happens with both DWARF and FP, eg
> >=20
> > perf record -g --call-graph fp -p 3293, or
> > perf record -g --call-graph dwarf -p 3293
> >=20
> > Here are two examples, sys_fcntl in perf script output:
> >=20
> > DWARF:
> >=20
> > smbd  3293 48551.772583:     250000 cpu-clock:
> >             7fff8183eb75 _cond_resched ([kernel.kallsyms])
> >             7fff81264bfb locks_alloc_lock ([kernel.kallsyms])
> >             7fff812680a6 fcntl_setlk ([kernel.kallsyms])
> >             7fff81224182 sys_fcntl ([kernel.kallsyms])
> >             7fff81842a72 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
> >             7f9aca651687 __libc_fcntl
> >=20
> > (/lib/x86_64-linux-gnu/libpthread-2.23.so) 7f9ac407d032 fcntl_lock
> > (/home/slow/git/samba/scratch/bin/default/lib/tdb/libtdb.so)
> >=20
> > FP:
> >=20
> > smbd  3293 48969.378250:     250000 cpu-clock:
> >             7fff810c5b00 __init_waitqueue_head ([kernel.kallsyms])
> >             7fff812680a6 fcntl_setlk ([kernel.kallsyms])
> >             7fff81224182 sys_fcntl ([kernel.kallsyms])
> >             7fff81842a72 entry_SYSCALL_64_fastpath ([kernel.kallsyms])
> >            =20
> >                    10687 __libc_fcntl
> >=20
> > (/lib/x86_64-linux-gnu/libpthread-2.23.so) c [unknown] ([unknown])
> >=20
> >             556e17ea6470 [unknown] ([unknown])
> >=20
> > I'm seeing this on different kernels and perf versions:
> >=20
> > # uname -a && perf -v
> > Linux kazak 4.12.8-300.fc26.x86_64 #1 SMP Thu Aug 17 15:30:20 UTC 2017
> > x86_64 x86_64 x86_64 GNU/Linux perf version 4.12.8.300.fc26.x86_64.ga6ba
> >=20
> > # uname -a && perf -v
> > Linux titan 4.4.0-79-generic #100-Ubuntu SMP Wed May 17 19:58:14 UTC 20=
17
> > x86_64 x86_64 x86_64 GNU/Linux perf version 4.4.67
> >=20
> > Occasionally callgraphs are not split, but this seems to be the excepti=
on:
> >=20
> > smbd 18113 298919.831823:     250000 cpu-clock:
> >                   46e9a9 path_get
> >=20
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 4605d5
> > do_dentry_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlin=
ux)
> > 461bfe vfs_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
> > 473caf path_openat
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 475e8b
> > do_filp_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
> > 4620ea do_sys_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 46219e
> > sys_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) a77737
> > entry_SYSCALL_64
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 1189d
> > [unknown]
> > (/usr/lib64/libpthread-2.25.so) 1c51c6 dos_mode_check_compressed
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 1c5435 dos_mode
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 22a89d smbd_smb2_create_send
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 2269c4 smbd_smb2_request_process_create
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 219833 smbd_smb2_request_dispatch
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 21e974 smbd_smb2_io_handler
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > 21ea7a smbd_smb2_connection_handler
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > f106 epoll_event_loop
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) f73e
> > epoll_event_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) c431
> > std_event_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 51b9
> > _tevent_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 54d4
> > tevent_common_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) c4d3
> > std_event_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 5577
> > _tevent_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 200d=
a1
> > smbd_process
> > (/home/slow/git/samba/scratch/bin/default/source3/libsmbd-base-samba4.s=
o)
> > dd24 smbd_accept_connection
> > (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd) f106
> > epoll_event_loop
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) f73e
> > epoll_event_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) c431
> > std_event_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 51b9
> > _tevent_loop_once
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 54d4
> > tevent_common_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) c4d3
> > std_event_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) 5577
> > _tevent_loop_wait
> > (/home/slow/git/samba/scratch/bin/default/lib/tevent/libtevent.so) eb27
> > smbd_parent_loop
> > (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd) 10ce5 main
> > (/home/slow/git/samba/scratch/bin/default/source3/smbd/smbd) 2050a
> > __libc_start_main (/usr/lib64/libc-2.25.so) 6e3e258d4c544155 [unknown]
> > ([unknown])
> >=20
> > The majority of callgraphs for sys_open is split as well:
> >=20
> > smbd 18113 298923.760035:     250000 cpu-clock:
> >                   3d7de6 file_ra_state_init
> >=20
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 461bfe
> > vfs_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 473caf
> > path_openat (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
> > 475e8b do_filp_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 4620ea
> > do_sys_open (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
> > 46219e sys_open
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux)
> > a77737 entry_SYSCALL_64
> > (/usr/lib/debug/lib/modules/4.12.8-300.fc26.x86_64/vmlinux) 1189d
> > [unknown]
> > (/usr/lib64/libpthread-2.25.so) c70 [unknown] ([unknown])
> >=20
> >               ee0000000b [unknown] ([unknown])
> >              =20
> >                       41 [unknown] ([unknown])
> >=20
> > As a result overhead calcuation is split between userspace and kernel:
> > # perf report --stdio -g none
> >=20
> > # To display the perf.data header info, please use --header/--header-on=
ly
> > options. #
> > # Total Lost Samples: 0
> > #
> > # Samples: 11K of event 'cpu-clock'
> > # Event count (approx.): 2754000000
> > #
> > # Children      Self  Command  Shared Object                Symbol
> > # ........  ........  .......  ...........................
> > ..................... #
> >=20
> >     54.73%     0.60%  smbd     [kernel.vmlinux]             [k]
> >=20
> > entry_SYSCALL_64e 44.62%     0.09%  smbd     libtevent.so
> > [.] epoll_event_loop 44.62%     0.05%  smbd     libtevent.so
> >=20
> >  [.] _tevent_loop_once
> >=20
> > The following flamegraph shows this as well:
> >=20
> > <https://www.samba.org/~slow/flamegraph-25453.svg>
> >=20
> > Am I missing something? This renders CPU profiling with perf pretty
> > useless
> > for my usecase with lots of syscalls.
>=20
> I'm not sure whether what I'm seeing is also related to your issue, but I
> just tested this:
>=20
> ~~~~~
> #include <complex>
> #include <cmath>
> #include <random>
> #include <iostream>
> #include <thread>
> #include <mutex>
> #include <vector>
> #include <future>
>=20
> using namespace std;
>=20
> mutex g_mutex;
>=20
> double worker()
> {
>     lock_guard<mutex> guard(g_mutex);
>     uniform_real_distribution<double> uniform(-1E5, 1E5);
>     default_random_engine engine;
>     double s =3D 0;
>     for (int i =3D 0; i < 1000; ++i) {
>         s +=3D norm(complex<double>(uniform(engine), uniform(engine)));
>     }
>     return s;
> }
>=20
> int main()
> {
>     vector<std::future<double>> results;
>     for (int i =3D 0; i < 10000; ++i) {
>         results.push_back(async(launch::async, worker));
>     }
>     return 0;
> }
> ~~~~~
>=20
> Then compile and record it:
>=20
> ~~~~~
> $ g++ --std=3Dc++11 -pthread -O2 -g test.cpp -o test
> $ perf record -c 100000 --call-graph dwarf ./test
> [ perf record: Woken up 559 times to write data ]
> [ perf record: Captured and wrote 144.038 MB perf.data (17566 samples) ]
> ~~~~~
>=20
> The report then shows three big chunks where unwinding fails:
>=20
> ~~~~~
> $ perf report --stdio --no-children
> ...
>     20.56%  test     [kernel.vmlinux]     [.] syscall_return_via_sysret
>=20
>             ---syscall_return_via_sysret
>=20
>     12.76%  test     [kernel.vmlinux]     [.] entry_SYSCALL_64_fastpath
>=20
>             ---entry_SYSCALL_64_fastpath
>=20
>      6.64%  test     [kernel.vmlinux]     [.] native_irq_return_iret
>=20
>             ---native_irq_return_iret
> ~~~~~
>=20
> This happens with both, libunwind and elfutils' libdw.

In my case, it seems to help to remove the filter. I.e. by default perf=20
nowadays uses `cycles:uppp` on my system. If I instead specify `cycles:P`=20
explicitly at `perf record` time, the issue above seems to be reduced, albe=
it=20
not completely. Does this help in your situation too?

Cheers

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart3196984.TOXpVT1YzZ
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTA0MTY0NDIzWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgL397G753ooopWdi8ABC7KEHJL00k
5k5ziuEdVssAqrIwDQYJKoZIhvcNAQEBBQAEggEAAS/WTpgDb/PehTVc3LAwYUElXT1CQAgN0LVT
HcSUV5XTlm5el0zX29WS3bCXny6ENsKOIldwf4FeVluKq5ccZUTNO2i7G1t4nmwmA/OFu13S9h15
XKJJVGWONgLC8wWGCPeI4rvsbNrlD0YIw4YW/dPDBzWdMTlrZ0s/0CgWrpaRr4ACODlpuxN8NU/U
kLU5VKm/g7mooIuuNdcJPHrhihCv/EFPWdLk6ikYVd2hNVYF6xvautXQ8ZheJa55uOZW5As2xwVP
yWCQrrWCZXWVRRXXKFlRD90W7T0JAAOsMai0lWegk575QapjsnZXrQpzEUheutxyl6T/9Jy/vYJC
QgAAAAAAAA==


--nextPart3196984.TOXpVT1YzZ--
