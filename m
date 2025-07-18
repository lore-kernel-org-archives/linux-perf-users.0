Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC917A2F5;
	Fri, 18 Jul 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862790; cv=none; b=kuK2GDHaNTZbMO5cYf27P3ll6tvDrdVaAKUgn4Hzzp/oQom+aX5vd9PdfzrvyY5DleFgg6AnqgcZNt/D08t66W9umS71KkebFEGYz5J9UNNF2+5FLvYFon84+E4iXNKIH1L0enp+t+i7c8Ae5A8aaCaJz0RzsXMUbexWKUDZGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862790; c=relaxed/simple;
	bh=HgkDBG2XvoXIvMmiMWL1rH9r2SAWb6qGh6b36D70yEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9nKojdgTZb5gKrc9VjbYPHmOnGpPTfokaLCFcmXzbGMohdiwY6sVClaH5L5/L0obvp/dFmDkp2LNRelTt5OS42enqktXZE/GFYZfDM/1BSnoEr7U6rNu075pu0D2VThF2qUrHCq4wiB6WKcxdu+9g9+pmcAHOLmTDxB9mW5RdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHQCfGiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHQCfGiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8AEC4CEEB;
	Fri, 18 Jul 2025 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752862790;
	bh=HgkDBG2XvoXIvMmiMWL1rH9r2SAWb6qGh6b36D70yEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHQCfGiE5Hp6bDoHI5f/9MEvzbAH3TJeLPDZLa9kcIhKRWlLDUsyTueMJ5A6d5iVH
	 LQAnYNmaqVrxvWaJBBmnCm3U5zknZzY3AsfLRSR1KARPuFLWPWHS3KKxJEqPTAkks5
	 uGsaeLgR1dmPd5ILao3EeYPLY987GLIvGNthe5p5DhXXEo5cKNHMJhAt2uMitAwXI6
	 f9ekxHBOQlziZuO0EB5yYzUhNMpdLtmOLNjCY5ONGDd3ASHxGz3mTFnklkaM5pr7s5
	 JAqYW3saQfp3J+w97gDlPsKQmDfCPXppMiUmITwPaNST7EHKuT5KuouanNcH3LlMux
	 kc0NCQ04qZ/BQ==
Date: Fri, 18 Jul 2025 11:19:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] CPU mask improvements/fixes particularly for
 hybrid
Message-ID: <aHqQQwI0MckHdBlY@google.com>
References: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>

On Thu, Jul 17, 2025 at 02:02:21PM -0700, Ian Rogers wrote:
> On hybrid systems some PMUs apply to all core types, particularly for
> metrics the msr PMU and the tsc event. The metrics often only want the
> values of the counter for their specific core type. These patches
> allow the cpu term in an event to give a PMU name to take the cpumask
> from. For example:
> 
>   $ perf stat -e msr/tsc,cpu=cpu_atom/ ...
> 
> will aggregate the msr/tsc/ value but only for atom cores. In doing
> this problems were identified in how cpumasks are handled by parsing
> and event setup when cpumasks are specified along with a task to
> profile. The event parsing, cpumask evlist propagation code and perf
> stat code are updated accordingly.
> 
> The final result of the patch series is to be able to run:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
>  10.1: Basic parsing test                                            : Ok
>  10.2: Parsing without PMU name                                      : Ok
>  10.3: Parsing with PMU name                                         : Ok
> 
>  Performance counter stats for 'perf test -F 10':
> 
>         63,704,975      msr/tsc/
>         47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
>         16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
> ```
> 
> This has (further) identified a kernel bug for task events around the
> enabled time being too large leading to invalid scaling (hence the
>  --no-scale in the command line above).
> 
> v2: Add additional documentation of the cpu term to `perf list`
>     (Namhyung), extend the term to also allow CPU ranges. Add Thomas
>     Falcon's reviewed-by. Still open for discussion whether the term
>     cpu should have >1 variant for PMUs, etc. or whether the single
>     term is okay. We could refactor later and add a term, but that
>     would break existing users, but they are most likely to be metrics
>     so probably not a huge issue.

I slightly prefer a new term to minimize the possible confusion.  But
it's not strong and I'm open to other opinion.

On the other hand, the 'cpu' term is new and I don't think it has many
users outside.  So probably we can change it later.

Thanks,
Namhyung

> 
> Ian Rogers (12):
>   perf parse-events: Warn if a cpu term is unsupported by a CPU
>   perf stat: Avoid buffer overflow to the aggregation map
>   perf stat: Don't size aggregation ids from user_requested_cpus
>   perf parse-events: Allow the cpu term to be a PMU or CPU range
>   perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
>   libperf evsel: Rename own_cpus to pmu_cpus
>   libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
>   perf evsel: Use libperf perf_evsel__exit
>   perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
>   perf parse-events: Minor __add_event refactoring
>   perf evsel: Add evsel__open_per_cpu_and_thread
>   perf parse-events: Support user CPUs mixed with threads/processes
> 
>  tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
>  tools/lib/perf/evsel.c                  |   9 +-
>  tools/lib/perf/include/internal/evsel.h |   3 +-
>  tools/perf/Documentation/perf-list.txt  |  25 +++--
>  tools/perf/builtin-stat.c               |   9 +-
>  tools/perf/tests/event_update.c         |   4 +-
>  tools/perf/util/evlist.c                |  15 +--
>  tools/perf/util/evsel.c                 |  55 +++++++++--
>  tools/perf/util/evsel.h                 |   5 +
>  tools/perf/util/expr.c                  |   2 +-
>  tools/perf/util/header.c                |   4 +-
>  tools/perf/util/parse-events.c          | 112 ++++++++++++++++------
>  tools/perf/util/pmus.c                  |  29 +++---
>  tools/perf/util/pmus.h                  |   2 +
>  tools/perf/util/stat.c                  |   6 +-
>  tools/perf/util/synthetic-events.c      |   4 +-
>  tools/perf/util/tool_pmu.c              |  56 +++++++++--
>  tools/perf/util/tool_pmu.h              |   2 +-
>  18 files changed, 323 insertions(+), 137 deletions(-)
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
