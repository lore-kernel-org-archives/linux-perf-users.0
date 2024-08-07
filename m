Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2B84A35;
	Wed,  7 Aug 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043238; cv=none; b=fwMoZ0hqiE0Z/NaSBMTbNiRSKo+TMOwos1608VaP3u7iQ+s5gD55Dz4ngapMV0/M998rp0af9tmIlrNZj7MsrJl6LBK5erEwWFPKPaa52oHUng+z1yNjdmuDO10fZN8q/VGl/QnM8YJykmcJepow1Tq+ZYCzSEh7CCsdGc/vSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043238; c=relaxed/simple;
	bh=XlDTbt8YAE8zZrwufPbFDMnipG8vtRRxesIMsKSTYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSk1CHQPGrT8W8GN+HokB8ic1bzktCfed8kPHmd6fMxqmtuLr8a48CMpTTPz1PxhcK0ElH2bH2cKAB38DZqGLWLbP7XVxDZmN83qL9jxnC9mt6M0pNz4B6flsaW9Ckh53TyViUWeM7cYfelDhaadOtvkNeLppMRCAzfyjs+zxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnMrydow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnMrydow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98172C4AF0D;
	Wed,  7 Aug 2024 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043238;
	bh=XlDTbt8YAE8zZrwufPbFDMnipG8vtRRxesIMsKSTYnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnMrydowz0uwHSFEWhrq4UCMrxUwkJk/uxPved2N5Vnec7Tuzex/O6/H9guMg1AiV
	 geY6YZY9r8Pd6QIUqUttLip2zSZOpkVKz08NgXfv8/5v+lIahrbqcAilVCbQI+2I3i
	 rAxwPHtMolclIsjOSHaJ35BArGqMvvmNsu1JHHcCZO3FIbGVxisDl+peCXkRH7OJej
	 qvPkkgzeyXHwonkl8rqPFksVMwjuDAldNIpGrESksOY/qjyxslzUEE6XHIxH4X9U32
	 T2t2F9tJY802xgnUv1tggsxyVvk+fTtROfadXdlDKAaafQGYZqfOk9ToO4zEBgrxvV
	 zb0STrSrqhtjA==
Date: Wed, 7 Aug 2024 12:07:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf hist: Fix reference counting of branch_info
Message-ID: <ZrONok4ZhoA6FhNi@x1>
References: <20240807065136.1039977-1-irogers@google.com>
 <277a02a5-9355-4f06-9158-026cf4b330f7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <277a02a5-9355-4f06-9158-026cf4b330f7@linux.intel.com>

On Wed, Aug 07, 2024 at 09:27:02AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-08-07 2:51 a.m., Ian Rogers wrote:
> > iter_finish_branch_entry doesn't put the branch_info from/to map
> > elements creating memory leaks. This can be seen with:
> > 
> > ```
> > $ perf record -e cycles -b perf test -w noploop
> > $ perf report -D
> > ...
> > Direct leak of 984344 byte(s) in 123043 object(s) allocated from:
> >     #0 0x7fb2654f3bd7 in malloc libsanitizer/asan/asan_malloc_linux.cpp:69
> >     #1 0x564d3400d10b in map__get util/map.h:186
> >     #2 0x564d3400d10b in ip__resolve_ams util/machine.c:1981
> >     #3 0x564d34014d81 in sample__resolve_bstack util/machine.c:2151
> >     #4 0x564d34094790 in iter_prepare_branch_entry util/hist.c:898
> >     #5 0x564d34098fa4 in hist_entry_iter__add util/hist.c:1238
> >     #6 0x564d33d1f0c7 in process_sample_event tools/perf/builtin-report.c:334
> >     #7 0x564d34031eb7 in perf_session__deliver_event util/session.c:1655
> >     #8 0x564d3403ba52 in do_flush util/ordered-events.c:245
> >     #9 0x564d3403ba52 in __ordered_events__flush util/ordered-events.c:324
> >     #10 0x564d3402d32e in perf_session__process_user_event util/session.c:1708
> >     #11 0x564d34032480 in perf_session__process_event util/session.c:1877
> >     #12 0x564d340336ad in reader__read_event util/session.c:2399
> >     #13 0x564d34033fdc in reader__process_events util/session.c:2448
> >     #14 0x564d34033fdc in __perf_session__process_events util/session.c:2495
> >     #15 0x564d34033fdc in perf_session__process_events util/session.c:2661
> >     #16 0x564d33d27113 in __cmd_report tools/perf/builtin-report.c:1065
> >     #17 0x564d33d27113 in cmd_report tools/perf/builtin-report.c:1805
> >     #18 0x564d33e0ccb7 in run_builtin tools/perf/perf.c:350
> >     #19 0x564d33e0d45e in handle_internal_command tools/perf/perf.c:403
> >     #20 0x564d33cdd827 in run_argv tools/perf/perf.c:447
> >     #21 0x564d33cdd827 in main tools/perf/perf.c:561
> > ...
> > ```
> > 
> > Clearing up the map_symbols properly creates maps reference count
> > issues so resolve those. Resolving this issue doesn't improve peak
> > heap consumption for the test above.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applying.

While trying to test it:

make -k CORESIGHT=1 EXTRA_CFLAGS="-fsanitize=memory" CC=clang HOSTCC=clang NO_LIBTRACEEVENT=1 NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin

Used that from a previous patch description from Ian to get rid of some
other problems with those other libraries:

⬢[acme@toolbox perf-tools-next]$  perf record -e cycles -b perf test -w noploop
Uninitialized bytes in fopen64 at offset 46 inside [0x7fff1077e890, 52)
==1948231==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x7921df in perf_pmu_format__load pmu.c
    #1 0x791f3e in perf_pmu__warn_invalid_formats (/home/acme/bin/perf+0x791f3e) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #2 0x6f62d0 in __add_event parse-events.c
    #3 0x6fa681 in __parse_events_add_numeric parse-events.c
    #4 0x6fa3e4 in parse_events_add_numeric (/home/acme/bin/perf+0x6fa3e4) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #5 0x78c6ca in parse_events_parse (/home/acme/bin/perf+0x78c6ca) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #6 0x6fd8eb in __parse_events (/home/acme/bin/perf+0x6fd8eb) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #7 0x6ff232 in parse_events_option (/home/acme/bin/perf+0x6ff232) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #8 0x5be82f in get_value /home/acme/git/perf-tools-next/tools/lib/subcmd/parse-options.c
    #9 0x5ba474 in parse_short_opt /home/acme/git/perf-tools-next/tools/lib/subcmd/parse-options.c:351:11
    #10 0x5ba474 in parse_options_step /home/acme/git/perf-tools-next/tools/lib/subcmd/parse-options.c:539:12
    #11 0x5ba474 in parse_options_subcommand /home/acme/git/perf-tools-next/tools/lib/subcmd/parse-options.c:653:10
    #12 0x4f089f in cmd_record (/home/acme/bin/perf+0x4f089f) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #13 0x56fda9 in run_builtin perf.c
    #14 0x56e9ea in main (/home/acme/bin/perf+0x56e9ea) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)
    #15 0x7fbf387ea087 in __libc_start_call_main (/lib64/libc.so.6+0x2a087) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
    #16 0x7fbf387ea14a in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x2a14a) (BuildId: 8f53abaad945a669f2bdcd25f471d80e077568ef)
    #17 0x4364e4 in _start (/home/acme/bin/perf+0x4364e4) (BuildId: d7742e31f05abb200493b431a6191afda9ed77c8)

SUMMARY: MemorySanitizer: use-of-uninitialized-value pmu.c in perf_pmu_format__load
Exiting
⬢[acme@toolbox perf-tools-next]$

So I think there is something else nor merged or is this something new?

- Arnaldo
