Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2E17DFE7;
	Sat, 26 Jul 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571552; cv=none; b=pSqXd3RWUVJ541w+RNnZUpvFggSU/Lt5ZsrugRuELe3o+302vZcpizWMCaqL+lJTYriUGDhk+vGm6KYYBKx1hMN/9jkIz1oOYZWGDTRkTr0WVAuDbn6aMg65D12GrUNduFO8jTNqxw6+rQjXDR1LLlufOUszzNoBlbRZpmkPoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571552; c=relaxed/simple;
	bh=9Ma0AfkSwYPqifnxcNePHE2rzmoC0sMiObkPnYwR1lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbfvsOI0NLFx7MvO3LFWgxXdXdcBndyBCvY6jSiL0szCNLePkpqXUu9tsFVflr4w0WPZCVUhZsreMXS5kvw6yCcpizaNSVVksyl8DGP3QqQeWXPMK8d3jjK69RUh4ibw2PrcpARnbU4v2HshwCtqfBMg2x/Wu9Zw2+bbEiORPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/mxENg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/mxENg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F9C4CEED;
	Sat, 26 Jul 2025 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753571551;
	bh=9Ma0AfkSwYPqifnxcNePHE2rzmoC0sMiObkPnYwR1lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/mxENg0+gtHd08yRH/ewb2RurTPcU6B/1/0ejYjealFueBYgbpydvu9OgqsFFM+m
	 jOFxHIzApv6FRlFL6FDHslpgzxCHPM5G/2PZVaMAebjIGiOa3/BU/8b8nyCphCo8WS
	 ZibHFhVFRVwFtbjHvgA3pPe5QbrUJy4kV0sHNHfmSem+STpbxSS6m2jy9v6YvdIz+k
	 1rXpCqkR+dvIA3jMFB/FjqI/aI1cbD0pP8BHxYFJlRcpWt0ADrAvryJa3gxs3GfoZ+
	 hTD5v/Xi95M/1B0Ju1BOwnA7EHYjCPMEkpE9/HsoUTA6mUmpV5KkKwsu+l8vX0bMCZ
	 CEbrDOdyalHnA==
Date: Sat, 26 Jul 2025 16:12:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 00/16] New perf ilist app
Message-ID: <aIVg3X5ByiTPkXRA@google.com>
References: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725185202.68671-1-irogers@google.com>

Hi Ian,

On Fri, Jul 25, 2025 at 11:51:46AM -0700, Ian Rogers wrote:
> This patch series builds up to the addition of a new ilist app written
> in python using textual [1] for the UI. The app presents perf PMUs and
> events, displays the event information as in `perf list` while at the
> bottom of the console showing recent activity of the event in total
> and across all CPUs. It also displays metrics, placed in a tree
> through their metric group, again with counts being displayed in the
> bottom panel.
> 
> The first ground work patches of fixes, cleanup and refactoring were
> separated into their own series here:
> https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
> 
> The second part of the patches adds event json for the software PMU
> and makes the tracepoint PMU support iteration of events and the
> like. Without these improvements the tracepoint and software PMUs will
> appear to have no events in the ilist app. As the software PMU moves
> parsing to json, the legacy hard coded parsing is removed. This has
> proven controversial for hardware events and so that cleanup isn't
> done here.

Even software PMU can be controversial. :)  But I think we can try this
first.  Basically this will change the output `perf list` and the event
parsing behavior.

For example, `perf list sw` will look like:

software:
  alignment-faults
       [Number of kernel handled memory alignment faults. Unit: software]
  bpf-output
       [An event used by BPF programs to write to the perf ring buffer. Unit: software]
  cgroup-switches
       [Number of context switches to a task in a different cgroup. Unit: software]
  context-switches
       [Number of context switches [This event is an alias of cs]. Unit: software]
  cpu-clock
       [Per-CPU high-resolution timer based event. Unit: software]
  cpu-migrations
       [Number of times a process has migrated to a new CPU [This event is an alias of migrations]. Unit: software]
  cs
       [Number of context switches [This event is an alias of context-switches]. Unit: software]
  dummy
       [A placeholder event that doesn't count anything. Unit: software]
  ...

Let's add this change and see if people complain..

Btw, I think the alias can be one-way.  IOW 'context-switches' is a
software event and 'cs' is an alias to it, not vice versa.  I'll make
the change.

> 
> The final patches expand the perf python APIs and add the ilist
> command. To run it you need the updated perf.cpython.so in your
> PYTHONPATH and then execute the script. Expanding PMUs and then
> selecting events will cause event informatin to be displayed in the
> top-right and the counters values to be displayed as sparklines and
> counts in the bottom half of the screen.

This part can go to the next cycle.

Thanks,
Namhyung

> 
> [1] https://textual.textualize.io/
> 
> v9: sys metric support and pep8 clean up suggested by Xu Yang
>     <xu.yang_2@nxp.com>.
> 
> v8: nit fixing of issues caught by Arnaldo and Namhyung. Add Arnaldo's
>     tested-by. Fail to repro issue reported by Thomas Falcon but
>     encounter textual rendering and DOM query race, add an exception
>     handling path to avoid the race being fatal. The change is minor
>     in patch 16, so Arnaldo's tested-by is kept.
> 
> v7: Better handle errors in the python code and ignore errors when
>     scanning PMU/events in ilist.py, improving the behavior when not
>     root. Add a tp_pmu/python clean up. Minor kernel coding style
>     clean up. Fix behavior of ilist if a search result isn't found but
>     then next is chosen.
> 
> v6: For metrics on hybrid systems don't purely match by name, also
>     match the CPU and thread so that if the same metric exists for
>     different PMUs the appropriate one is selected and counters may be
>     read. Likewise use evsel maps and not the evlists.
> 
> v5: Split the series in two. Add metric support. Various clean ups and
>     tweaks to the app in particular around the handling of searches.
> 
> v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
>     displays as expected.
> 
> v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
>     keys. No changes in the ground work first 14 patches.
> 
> v2: In the jevents event description duplication, some minor changes
>     accidentally missed from v1 meaning that in v1 the descriptions
>     were still duplicated. Expand the cover letter with some thoughts
>     on the series.
> 
> Ian Rogers (16):
>   perf python: Add more exceptions on error paths
>   perf jevents: Add common software event json
>   perf parse-events: Remove non-json software events
>   perf tp_pmu: Factor existing tracepoint logic to new file
>   perf tp_pmu: Add event APIs
>   perf list: Remove tracepoint printing code
>   perf list: Skip ABI PMUs when printing pmu values
>   perf python: Improve the tracepoint function if no libtraceevent
>   perf python: Add basic PMU abstraction and pmus sequence
>   perf python: Add function returning dictionary of all events on a PMU
>   perf ilist: Add new python ilist command
>   perf python: Add parse_metrics function
>   perf python: Add evlist metrics function
>   perf python: Add evlist compute_metric
>   perf python: Add metrics function
>   perf ilist: Add support for metrics
> 
>  tools/perf/builtin-list.c                     |  65 ++-
>  .../arch/common/common/software.json          |  92 +++
>  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
>  tools/perf/pmu-events/jevents.py              |  15 +-
>  tools/perf/python/ilist.py                    | 495 +++++++++++++++++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/evsel.c                       |  21 +-
>  tools/perf/util/parse-events.c                | 198 ++-----
>  tools/perf/util/parse-events.h                |   1 -
>  tools/perf/util/parse-events.l                |  38 +-
>  tools/perf/util/parse-events.y                |  29 +-
>  tools/perf/util/pfm.c                         |   2 +
>  tools/perf/util/pmu.c                         |   7 +
>  tools/perf/util/pmus.c                        |   2 +
>  tools/perf/util/print-events.c                | 100 +---
>  tools/perf/util/print-events.h                |   4 +-
>  tools/perf/util/python.c                      | 522 +++++++++++++++++-
>  tools/perf/util/tp_pmu.c                      | 210 +++++++
>  tools/perf/util/tp_pmu.h                      |  19 +
>  19 files changed, 1646 insertions(+), 441 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
>  create mode 100755 tools/perf/python/ilist.py
>  create mode 100644 tools/perf/util/tp_pmu.c
>  create mode 100644 tools/perf/util/tp_pmu.h
> 
> -- 
> 2.50.1.552.g942d659e1b-goog
> 
