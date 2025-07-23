Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AD21FF42;
	Wed, 23 Jul 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293621; cv=none; b=j+nFWwK8FfGnRgoJNAMcvUgKUMK6EinjohbESGY4foTW03AYwCi5NBaP/hWVGZUWSNBtMvHHtCPPhIViuYfMMBaQepfN5E5Ns+XM3abMpFMfSXnr48jRh7LoTx8cIODmeRnNPt0bL9SMRONWQeWNUWXqFZ+0DUb3wr5hKAjzqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293621; c=relaxed/simple;
	bh=apI8pnNAFLf6iQss/lQxckExRNzFL10tAutzTRF9k5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5M8Z0uzHs34ltmsqdKoVnacIspNRKMfK5TvhkB99h3ssUAc/uHi9zmjsYmDrJ5Q+NoVA8Z8PQetMuvH/uFunxl0GjQNIJ43Izb63YopSKI017CTZk36hd21pAmGlQXfe/cQVPiBEAdZcebv0HJ4u4DQQ0qWVGig1JyGFZHvEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbCi6oRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbCi6oRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B6FC4CEF7;
	Wed, 23 Jul 2025 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753293620;
	bh=apI8pnNAFLf6iQss/lQxckExRNzFL10tAutzTRF9k5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbCi6oRp62dNOChxWFud2O3ip6O/K8eJghSx4JCeiZ9HllkZKcmfD2vrx5nD4uM0V
	 aTZAyCesPftUjuwevqcirwvPSHxYkOItW9wwGrhUPX4bUaEaFePSU1rDqFJbRGrhf0
	 G8BrvYf/ZVtVGDjU0H+8kuQrfd8+vX1qagDyvixXCJ0xl8xFzcAgahPXDkkFmf8hpi
	 k/Va+MIoUE1u6mwoQcHqmEhrBkZVWs3U08DKMOMRthDFJaZqTncgGnuoE8b/MWluvG
	 SrRs0GQaSgI/fv0b3JN8ES38UTOQwOHbkk/yQB0gmeiK7JGRkxCKN+img8bl8ll9vB
	 vLkPxhmg99bpw==
Date: Wed, 23 Jul 2025 11:00:18 -0700
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
Subject: Re: [PATCH v7 00/16] New perf ilist app
Message-ID: <aIEjMroa3bW-T7d-@google.com>
References: <20250714164405.111477-1-irogers@google.com>
 <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>

Hi Ian,

On Wed, Jul 23, 2025 at 08:32:33AM -0700, Ian Rogers wrote:
> On Mon, Jul 14, 2025 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
> >
> > This patch series builds up to the addition of a new ilist app written
> > in python using textual [1] for the UI. The app presents perf PMUs and
> > events, displays the event information as in `perf list` while at the
> > bottom of the console showing recent activity of the event in total
> > and across all CPUs. It also displays metrics, placed in a tree
> > through their metric group, again with counts being displayed in the
> > bottom panel.
> >
> > The first ground work patches of fixes, cleanup and refactoring were
> > separated into their own series here:
> > https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
> >
> > The second part of the patches adds event json for the software PMU
> > and makes the tracepoint PMU support iteration of events and the
> > like. Without these improvements the tracepoint and software PMUs will
> > appear to have no events in the ilist app. As the software PMU moves
> > parsing to json, the legacy hard coded parsing is removed. This has
> > proven controversial for hardware events and so that cleanup isn't
> > done here.
> >
> > The final patches expand the perf python APIs and add the ilist
> > command. To run it you need the updated perf.cpython.so in your
> > PYTHONPATH and then execute the script. Expanding PMUs and then
> > selecting events will cause event informatin to be displayed in the
> > top-right and the counters values to be displayed as sparklines and
> > counts in the bottom half of the screen.
> >
> > [1] https://textual.textualize.io/
> >
> > v7: Better handle errors in the python code and ignore errors when
> >     scanning PMU/events in ilist.py, improving the behavior when not
> >     root. Add a tp_pmu/python clean up. Minor kernel coding style
> >     clean up. Fix behavior of ilist if a search result isn't found but
> >     then next is chosen.
> >
> > v6: For metrics on hybrid systems don't purely match by name, also
> >     match the CPU and thread so that if the same metric exists for
> >     different PMUs the appropriate one is selected and counters may be
> >     read. Likewise use evsel maps and not the evlists.
> >
> > v5: Split the series in two. Add metric support. Various clean ups and
> >     tweaks to the app in particular around the handling of searches.
> >
> > v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
> >     displays as expected.
> >
> > v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
> >     keys. No changes in the ground work first 14 patches.
> >
> > v2: In the jevents event description duplication, some minor changes
> >     accidentally missed from v1 meaning that in v1 the descriptions
> >     were still duplicated. Expand the cover letter with some thoughts
> >     on the series.
> >
> > Ian Rogers (16):
> >   perf python: Add more exceptions on error paths
> >   perf jevents: Add common software event json
> >   perf parse-events: Remove non-json software events
> >   perf tp_pmu: Factor existing tracepoint logic to new file
> >   perf tp_pmu: Add event APIs
> >   perf list: Remove tracepoint printing code
> >   perf list: Skip ABI PMUs when printing pmu values
> >   perf python: Improve the tracepoint function if no libtraceevent
> >   perf python: Add basic PMU abstraction and pmus sequence
> >   perf python: Add function returning dictionary of all events on a PMU
> >   perf ilist: Add new python ilist command
> >   perf python: Add parse_metrics function
> >   perf python: Add evlist metrics function
> >   perf python: Add evlist compute_metric
> >   perf python: Add metrics function
> >   perf ilist: Add support for metrics
> 
> Hi,
> 
> Is there any more I can do to get this series landed? I appreciate having:
> 
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> 
> I think there is some follow up for "make install" for scripts like
> these, but I'm keen for the python API to move forward.
 
I'll review the series today so that we can get some part of it, at
least.  Basically I think we need a wrapper script like perf-ilist to
run this easily (maybe with documentation).

Thanks,
Namhyung

> >
> >  tools/perf/builtin-list.c                     |  65 ++-
> >  .../arch/common/common/software.json          |  92 ++++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
> >  tools/perf/pmu-events/jevents.py              |  15 +-
> >  tools/perf/python/ilist.py                    | 491 +++++++++++++++++
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/evsel.c                       |  21 +-
> >  tools/perf/util/parse-events.c                | 198 ++-----
> >  tools/perf/util/parse-events.h                |   1 -
> >  tools/perf/util/parse-events.l                |  38 +-
> >  tools/perf/util/parse-events.y                |  29 +-
> >  tools/perf/util/pfm.c                         |   2 +
> >  tools/perf/util/pmu.c                         |   7 +
> >  tools/perf/util/pmus.c                        |   2 +
> >  tools/perf/util/print-events.c                | 100 +---
> >  tools/perf/util/print-events.h                |   4 +-
> >  tools/perf/util/python.c                      | 519 +++++++++++++++++-
> >  tools/perf/util/tp_pmu.c                      | 209 +++++++
> >  tools/perf/util/tp_pmu.h                      |  19 +
> >  19 files changed, 1638 insertions(+), 441 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
> >  create mode 100755 tools/perf/python/ilist.py
> >  create mode 100644 tools/perf/util/tp_pmu.c
> >  create mode 100644 tools/perf/util/tp_pmu.h
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
