Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6D37BE9B;
	Fri, 27 Feb 2026 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228383; cv=none; b=dvWxvY8UI1F/8xzunY4Gg+bwJ7/BRRMQ/g/C6Yr6qOny6fFzNuubCiflVOFbj3nKIwcVJOGisnQvhVWkFJUmOW85RtJJdyUqaBDHSSZ9WJqzOJcBajlp1aWwLXrr37Rq3pnIqU5xApbkyKrM0BgRRZ2Ont5PxX6K6tpsoEioL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228383; c=relaxed/simple;
	bh=9SrQGZCUU/3F0tQgi9lXJNHAP5eSd25+0g/Y3JjUFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MweRxqxZf2GXdfUVJ1ykxzWLw2DSPNuxJ7Kb+4atZRicnSJMdipIJpukblUY0eMUqvhCsEOIqqJjAelTvGIjErKxBzY5MHQj0GMwkpecpWIcnWBH3tHJ9WxYAM3KOMmzALld24dq2R15AtKPAXorxHdmT872kyYLiM9gIKA6VZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXH3CBz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXH3CBz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB3C116C6;
	Fri, 27 Feb 2026 21:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772228382;
	bh=9SrQGZCUU/3F0tQgi9lXJNHAP5eSd25+0g/Y3JjUFLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXH3CBz/i+yCxUNH0E5UVPeTT6OLFemN1/gj9dOHylfk6ikU16pAPapgcz9ryEUxw
	 +NjxW2Ww52Djyy9UWVEx9l8SRuH8+2glbNA8nqixQ8RiMldyPoziNN3jgXYmsZx66e
	 xlbi7YKnSUvHEFyfU0uzLah1Kb2t+XKns56USGJaC47u2IwQ/BwuqPNr4VXycaH7rc
	 xs9UFueSxCstZmg4D8oIzbNuyjbaq6zb0VZ8oNq6xACwVYu0ZYrk+hsDvXxgbUC1XJ
	 gxf6ruB8LVJwQdEs/KZuWg0sqF5fGdEjXNIIDbYllLOp/7KQF857YVy1duN2NUu+jE
	 dy+Pc8+6HcHuA==
Date: Fri, 27 Feb 2026 13:39:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf test]  c9cd0c7e52:
 perf-sanity-tests.python_profiling_with_jitdump.fail
Message-ID: <aaIPHGMxrxkYsD0b@google.com>
References: <202602270932.50ed0a9f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202602270932.50ed0a9f-lkp@intel.com>

On Fri, Feb 27, 2026 at 04:42:59PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> 
> we failed to run this new added test. not sure if we miss any dependencies?
> 
> 
> below is full report FYI.
> 
> 
> kernel test robot noticed "perf-sanity-tests.python_profiling_with_jitdump.fail" on:
> 
> commit: c9cd0c7e529e80e9be79867d2ebb874f67dbc35e ("perf test: Add python JIT dump test")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: clang
> 	group: group-02
> 
> 
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602270932.50ed0a9f-lkp@intel.com

Looks like a reference leak to map during libdw unwinding.

Ian, can you please take a look?

Thanks,
Namhyung

> 
> 
> 2026-01-26 15:25:04 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf test 84 -v
>  84: python profiling with jitdump                                   : Running (1 active)
> --- start ---
> test child forked, pid 12390
> Run python with -Xperf_jit
> [ perf record: Woken up 5 times to write data ]
> =================================================================
> ==12400==ERROR: AddressSanitizer: heap-use-after-free on address 0x50200002ba30 at pc 0x55c306993987 bp 0x7ffd98998720 sp 0x7ffd98998718
> READ of size 8 at 0x50200002ba30 thread T0
>     #0 0x55c306993986 in map__start util/map.h:54
>     #1 0x55c306993cd0 in map__dso_map_ip util/map.h:110
>     #2 0x55c3069b1ecb in unwind_entry util/machine.c:2950
>     #3 0x55c306e4197b in unwind__get_entries util/unwind-libdw.c:321
>     #4 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
>     #5 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
>     #6 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
>     #7 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
>     #8 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
>     #9 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
>     #10 0x55c3069dc425 in machines__deliver_event util/session.c:1299
>     #11 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
>     #12 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
>     #13 0x55c306a06aac in do_flush util/ordered-events.c:245
>     #14 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
>     #15 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
>     #16 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
>     #17 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
>     #18 0x55c3069e190e in perf_session__process_event util/session.c:1668
>     #19 0x55c3069e9198 in process_simple util/session.c:2259
>     #20 0x55c3069e8158 in reader__read_event util/session.c:2188
>     #21 0x55c3069e8afe in reader__process_events util/session.c:2237
>     #22 0x55c3069e9987 in __perf_session__process_events util/session.c:2282
>     #23 0x55c3069eca43 in perf_session__process_events util/session.c:2446
>     #24 0x55c3062f7328 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1534
>     #25 0x55c3062fbdf0 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1858
>     #26 0x55c306309ebf in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:2930
>     #27 0x55c306317a8f in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:4417
>     #28 0x55c30652bf7b in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:349
>     #29 0x55c30652c86c in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:401
>     #30 0x55c30652cdc2 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:445
>     #31 0x55c30652d569 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf.c:553
>     #32 0x7f026b873ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
>     #33 0x7f026b873d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
>     #34 0x55c306293210 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/perf+0x1023210) (BuildId: 47c1eede4a6cf8e0c379d2104e8b035638daa1b4)
> 
> 0x50200002ba30 is located 0 bytes inside of 8-byte region [0x50200002ba30,0x50200002ba38)
> freed by thread T0 here:
>     #0 0x7f0275b3d8f8 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
>     #1 0x55c3069ba258 in map__put util/map.c:312
>     #2 0x55c30679b7f8 in __map__zput util/map.h:198
>     #3 0x55c30679c0df in addr_location__exit util/addr_location.c:31
>     #4 0x55c306e3f7fe in entry util/unwind-libdw.c:147
>     #5 0x55c306e40b1b in frame_callback util/unwind-libdw.c:259
>     #6 0x7f02758daae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #7 0x7f02758dae53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #8 0x55c306e414af in unwind__get_entries util/unwind-libdw.c:307
>     #9 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
>     #10 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
>     #11 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
>     #12 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
>     #13 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
>     #14 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
>     #15 0x55c3069dc425 in machines__deliver_event util/session.c:1299
>     #16 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
>     #17 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
>     #18 0x55c306a06aac in do_flush util/ordered-events.c:245
>     #19 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
>     #20 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
>     #21 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
>     #22 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
>     #23 0x55c3069e190e in perf_session__process_event util/session.c:1668
>     #24 0x55c3069e9198 in process_simple util/session.c:2259
>     #25 0x55c3069e8158 in reader__read_event util/session.c:2188
>     #26 0x55c3069e8afe in reader__process_events util/session.c:2237
>     #27 0x55c3069e9987 in __perf_session__process_events util/session.c:2282
> 
> previously allocated by thread T0 here:
>     #0 0x7f0275b3ec57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
>     #1 0x55c3069bd747 in map__get util/map.h:188
>     #2 0x55c3069c72c4 in maps__find util/maps.c:1112
>     #3 0x55c30683b979 in thread__find_map util/event.c:687
>     #4 0x55c30683be37 in thread__find_symbol util/event.c:723
>     #5 0x55c306e3e7c3 in __report_module util/unwind-libdw.c:54
>     #6 0x55c306e3f428 in entry util/unwind-libdw.c:133
>     #7 0x55c306e40b1b in frame_callback util/unwind-libdw.c:259
>     #8 0x7f02758daae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #9 0x7f02758dae53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
>     #10 0x55c306e414af in unwind__get_entries util/unwind-libdw.c:307
>     #11 0x55c3069b2398 in thread__resolve_callchain_unwind util/machine.c:2976
>     #12 0x55c3069b24ec in __thread__resolve_callchain util/machine.c:3003
>     #13 0x55c306987e78 in sample__for_each_callchain_node util/callchain.c:1808
>     #14 0x55c3067d4ece in build_id__mark_dso_hit util/build-id.c:77
>     #15 0x55c3062f7004 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-c9cd0c7e529e80e9be79867d2ebb874f67dbc35e/tools/perf/builtin-record.c:1504
>     #16 0x55c3069dbec3 in evlist__deliver_sample util/session.c:1259
>     #17 0x55c3069dc425 in machines__deliver_event util/session.c:1299
>     #18 0x55c3069de009 in perf_session__deliver_event util/session.c:1386
>     #19 0x55c3069cb296 in ordered_events__deliver_event util/session.c:134
>     #20 0x55c306a06aac in do_flush util/ordered-events.c:245
>     #21 0x55c306a07951 in __ordered_events__flush util/ordered-events.c:324
>     #22 0x55c306a07e62 in ordered_events__flush util/ordered-events.c:342
>     #23 0x55c3069d6863 in perf_event__process_finished_round util/session.c:786
>     #24 0x55c3069deb7e in perf_session__process_user_event util/session.c:1446
>     #25 0x55c3069e190e in perf_session__process_event util/session.c:1668
>     #26 0x55c3069e9198 in process_simple util/session.c:2259
>     #27 0x55c3069e8158 in reader__read_event util/session.c:2188
> 
> SUMMARY: AddressSanitizer: heap-use-after-free util/map.h:54 in map__start
> Shadow bytes around the buggy address:
>   0x50200002b780: fa fa fd fa fa fa fd fd fa fa 00 06 fa fa 00 fa
>   0x50200002b800: fa fa 00 fa fa fa fd fa fa fa 00 fa fa fa 00 fa
>   0x50200002b880: fa fa 00 fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002b900: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002b980: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
> =>0x50200002ba00: fa fa fd fa fa fa[fd]fa fa fa fd fa fa fa fd fa
>   0x50200002ba80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002bb00: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002bb80: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002bc00: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fd fa
>   0x50200002bc80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07 
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> ==12400==ABORTING
> Error:
> failed to process sample
> Generate JIT-ed DSOs using perf inject
> WARNING: The /tmp/__perf_test.perf.data.W1jHYt file's data size field is 0 which is unexpected.
> Was the 'perf record' command properly terminated?
> Add JIT-ed DSOs to the build-ID cache
> Couldn't add /tmp/jitted--*.so: No such file or directory
> Check the symbol containing the function/module name
> zero-sized data (/tmp/__perf_test.perf.data.W1jHYt.jit), nothing to do!
> Found 0 matching lines
> Remove JIT-ed DSOs from the build-ID cache
> Cleaning up files...
> ---- end(-1) ----
>  84: python profiling with jitdump                                   : FAILED!
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260227/202602270932.50ed0a9f-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
