From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Date: Tue, 22 Aug 2017 12:20:25 +0200
Message-ID: <20170822102025.prgdo4vxy2cjx2xp@gmail.com>
References: <20170821192549.17251-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38178 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdHVKUa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2017 06:20:30 -0400
Content-Disposition: inline
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9881223c6cc0644cc3aeea41e1f19ea7e3041f33:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170816' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-17 09:41:56 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170821
> 
> for you to fetch changes up to 3a555c7799de69d73826eccc9a21948a5775d4d3:
> 
>   perf annotate browser: Circulate percent, total-period and nr-samples view (2017-08-18 11:23:20 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Support --show-nr-samples in annotate's --stdio and --tui, using
>   the existing 't' toggle to circulate 'percent', 'total-period' and
>   'nr-samples' as the first column (Taeung Song)
> 
> - Support FCMask and PortMask in JSON vendor events (Andi Kleen)
> 
> - Fix off by one string allocation problem in 'perf trace' (Arnaldo Carvalho de Melo)
> 
> - Use just one parse events state struct in yyparse(), fixing one
>   reported segfault when a routine received a different data struct,
>   smaller than the one it expected to use (Arnaldo Carvalho de Melo)
> 
> - Remove unused cpu_relax() macros, they stopped being used when
>   tools/perf lived in Documentation/ (Arnaldo Carvalho de Melo)
> 
> - Fix double file test in libbpf's Makefile (Daniel Díaz):
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf jevents: Support FCMask and PortMask
> 
> Arnaldo Carvalho de Melo (7):
>       perf trace: Fix off by one string allocation problem
>       perf events parse: Remove some needless local variables
>       perf events parse: Rename parsing state struct to clearer name
>       perf events parse: Use just one parse events state struct
>       perf events parse: Rename parse_events_parse arguments
>       perf tools: Remove unused cpu_relax() macros
>       perf tools: Use default CPUINFO_PROC where it fits
> 
> Daniel Díaz (1):
>       tools lib bpf: Fix double file test in Makefile
> 
> Taeung Song (4):
>       perf annotate stdio: Support --show-nr-samples option
>       perf annotate: Document --show-total-period option
>       perf annotate browser: Support --show-nr-samples option
>       perf annotate browser: Circulate percent, total-period and nr-samples view
> 
>  tools/lib/bpf/Makefile                     |  4 +-
>  tools/perf/Documentation/perf-annotate.txt |  6 ++
>  tools/perf/builtin-annotate.c              | 16 ++++-
>  tools/perf/builtin-trace.c                 |  2 +-
>  tools/perf/perf-sys.h                      | 28 +--------
>  tools/perf/pmu-events/jevents.c            |  2 +
>  tools/perf/tests/bpf.c                     | 16 ++---
>  tools/perf/ui/browsers/annotate.c          | 25 ++++++--
>  tools/perf/util/annotate.c                 |  6 +-
>  tools/perf/util/header.c                   |  3 -
>  tools/perf/util/parse-events.c             | 96 +++++++++++++++---------------
>  tools/perf/util/parse-events.h             | 19 +++---
>  tools/perf/util/parse-events.y             | 94 ++++++++++++++---------------
>  13 files changed, 159 insertions(+), 158 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
