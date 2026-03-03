Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659C227B94;
	Tue,  3 Mar 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500221; cv=none; b=gnz+a562FRj54Epxg+VG4Ay5FOISOm2WXhZPkhzV6PbiOXhPdWv0G2EQGgmJcJNYJCLrD2BwblwJmz7E4DsedVhmGAAwK4dI6Xy7atadUV7ZPxrShAiSOZzpfnSJztsTXHP13bYmMukKkVaSc5+eIjCd0BAx0UvsyG7HMRy0320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500221; c=relaxed/simple;
	bh=YV5ZN1UNzukTy3luarU0zK5ekg201gQEDQ1YxmefsTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKk5Kn3sMXLdpq1hFz7sZgA3eZEGzP961je0egDkdw4TrSTiG2fH4enMs8QUwYIzZX1abvxb1Ji7Rvtr46gtxn3gvS2ASOqihMzKayYssO7N8VPxdZR7Lo/opHcKPlWvrIcwqSUHwkgpJ+JaJJ8ADGWmmU5jIERkydTeo0mrlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqj6prhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqj6prhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14080C19423;
	Tue,  3 Mar 2026 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772500220;
	bh=YV5ZN1UNzukTy3luarU0zK5ekg201gQEDQ1YxmefsTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqj6prhz+QLMO1wW4jJ2D1q4ZYRfyq+C3hcz9LcQ8qqk8U1LVJAKenvm81KMRrPJC
	 2gNpZmrzRaDHJkcutDC6GsPzXa6xHBqD3XKdZbJ6Ko6t/j+ApQ0X1dIPrmg1vxZOO4
	 FCSLIzS7cndGIStxkKLtjYibrKomc13ALmb7pfXbLQ81VyiTvlU0yXx/OznSSucw99
	 xCq/myZTzUzONbk3MHJZhnf4ANaebrhpes1leycQBJV6gdTS6tTM9hFp3HFPgtSijF
	 1wTEzx0xDqZwvsHY41aQFIpIwR6GGaXDXBG126BbG8KOnOID1/eMH6QspRXkEvJ2XO
	 zo+bHleyMCJaA==
Date: Mon, 2 Mar 2026 17:10:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf test] c9cd0c7e52:
 perf-sanity-tests.python_profiling_with_jitdump.fail
Message-ID: <aaY0-sJzSSdOq-JL@google.com>
References: <202602270932.50ed0a9f-lkp@intel.com>
 <aaIPHGMxrxkYsD0b@google.com>
 <CAP-5=fXpFrNOBR7XmVcD0fdZ20sDMmczCvpo=St0eaPBtwdk_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXpFrNOBR7XmVcD0fdZ20sDMmczCvpo=St0eaPBtwdk_g@mail.gmail.com>

On Mon, Mar 02, 2026 at 02:08:09PM -0800, Ian Rogers wrote:
> On Fri, Feb 27, 2026 at 1:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Feb 27, 2026 at 04:42:59PM +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > >
> > > we failed to run this new added test. not sure if we miss any dependencies?
> > >
> > >
> > > below is full report FYI.
> > >
> > >
> > > kernel test robot noticed "perf-sanity-tests.python_profiling_with_jitdump.fail" on:
> > >
> > > commit: c9cd0c7e529e80e9be79867d2ebb874f67dbc35e ("perf test: Add python JIT dump test")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: perf-sanity-tests
> > > version:
> > > with following parameters:
> > >
> > >       perf_compiler: clang
> > >       group: group-02
> > >
> > >
> > > config: x86_64-rhel-9.4-bpf
> > > compiler: gcc-14
> > > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202602270932.50ed0a9f-lkp@intel.com
> >
> > Looks like a reference leak to map during libdw unwinding.
> >
> > Ian, can you please take a look?
> >
> > Thanks,
> > Namhyung
> >
> > >
> > >
> > > 2026-01-26 15:25:04 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf test 84 -v
> > >  84: python profiling with jitdump                                   : Running (1 active)
> > > --- start ---
> > > test child forked, pid 12390
> > > Run python with -Xperf_jit
> > > [ perf record: Woken up 5 times to write data ]
> > > =================================================================
> > > ==12400==ERROR: AddressSanitizer: heap-use-after-free on address 0x50200002ba30 at pc 0x55c306993987 bp 0x7ffd98998720 sp 0x7ffd98998718
> > > READ of size 8 at 0x50200002ba30 thread T0
> > >     #0 0x55c306993986 in map__start util/map.h:54
> > >     #1 0x55c306993cd0 in map__dso_map_ip util/map.h:110
> > >     #2 0x55c3069b1ecb in unwind_entry util/machine.c:2950
> > >     #3 0x55c306e4197b in unwind__get_entries util/unwind-libdw.c:321
> > >     #4 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
> > >     #5 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
> > >     #6 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
> > >     #7 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
> > >     #8 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
> > >     #9 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
> > >     #10 0x55c3069dc425 in machines__deliver_event util/session.c:1299
> > >     #11 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
> > >     #12 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
> > >     #13 0x55c306a06aac in do_flush util/ordered-events.c:245
> > >     #14 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
> > >     #15 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
> > >     #16 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
> > >     #17 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
> > >     #18 0x55c3069e190e in perf_session__process_event util/session.c:1668
> > >     #19 0x55c3069e9198 in process_simple util/session.c:2259
> > >     #20 0x55c3069e8158 in reader__read_event util/session.c:2188
> > >     #21 0x55c3069e8afe in reader__process_events util/session.c:2237
> > >     #22 0x55c3069e9987 in __perf_session__process_events util/session.c:2282
> > >     #23 0x55c3069eca43 in perf_session__process_events util/session.c:2446
> > >     #24 0x55c3062f7328 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1534
> > >     #25 0x55c3062fbdf0 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1858
> > >     #26 0x55c306309ebf in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:2930
> > >     #27 0x55c306317a8f in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:4417
> > >     #28 0x55c30652bf7b in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:349
> > >     #29 0x55c30652c86c in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:401
> > >     #30 0x55c30652cdc2 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:445
> > >     #31 0x55c30652d569 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:553
> > >     #32 0x7f026b873ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
> > >     #33 0x7f026b873d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
> > >     #34 0x55c306293210 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf+0x1023210) (BuildId: 47c1eede4a6cf8e0c379d2104e8b035638daa1b4)
> > >
> > > 0x50200002ba30 is located 0 bytes inside of 8-byte region [0x50200002ba30,0x50200002ba38)
> > > freed by thread T0 here:
> > >     #0 0x7f0275b3d8f8 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
> > >     #1 0x55c3069ba258 in map__put util/map.c:312
> > >     #2 0x55c30679b7f8 in __map__zput util/map.h:198
> > >     #3 0x55c30679c0df in addr_location__exit util/addr_location.c:31
> > >     #4 0x55c306e3f7fe in entry util/unwind-libdw.c:147
> 
> This free is happening here (note I've set the commit to be that in
> the report here):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/unwind-libdw.c?h=perf-tools-next&id=c9cd0c7e529e80e9be79867d2ebb874f67dbc35e#n147
> ```
> static int entry(u64 ip, struct unwind_info *ui)
> {
> struct unwind_entry *e = &ui->entries[ui->idx++];
> struct addr_location al;
> 
> addr_location__init(&al);
> if (__report_module(&al, ip, ui)) {
> addr_location__exit(&al);
> return -1;
> }
> 
> e->ip   = ip;
> e->ms.maps = al.maps;
> e->ms.map = al.map;
> e->ms.sym = al.sym;
> 
> pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
> al.sym ? al.sym->name : "''",
> ip,
> al.map ? map__map_ip(al.map, ip) : (u64) 0);
> addr_location__exit(&al);  // <-- free happens here
> return 0;
> }
> ```
> 
> This was fixed by the first of my unwind-libdw changes:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/unwind-libdw.c?h=perf-tools-next&id=f815fc0c66e777c727689666cfb46b8d461c2f99
> 
> That is the new test exposed a latent bug, which we've already fixed,
> with a "fixes" tag for backports.

Great, thanks for looking into it.

Namhyung

