Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037702772D;
	Wed,  4 Mar 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586152; cv=none; b=CF/MQXM6AQqA7smb/urPQ58wJLfU/iyjUoiO//XCs581X9Olt2WbPEooYUQ+R55W7CHf2/EvLDbh7Maeh1IeCbt8gXKfXn2w/7iZQc7g1UvKjT6T4KedHOPnCcdkfy998DZRs3CVcjeYGKoo1795rU4wYisMZS2IKRaCIWo5S60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586152; c=relaxed/simple;
	bh=S0/MROHs4eSfHAG9l74chqY/q6dMxkoeRazUMS1wZAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAW5W9/lsNHgmhzZR2/GrPiHbIsg9eAgZtz+SY6dmTY3gJzxicGFynV+WDWRQF0iQKnNzfyaMuca6osgRaVqm6mN43VUiAOqZ1VrHDo/T64HOA3lic3dsZGDYi+v4YDuPp6GME2SdFi4pE7WshVBTPR4BlUrjhp2K6Y12a58Y3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ychh549u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ychh549u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464BFC116C6;
	Wed,  4 Mar 2026 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586151;
	bh=S0/MROHs4eSfHAG9l74chqY/q6dMxkoeRazUMS1wZAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ychh549uKWl81snT8NVTaaP1M4WxXElawhJLho4SUzPqbLlADv9ElpdETuI88x5nc
	 SChJRbnyT/bT7SWwKDIlJOd/YgtfNLg9753g6+R1QY45upQj+65ElQDOHKznfOjIas
	 aoTxsDqXoICTNTfh0HgP54j42Y6HTsgddYpO4//4q8jdHqHU1mkUoL/QHcifZF0YK5
	 iBmJ/Yofz/ZuU76RJchGuv+6rCnLqD2Lzh3d0RFivnFZ6Y8mdkEglmNr731aGKJpB0
	 xJQp11wgtIJuwC0gcbk63LIBKnergJT22/+zLt+NTUWXUUP9+yovCwRH0Oc5jPSiBS
	 zENfrqW0eUhoA==
Date: Tue, 3 Mar 2026 17:02:28 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	tanze <tanze@kylinos.cn>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/25] perf tool: Add evsel to perf_sample
Message-ID: <aaeEpB9OTFGVIsr4@google.com>
References: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>

On Mon, Feb 09, 2026 at 09:40:07AM -0800, Ian Rogers wrote:
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

Do you have a patch for off-CPU on top of this change?  I'd like to see
what you expect before applying massive changes.

Thanks,
Namhyung

> 
> Ian Rogers (25):
>   perf sample: Document struct perf_sample
>   perf sample: Make sure perf_sample__init/exit are used
>   perf sample: Add evsel to struct perf_sample
>   perf tool: Remove evsel from tool APIs that pass the sample
>   perf kvm: Don't pass evsel with sample
>   perf evsel: Refactor evsel__intval to perf_sample__intval
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
>   perf s390-sample-raw: Don't pass evsel with sample
>   perf evsel: Don't pass evsel with sample
> 
>  tools/perf/builtin-annotate.c                 |  28 ++-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   |  81 ++++----
>  tools/perf/builtin-kmem.c                     |  58 +++---
>  tools/perf/builtin-kvm.c                      |  22 +--
>  tools/perf/builtin-kwork.c                    | 104 ++++------
>  tools/perf/builtin-lock.c                     | 117 +++++------
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  38 ++--
>  tools/perf/builtin-sched.c                    | 183 ++++++++----------
>  tools/perf/builtin-script.c                   |  26 ++-
>  tools/perf/builtin-timechart.c                |  76 +++-----
>  tools/perf/builtin-top.c                      |  19 +-
>  tools/perf/builtin-trace.c                    | 103 +++++-----
>  tools/perf/tests/hists_cumulate.c             |   3 +-
>  tools/perf/tests/hists_filter.c               |   2 +-
>  tools/perf/tests/hists_output.c               |   3 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/switch-tracking.c            |   9 +-
>  tools/perf/util/annotate.c                    |  19 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   7 +-
>  tools/perf/util/callchain.c                   |   8 +-
>  tools/perf/util/callchain.h                   |   5 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  13 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evsel.c                       |  60 +++---
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  26 +--
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |  12 +-
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
>  tools/perf/util/s390-sample-raw.c             |  15 +-
>  tools/perf/util/sample.c                      |   8 +-
>  tools/perf/util/sample.h                      |  93 ++++++++-
>  .../util/scripting-engines/trace-event-perl.c |  23 +--
>  .../scripting-engines/trace-event-python.c    |  47 ++---
>  tools/perf/util/session.c                     |  74 ++++---
>  tools/perf/util/synthetic-events.c            |   9 +-
>  tools/perf/util/synthetic-events.h            |   2 -
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  62 files changed, 769 insertions(+), 823 deletions(-)
> 
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
