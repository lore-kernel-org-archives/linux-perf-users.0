Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE41B948
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174954; cv=none; b=DCGgHm+I3uvFQpCtJxKLeLkEtEjHXsVcvk5S1Tfd0jig0FHBySrxj+Ht3C31gzgOmRjs22HhxagFlo1qVj1m1OkrdDL7W8RKZVLx1+eudORZ58mdsq2AhzQwtqrBB/pPJNaHbPvOOcmbwBuXqkzvp9SO4777kVTskgmAGG+Wybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174954; c=relaxed/simple;
	bh=cnW29TIyNgNZIpqLv+5M0m8LWpcmA5BrmSrytT/AMus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGKmN6PZnHa6MxNqew1xyy8HjBBcqpA0i1aqgB8rFRYfckdfcoc3CgJN+7jlYqdijID2/HElUMh0l55u727FLe/Wezjd87bjmifR3bZYOYnl4d2AGdUtaVVlVSlF9GgF2e1BLwIjbkV7IqmduOP1E2cJKiJXO3esdSVOir4GXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsUzFagR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsUzFagR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f61bbb1dfcso8155ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717174950; x=1717779750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beeil7fLNroi82J04ipqvOPAtSIljbSpLfla/IBgUIU=;
        b=dsUzFagR2Li4yDX3bBxuT9wA3Wp0sZslLcik5kJ/8MmXeuxJ36uIYAT87+vGiE8fyO
         n4no8ygmsAo5JrKow8C3DUzYiroRyg+a3vQktj9jLc03E1ChnpQNYfmeiBwdVoIOaoC1
         8UvdTTUV/RZ3S+oyMN55zIEjLrLUxwCvLaVwcrbcDbR5SgaLe7f5LVmjZCfDHgIuvXn9
         6i0J6vJtMfz5TaoE0qGdnay64tQUki5Q7HxTdDz17jlbye6nuXDqfYB34gAwWQ7MwQMg
         4U7ZLb4IFDtS6tdnUTw34/1euAaZPA85dHFpBI+qo0BLjuHc7YDwv2sPJa8ZRlXvanFm
         C7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174950; x=1717779750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beeil7fLNroi82J04ipqvOPAtSIljbSpLfla/IBgUIU=;
        b=om0tQBleYBadqLZoP1tyyYKc2Ot+v9rOpY5pMeBXgfqXs8QuDdm5Zxqpyt+znPHWxU
         DRfEHs/jiDsW2xlQn4P5dG++ALPl3lqd53yrWzTtj0gqrKBCDP2b6h5cJS4A8HETQ0cF
         Ca8hEZIsN79ySvS81g8E6hbs8NcnLWANgBbWd/xnA4bg545X+43GL3DrBTlnGDg8KTbp
         YPQpstjVmhB+CMBk1tpQ3Mzjfq6cbK4cafSFSjmvsdR24pLWbaibvopaifynDcaKRHvv
         90mssq8Wxv5lDPNsegeGGgQ+efS8e8NxuXVldEqdcFjf9b8EnBCezc7Xxzk9wJ74EmOY
         0CZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU6s9CSDy56dHGmZgieP8GSGLyM9Usi8FLiemvAAb1iEl90ydQOS9HEinEpt/QczoegF6jcIj21Zh6em1u+u+qOjHB37BdUYzbru7mfyHq3Q==
X-Gm-Message-State: AOJu0YydaDad7wiNqkAZsla0gIHUBi0pr9Xi84CwuhTdEbf7DOaXEL0s
	LjL8thEPos90YXUS7UA/x+uBi3lEIXuGf8fU/vRaZqKJu31qdj4/MCkclvOpHeIcaRun2Ig6AlN
	C1FtRB+nN6o4/KdLvRIXFsj7uTOIg4aReLHcV
X-Google-Smtp-Source: AGHT+IEy5jZBY1TceKOy7EjTzjnHeQ1QEXwYqqaVCk5hjZ+576RpWBkWuZYqSEfPY5YulKgRgUSJJqTdF0sSHIA+fm8=
X-Received: by 2002:a17:902:d3d5:b0:1f3:49f6:a851 with SMTP id
 d9443c01a7336-1f634372e9dmr2369775ad.10.1717174949625; Fri, 31 May 2024
 10:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zlns_o_IE5L28168@cern.ch>
In-Reply-To: <Zlns_o_IE5L28168@cern.ch>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 May 2024 10:02:18 -0700
Message-ID: <CAP-5=fWyOhZDVQh+dpxQYRfSST6+v1wUTrm7gPwe5LTL_ir52w@mail.gmail.com>
Subject: Re: perf mem segfaults
To: Guilherme Amadio <amadio@cern.ch>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:30=E2=80=AFAM Guilherme Amadio <amadio@cern.ch> w=
rote:
>
> Hi Arnaldo,
>
> I reached some segfaults with perf mem, so I recompiled with DEBUG=3D1
> and am sending below some stack traces. This is all with perf 6.9 for
> now. The first one seems to pass a null pointer as format in frame #5,
> along with a blank mem_loads_name:
>
> gentoo ~ $ gdb --args perf mem record -t load -- root.exe -l -q
> GNU gdb (Gentoo 14.2 vanilla) 14.2
> Reading symbols from perf...
> (gdb) run
> Starting program: /usr/bin/perf mem record -t load -- root.exe -l -q
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib64/libthread_db.so.1".
>
> Program received signal SIGSEGV, Segmentation fault.
> __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
> 67              vmovdqu (%rdi), %ymm2
> (gdb) bt
> #0  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
> #1  0x00007ffff6c982de in __find_specmb (format=3D0x0) at printf-parse.h:=
82
> #2  __printf_buffer (buf=3Dbuf@entry=3D0x7fffffffc760, format=3Dformat@en=
try=3D0x0, ap=3Dap@entry=3D0x7fffffffc880,
>     mode_flags=3Dmode_flags@entry=3D0) at vfprintf-internal.c:649
> #3  0x00007ffff6cb7840 in __vsnprintf_internal (string=3D<optimized out>,=
 maxlen=3D<optimized out>, format=3D0x0,
>     args=3D0x7fffffffc880, mode_flags=3Dmode_flags@entry=3D0) at vsnprint=
f.c:96
> #4  0x00007ffff6cb787f in ___vsnprintf (string=3D<optimized out>, maxlen=
=3D<optimized out>, format=3D<optimized out>,
>     args=3D<optimized out>) at vsnprintf.c:103
> #5  0x00005555557b9391 in scnprintf (buf=3D0x555555fe9320 <mem_loads_name=
> "", size=3D100, fmt=3D0x0)
>     at ../lib/vsprintf.c:21
> #6  0x00005555557b74c3 in perf_pmu__mem_events_name (i=3D0, pmu=3D0x55555=
6832180) at util/mem-events.c:106
> #7  0x00005555557b7ab9 in perf_mem_events__record_args (rec_argv=3D0x5555=
5684c000, argv_nr=3D0x7fffffffca20)
>     at util/mem-events.c:252
> #8  0x00005555555e370d in __cmd_record (argc=3D3, argv=3D0x7fffffffd760, =
mem=3D0x7fffffffcd80) at builtin-mem.c:156
> #9  0x00005555555e49c4 in cmd_mem (argc=3D4, argv=3D0x7fffffffd760) at bu=
iltin-mem.c:514
> #10 0x000055555569716c in run_builtin (p=3D0x555555fcde80 <commands+672>,=
 argc=3D8, argv=3D0x7fffffffd760) at perf.c:349
> #11 0x0000555555697402 in handle_internal_command (argc=3D8, argv=3D0x7ff=
fffffd760) at perf.c:402
> #12 0x0000555555697560 in run_argv (argcp=3D0x7fffffffd59c, argv=3D0x7fff=
ffffd590) at perf.c:446
> #13 0x00005555556978a6 in main (argc=3D8, argv=3D0x7fffffffd760) at perf.=
c:562
> (gdb)
>
> when I record without -t load, then it works. However, when I report
> with --hierarchy, I get a crash as well:
>
> gentoo ~ $ gdb --args perf mem report --stdio --hierarchy
> ...
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055555574b228 in _hist_entry__sym_snprintf (ms=3D0x555558256940, ip=
=3D7237970023832232038, level=3D46 '.',
>     bf=3D0x555558261200 "[.] ", size=3D525, width=3D42) at util/sort.c:37=
6
> 376                     if (sym->type =3D=3D STT_OBJECT) {
> (gdb) bt
> #0  0x000055555574b228 in _hist_entry__sym_snprintf (ms=3D0x555558256940,=
 ip=3D7237970023832232038, level=3D46 '.',
>     bf=3D0x555558261200 "[.] ", size=3D525, width=3D42) at util/sort.c:37=
6
> #1  0x000055555574e148 in hist_entry__daddr_snprintf (he=3D0x5555568d66c0=
, bf=3D0x555558261200 "[.] ", size=3D525, width=3D42)
>     at util/sort.c:1384
> #2  0x0000555555750acb in __sort__hpp_entry (fmt=3D0x555556844a00, hpp=3D=
0x7fffffffa550, he=3D0x5555568d66c0)
>     at util/sort.c:2505
> #3  0x0000555555829cce in hist_entry__hierarchy_fprintf (he=3D0x5555568d6=
6c0, hpp=3D0x7fffffffa550, hists=3D0x555556818270,
>     fp=3D0x7ffff6df25c0 <_IO_2_1_stdout_>) at ui/stdio/hist.c:517
> #4  0x000055555582a039 in hist_entry__fprintf (he=3D0x5555568d66c0, size=
=3D525, bf=3D0x555558261200 "[.] ", bfsz=3D525,
>     fp=3D0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=3Dtrue) at u=
i/stdio/hist.c:598
> #5  0x000055555582adf5 in hists__fprintf (hists=3D0x555556818270, show_he=
ader=3Dtrue, max_rows=3D0, max_cols=3D0, min_pcnt=3D0,
>     fp=3D0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=3Dtrue) at u=
i/stdio/hist.c:868
> #6  0x00005555555b2442 in evlist__tty_browse_hists (evlist=3D0x55555682e0=
00, rep=3D0x7fffffffa930,
>     help=3D0x555556924240 "Tip: System-wide collection from all CPUs: per=
f record -a") at builtin-report.c:581
> #7  0x00005555555b28c0 in report__browse_hists (rep=3D0x7fffffffa930) at =
builtin-report.c:684
> #8  0x00005555555b3e7f in __cmd_report (rep=3D0x7fffffffa930) at builtin-=
report.c:1141
> #9  0x00005555555b668a in cmd_report (argc=3D0, argv=3D0x555556806100) at=
 builtin-report.c:1800
> #10 0x00005555555e42d2 in report_events (argc=3D3, argv=3D0x7fffffffd790,=
 mem=3D0x7fffffffcdb0) at builtin-mem.c:374
> #11 0x00005555555e4a1c in cmd_mem (argc=3D3, argv=3D0x7fffffffd790) at bu=
iltin-mem.c:516
> #12 0x000055555569716c in run_builtin (p=3D0x555555fcde80 <commands+672>,=
 argc=3D4, argv=3D0x7fffffffd790) at perf.c:349
> #13 0x0000555555697402 in handle_internal_command (argc=3D4, argv=3D0x7ff=
fffffd790) at perf.c:402
> #14 0x0000555555697560 in run_argv (argcp=3D0x7fffffffd5cc, argv=3D0x7fff=
ffffd5c0) at perf.c:446
> #15 0x00005555556978a6 in main (argc=3D4, argv=3D0x7fffffffd790) at perf.=
c:562
> (gdb)

Maybe this relates to the cleanup in:
https://lore.kernel.org/all/20240123185036.3461837-1-kan.liang@linux.intel.=
com/
I also did some smaller cleanup trying to make sanitizers happy:
https://lore.kernel.org/all/20240507183545.1236093-1-irogers@google.com/

> The other thing I noticed as of recently is that --hierarchy sometimes
> fails to correctly show stacks:
>
> $ sudo perf record -a --off-cpu -g -- sleep 10
> gentoo ~ $ sudo perf report --stdio --no-children --percent-limit 5 -c sw=
apper
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> # comm: swapper
> #
> # Total Lost Samples: 0
> #
> # Samples: 17K of event 'cycles:P'
> # Event count (approx.): 6796556494
> #
> # Overhead  Shared Object                        Symbol
> # ........  ...................................  ........................=
.................
> #
>     39.71%  [kernel.kallsyms]                    [k] io_idle
>             |
>              --32.55%--io_idle
>                        acpi_idle_enter
>                        cpuidle_enter_state
>                        cpuidle_enter
>                        call_cpuidle
>                        do_idle
>                        cpu_startup_entry
>                        |
>                         --31.71%--0xffffffffa18d046c
>                                   secondary_startup_64
>
> # Samples: 525  of event 'offcpu-time'
> # Event count (approx.): 294273818205
> #
> # Overhead  Shared Object  Symbol
> # ........  .............  ......
> #
>
> $ sudo perf report --stdio --no-children --percent-limit 5 -c swapper --h=
ierarchy
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> # comm: swapper
> #
> # Total Lost Samples: 0
> #
> # Samples: 17K of event 'cycles:P'
> # Event count (approx.): 6796556494
> #
> #       Overhead  Command / Shared Object / Symbol
> # ..............  ...............................................
> #
>     47.61%        swapper
>        47.58%        [kernel.kallsyms]
>           39.71%        [k] io_idle
>             |
>              --32.55%--0xffffffffa36504b3
>                        0xffffffffa3650837
>                        0xffffffffa364f9a4
>                        0xffffffffa2e63049
>                        0xffffffffa1a36d42
>                        0xffffffffa1a3c963
>                        0xffffffffa1a3cbc9
>                        |
>                         --31.71%--0xffffffffa18d046c
>                                   0xffffffffa189aefd
>
>
>
> # Samples: 525  of event 'offcpu-time'
> # Event count (approx.): 294273818205
> #
> #       Overhead  Command / Shared Object / Symbol
> # ..............  ................................
> #
>
> So the off-cpu stacks are not shown, and with --hierarchy symbol
> resolution seems to not work anymore, which is somewhat strange.

Perhaps this is another instance of this regression I introduced:
https://lore.kernel.org/linux-perf-users/CAM9d7cjCL2=3Dh6jwQ_cM24JqT2Um=3Dz=
fWtJYdQbiy6BAcktyudnQ@mail.gmail.com/
Apologies if it is.

Thanks,
Ian

> This is the hardware I'm using:
>
> gentoo ~ $ lscpu | head
> Architecture:                         x86_64
> CPU op-mode(s):                       32-bit, 64-bit
> Address sizes:                        43 bits physical, 48 bits virtual
> Byte Order:                           Little Endian
> CPU(s):                               32
> On-line CPU(s) list:                  0-31
> Vendor ID:                            AuthenticAMD
> Model name:                           AMD Ryzen 9 3950X 16-Core Processor
> CPU family:                           23
> Model:                                113
>
> It's known to be buggy with the NMI interrupts, which still causes dmesg
> to show strange messages like shown below:
>
> [286943.722814] perf[1010806]: segfault at 0 ip 00007f1dc277ab43 sp 00007=
ffdcd302cd8 error 4 in libc.so.6[7f1dc2666000+134000] likely on CPU 5 (core=
 5, socket 0)
> [286943.722827] Code: f8 77 c3 0f 1f 40 00 f3 0f 1e fa c5 f9 6e c6 89 f8 =
25 ff 0f 00 00 c4 e2 7d 78 c0 c5 f1 ef c9 3d e0 0f 00 00 0f 87 8d 01 00 00 =
<c5> fe 6f 17 c5 fd 74 da c5 f5 74 d2 c5 ed eb db c5 fd d7 c3 85 c0
> [288940.208010] traps: perf[1111710] general protection fault ip:55c0999f=
b228 sp:7ffd96023f00 error:0 in perf[55c09983d000+31d000]
> [289114.949941] perf: interrupt took too long (2511 > 2500), lowering ker=
nel.perf_event_max_sample_rate to 79600
> [289115.070561] WARNING: kernel stack frame pointer at 00000000189df501 i=
n swapper/20:0 has bad value 000000005dc8ab50
> [289115.070568] unwind stack type:0 next_sp:0000000000000000 mask:0x6 gra=
ph_idx:0
> [289115.070570] 00000000b2bdf5fc: ffffab26805f4ba0 (0xffffab26805f4ba0)
> [289115.070575] 000000008d353c11: ffffffffa365c2d2 (_raw_spin_lock_irqsav=
e+0x52/0x70)
> [289115.070580] 000000002fccc0bb: ffff9ca4057d5be8 (0xffff9ca4057d5be8)
> [289115.070582] 00000000078840a2: 0000000000000000 ...
> [289115.070583] 000000002c7f6250: ffffab26805f4bb8 (0xffffab26805f4bb8)
> [289115.070585] 00000000afe09fb3: ffffffffc03eef12 (os_acquire_spinlock+0=
x12/0x30 [nvidia])
> [289115.070844] 000000005d608f8f: ffff9ca4057d5bc8 (0xffff9ca4057d5bc8)
> [289115.070846] 00000000189df501: ffff9ca4297ade60 (0xffff9ca4297ade60)
> [289115.070848] 00000000b4c4e61a: ffffffffc0cfd120 (_nv044096rm+0x10/0x20=
 [nvidia])
> [289115.071189] 00000000e2a64928: 0000000000000000 ...
>
> and later (the usual "Dazed and confused ones"):
>
> [289115.075161] INFO: NMI handler (perf_ibs_nmi_handler) took too long to=
 run: 4.605 msecs
> [289115.075166] perf: interrupt took too long (38058 > 3138), lowering ke=
rnel.perf_event_max_sample_rate to 5200
> [289117.772464] Uhhuh. NMI received for unknown reason 3c on CPU 16.
> [289117.772468] Dazed and confused, but trying to continue
>
> I wonder also if the nvidia drivers taint have anything to do with this.
> I'd appreciate your insights in helping to debug this last problem, as I
> couldn't find out why it's happening. I'm running Linux 6.9.0.
>
> I hope this is enough information to at least fix the segfaults, but if
> you need any extra information, please let me know.
>
> Best regards,
> -Guilherme
>
>
