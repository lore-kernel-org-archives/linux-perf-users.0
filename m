Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF5261567;
	Tue, 11 Feb 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296924; cv=none; b=KW20q59o80OC3CrvGRZS7crxZBe0t4NgAsJFgLgflca3uwVnhNAChvETr5H7oW68UITWjVfJeZ0jGHP80H7rjZ+5X/WTLpWx8wMggahqOeBYi7lbwt6JclADRXii4nYu6T79+x/Qyqr/BlX94SXGrZ+8FOfQe+mQ36qc5fPbkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296924; c=relaxed/simple;
	bh=9q1j9mbK6taSlO9Ko0itXO+3nwGf6IaO51i+WTz7fxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szsxc35vNegO8F1UGe8rOTscCmyyT3TguRcFJAkdaD79pp0+AunX8ux2zJA/WRLYgyRayvTdE02h0F8Vn6XOMvYNnaKoQahj04FynHiZdKOCiBYFPTGL9wejJM8wP9oDUa1zwDHlt9CsGrfP3g92hE7P6zspolYXeCdFBy5eVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Tg4Kqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Tg4Kqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6DAC4CEDD;
	Tue, 11 Feb 2025 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296924;
	bh=9q1j9mbK6taSlO9Ko0itXO+3nwGf6IaO51i+WTz7fxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4Tg4KqplSiGhbtaGLoG4jctttHxqUsEUQoZIzH3meCwihdJnclA5DEn9U4banEMr
	 /1UHRYUoCEfZoH76qCnVmJaLeWIMp12K0WVs+GLtH90jegM0X2PblqVNXnuf74njfV
	 eCg2L/ONWgewOgYZ8thZsQIfZfyR4TBmpp8T33wVqAhYT86W7CZom6xhCpkmNf7t1q
	 ueMJV2OuC78KNSKtp5NvTgBbMHOSxkzPB1XU6PhPx1NgjK+M8/gKEGlUEW5LHidnKP
	 AOupEPGTNq913L4KYt/Yp045XCLudBK/R2Y45gt/TCIkPCbDhxWy+f8+8j7rccXEIx
	 3HRyHDLNhZXPw==
Date: Tue, 11 Feb 2025 19:02:01 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <Z6uQmcLllm1wR3-h@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <Z2CJW0vFT005gmIe@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2CJW0vFT005gmIe@google.com>

On Mon, Dec 16, 2024 at 12:11:07PM -0800, Namhyung Kim wrote:
> On Sun, Dec 15, 2024 at 10:12:10AM -0800, Howard Chu wrote:
> > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323
> > 
> > Currently, off-cpu samples are dumped when perf record is exiting. This
> > results in off-cpu samples being after the regular samples. This patch
> > series makes possible dumping off-cpu samples on-the-fly, directly into
> > perf ring buffer. And it dispatches those samples to the correct format
> > for perf.data consumers.
> > 
> > Before:
> > ```
> >      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
> >      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
> >      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
> > 
> > sshd  708098 [000] 18446744069.414584:     286392 offcpu-time: 
> > 	    79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> > 	    585690935cca [unknown] (/usr/bin/sshd)
> > ```
> > 
> > After:
> > ```
> >             perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
> >             perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
> >          swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >          swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time: 
> > 	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> > 	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> > 	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> > 	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> > 	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> > 	    7fff24e862d8 [unknown] ([unknown])
> > 
> > 
> >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time: 
> > 	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> > 	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> > 	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
> > 	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
> > 	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> > 	    7fff24e862d8 [unknown] ([unknown])
> > 
> > 
> >          swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >      dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> > ```

So I'm trying to reproduce your results, with:

root@number:~# perf record --off-cpu sleep 0.6
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~# perf trace -e *sleep sleep 0.6
     0.000 (600.137 ms): sleep/466769 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 600000000 }, rmtp: 0x7ffe024dea30) = 0
root@number:~#

So a simple test that crosses that 500ms threshold and thus should
produce an offcpu-time sample, right?

root@number:~# perf record --off-cpu sleep 0.6
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~# perf evlist
cpu_atom/cycles/P
cpu_core/cycles/P
offcpu-time
dummy:u
root@number:~#

root@number:~# perf script | grep offcpu
root@number:~#

What I have:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline -11
cd59081880e89df8 (HEAD -> perf-tools-next) perf test: Add direct off-cpu test
56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
2bc05b02743b50a7 perf script: Display off-cpu samples correctly
bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
eca732cc42d20266 perf evsel: Assemble offcpu samples
74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
357b965deba9fb71 (perf-tools-next/perf-tools-next) perf stat: Changes to event name uniquification
⬢ [acme@toolbox perf-tools-next]$

The only change was the one I mentioned about 'struct __stack'
replacing 'struct stack' to avoid the clash with the vmlinux.h generated
using GEN_VMLINUX_H=1.

Perhaps that is because my test is not being system wide, if I use '-a'
we get:

root@number:~# perf record --off-cpu -a sleep 0.6
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.868 MB perf.data (443 samples) ]
root@number:~# perf script | grep offcpu
         firefox    4010 [004] 16746.571035:  518930922       offcpu-time: 
           sleep  466955 [019] 16746.629875:  600279888       offcpu-time: 
            perf  466953 [027] 16746.630541:  601731496       offcpu-time: 
  IPC I/O Parent    4039 [000] 18446744069.414584:      20781       offcpu-time: 
 TaskCon~ller #3    4454 [000] 18446744069.414584:     117724       offcpu-time: 
 Isolated Servic    4253 [000] 18446744069.414584:  387311029       offcpu-time: 
  IPC I/O Parent    4039 [000] 18446744069.414584:  520075456       offcpu-time: 
           Timer    4040 [000] 18446744069.414584:  581156755       offcpu-time: 
           Timer    4380 [000] 18446744069.414584:   22520305       offcpu-time: 
 sqldb:c~lite #6    4327 [000] 18446744069.414584:    2073583       offcpu-time: 
 Isolated Web Co  156033 [000] 18446744069.414584:      23277       offcpu-time: 
 sqldb:c~lite #6    4327 [000] 18446744069.414584:      24974       offcpu-time: 
     dbus-broker    2526 [000] 18446744069.414584:    1175447       offcpu-time: 
 IPDL Background    4043 [000] 18446744069.414584:      12055       offcpu-time: 
 glean.dispatche    4037 [000] 18446744069.414584:      62321       offcpu-time: 
          podman   12139 [000] 18446744069.414584:  502656763       offcpu-time: 
     gnome-shell    2709 [000] 18446744069.414584:  579190477       offcpu-time: 
          podman    3936 [000] 18446744069.414584:   60777801       offcpu-time: 
      KMS thread    2739 [000] 18446744069.414584:   14578641       offcpu-time: 
   IPC I/O Child    7113 [000] 18446744069.414584:  386343655       offcpu-time: 
    WaylandProxy    4027 [000] 18446744069.414584:   46989879       offcpu-time: 
           Timer  156048 [000] 18446744069.414584:  404662799       offcpu-time: 
  URL Classifier    4234 [000] 18446744069.414584:      55337       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:      57229       offcpu-time: 
 Isolated Web Co    4261 [000] 18446744069.414584:      26671       offcpu-time: 
          podman   12130 [000] 18446744069.414584:  450853233       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:      56800       offcpu-time: 
          podman    3951 [000] 18446744069.414584:  502100761       offcpu-time: 
          podman   12131 [000] 18446744069.414584:  501954466       offcpu-time: 
           Timer    4306 [000] 18446744069.414584:  360125199       offcpu-time: 
 RemoteLzyStream    4230 [000] 18446744069.414584:     172647       offcpu-time: 
 TaskCon~ller #1    4452 [000] 18446744069.414584:      38083       offcpu-time: 
 Isolated Web Co  156033 [000] 18446744069.414584:  496574141       offcpu-time: 
   Socket Thread    4042 [000] 18446744069.414584:  295030041       offcpu-time: 
 IPDL Background    4043 [000] 18446744069.414584:      13990       offcpu-time: 
 Inotify~tThread    7430 [000] 18446744069.414584:  300841349       offcpu-time: 
           Timer    7186 [000] 18446744069.414584:     117536       offcpu-time: 
 Backgro~ol #163  466653 [000] 18446744069.414584:      29312       offcpu-time: 
 Isolated Web Co    7107 [000] 18446744069.414584:  418466228       offcpu-time: 
 Isolated Web Co  156033 [000] 18446744069.414584:      22049       offcpu-time: 
   Socket Thread    4295 [000] 18446744069.414584:  309685524       offcpu-time: 
          podman   12130 [000] 18446744069.414584:   60960566       offcpu-time: 
   Socket Thread    4042 [000] 18446744069.414584:       9726       offcpu-time: 
 glean.dispatche    4037 [000] 18446744069.414584:      30560       offcpu-time: 
 TaskCon~ller #0    4451 [000] 18446744069.414584:    3661284       offcpu-time: 
  URL Classifier    4234 [000] 18446744069.414584:      18112       offcpu-time: 
 Isolated Web Co    4261 [000] 18446744069.414584:  380745777       offcpu-time: 
   IPC I/O Child    7039 [000] 18446744069.414584:   54365677       offcpu-time: 
   IPC I/O Child    4292 [000] 18446744069.414584:  386687065       offcpu-time: 
 glean.dispatche    4037 [000] 18446744069.414584:      48091       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:  570509826       offcpu-time: 
          podman    3936 [000] 18446744069.414584:  451176929       offcpu-time: 
 Isolated Web Co    7034 [000] 18446744069.414584:   57005742       offcpu-time: 
 gnome-terminal-    3583 [000] 18446744069.414584:   97027967       offcpu-time: 
 sqldb:c~lite #6    4327 [000] 18446744069.414584:      27118       offcpu-time: 
 TaskCon~ller #1    4452 [000] 18446744069.414584:      20008       offcpu-time: 
  IPC I/O Parent    4039 [000] 18446744069.414584:      58205       offcpu-time: 
           Timer  157669 [000] 18446744069.414584:     180649       offcpu-time: 
   IPC I/O Child    4265 [000] 18446744069.414584:  387442919       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:     215006       offcpu-time: 
          podman    3949 [000] 18446744069.414584:  502715978       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:      94719       offcpu-time: 
           gdbus    4032 [000] 18446744069.414584:    1330625       offcpu-time: 
 Worker Launcher    4348 [000] 18446744069.414584:   83393104       offcpu-time: 
   Socket Thread    4042 [000] 18446744069.414584:      48713       offcpu-time: 
 IPDL Background    4043 [000] 18446744069.414584:  386560332       offcpu-time: 
           Timer    7123 [000] 18446744069.414584:  422634111       offcpu-time: 
 Isolated Web Co    4358 [000] 18446744069.414584:   18063623       offcpu-time: 
 glean.dispatche    4037 [000] 18446744069.414584:  302249112       offcpu-time: 
  IPC I/O Parent    4039 [000] 18446744069.414584:      16204       offcpu-time: 
 Inotify~tThread    7430 [000] 18446744069.414584:  300780100       offcpu-time: 
 RemoteLzyStream    4230 [000] 18446744069.414584:      14778       offcpu-time: 
      DOM Worker   10133 [000] 18446744069.414584:     331946       offcpu-time: 
  URL Classifier    4234 [000] 18446744069.414584:    5003953       offcpu-time: 
           gdbus    2729 [000] 18446744069.414584:     331119       offcpu-time: 
 TaskCon~ller #2    4453 [000] 18446744069.414584:     125448       offcpu-time: 
         firefox    4010 [000] 18446744069.414584:      40894       offcpu-time: 
   IPC I/O Child  156038 [000] 18446744069.414584:    4079439       offcpu-time: 
      DOM Worker   10228 [000] 18446744069.414584:    3397046       offcpu-time: 
root@number:~# 

With 'offcpu-time' samples intermixed with the other cycles events:

<SNIP>
 Isolated Web Co    4261 [010] 16746.570827:     287731 cpu_core/cycles/P:  ffffffff8b145b24 __get_user_nocheck_8+0x4 ([kernel.kallsyms])
 Isolated Web Co    7107 [006] 16746.570834:     235654 cpu_core/cycles/P:      7f08bf336592 pthread_mutex_trylock@@GLIBC_2.34+0xe2 (/usr/lib64/libc.so.6)
         firefox    4010 [004] 16746.571035:  518930922       offcpu-time: 
            7f2dab89eda9 dlsym@@GLIBC_2.34+0x59 (/usr/lib64/libc.so.6)
            7f2dab8a17f9 pthread_cond_broadcast@@GLIBC_2.3.2+0x399 (/usr/lib64/libc.so.6)
            556309ec5bca mozilla::detail::ConditionVariableImpl::wait(mozilla::detail::MutexImpl&)+0xa (/usr/lib64/firefox/firefox)

         swapper       0 [019] 16746.571151:     315218 cpu_atom/cycles/P:  ffffffff8adf4ad0 menu_select+0x1b0 ([kernel.kallsyms])
<SNIP>
 Isolated Web Co    7107 [010] 16746.607631:     288723 cpu_core/cycles/P:      34d114ccce4a [unknown] (/tmp/perf-7107.map)
         swapper       0 [008] 16746.622828:     136175 cpu_core/cycles/P:  ffffffff8b213d7a intel_idle+0x6a ([kernel.kallsyms])
           Timer    4306 [008] 16746.622977:     129681 cpu_core/cycles/P:  ffffffff8b134e46 rb_erase+0x46 ([kernel.kallsyms])
         swapper       0 [000] 16746.623018:     298081 cpu_core/cycles/P:  ffffffff8a13d3ea update_rq_clock+0x7a ([kernel.kallsyms])
         swapper       0 [019] 16746.629839:     256701 cpu_atom/cycles/P:  ffffffff8a148455 __dequeue_entity+0x5 ([kernel.kallsyms])
           sleep  466955 [019] 16746.629875:  600279888       offcpu-time: 
            7f6feb8bf497 clock_nanosleep@GLIBC_2.2.5+0x27 (/usr/lib64/libc.so.6)
            5608d1601a9f [unknown] (/usr/bin/sleep)
            7f6feb805088 __libc_start_call_main+0x78 (/usr/lib64/libc.so.6)
            7f6feb80514b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
            5608d1601c05 [unknown] (/usr/bin/sleep)

           sleep  466955 [006] 16746.630223:     225700 cpu_core/cycles/P:  ffffffff8a40ec5a folio_remove_rmap_ptes+0x1a ([kernel.kallsyms])
         :466955  466955 [006] 16746.630442:     225700 cpu_core/cycles/P:  ffffffff8b1387eb timerqueue_add+0x3b ([kernel.kallsyms])
            perf  466953 [027] 16746.630541:  601731496       offcpu-time: 
            7f818451c1fd __poll+0x4d (/usr/lib64/libc.so.6)
                  49606e fdarray__poll+0x2e (/home/acme/bin/perf)
                  429eed __cmd_record.constprop.0+0x18ad (/home/acme/bin/perf)
                  42c77e cmd_record+0xd9e (/home/acme/bin/perf)
                  495700 run_builtin+0x70 (/home/acme/bin/perf)
                  495a1b handle_internal_command+0xab (/home/acme/bin/perf)
                  413473 main+0x2f3 (/home/acme/bin/perf)
            7f8184438088 __libc_start_call_main+0x78 (/usr/lib64/libc.so.6)
            7f818443814b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
                  413ac5 _start+0x25 (/home/acme/bin/perf)

            perf  466953 [000] 16746.630831:     298081 cpu_core/cycles/P:  ffffffff8b40012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
         swapper       0 [019] 16746.630985:     250096 cpu_atom/cycles/P:  ffffffff8b213d7a intel_idle+0x6a ([kernel.kallsyms])
            perf  466953 [010] 16746.632045:     286467 cpu_core/cycles/P:  ffffffff8a1c3f21 __rcu_read_lock+0x11 ([kernel.kallsyms])
  IPC I/O Parent    4039 [000] 18446744069.414584:      20781       offcpu-time: 
            7f2dab89f000 __GI___pthread_enable_asynccancel+0x20 (/usr/lib64/libc.so.6)
            556309ebede4 moz_xmalloc+0x104 (/usr/lib64/firefox/firefox)
           3bbdf3d834830 [unknown] ([unknown])


And if I install the 'coreutils' debuginfo I get the sleep backtraces
resolved, nice, but again only when I'm running in system wide (-a)
mode.

 Isolated Web Co    7167 [008] 16915.115432:     188682 cpu_core/cycles/P:      7fe85f558260 nsBaseHashtable<nsStringHashKey, mozilla::UniquePtr<nsBaseHashtable<nsIntegralHashKey<unsigned lo>
         swapper       0 [013] 16915.126739:     120783 cpu_core/cycles/P:  ffffffff8a15221d enqueue_task_fair+0x22d ([kernel.kallsyms])
           sleep  467147 [013] 16915.126780:  600336127       offcpu-time: 
            7ff010611497 clock_nanosleep@GLIBC_2.2.5+0x27 (/usr/lib64/libc.so.6)
            563f045a3a9f main+0x4af (/usr/bin/sleep)
            7ff010557088 __libc_start_call_main+0x78 (/usr/lib64/libc.so.6)
            7ff01055714b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
            563f045a3c05 _start+0x25 (/usr/bin/sleep)

           sleep  467147 [013] 16915.126861:     120783 cpu_core/cycles/P:  ffffffff8a3ef391 unmap_page_range+0x661 ([kernel.kallsyms])
           sleep  467147 [013] 16915.126973:     139106 cpu_core/cycles/P:  ffffffff8a3a5b4d folios_put_refs+0x8d ([kernel.kallsyms])
         swapper       0 [013] 16915.127102:     160383 cpu_core/cycles/P:  ffffffff8a14b5c4 sched_balance_update_blocked_averages+0xb4 ([kernel.kallsyms])

When running just one workload:

root@number:~# for a in `seq 10` ; do perf record --off-cpu sleep 1s ; perf script | grep offcpu-time ; done
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (13 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (16 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (14 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (12 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~#

Have you tested it like that? Is this a known issue/current limitation?

I'm reading the patches to see I understand this better.

- Arnaldo
