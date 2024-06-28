Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF010155756;
	Fri, 28 Jun 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595501; cv=none; b=mQW0rteXmTUjgEHlCD5c1ZMCbfXOc6gdcI3hVHoSLtvWSWN3uldBK/y/Yra9O2EA8JfFjrHcFs7BoPQWbDO6CPdyL87FYEKxN9TKAPiD/ubwPY3I+5LqZpNsenBxDK6uoat6vBIHRiIXDMTuiwUrkNFF6TVSvH4MgY13MSXmj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595501; c=relaxed/simple;
	bh=AKDp42mRsUBja/ZLr+8Y1Iqms9ORd+ytnrDKdKS7MIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPLxyw92keeYB2o2T6jUFJgeB0Seuxa4qp1nAZOAAeD271H/sviyds0py5lg1ZiOf56vMwGVmpYiyU4GmrRLb0h0Nnxzfbvptf87lWVBbsoTcf/H/31aJSQ24e/eYb8xy6PWe9klI5T3dgbOOpB6KZS1UHRlBKi241SyXnYpv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fahcjlzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fahcjlzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60717C116B1;
	Fri, 28 Jun 2024 17:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719595501;
	bh=AKDp42mRsUBja/ZLr+8Y1Iqms9ORd+ytnrDKdKS7MIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fahcjlzO7Dqk88dt4n1sOJ3BAs41JLixAADOHyJdH1tdvF4vPVb70vNM2lEYg82EX
	 lUIB9ziaAEx23iFz/0dMlDSxHLQrQ+7vVGXIZxV+7ughBdShqrnkAqExIeAznTNTyf
	 f1jAseVHD4vNp3CCYuUhvJGVzMsl7zf7s4Nssmo3m6oZxYkZ900Wuyw8KAgYiV+X75
	 JTlTzKlbnwage8O2OokM5LfGCbiICwrSKlGqgGTc4jxXnI0/S6h9LWxg1OfmVQxAgH
	 X7Xm4NPthPo71OYampk8m6uAJq1TeR3vZrzMrdabHkJ6Yu6hwrHKNqznf99H1YZkKW
	 3pq/u56GHHRpQ==
Date: Fri, 28 Jun 2024 10:24:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nick Terrell <terrelln@fb.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/27] Constify tool pointers
Message-ID: <Zn7x6u7cedoFIHSi@google.com>
References: <20240626203630.1194748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>

On Wed, Jun 26, 2024 at 01:36:02PM -0700, Ian Rogers wrote:
> struct perf_tool provides a set of function pointers that are called
> through when processing perf data. To make filling the pointers less
> cumbersome, if they are NULL perf_tools__fill_defaults will add
> default do nothing implementations.
> 
> This change refactors struct perf_tool to have an init function that
> provides the default implementation. The special use of NULL and
> perf_tools__fill_defaults are removed. As a consequence the tool
> pointers can then all be made const, which better reflects the
> behavior a particular perf command would expect of the tool and to
> some extent can reduce the cognitive load on someone working on a
> command.

I thought you actually wanted to make the tool const (rodata) but it
seems you leave it as is but treat it as const.

I'm curious if we can change the event delivery code something like:

  if (tool->func)
      tool->func(...);
  else
      stub_func(...);

Then probably we don't need to touch the tool and make it const.
Thoughts?

Thanks,
Namhyung

> 
> v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
>     cs-etm fix for address sanitizer build, found necessary when
>     testing dummy tool change.
> 
> Ian Rogers (27):
>   perf auxevent: Zero size dummy tool
>   perf cs-etm: Fix address sanitizer dso build failure
>   perf tool: Constify tool pointers
>   perf tool: Move fill defaults into tool.c
>   perf tool: Add perf_tool__init
>   perf kmem: Use perf_tool__init
>   perf buildid-list: Use perf_tool__init
>   perf kvm: Use perf_tool__init
>   perf lock: Use perf_tool__init
>   perf evlist: Use perf_tool__init
>   perf record: Use perf_tool__init
>   perf c2c: Use perf_tool__init
>   perf script: Use perf_tool__init
>   perf inject: Use perf_tool__init
>   perf report: Use perf_tool__init
>   perf stat: Use perf_tool__init
>   perf annotate: Use perf_tool__init
>   perf sched: Use perf_tool__init
>   perf mem: Use perf_tool__init
>   perf timechart: Use perf_tool__init
>   perf diff: Use perf_tool__init
>   perf data convert json: Use perf_tool__init
>   perf data convert ctf: Use perf_tool__init
>   perf test event_update: Ensure tools is initialized
>   perf kwork: Use perf_tool__init
>   perf tool: Remove perf_tool__fill_defaults
>   perf session: Constify tool
> 
>  tools/perf/arch/x86/util/event.c    |   4 +-
>  tools/perf/bench/synthesize.c       |   2 +-
>  tools/perf/builtin-annotate.c       |  44 ++--
>  tools/perf/builtin-buildid-list.c   |  10 +
>  tools/perf/builtin-c2c.c            |  33 ++-
>  tools/perf/builtin-diff.c           |  30 ++-
>  tools/perf/builtin-evlist.c         |  10 +-
>  tools/perf/builtin-inject.c         | 159 +++++++------
>  tools/perf/builtin-kmem.c           |  20 +-
>  tools/perf/builtin-kvm.c            |  19 +-
>  tools/perf/builtin-kwork.c          |  33 ++-
>  tools/perf/builtin-lock.c           |  41 ++--
>  tools/perf/builtin-mem.c            |  37 +--
>  tools/perf/builtin-record.c         |  47 ++--
>  tools/perf/builtin-report.c         |  67 +++---
>  tools/perf/builtin-sched.c          |  50 ++--
>  tools/perf/builtin-script.c         | 106 ++++-----
>  tools/perf/builtin-stat.c           |  26 +--
>  tools/perf/builtin-timechart.c      |  25 +-
>  tools/perf/builtin-top.c            |   2 +-
>  tools/perf/builtin-trace.c          |   4 +-
>  tools/perf/tests/cpumap.c           |   6 +-
>  tools/perf/tests/dlfilter-test.c    |   2 +-
>  tools/perf/tests/dwarf-unwind.c     |   2 +-
>  tools/perf/tests/event_update.c     |   9 +-
>  tools/perf/tests/stat.c             |   6 +-
>  tools/perf/tests/thread-map.c       |   2 +-
>  tools/perf/util/Build               |   1 +
>  tools/perf/util/arm-spe.c           |  14 +-
>  tools/perf/util/auxtrace.c          |  12 +-
>  tools/perf/util/auxtrace.h          |  20 +-
>  tools/perf/util/bpf-event.c         |   4 +-
>  tools/perf/util/build-id.c          |  34 +--
>  tools/perf/util/build-id.h          |   8 +-
>  tools/perf/util/cs-etm.c            |  24 +-
>  tools/perf/util/data-convert-bt.c   |  34 ++-
>  tools/perf/util/data-convert-json.c |  47 ++--
>  tools/perf/util/dso.h               |  10 +
>  tools/perf/util/event.c             |  54 +++--
>  tools/perf/util/event.h             |  38 ++--
>  tools/perf/util/header.c            |   6 +-
>  tools/perf/util/header.h            |   4 +-
>  tools/perf/util/hisi-ptt.c          |   6 +-
>  tools/perf/util/intel-bts.c         |  14 +-
>  tools/perf/util/intel-pt.c          |  15 +-
>  tools/perf/util/jitdump.c           |   4 +-
>  tools/perf/util/s390-cpumsf.c       |  11 +-
>  tools/perf/util/session.c           | 342 ++--------------------------
>  tools/perf/util/session.h           |   6 +-
>  tools/perf/util/synthetic-events.c  |  80 +++----
>  tools/perf/util/synthetic-events.h  |  70 +++---
>  tools/perf/util/tool.c              | 294 ++++++++++++++++++++++++
>  tools/perf/util/tool.h              |  18 +-
>  tools/perf/util/tsc.c               |   2 +-
>  54 files changed, 967 insertions(+), 1001 deletions(-)
>  create mode 100644 tools/perf/util/tool.c
> 
> -- 
> 2.45.2.741.gdbec12cfda-goog
> 
