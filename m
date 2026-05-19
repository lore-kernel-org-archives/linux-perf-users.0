Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FD3603F7;
	Tue, 19 May 2026 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226489; cv=none; b=oVEAkKj2lgfQKD+FxAFMCWXDIlbfdmcF0ibTM/L+ZLKSu/bfxTF97EKRfUHbGe1x0FeQ8o35U/Hsyj6qMtAOXUqU7XJw9+vQ1tES3y99Om7SaRqPzje/blZOkHjWsTFsi70hCRBGW7GXHHZwA5CW5xXu/PQxCgp6iix/bwvkKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226489; c=relaxed/simple;
	bh=gX3KbPE3GW2lJ0+jhOpDPBunAcZ6nZ+nCO0fiyAgCyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB/JAXCa1OKDxhLYHHSL3I2COG4ewUnr3sXC7zeE7XpX9k5EHJg53Rq9T7naC/n9cuB2wpRyyobMBPU0uEZgTJ/hVN1YSwMj9ssT6mG2xZ28KvXAOjRr8mQx+kFIf1hyWC/2mKsNaCIJE3V56ZVq3bsa9m7qGW5xNRr8XI/RUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcciOPqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcciOPqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0011F000E9;
	Tue, 19 May 2026 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779226487;
	bh=5wdlPy4IBA3bll+BngIFCGexhVcfEoPhpDBrL+YNL64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fcciOPqSsKO2XPjv+/Lx0xJfwUlT6RtOaL0y5TNFCoqmQ/xzehV/AANMHJOLgSUSm
	 Y5LYMBAo/qD9iH4w28uQq2+QCQqcJi+4x3b72m9bH20gelZ3lQ0fUcCECXmzpY4JJO
	 6mJrSK9wfiZVmO+26v424N8xvWQ7bR+NZFYMPRrQH3Kv004PD3SpXxKN3FJHbCdi3L
	 INr0v/drOs3Gmh4fXAe8Axn73jFqOovhqQtnBBnUvvp9OYuS6KGeE7zaa5HWh6L7ur
	 GhhkP7M0qB7FQd9sGP5um3mhRepTZiakGWAaXz3cFtpgjYHoFaJ0eMhvujbaAFEL/b
	 kBcJQi/D36euA==
Date: Tue, 19 May 2026 14:34:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v13 00/32] perf tool: Add evsel to perf_sample
Message-ID: <agzXc--sXpLz0RNK@google.com>
References: <20260413041143.1736055-1-irogers@google.com>
 <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>

On Tue, May 12, 2026 at 03:29:29PM -0700, Ian Rogers wrote:
> Nearly all perf code ends up passing an evsel with the perf_sample,
> which is problematic if you want to rewrite the evsel such as with
> off-CPU processing - all uses of the evsel need fixing up. Previously
> I'd mailed this patch as an RFC with everything combined:
> https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> and there was a request to break it up.
> 
> v13: Rebase removing patches merged by Namhyung. Namhyung proposed
>      changes that are in this series, but we became diverged. Address
>      some minor Sashiko issues.
> 
> v12: Add missing byteswap for tracepoint rawptr for dynamic
>      offsets. Avoid some unsigned <0 compiler warnings.
> https://lore.kernel.org/linux-perf-users/20260413041143.1736055-1-irogers@google.com/
> 
> v11: Separate any remaining error path or other fixes out of
>      refactoring the evsel into sample. Incorporate Sashiko
>      feedback. Improve bounds checking for tracepoint data in
>      samples. Incorporate changes from Namhyung.
> https://lore.kernel.org/lkml/20260413012227.1089445-1-irogers@google.com/
> 
> v10: Changes to some of the bounds checks as prompted by Sashiko.
> https://lore.kernel.org/linux-perf-users/20260412020833.641177-1-irogers@google.com/
> 
> v9: Clean up some error path nits caught by Sashiko and simple bound
>     checks Sashiko recommended.
> https://lore.kernel.org/linux-perf-users/20260411191710.524998-1-irogers@google.com/
> 
> v8: Fix address sanitizer issues with kwork and move patches, along
>     with bound check additions, to end of series.
> https://lore.kernel.org/linux-perf-users/20260411065718.372240-1-irogers@google.com/
> 
> v7: Separate out kwork work->name to a strdup into its own patch, now patch 4.
> https://lore.kernel.org/linux-perf-users/20260408072601.210837-1-irogers@google.com/
> 
> v6: Address more Sashiko feedback.
> https://lore.kernel.org/lkml/20260404034325.3172592-1-irogers@google.com/
> 
> v5: Address feedback from Sashiko and Namhyung.
> https://lore.kernel.org/lkml/20260403204017.2919994-1-irogers@google.com/
> 
> v4: Fix more sashiko issues: bounds checks, memory safety, making
>     refactors better, inconsistent evsels, mmap2 buildid injection
>     choice of evsel, mismatched function arguments.
> https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google.com
> https://lore.kernel.org/lkml/20260320192627.368357-1-irogers@google.com/
> 
> v3: Fix various sashiko review comments particularly about unintended
>     behavior changes.
> https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com/
> 
> v2: Add review feedback on the first 2 patches from Namhyung, fix a
>     missed evsel assignment running event2evsel in builtin-inject.
> https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.com/
> 
> Ian Rogers (32):
>   perf tool: Remove evsel from tool APIs that pass the sample
>   perf kvm: Don't pass evsel with sample
>   perf evsel: Refactor evsel tracepoint sample accessors perf_sample
>   perf trace: Don't pass evsel with sample
>   perf callchain: Don't pass evsel and sample
>   perf lock: Only pass sample to handlers
>   perf hist: Remove evsel parameter from inc samples functions
>   perf db-export: Remove evsel from struct export_sample
>   perf hist: Remove evsel from struct hist_entry_iter
>   perf report: Directly use sample->evsel to avoid computing from
>     sample->id
>   perf annotate: Don't pass evsel to add_sample
>   perf inject: Don't pass evsel with sample
>   perf kmem: Don't pass evsel with sample
>   perf kwork: Don't pass evsel with sample
>   perf sched: Don't pass evsel with sample
>   perf timechart: Don't pass evsel with sample
>   perf trace: Don't pass evsel with sample
>   perf evlist: Try to avoid computing evsel from sample
>   perf script: Don't pass evsel with sample
>   perf s390-sample-raw: Don't pass evsel or its PMU with sample
>   perf evsel: Don't pass evsel with sample
>   perf lock: Constify trace_lock_handler variables
>   perf lock: Avoid segv if event is missing a callchain
>   perf timechart: Fix memory leaks
>   perf kmem: Fix memory leaks on error path and when skipping
>   perf synthetic-events: Bound check when synthesizing mmap2 and
>     build_id events
>   perf kmem: Add bounds checks to tracepoint read values
>   perf sched: Bounds check CPU in sched switch events
>   perf timechart: Bounds check CPU
>   perf evsel: Add bounds checking to trace point raw data accessors
>   perf kwork: Fix address sanitizer issues
>   perf kwork: Fix memory management of kwork_work

I have a few nitpicks but I think it's good to go.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/builtin-annotate.c                 |  28 +-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   |  75 +++---
>  tools/perf/builtin-kmem.c                     |  95 ++++---
>  tools/perf/builtin-kvm.c                      |  22 +-
>  tools/perf/builtin-kwork.c                    | 253 +++++++++++-------
>  tools/perf/builtin-lock.c                     | 128 +++++----
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  38 ++-
>  tools/perf/builtin-sched.c                    | 198 +++++++-------
>  tools/perf/builtin-script.c                   |  22 +-
>  tools/perf/builtin-timechart.c                | 170 +++++++-----
>  tools/perf/builtin-top.c                      |  19 +-
>  tools/perf/builtin-trace.c                    | 121 +++++----
>  tools/perf/tests/hists_cumulate.c             |   1 -
>  tools/perf/tests/hists_filter.c               |   1 -
>  tools/perf/tests/hists_output.c               |   1 -
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/switch-tracking.c            |   9 +-
>  tools/perf/util/annotate.c                    |  19 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/bpf_kwork.c                   |  14 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   7 +-
>  tools/perf/util/callchain.c                   |   8 +-
>  tools/perf/util/callchain.h                   |   6 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  13 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evsel.c                       | 137 +++++++---
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  26 +-
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/intel-tpebs.c                 |   3 +-
>  tools/perf/util/jitdump.c                     |   2 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
>  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
>  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 ++---
>  tools/perf/util/kvm-stat.c                    |  19 +-
>  tools/perf/util/kvm-stat.h                    |  18 +-
>  tools/perf/util/kwork.h                       |  11 +-
>  tools/perf/util/machine.c                     |  14 +-
>  tools/perf/util/machine.h                     |   3 -
>  tools/perf/util/s390-sample-raw.c             |  31 ++-
>  .../util/scripting-engines/trace-event-perl.c |  23 +-
>  .../scripting-engines/trace-event-python.c    |  47 ++--
>  tools/perf/util/session.c                     |  38 +--
>  tools/perf/util/synthetic-events.c            |  49 ++--
>  tools/perf/util/synthetic-events.h            |   2 -
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  61 files changed, 991 insertions(+), 913 deletions(-)
> 
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
