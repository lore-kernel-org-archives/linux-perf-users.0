Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C93ACF03;
	Mon, 23 Mar 2026 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276586; cv=none; b=dJMOcyafEGnUDryLiudLllOhY9BMM5hlZBk5r19cYFs5UlUyCkWAO8xW0j7tAIw+7pFKweOQ9xMN3EUxUMr3Z5H1b+LDpT4k/UQraFDiOoTnCnXuVvoTcJSL5qNHaZxI94+Ug1EDOClkU8xqLnofdls/Kwf06w/CN0FrmrdXTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276586; c=relaxed/simple;
	bh=8bo40OUmEzaCMVbJOsVqLOEajqU4sMBo9QYog8uS4H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrBo43GPScxR3UxDf732rROAdIHm3CSnKwVJVMCleE/AP8rrUMPj+ulj2K4P2jeTFe1+tycHl58zJBupMzZ33cZradQWZQvnCYN1M9CBgN1Hq7ckmvBZobSaFHqn2qFUppws9rbsi+T1QoiWInQ7PJAh+eIIhhMnxnMg36GSQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huhtr5VG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huhtr5VG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A62C4CEF7;
	Mon, 23 Mar 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774276586;
	bh=8bo40OUmEzaCMVbJOsVqLOEajqU4sMBo9QYog8uS4H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Huhtr5VGNClE/y3garEEPC4rzHhObWTNdhXq4fD8lQBifVH5mSzk2cBQgi2oObynl
	 n4cbSHIpeYUGvakIosViGhXgzV45m68v9d5c4bJY8nMjC+cRK0yXD821/fqGgmaKot
	 I+F8jYiS5uynivOylEekKlE5rSJE4M3TZ/N+gL3Km071yylj8uueVNUSWcbxvYvse7
	 Z/Fn5OfRGlR6bLcurcm7iVtbO5KcEZJI9q58RZYKf8UbnKxl1o8mZxLzqcQpurLmGb
	 MkAt/Ag2vRNFCSqZwZQO8WmcnR6iO0H2Gfyf6Y2jeIQlQRrNu8D7+hIm7beOoxtMQc
	 r3H1+iJ/KxDUA==
Date: Mon, 23 Mar 2026 11:36:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <acFP5timJfI5qWEJ@x1>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
 <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
 <abFBoVrlGl9cIg1h@gmail.com>
 <20260311115011.GJ4153946@e132581.arm.com>
 <acFMfBS-85NWuDu-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFMfBS-85NWuDu-@x1>

On Mon, Mar 23, 2026 at 11:21:48AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 11, 2026 at 11:50:11AM +0000, Leo Yan wrote:
> > On Wed, Mar 11, 2026 at 03:21:00AM -0700, Breno Leitao wrote:
> > > On Thu, Feb 05, 2026 at 10:22:27AM -0800, Ian Rogers wrote:
> > > > I think it is a different issue, they have metrics while you don't.
> > > > Your report does highlight we're missing a NO_JEVENTS=1 build-test,
> > > > but the build is working for me. I'll send out two patches for these
> > > > issues.
> 
> > > I wanted to follow up on this. Are there any next steps I should take?
>  
> > I can reproduce the issue on my Orion6 with setting a _dummy_ CPUID:
>  
> >  $ export PERF_CPUID=0x00000000410fd490
> >  $ perf stat -C 5 -vvv
> >  ...
> >  Aborted
> >  perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' failed
> 
> > Because we are working on different hardwares, I am a bit suspect I
> > reproduced the issue with difference sequence as yours.  Anyway, I do
> > see that an event can be opened prior to its leader event, see the log
> > below.
>  
> > Thus, your patch seems make sense to me as we need to ensure the leader
> > event to be opened first.  Ian, how about you think?
>  
> > I have a side question (maybe this is for James :): why other arch (or
> > platforms) don't have reproduce the issue?  I am wandering if any error
> > or special stuffs in Arm CPU's json files.
> 
> I managed to reproduce using Leo's method:

But then I applied Breno's patch and got the same SEGV as below.

- Arnaldo
 
> (gdb) run stat -C 1
> Starting program: /root/bin/perf stat -C 1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
> Failure to read '#slots'Failure to read '#slots'Failure to read '#slots'Failure to read '#slots'
> Program received signal SIGSEGV, Segmentation fault.
> metricgroup__copy_metric_events (evlist=0x555555c85790, cgrp=0x0, new_metric_events=0x555555c86250, old_metric_events=0x555555c86d60) at util/metricgroup.c:1662
> 1662			evsel = evlist__find_evsel(evlist, old_me->evsel->core.idx);
> (gdb) bt
> #0  metricgroup__copy_metric_events (evlist=0x555555c85790, cgrp=0x0, new_metric_events=0x555555c86250, old_metric_events=0x555555c86d60) at util/metricgroup.c:1662
> #1  0x00005555555db404 in add_default_events () at builtin-stat.c:2102
> #2  0x00005555555de000 in cmd_stat (argc=0, argv=0x7ffffffffc30) at builtin-stat.c:2830
> #3  0x00005555556778e0 in run_builtin (p=0x555555bd5558 <commands+360>, argc=3, argv=0x7ffffffffc30) at perf.c:348
> #4  0x0000555555677b5c in handle_internal_command (argc=3, argv=0x7ffffffffc30) at perf.c:398
> #5  0x0000555555677d20 in run_argv (argcp=0x7ffffffffa4c, argv=0x7ffffffffa40) at perf.c:442
> #6  0x0000555555678064 in main (argc=3, argv=0x7ffffffffc30) at perf.c:549
> (gdb)
> 
> acme@raspberrypi:~/git/perf-tools $ git log --no-merges --oneline -15 tools/
> 493ad070cbcb (HEAD -> perf-tools, tag: perf-tools-fixes-for-v7.0-2-2026-03-23, x1/perf-tools, number/perf-tools) tools headers: Synchronize linux/build_bug.h with the kernel sources
> 0a8b2a0857ed tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
> 3c71ae8ec9ad tools headers UAPI: Sync linux/kvm.h with the kernel sources
> 4ddd7588fae6 tools arch x86: Sync the msr-index.h copy with the kernel sources
> 563d39928db6 perf kvm stat: Fix relative paths for including headers
> 72a8b9c060d3 perf parse-events: Fix big-endian 'overwrite' by writing correct union member
> 8dd1d9a33532 perf metricgroup: Fix metricgroup__has_metric_or_groups()
> 5d4c6c132ea9 selftests/hid: fix compilation when bpf_wq and hid_device are not exported
> 81f86728a980 tools headers: Skip arm64 cputype.h check
> e2715ea5fb35 bootconfig: Add bootconfig tests about braces
> d2ea4ff1ce50 KVM: selftests: Verify SEV+ guests can read and write EFER, CR0, CR4, and CR8
> 146c9ab38b48 powerpc/selftests/copyloops: extend selftest to exercise __copy_tofrom_user_power7_vmx
> 68e76fc12df0 selftests: rtnetlink: add neighbour update test
> 35b16a7a2c4f (tag: perf-tools-fixes-for-v7.0-1-2026-03-13, five/perf-tools) perf synthetic-events: Fix stale build ID in module MMAP2 records
> 3e745694b032 selftests: kvm: add a test that VMX validates controls on RSM
> acme@raspberrypi:~/git/perf-tools $
> 
> Below goes the full -vvv log FWIW.
> 
> - Arnaldo
> 
> root@raspberrypi:~# export PERF_CPUID=0x00000000410fd490
> root@raspberrypi:~# perf stat -C 1 -vvv
> Using CPUID 0x00000000410fd490
> metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
> parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
> Failure to read '#slots'literal: #slots = nan
> syntax error
> metric expr 100 * ((1 - OP_RETIRED / OP_SPEC) * (1 - (STALL_SLOT if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * #slots)) + BR_MIS_PRED * 4 / CPU_CYCLES) for bad_speculation
> parsing metric: 100 * ((1 - OP_RETIRED / OP_SPEC) * (1 - (STALL_SLOT if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * #slots)) + BR_MIS_PRED * 4 / CPU_CYCLES)
> Failure to read '#slots'literal: #slots = nan
> syntax error
> metric expr 100 * ((STALL_SLOT_FRONTEND if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT_FRONTEND - CPU_CYCLES) / (CPU_CYCLES * #slots) - BR_MIS_PRED / CPU_CYCLES) for frontend_bound
> parsing metric: 100 * ((STALL_SLOT_FRONTEND if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT_FRONTEND - CPU_CYCLES) / (CPU_CYCLES * #slots) - BR_MIS_PRED / CPU_CYCLES)
> Failure to read '#slots'literal: #slots = nan
> syntax error
> metric expr 100 * (OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * #slots))) for retiring
> parsing metric: 100 * (OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1 else STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * #slots)))
> Failure to read '#slots'literal: #slots = nan
> syntax error
> metric expr (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) / (duration_time * 1e9) for CPUs_utilized
> parsing metric: (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) / (duration_time * 1e9)
> literal: #target_cpu = 1.000000
> metric expr stalled\-cycles\-backend / cpu\-cycles for backend_cycles_idle
> parsing metric: backend_cycles_idle
> metric expr stalled\-cycles\-backend / cpu\-cycles for backend_cycles_idle
> parsing metric: stalled\-cycles\-backend / cpu\-cycles
> metric expr branches / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for branch_frequency
> parsing metric: branches / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@)
> literal: #target_cpu = 1.000000
> metric expr branch\-misses / branches for branch_miss_rate
> parsing metric: branch_miss_rate
> metric expr branch\-misses / branches for branch_miss_rate
> parsing metric: branch\-misses / branches
> metric expr software@context\-switches\,name\=context\-switches@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for cs_per_second
> parsing metric: software@context\-switches\,name\=context\-switches@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@)
> literal: #target_cpu = 1.000000
> metric expr cpu\-cycles / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for cycles_frequency
> parsing metric: cpu\-cycles / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@)
> literal: #target_cpu = 1.000000
> metric expr stalled\-cycles\-frontend / cpu\-cycles for frontend_cycles_idle
> parsing metric: frontend_cycles_idle
> metric expr stalled\-cycles\-frontend / cpu\-cycles for frontend_cycles_idle
> parsing metric: stalled\-cycles\-frontend / cpu\-cycles
> metric expr instructions / cpu\-cycles for insn_per_cycle
> parsing metric: insn_per_cycle
> metric expr instructions / cpu\-cycles for insn_per_cycle
> parsing metric: instructions / cpu\-cycles
> metric expr software@cpu\-migrations\,name\=cpu\-migrations@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for migrations_per_second
> parsing metric: software@cpu\-migrations\,name\=cpu\-migrations@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@)
> literal: #target_cpu = 1.000000
> metric expr software@page\-faults\,name\=page\-faults@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@) for page_faults_per_second
> parsing metric: software@page\-faults\,name\=page\-faults@ * 1e9 / (software@cpu\-clock\,name\=cpu\-clock@ if #target_cpu else software@task\-clock\,name\=task\-clock@)
> literal: #target_cpu = 1.000000
> metric expr max(stalled\-cycles\-frontend, stalled\-cycles\-backend) / instructions for stalled_cycles_per_instruction
> parsing metric: max(stalled\-cycles\-frontend, stalled\-cycles\-backend) / instructions
> found event software@context-switches,name=context-switches@
> found event duration_time
> found event software@page-faults,name=page-faults@
> found event cpu-cycles
> found event branches
> found event software@cpu-migrations,name=cpu-migrations@
> found event software@cpu-clock,name=cpu-clock@
> Parsing metric events 'software/context-switches,name=context-switches,metric-id=software!3context!1switches!0name!2context!1switches!3/,software/page-faults,name=page-faults,metric-id=software!3page!1faults!0name!2page!1faults!3/,cpu-cycles/metric-id=cpu!1cycles/,branches/metric-id=branches/,software/cpu-migrations,name=cpu-migrations,metric-id=software!3cpu!1migrations!0name!2cpu!1migrations!3/,software/cpu-clock,name=cpu-clock,metric-id=software!3cpu!1clock!0name!2cpu!1clock!3/,duration_time'
> Attempt to add: software/context-switches,name=context-switches,metric-id=software!3context!1switches!0name!2context!1switches!3/
> ..after resolving event: software/config=0x3,name=context-switches,metric-id=software!3context!1switches!0name!2context!1switches!3/
> Attempt to add: software/page-faults,name=page-faults,metric-id=software!3page!1faults!0name!2page!1faults!3/
> ..after resolving event: software/config=0x2,name=page-faults,metric-id=software!3page!1faults!0name!2page!1faults!3/
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> Attempt to add: armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> ..after resolving event: armv8_cortex_a76/metric-id=cpu!1cycles,legacy-hardware-config=0/
> cpu-cycles -> armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'branches'
> Attempt to add: armv8_cortex_a76/metric-id=branches,branches/
> ..after resolving event: armv8_cortex_a76/metric-id=branches,legacy-hardware-config=0x4/
> branches -> armv8_cortex_a76/metric-id=branches,branches/
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> Attempt to add: software/cpu-migrations,name=cpu-migrations,metric-id=software!3cpu!1migrations!0name!2cpu!1migrations!3/
> ..after resolving event: software/config=0x4,name=cpu-migrations,metric-id=software!3cpu!1migrations!0name!2cpu!1migrations!3/
> Attempt to add: software/cpu-clock,name=cpu-clock,metric-id=software!3cpu!1clock!0name!2cpu!1clock!3/
> ..after resolving event: software/config=0,name=cpu-clock,metric-id=software!3cpu!1clock!0name!2cpu!1clock!3/
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> found event duration_time
> Parsing metric events 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id duration_time to duration_time
> Events in 'frontend_bound' fully contained within 'retiring'
> Events in 'bad_speculation' fully contained within 'retiring'
> Events in 'backend_bound' fully contained within 'retiring'
> found event duration_time
> found event stalled-cycles-backend
> found event instructions
> found event stalled-cycles-frontend
> Parsing metric events '{stalled-cycles-backend/metric-id=stalled!1cycles!1backend/,instructions/metric-id=instructions/,stalled-cycles-frontend/metric-id=stalled!1cycles!1frontend/}:W,duration_time'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> Attempt to add: armv8_cortex_a76/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
> ..after resolving event: armv8_cortex_a76/metric-id=stalled!1cycles!1backend,legacy-hardware-config=0x8/
> stalled-cycles-backend -> armv8_cortex_a76/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'instructions'
> Attempt to add: armv8_cortex_a76/metric-id=instructions,instructions/
> ..after resolving event: armv8_cortex_a76/metric-id=instructions,legacy-hardware-config=0x1/
> instructions -> armv8_cortex_a76/metric-id=instructions,instructions/
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> Attempt to add: armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
> ..after resolving event: armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,legacy-hardware-config=0x7/
> stalled-cycles-frontend -> armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id stalled-cycles-backend to stalled-cycles-backend
> Matched metric-id instructions to instructions
> Matched metric-id stalled-cycles-frontend to stalled-cycles-frontend
> Matched metric-id duration_time to duration_time
> Matched metric-id software@page-faults,name=page-faults@ to page-faults
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> Matched metric-id software@cpu-migrations,name=cpu-migrations@ to cpu-migrations
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> found event duration_time
> found event cpu-cycles
> found event instructions
> Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,instructions/metric-id=instructions/}:W,duration_time'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> Attempt to add: armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> ..after resolving event: armv8_cortex_a76/metric-id=cpu!1cycles,legacy-hardware-config=0/
> cpu-cycles -> armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'instructions'
> Attempt to add: armv8_cortex_a76/metric-id=instructions,instructions/
> ..after resolving event: armv8_cortex_a76/metric-id=instructions,legacy-hardware-config=0x1/
> instructions -> armv8_cortex_a76/metric-id=instructions,instructions/
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon file 'instructions'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id cpu-cycles to cpu-cycles
> Matched metric-id instructions to instructions
> Matched metric-id duration_time to duration_time
> found event duration_time
> found event cpu-cycles
> found event stalled-cycles-frontend
> Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,stalled-cycles-frontend/metric-id=stalled!1cycles!1frontend/}:W,duration_time'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> Attempt to add: armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> ..after resolving event: armv8_cortex_a76/metric-id=cpu!1cycles,legacy-hardware-config=0/
> cpu-cycles -> armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> Attempt to add: armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
> ..after resolving event: armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,legacy-hardware-config=0x7/
> stalled-cycles-frontend -> armv8_cortex_a76/metric-id=stalled!1cycles!1frontend,stalled-cycles-frontend/
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-frontend'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id cpu-cycles to cpu-cycles
> Matched metric-id stalled-cycles-frontend to stalled-cycles-frontend
> Matched metric-id duration_time to duration_time
> Matched metric-id cpu-cycles to cpu-cycles
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> Matched metric-id software@context-switches,name=context-switches@ to context-switches
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> found event duration_time
> found event branch-misses
> found event branches
> Parsing metric events '{branch-misses/metric-id=branch!1misses/,branches/metric-id=branches/}:W,duration_time'
> hwmon_pmu: not a hwmon file 'branch-misses'
> Attempt to add: armv8_cortex_a76/metric-id=branch!1misses,branch-misses/
> ..after resolving event: armv8_cortex_a76/metric-id=branch!1misses,legacy-hardware-config=0x5/
> branch-misses -> armv8_cortex_a76/metric-id=branch!1misses,branch-misses/
> hwmon_pmu: not a hwmon file 'branch-misses'
> hwmon_pmu: not a hwmon file 'branch-misses'
> hwmon_pmu: not a hwmon file 'branch-misses'
> hwmon_pmu: not a hwmon file 'branch-misses'
> hwmon_pmu: not a hwmon file 'branch-misses'
> hwmon_pmu: not a hwmon file 'branches'
> Attempt to add: armv8_cortex_a76/metric-id=branches,branches/
> ..after resolving event: armv8_cortex_a76/metric-id=branches,legacy-hardware-config=0x4/
> branches -> armv8_cortex_a76/metric-id=branches,branches/
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon file 'branches'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id branch-misses to branch-misses
> Matched metric-id branches to branches
> Matched metric-id duration_time to duration_time
> Matched metric-id branches to branches
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> found event duration_time
> found event cpu-cycles
> found event stalled-cycles-backend
> Parsing metric events '{cpu-cycles/metric-id=cpu!1cycles/,stalled-cycles-backend/metric-id=stalled!1cycles!1backend/}:W,duration_time'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> Attempt to add: armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> ..after resolving event: armv8_cortex_a76/metric-id=cpu!1cycles,legacy-hardware-config=0/
> cpu-cycles -> armv8_cortex_a76/metric-id=cpu!1cycles,cpu-cycles/
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'cpu-cycles'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> Attempt to add: armv8_cortex_a76/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
> ..after resolving event: armv8_cortex_a76/metric-id=stalled!1cycles!1backend,legacy-hardware-config=0x8/
> stalled-cycles-backend -> armv8_cortex_a76/metric-id=stalled!1cycles!1backend,stalled-cycles-backend/
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon file 'stalled-cycles-backend'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> hwmon_pmu: not a hwmon type 'duration' in file name 'duration_time'
> Attempt to add: tool/duration_time/
> ..after resolving event: tool/config=0x1/
> duration_time -> tool/duration_time/
> Matched metric-id cpu-cycles to cpu-cycles
> Matched metric-id stalled-cycles-backend to stalled-cycles-backend
> Matched metric-id duration_time to duration_time
> Matched metric-id software@cpu-clock,name=cpu-clock@ to cpu-clock
> Matched metric-id duration_time to duration_time
> Segmentation fault
> root@raspberrypi:~#
> 
