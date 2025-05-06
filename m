Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19961283FDB;
	Tue,  6 May 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550574; cv=none; b=ODK4vE+4Ei6ErbZVQQWOnCe/YcWcxbLeAE4C4VKqV9c2xNfwjGZh5lULNhbLGahlAgEK0AgfNGS9wFjFOa373N/IdOw4mZ26qQLu0evSkrEJMnU83zLZgf8WkZ1L5AWUhX8FQqnqZ0rtqAuwrNnWBXj81f+m5wz/a9wtoIuiSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550574; c=relaxed/simple;
	bh=QDLiiAGPC2ixhvnRZpoOVhekmYXNYKxGNbWRiAZ788I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsZEggRAoLv1twdsywNlj1PLuJNr9a3jBeuqSVapYqc5ThLJ3fYywtaEGIbR51mFynKRtptpB0DsF5wvJq+mCAfrvyLXsLX3DEdnMypOkteY+QSFMAYJwuS/QaDjuliMUDy/YKAIrK0H2ZoZmyOnnc1pxrL2jL8nalPQnFm2kGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVZZFudr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVZZFudr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA1C4CEE4;
	Tue,  6 May 2025 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746550573;
	bh=QDLiiAGPC2ixhvnRZpoOVhekmYXNYKxGNbWRiAZ788I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVZZFudr19H4RudOXt/Mu0sb/cx3/ChaEMA52LX0wg89ZrLDxo7YI4KFU0e8Zpj0a
	 Nam1OoG2eMVgVjGookV9sPswECMxbyFmNaumpFMz0fzpJJHStReYW42op2IRDKVyuk
	 MGgZwKZx+/PADV8NOk1C9W6t4YQza/skbdhYjK5pWd9dTJSrUZ/QD3shBVW9y+qAhD
	 ytO1v1vGhQRGOKMivW/xFWFQ+R9NIwLRNB/ewRPsmWQQG8nhJnKBHEK6t/RIBCIDMG
	 ITb6vuYALfQQ82vXjFfLdxJS+15qgtSzwuqRNUZUVYswZ4dR6S8BqMQ8B/TPwlLTjQ
	 H7e3QhaPPgoBw==
Date: Tue, 6 May 2025 13:56:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf top: populate PMU capabilities data in perf_env
Message-ID: <aBo_KvXDmsequWng@x1>
References: <20250501184143.873536-1-thomas.falcon@intel.com>
 <CAP-5=fXorDgm-oJS9kC6cxCEvS9-Gz5Uh_5V4MtzCYV3pXAxCA@mail.gmail.com>
 <6732ac7aad986d682c6a36db5d435b113c7527d9.camel@intel.com>
 <4aa48d010cdaa91355f9f77b1c3a1eefc4b1becb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa48d010cdaa91355f9f77b1c3a1eefc4b1becb.camel@intel.com>

On Tue, May 06, 2025 at 04:09:37PM +0000, Falcon, Thomas wrote:
> On Thu, 2025-05-01 at 20:46 +0000, Falcon, Thomas wrote:
> > On Thu, 2025-05-01 at 13:00 -0700, Ian Rogers wrote:
> > > On Thu, May 1, 2025 at 11:42 AM Thomas Falcon <thomas.falcon@intel.com> wrote:
> > > > Calling perf top with brach filters enabled on Intel hybrid CPU's
> > > > with branch counter event logging support results in a segfault.

> > > > $ ./perf top -e '{cpu_core/cpu-cycles/,cpu_core/event=0xc6,umask=0x3,\
> > > >         frontend=0x11,name=frontend_retired_dsb_miss/}' -j any,counter
> > > > perf: Segmentation fault
> > > > -------- backtrace --------
> > > > ./perf() [0x55f460]
> > > > /lib64/libc.so.6(+0x1a050) [0x7fd8be227050]
> > > > ./perf() [0x57b4a7]
> > > > ./perf() [0x561e5a]
> > > > ./perf() [0x604a81]
> > > > ./perf() [0x4395b5]
> > > > ./perf() [0x601732]
> > > > ./perf() [0x439bc1]
> > > > ./perf() [0x5d35b3]
> > > > ./perf() [0x43936c]
> > > > /lib64/libc.so.6(+0x70ba8) [0x7fd8be27dba8]
> > > > /lib64/libc.so.6(+0xf4b8c) [0x7fd8be301b8c]

> > Hi Ian, thanks for reviewing.

> > > Thanks Thomas. Could you generate this backtrace in GDB? I did write a
> > > patch to symbolize backtraces like this:
> > > https://lore.kernel.org/lkml/20250313052952.871958-2-irogers@google.com/
> > > Sadly without any reviewed tags and unmerged - the code calls routines
> > > that malloc so it isn't strictly sound if say the backtrace was needed
> > > from a SEGV in the malloc implementation, it is nicely
> > > self-referencing the perf APIs, ..

> > Sorry about that, here is the backtrace I'm seeing when running the perf top command in gdb:

> > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.

> > [Switching to Thread 0x7fffcb7fe6c0 (LWP 812169)]
> > 0x000000000057b4a7 in perf_env.find_br_cntr_info ()
> > (gdb) backtrace
> > #0  0x000000000057b4a7 in perf_env.find_br_cntr_info ()
> > #1  0x0000000000561e5a in addr_map_symbol.account_cycles ()
> > #2  0x0000000000604a81 in hist.account_cycles ()
> > #3  0x00000000004395b5 in hist_iter.top_callback ()
> > #4  0x0000000000601732 in hist_entry_iter.add ()
> > #5  0x0000000000439bc1 in deliver_event ()
> > #6  0x00000000005d35b3 in __ordered_events__flush ()
> > #7  0x000000000043936c in process_thread ()
> > #8  0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> > #9  0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
 
> Sorry, let me try this again...
 
> Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffcf7fe6c0 (LWP 940046)]
> perf_env__find_br_cntr_info (env=0xf328c0 <perf_env>, nr=0x0, width=0x7fffcf7fd2c0) at util/env.c:653
> 653			*width = env->cpu_pmu_caps ? env->br_cntr_width :
> (gdb) bt
> #0  perf_env__find_br_cntr_info (env=0xf328c0 <perf_env>, nr=0x0, width=0x7fffcf7fd2c0) at util/env.c:653
> #1  0x00000000005ad829 in symbol__account_br_cntr (branch=0x7fffd11f9c00, evsel=0xfae480, offset=20, br_cntr=4) at util/annotate.c:345
> #2  0x00000000005ada8b in symbol__account_cycles (addr=5580436, start=5580433, sym=0x7fffd00d3010, cycles=1, evsel=0xfae480, br_cntr=4) at util/annotate.c:389
> #3  0x00000000005adc06 in addr_map_symbol__account_cycles (ams=0x7fffd17b1e20, start=0x7fffd17b1f00, cycles=1, evsel=0xfae480, br_cntr=4) at util/annotate.c:422
> #4  0x0000000000688ab4 in hist__account_cycles (bs=0x10cbaa8, al=0x7fffcf7fd540, sample=0x7fffcf7fd760, nonany_branch_mode=false, total_cycles=0x0, evsel=0xfae480) at util/hist.c:2774
> #5  0x0000000000446004 in hist_iter__top_callback (iter=0x7fffcf7fd590, al=0x7fffcf7fd540, single=true, arg=0x7fffffff9de0) at builtin-top.c:737
> #6  0x0000000000684d2a in hist_entry_iter__add (iter=0x7fffcf7fd590, al=0x7fffcf7fd540, max_stack_depth=127, arg=0x7fffffff9de0) at util/hist.c:1291
> #7  0x00000000004464fe in perf_event__process_sample (tool=0x7fffffff9de0, event=0x10cba70, evsel=0xfae480, sample=0x7fffcf7fd760, machine=0x105ec68) at builtin-top.c:845
> #8  0x0000000000447523 in deliver_event (qe=0x7fffffffa0f8, qevent=0x10cdd60) at builtin-top.c:1211
> #9  0x0000000000648aff in do_flush (oe=0x7fffffffa0f8, show_progress=false) at util/ordered-events.c:245
> #10 0x0000000000648e56 in __ordered_events__flush (oe=0x7fffffffa0f8, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> #11 0x0000000000648f40 in ordered_events__flush (oe=0x7fffffffa0f8, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> #12 0x0000000000447097 in process_thread (arg=0x7fffffff9de0) at builtin-top.c:1120
> #13 0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

I'll test on a 14700 later today, but on this one it is working:

root@x1:~# grep -m1 "model name" /proc/cpuinfo 
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~# perf -vv
perf version 6.15.rc2.g8feafba59c51
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
root@x1:~# perf top -e '{cpu_core/cpu-cycles/,cpu_core/event=0xc6,umask=0x3,frontend=0x11,name=frontend_retired_dsb_miss/}' -j any,counte

With what is in perf-tools-next/perf-tools-next:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -10
8feafba59c510be3 (HEAD -> perf-tools-next, x1/perf-tools-next, x1/HEAD) perf test: Add direct off-cpu tests
9557c000768741bb perf record --off-cpu: Add --off-cpu-thresh option
74069a01609ef0f4 perf record --off-cpu: Dump the remaining PERF_SAMPLE_ in sample_type from BPF's stack trace map
8ae7a5769b0a3ac2 perf script: Display off-cpu samples correctly
7de1a87f1ee75743 perf record --off-cpu: Disable perf_event's callchain collection
7f8f56475d585117 perf evsel: Assemble off-cpu samples
d6948f2af24e04ea perf record --off-cpu: Dump off-cpu samples in BPF
282c195906c76ddf perf record --off-cpu: Preparation of off-cpu BPF program
0f72027bb9fb77a2 perf record --off-cpu: Parse off-cpu event
671e943452b18001 perf evsel: Expose evsel__is_offcpu_event() for future use
⬢ [acme@toolbx perf-tools-next]$ 

- Arnaldo
