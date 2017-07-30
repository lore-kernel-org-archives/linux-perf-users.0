From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/15] perf/core improvements and fixes
Date: Sun, 30 Jul 2017 11:31:20 +0200
Message-ID: <20170730093120.ywvurvaojbzb5lx4@gmail.com>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35247 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdG3JbY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 30 Jul 2017 05:31:24 -0400
Content-Disposition: inline
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eran>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit ee438ec8f33c5af0d4a4ffb935c5b9272e8c2680:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170725' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-07-26 19:07:30 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170728
> 
> for you to fetch changes up to 6b7007af728df7258bb60ed73099be3b59b3030e:
> 
>   perf data: Add doc when no conversion support compiled (2017-07-28 16:30:45 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes for 4.14:
> 
> New features:
> 
> - Add PERF_SAMPLE_CALLCHAIN and PERF_RECORD_MMAP[2] to 'perf data' CTF
>   conversion, allowing CTF trace visualization tools to show callchains
>   and to resolve symbols (Geneviève Bastien)
> 
> Improvements:
> 
> - Use group read for event groups in 'perf stat', reducing overhead when
>   groups are defined in the event specification, i.e. when using {} to
>   enclose a list of events, asking them to be read at the same time,
>   e.g.: "perf stat -e '{cycles,instructions}'" (Jiri Olsa)
> 
> Fixes:
> 
> - Do not overwrite perf_sample->weight in 'perf annotate' when
>   processing samples, use whatever came from the kernel when
>   perf_event_attr.sample_type has PERF_SAMPLE_WEIGHT set or just handle
>   its default value, 0, when that is not set and "weight" is one of the
>   sort orders chosen (Arnaldo Carvalho de Melo)
> 
> - 'perf annotate --show-total-period' fixes:
>    - TUI should show period, not nr_samples
>    - Set appropriate column width for period/percent
>    - Fix the column header to show "Period" when when that is what
>      is being asked for
>   (Taeung Song, Arnaldo Carvalho de Melo)
> 
> - Use default sort if evlist is empty, fixing pipe mode (David Carrillo-Cisneros)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (6):
>       perf annotate: Do not overwrite perf_sample->weight
>       perf annotate stdio: Set enough columns for --show-total-period
>       perf annotate: Fix storing per line sym_hist_entry
>       perf annotate TUI: Use sym_hist_entry in disasm_line_samples
>       perf annotate TUI: Clarify calculation of column header widths
>       perf annotate TUI: Set appropriate column width for period/percent
> 
> David Carrillo-Cisneros (1):
>       perf sort: Use default sort if evlist is empty
> 
> Geneviève Bastien (3):
>       perf data: Add callchain to CTF conversion
>       perf data: Add mmap[2] events to CTF conversion
>       perf data: Add doc when no conversion support compiled
> 
> Jiri Olsa (3):
>       perf tools: Add perf_evsel__read_size function
>       perf evsel: Add read_counter()
>       perf stat: Use group read for event groups
> 
> Taeung Song (2):
>       perf annotate TUI: Fix --show-total-period
>       perf annotate TUI: Fix column header when toggling period/percent
> 
>  tools/perf/builtin-annotate.c     |   2 -
>  tools/perf/builtin-data.c         |   2 +-
>  tools/perf/builtin-stat.c         |  30 +++++++-
>  tools/perf/ui/browsers/annotate.c |  36 +++++-----
>  tools/perf/util/annotate.c        |  11 +--
>  tools/perf/util/counts.h          |   1 +
>  tools/perf/util/data-convert-bt.c | 127 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/evlist.h          |   5 ++
>  tools/perf/util/evsel.c           | 139 +++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h           |   2 +
>  tools/perf/util/sort.c            |   2 +-
>  tools/perf/util/stat.c            |   4 ++
>  tools/perf/util/stat.h            |   5 +-
>  13 files changed, 334 insertions(+), 32 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
