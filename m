From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: broken cycle counts from perf record in frequency mode [Was: Re: deducing CPU clock rate over time from cycle samples]
Date: Mon, 28 Aug 2017 16:40:43 +0200
Message-ID: <6142297.1ke4zlptR7@milian-kdab2>
References: <2900948.aeNJFYEL58@agathebauer> <1654509.hqsMC4Q0uj@agathebauer> <1503933130.rLYJWxPBaP@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1995764.jjz3H5TLMa"; micalg="sha256"; protocol="application/pkcs7-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503933130.rLYJWxPBaP@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

--nextPart1995764.jjz3H5TLMa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 28, 2017 4:08:47 PM CEST Milian Wolff wrote:
> On Sunday, June 18, 2017 9:53:05 PM CEST Milian Wolff wrote:
> > On Sonntag, 18. Juni 2017 06:22:19 CEST Andi Kleen wrote:
> > > Milian Wolff <milian.wolff@kdab.com> writes:
> > > > But when I look at the naively calculated first derivative, to
> > > > visualize
> > > > CPU load, i.e. CPU clock rate in Hz, then things start to become
> > > > somewhat
> > > > confusing:
> > > > 
> > > > ~~~~
> > > > perf script -F time,period | awk 'BEGIN {lastTime = -1;} { time = $1 +
> > > > 0.0; if (lastTime != -1) {printf("%.6f\t%f\n", time, $2 / (time -
> > > > lastTime));} lastTime = time; }' | gnuplot -p -e "plot '-' with
> > > > linespoints"
> > > > ~~~~
> > > 
> > > The perf time stamps approach the maximum precision of double (12 vs
> > > 15 digits). Likely the division loses too many digits, which may cause
> > > the bogus results. I've ran into similar problems before.
> > 
> > I don't think so, just look at the raw values:
> > 
> > $ perf script -F time,period --ns
> > 71789.438122347:          1
> > 71789.438127160:          1
> > 71789.438129599:          7
> > 71789.438131844:         94
> > 71789.438134282:       1391
> > 71789.438139871:      19106
> > 71789.438156426:     123336
> > ...
> > 
> > $ qalc '123336/(71789.438156426s - 71789.438139871s) to Hz'
> > 123336 / ((71789.438 * second) - (71789.438 * second)) = approx.
> > 7.4500755E9 Hz
> > 
> > > One way around is is to normalize the time stamps first that they
> > > start with 0, but this only works for shorter traces.
> > > Or use some bignum float library
> > 
> > I take the time delta between two samples, so a normalization of the
> > individual times to 0 would not affect my calculations - the delta stays
> > the same after all.
> > 
> > Also, using bignum in my calculations wouldn't change anything either. If
> > perf tells me that 123336 cycles have been executed in 16.555 us, then it
> > will always be larger than any expected value. At 3.2GHz it should be
> > maximally 52976 cycles in such a short timeframe...
> > 
> > > Also at the beginning of frequency the periods are very small, and
> > > the default us resolution will give big jumps for such a calculation.
> > 
> > OK, but who/what measures the large cycle values then? Is this a PMU
> > limitation? Or is this an issue with the interaction with the kernel, when
> > the algorithm tries to find a good frequency at the beginning?
> > 
> > > It's better to use the script --ns option then, but that makes the
> > > double precision problem event worse.
> > 
> > See above, using `--ns` doesn't change anything. And qalc e.g. already
> > uses
> > bignum internally.
> > 
> > > In generally you get better results by avoiding frequency mode,
> > > but always specify a fixed period.
> > 
> > This indeed removes the spikes at the beginning:
> > 
> > perf record --switch-events --call-graph dwarf -P -c 500000
> > 
> > The value is chosen to give a similar sample count to frequency mode.
> 
> Hey all,
> 
> I want to revive the above discussion as I'm still completely puzzled by the
> observation. The tl;dr; for those who have not followed the previous
> discussion:
> 
> perf record in frequency mode (i.e. "record ~1000 samples per second")
> sometimes reports excessively large cycle counts.
> 
> In the previous mails I have outlined how to visualize this issue
> graphically with gnuplot, by drawing the first derivative of the cycles
> over time which gives nicely comparable numbers to ones CPU clock speed.
> 
> Sometimes, this value goe up to 10Ghz and beyond. Sometimes the values are
> so broken (i.e. so high), that they completely break the analysis with perf
> report or similar, as they completely skew the total event count and
> thereby drastically influence the fractional cost reported by perf. E.g.
> just now I ran `perf record` on another application and got this result:
> 
> ~~~~~
> $ perf script | grep page_remove_rmap -C 10
>  QXcbEventReader 23866 605019.879412:     128193 cycles:ppp: 
> ffffffffbb23fbf5 __fget_light (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879469:          1 cycles:ppp: 
> ffffffffbb064504 native_write_msr
> (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>  QXcbEventReader 23866 605019.879471:    1810360 cycles:ppp: 
> ffffffffbb1cb4ec find_vma (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879472:          1 cycles:ppp: 
> ffffffffbb064504 native_write_msr
> (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879474:         10 cycles:ppp: 
> ffffffffbb064504 native_write_msr
> (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879475:        216 cycles:ppp: 
> ffffffffbb064504 native_write_msr
> (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879486:       5106 cycles:ppp: 
> ffffffffbb064504 native_write_msr
> (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
>   lab_mandelbrot 23865 605019.879489:      19381 cycles:ppp:     
> 7f85beae64ce QWaitCondition::wait (/usr/lib/libQt5Core.so.5.9.1)
>   lab_mandelbrot 23865 605019.879495:     251346 cycles:ppp:     
> 7f85bf2567c1 QScreen::~QScreen (/usr/lib/libQt5Gui.so.5.9.1)
>   lab_mandelbrot 23865 605019.880722:    3210571 cycles:ppp:     
> 7f85bd96f850 __cxa_finalize (/usr/lib/libc-2.25.so)
>   lab_mandelbrot 23865 605019.881592: 21110358010774 cycles:ppp:
> ffffffffbb1d4218 page_remove_rmap (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
> ~~~~~
> 
> Note the last sample's cycle cost of 21110358010774. This is so large, that
> it completely dominates the total event count, which lies at
> 21126914067278. The runtime for this perf record was about 4s, it was on a
> single threaded application with 4.12.8-2-ARCH on a Intel(R) Core(TM)
> i7-4770 CPU @ 3.40GHz. So that hardware should at most be capable of
> running up to ~1.36E10 cycles over 4s. perf record, thanks to the last
> sample, measured ~2.11E13 cycles - clearly off the charts.
> 
> I have never seen this issue outside of perf's frequency mode. But then
> again, that mode is the default and quite useful. Can anyone explain what
> I'm seeing here?
> 
> Is it a bug in the kernel?
> Is it a bug/limitation in the PMU?

I think this also sometimes manifests itself in lack of samples. I.e. for the 
same workload above I now only get a couple dozen samples over a timeframe of 
4s in total:

~~~~~
$ time perf record  .../lab_mandelbrot -b 10
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.041 MB perf.data (131 samples) ]

real    0m5.042s
user    0m4.964s
sys     0m0.054s
~~~~~

Dmesg is silent here, so I don't think it's due to throttling:

~~~~~
/proc/sys/kernel/perf_cpu_time_max_percent
25
/proc/sys/kernel/perf_event_max_contexts_per_stack
8
/proc/sys/kernel/perf_event_max_sample_rate
50400
/proc/sys/kernel/perf_event_max_stack
127
/proc/sys/kernel/perf_event_mlock_kb
516
/proc/sys/kernel/perf_event_paranoid
-1
~~~~~

Rather, it's again the broken cycle counts which probably confuse the 
frequency algorithm in the kernel:

~~~~~
$ perf script
            perf  5678 611709.152451:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
            perf  5678 611709.152455:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
            perf  5678 611709.152456:          8 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
            perf  5678 611709.152457:        203 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
            perf  5678 611709.152459:       5421 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.152461:     144518 cycles:ppp:  ffffffffbb173fe0 
__perf_event__output_id_sample (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.152502:    1902383 cycles:ppp:  ffffffffbb208e00 
unlock_page_memcg (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.153037: 18471563529604 cycles:ppp:      
7f20085ecc58 _dl_map_object_from_fd (/usr/lib/ld-2.25.so)
  lab_mandelbrot  5679 611709.163192:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5679 611709.163195:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5679 611709.163197:          7 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5679 611709.163198:        158 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5679 611709.163200:       3376 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5679 611709.163202:      79849 cycles:ppp:      7f2005e50b10 
__ctype_init (/usr/lib/libc-2.25.so)
  lab_mandelbrot  5679 611709.163233:    1142185 cycles:ppp:  ffffffffbb340a87 
clear_page_erms (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164503:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164505:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164507:         14 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164508:        264 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164510:       5234 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164513:     102113 cycles:ppp:  ffffffffbb10928a 
sys_futex (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164540:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164543:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164545:         12 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164547:        217 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164548:       4154 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.164551:      82262 cycles:ppp:      7f2006a880a2 
pthread_cond_wait@@GLIBC_2.3.2 (/usr/lib/libpthread-2.25.so)

.. this pattern repeats and already looks quite bogus I think ...
.. eventually we hit completely broken values: ...

  lab_mandelbrot  5678 611709.167097:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.167099:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.167100:         17 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.167102:        435 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.167103:      11560 cycles:ppp:  ffffffffbb031e7b 
nmi_handle (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.167107:     306222 cycles:ppp:      7f2006a848ef 
pthread_mutex_lock (/usr/lib/libpthread-2.25.so)
  lab_mandelbrot  5678 611709.167277:    2558928 cycles:ppp:  ffffffffbb1bd9f5 
vmacache_update (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.168034:    2710380 cycles:ppp:      7f2005e9e72a 
_int_free (/usr/lib/libc-2.25.so)
  lab_mandelbrot  5678 611709.168772:    2483393 cycles:ppp:  ffffffffbb220550 
get_empty_filp (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.169450: 23749385103571 cycles:ppp:      
7f20086019d4 strcmp (/usr/lib/ld-2.25.so)
  lab_mandelbrot  5678 611709.190936:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190939:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190941:          9 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190942:        194 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190943:       4357 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190946:     100515 cycles:ppp:  ffffffffbb1086c3 
do_futex (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
  lab_mandelbrot  5678 611709.190975:    1437218 cycles:ppp:      7f2005ea0ef4 
_int_realloc (/usr/lib/libc-2.25.so)
 QDBusConnection  5680 611709.191013:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191015:          1 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191026:         13 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191027:         50 cycles:ppp:  ffffffffbb064504 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191028:       1395 cycles:ppp:  ffffffffbb064506 
native_write_msr (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191029:      38641 cycles:ppp:  ffffffffbb65bce7 
schedule_hrtimeout_range_clock (/lib/modules/4.12.8-2-ARCH/build/vmlinux)
 QDBusConnection  5680 611709.191041:     934282 cycles:ppp:      7f1ffcde715f 
_dbus_first_type_in_signature (/usr/lib/libdbus-1.so.3.14.13)
  lab_mandelbrot  5678 611709.191535:    2815425 cycles:ppp:      7f1ff46dc8ef 
qMax<double> (/ssd2/milian/projects/compiled/kf5/lib/libKF5GuiAddons.so.
5.37.0)
  lab_mandelbrot  5678 611709.192280:    2620652 cycles:ppp:      7f200640230d 
[unknown] (/usr/lib/libm-2.25.so)
  lab_mandelbrot  5678 611709.192992: 23749385195574 cycles:ppp:      
7f1ff644e442 QMap<KEntryKey, KEntry>::const_iterator::const_iterator (/ssd2/
milian/projects/compiled/kf5/lib/libKF5ConfigCore.so.5.37.0)
  lab_mandelbrot  5678 611709.536988:   27340128 cycles:ppp:      565094e15c28 
drawMandelbrot (/ssd/milian/projects/kdab/training-material/addon/profiling/
build/lab_mandelbrot/src/lab_mandelbrot)
  lab_mandelbrot  5678 611709.544397: 2308960570885 cycles:ppp:      
7f20064029fc __hypot_finite (/usr/lib/libm-2.25.so)
  lab_mandelbrot  5678 611709.858996:   19754129 cycles:ppp:      7f2006402a37 
__hypot_finite (/usr/lib/libm-2.25.so)
  lab_mandelbrot  5678 611709.864538: 2308954751998 cycles:ppp:      
7f2006402a77 __hypot_finite (/usr/lib/libm-2.25.so)
  lab_mandelbrot  5678 611710.183972:   14591525 cycles:ppp:      565094e14ce0 
cabs@plt (/ssd/milian/projects/kdab/training-material/addon/profiling/build/
lab_mandelbrot/src/lab_mandelbrot)
  lab_mandelbrot  5678 611710.188004: 2638800790961 cycles:ppp:      
7f20078dacc0 QColor::toRgb (/usr/lib/libQt5Gui.so.5.9.1)
  lab_mandelbrot  5678 611710.495016:   25617507 cycles:ppp:      7f20061cdc6d 
__muldc3 (/usr/lib/libgcc_s.so.1)
  lab_mandelbrot  5678 611710.501962: 2308959251991 cycles:ppp:      
7f2006402a63 __hypot_finite (/usr/lib/libm-2.25.so)
  lab_mandelbrot  5678 611710.815734:   19739740 cycles:ppp:      7f20061cdc5c 
__muldc3 (/usr/lib/libgcc_s.so.1)
  lab_mandelbrot  5678 611710.821164: 2308954745231 cycles:ppp:      
7f2006402b33 __hypot_finite (/usr/lib/libm-2.25.so)
~~~~~

So, is my PMU messed up?
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1995764.jjz3H5TLMa
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwODI4MTQ0MDQzWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgMqkMujh0Is2K3aTaJHiuUbnSl0fP
NQ1CJ7xuckGqAOcwDQYJKoZIhvcNAQEBBQAEggEALFjNylidR7im4M2h5e3hhTcvM/akiCmhfpSg
RwRk8ijYLDiRTYQ7ev2Zgs4yh4Nw3kD2SibJN40gc+2G/iOfnlpRCgE0SuQg7BxRON4wn2pkK0SJ
aAQBqjAYYGPOO9qnAdjtKBfAiQiDmeGegJ0dI25j+AaC1XKKngxm69sS2t95VMPnCfE6v3MIP0bj
UJvT5I8tfibUWCnxK00x7M6+vConYMiueoQPuO0D21WgMUatV7yQtCDoMw8W67b176wD+Ib0apMP
raioTSgXiBWIEZGIts+fY5wbmEn6WpYBAWf7wEieOA4r67CANGWHwaAGLOGKcWdByGdvrZReVTgd
mwAAAAAAAA==


--nextPart1995764.jjz3H5TLMa--
