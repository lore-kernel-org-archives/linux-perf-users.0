Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55394346774;
	Mon,  6 Apr 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775455866; cv=none; b=mFt78Kpeh6ywCaz5Rb/lal7BvxKctO+TmbzNdmfWQMrFQBO5pX1DOV6uhdwCElHv5UOT5UeVNbWUMWeIowXhvwmMtANl5Ms3qfkvWhNGMZl6S1YvUh9zc5/3KojqPVwDFNCaii/sfCTPfbt2gvrMtiN/xx15skxQJTssW6R9Qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775455866; c=relaxed/simple;
	bh=buyt9irvOYHpOAgE68qp2vk7cqZbe4jlqeAq03KN2mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYz0CQlZAAHuFvw+2PPBwKmiY2KZ3O+g+JjJ3wA7ig1vnCC6lL4kYQzvJ98vGsAj/ae64KWiMjRBFgH1sxhQhnKp+ppn8pKZcGhmLd5yJ2Eha8tOf/N5EprjH9UNikySgXZDgbaZRPLRiYquON1lpXe7gCsGtCdAbM/BX3/xGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/rcQEdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/rcQEdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E557C4CEF7;
	Mon,  6 Apr 2026 06:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775455865;
	bh=buyt9irvOYHpOAgE68qp2vk7cqZbe4jlqeAq03KN2mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/rcQEdlnIjqB5yd7CkRzOwdwWwa3NFQvU38Bprbet1tm+vTJ2C+uhtBlfHHMKjcT
	 fTW3b2TCYZdjEeozL4kDvTlOpNGnKUK70UkOvfcxNgXLPUdUIfn01tvV2cSh+Pi0ho
	 EGW2/11G1o8xLZuRe3XpNakZa4DKiNhDOXt6tXKEfY3LXNh//Y1r7hGFNzhGaX02uq
	 RH7taMAxqzApki+nfUqLUsnByXjhDddf44bVIL4cTzZrSeCAAsF2oJpkNAt+ZqA3FT
	 L87XKL7UiuPhhTEMD7oGch+f4HW8mTs7Sj61zpQ+Kttox+hVDv2hxUgOqlrYRy+A0t
	 dcYQKOZJ0lTXA==
Date: Sun, 5 Apr 2026 23:11:03 -0700
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
Subject: Re: [PATCH v6 00/25] perf tool: Add evsel to perf_sample
Message-ID: <adNOd_yaPL3nlXUr@google.com>
References: <20260403204017.2919994-1-irogers@google.com>
 <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>

On Fri, Apr 03, 2026 at 08:43:00PM -0700, Ian Rogers wrote:
> Nearly all perf code ends up passing an evsel with the perf_sample,
> which is problematic if you want to rewrite the evsel such as with
> off-CPU processing - all uses of the evsel need fixing up. Previously
> I'd mailed this patch as an RFC with everything combined:
> https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> and there was a request to break it up.
> 
> I've started the series by adding documentation to struct
> perf_sample. Next I fixed missing perf_sample__init/exit largely from
> the recent perf inject callchain rewriting work. The 3rd patch adds
> the evsel to struct perf_sample and ensures it is correctly
> initialized. The next 22 patches avoid passing the evsel along with
> sample for different parts of the perf tool, along with some minor
> tweaks like constification and not determining the evsel if it is
> present in the sample.

I'll test and process the first 3 patches first as I found an issue in
patch 6 and I guess applying patch 4 would break partial imports later.

I still think it's better to remove perf_sample__init() int
evsel__parse_sample().. but it could be a different patchset.

Thanks,
Namhyung

> 
> v6: Address more Sashiko feedback.
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
> Ian Rogers (25):
>   perf sample: Document struct perf_sample
>   perf sample: Make sure perf_sample__init/exit are used
>   perf sample: Add evsel to struct perf_sample
>   perf tool: Remove evsel from tool APIs that pass the sample
>   perf kvm: Don't pass evsel with sample
>   perf evsel: Refactor evsel tracepoint sample accessors perf_sample
>   perf trace: Don't pass evsel with sample
>   perf callchain: Don't pass evsel and sample
>   perf lock: Only pass sample to handlers
>   perf lock: Constify trace_lock_handler variables
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
> 
>  tools/perf/builtin-annotate.c                 |  28 ++-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   | 136 +++++++------
>  tools/perf/builtin-kmem.c                     |  95 +++++----
>  tools/perf/builtin-kvm.c                      |  22 +-
>  tools/perf/builtin-kwork.c                    | 104 ++++------
>  tools/perf/builtin-lock.c                     | 120 +++++------
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  38 ++--
>  tools/perf/builtin-sched.c                    | 188 ++++++++----------
>  tools/perf/builtin-script.c                   |  26 ++-
>  tools/perf/builtin-timechart.c                | 151 +++++++-------
>  tools/perf/builtin-top.c                      |  19 +-
>  tools/perf/builtin-trace.c                    | 120 +++++------
>  tools/perf/tests/hists_cumulate.c             |   3 +-
>  tools/perf/tests/hists_filter.c               |   2 +-
>  tools/perf/tests/hists_output.c               |   3 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/perf-record.c                |   1 +
>  tools/perf/tests/switch-tracking.c            |  11 +-
>  tools/perf/util/annotate.c                    |  19 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   7 +-
>  tools/perf/util/callchain.c                   |  18 +-
>  tools/perf/util/callchain.h                   |   6 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  13 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evlist.c                      |   5 +-
>  tools/perf/util/evsel.c                       | 115 ++++++++---
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  26 +--
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/intel-tpebs.c                 |   3 +-
>  tools/perf/util/jitdump.c                     |   2 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
>  .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
>  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
>  .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 +++----
>  tools/perf/util/kvm-stat.c                    |  19 +-
>  tools/perf/util/kvm-stat.h                    |  18 +-
>  tools/perf/util/kwork.h                       |   9 +-
>  tools/perf/util/machine.c                     |  14 +-
>  tools/perf/util/machine.h                     |   3 -
>  tools/perf/util/powerpc-vpadtl.c              |  10 +-
>  tools/perf/util/s390-sample-raw.c             |  31 +--
>  tools/perf/util/sample.c                      |  11 +-
>  tools/perf/util/sample.h                      | 119 ++++++++++-
>  .../util/scripting-engines/trace-event-perl.c |  23 +--
>  .../scripting-engines/trace-event-python.c    |  47 ++---
>  tools/perf/util/session.c                     |  74 ++++---
>  tools/perf/util/synthetic-events.c            |  57 ++++--
>  tools/perf/util/synthetic-events.h            |   2 -
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  65 files changed, 1045 insertions(+), 906 deletions(-)
> 
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
