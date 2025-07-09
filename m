Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64721859A;
	Wed,  9 Jul 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078925; cv=none; b=FWfHThh7HOjLioZFMq8lJNG2kg9LDDO0r8yEJXCjPUuI6AEBbeuz++h+TCehwd6vWxGF8NS51gLxCEbrHJl4/KIJUoirYdDjDXlx/zuPjU5k0ZaKxHTCFAygJdXzSaLm3NMeaPKcyphikkHLizY+8d6ebwg2uV71g8gqxDy77Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078925; c=relaxed/simple;
	bh=qLAqIavMfIsW7n9k+wC1ExT+uqRdlxF4NJDphcNPadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6OCRaX0RcVTQYRjIi4oem8sK2tYCsGOD783Fv2CFZ+w9uXgwl7pRB5nDigw5S3uQLxiRkRoq/ALzJi7+sfamB0JKZryGQp6A70O8i+e8/akfEgaGcfyMpfR9ih93RZv7DqCNVPfg7Hl4Z60Y31LruaOw2D8iZ9SDG0JpQGlOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4VabdK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4VabdK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4095DC4CEEF;
	Wed,  9 Jul 2025 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752078925;
	bh=qLAqIavMfIsW7n9k+wC1ExT+uqRdlxF4NJDphcNPadE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4VabdK7lPH0uiw2B0R9RPJ2XfGWem2u4r4cco2AvIzQiAyjRsAH2yiRdP8y+S2yz
	 0mpghlee1q75h+2jMYXtjcJT7GYbOk8SS/jJcwYnF8IejFLwpBs7SxC7Kes0ftc+9Z
	 WA1Oz9TAtm4y0+0BWOM9p/1KtrQfagRGyuzEaHfwZaMPY3x+bAv4g2mERrpjEJxSGB
	 LjbG+vJMdaYaThi7Pet4ZqjxDd+tu+ah3hUH6OUAJBCn3t9VqZzZE5y6Ejqwxgxjxo
	 iG1uHj28n8lvEbetEMGxXrTkMqUiDp7wgtU7es13vGwLP2XZs9YcCSLsAVXe0ZB25p
	 T707zn9+DKdAg==
Date: Wed, 9 Jul 2025 09:35:21 -0700
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
	John Garry <john.g.garry@oracle.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 00/15] New perf ilist app
Message-ID: <aG6aSX0Ws1cioo5T@google.com>
References: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250628000929.230406-1-irogers@google.com>

Hi Ian,

Sorry for the delay.

On Fri, Jun 27, 2025 at 05:09:14PM -0700, Ian Rogers wrote:
> This patch series builds up to the addition of a new ilist app written
> in python using textual [1] for the UI. The app presents perf PMUs and
> events, displays the event information as in `perf list` while at the
> bottom of the console showing recent activity of the event in total
> and across all CPUs.
> 
> The first part of the patches are a few perf and perf python C API
> fixes, most importantly the counter reading in python supports tool
> PMUs.

The first part looks ok.  It'd be nice if you can send it separately.

> 
> The second part of the patches adds event json for the software PMU
> and makes the tracepoint PMU support iteration of events and the
> like. Without these improvements the tracepoint and software PMUs will
> appear to have no events in the ilist app. As the software PMU moves
> parsing to json, the legacy hard coded parsing is removed. This has
> proven controversial for hardware events and so that cleanup isn't
> done here.

I think it's ok to move hardware events to JSON as well.  Then we can
probably remove the hard coded parsing code.

The tricky part is the hybrid machines.  Would it be possible to define
common hardware with standard (legacy) encoding and to mark it "weak" or
overridable by arch-specific events with the same name?

> 
> The final patch adds the ilist command. To run it you need the updated
> perf.cpython.so in your PYTHONPATH and then execute the
> script. Expanding PMUs and then selecting events will cause event
> informatin to be displayed in the top-right and the counters values to
> be displayed as sparklines and counts in the bottom half of the
> screen.
> 
> Some thoughts on the series:
> 
>  - The PMU changes will conflict with the addition of the DRM PMU:
>    https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.com/
>    when these two are merged together ilist will show yet more
>    counters. It'd be nice if the DRM stuff could land and then I can
>    rebase these patches.

Yep, it's merged now.  Please rebase the series.

> 
>  - The parse-events clean up of the software and tracepoint PMU. The
>    software PMU hard coding to be legacy first has similar issues and
>    will conflict with the clean up in:
>    https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
>    Moving the software work to json means we don't need special parse
>    events terms for software events, etc. We can just treat things
>    like regular PMUs with json, etc. I'd much rather we had less
>    special case logic so that series is best rebased on top of this
>    work and it should drop the changes for software terms, etc. which
>    this series removes. Maybe one day the whole event parsing can be
>    much more regular in how PMUs are treated but there's always
>    "cycles".

As I said, moving the hardware events would be a solution as long as it
can handle complexities in hybrid.

> 
>  - Should python libraries have feature tests? How does this get
>    packaged outside the kernel tree? I think these are open
>    questions. Clearly textual is kind of a big dependency and we've
>    largely been moving in the direction of fewer dependencies
>    recently. Hopefully the app makes it clear why I think this one is
>    worth carrying. We carry libslang as a dependency and I think
>    textual clearly far surpasses it.

Hmm.. I think it can be checked at runtime.  And maybe it can ask users
to install the required packages.

> 
>  - How to launch? Currently I run tools/perf/python/ilist.py but it
>    would be much nicer if we could do `perf ilist` much as we do for
>    perf-archive.sh. There are probably other scripts that should be
>    perf commands like flamegraph and gecko. It'd be nice to follow up
>    the series with something to make using these commands easy.

Sounds good.

Thanks,
Namhyung

> 
>  - Additional thoughts were captured on the mailing list:
>    https://lore.kernel.org/lkml/CAP-5=fWC+doaVd5rEMWJXSQi_db_Wu2tyAe5Lm6jnQjcwXkF+w@mail.gmail.com/
>  
> [1] https://textual.textualize.io/
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
> Ian Rogers (15):
>   perf hwmon_pmu: Avoid shortening hwmon PMU name
>   perf parse-events: Minor tidy up of event_type helper
>   perf python: In str(evsel) use the evsel__pmu_name helper
>   perf python: Fix thread check in pyrf_evsel__read
>   perf python: Correct pyrf_evsel__read for tool PMUs
>   perf python: Add basic PMU abstraction and pmus sequence
>   perf python: Add function returning dictionary of all events on a PMU
>   perf jevents: If the long_desc and desc are identical then drop the
>     long_desc
>   perf jevents: Add common software event json
>   perf pmu: Tolerate failure to read the type for wellknown PMUs
>   perf parse-events: Remove non-json software events
>   perf tp_pmu: Factor existing tracepoint logic to new file
>   perf tp_pmu: Add event APIs
>   perf list: Remove tracepoint printing code
>   perf ilist: Add new python ilist command
> 
>  tools/perf/builtin-list.c                     |  47 ++-
>  .../arch/common/common/software.json          |  92 +++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++++-----
>  tools/perf/pmu-events/jevents.py              |  18 +-
>  tools/perf/python/ilist.py                    | 376 ++++++++++++++++++
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/evsel.c                       |  21 +-
>  tools/perf/util/hwmon_pmu.c                   |   2 +-
>  tools/perf/util/parse-events.c                | 225 ++++-------
>  tools/perf/util/parse-events.h                |   3 +-
>  tools/perf/util/parse-events.l                |  38 +-
>  tools/perf/util/parse-events.y                |  29 +-
>  tools/perf/util/pmu.c                         |  44 +-
>  tools/perf/util/print-events.c                |  95 -----
>  tools/perf/util/print-events.h                |   1 -
>  tools/perf/util/python.c                      | 248 +++++++++++-
>  tools/perf/util/tp_pmu.c                      | 209 ++++++++++
>  tools/perf/util/tp_pmu.h                      |  19 +
>  18 files changed, 1282 insertions(+), 452 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
>  create mode 100755 tools/perf/python/ilist.py
>  create mode 100644 tools/perf/util/tp_pmu.c
>  create mode 100644 tools/perf/util/tp_pmu.h
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
