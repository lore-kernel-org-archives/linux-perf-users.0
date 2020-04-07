From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Mon, 6 Apr 2020 23:43:29 -0700
Message-ID: <CAP-5=fX346zwohXP_xgoZHyq4JSbV8hdLPvBR3ZpS_iOHcX1hA@mail.gmail.com>
References: <20200323235846.104937-1-irogers@google.com> <20200324102732.GR1534489@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200324102732.GR1534489@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 24, 2020 at 3:28 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 04:58:46PM -0700, Ian Rogers wrote:
> > This patch links perf with the libpfm4 library if it is available and
> > NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
> > event tables for all processors supported by perf_events. It is a helper
> > library that helps convert from a symbolic event name to the event
> > encoding required by the underlying kernel interface. This
> > library is open-source and available from: http://perfmon2.sf.net.
> >
> > With this patch, it is possible to specify full hardware events
> > by name. Hardware filters are also supported. Events must be
> > specified via the --pfm-events and not -e option. Both options
> > are active at the same time and it is possible to mix and match:
> >
> > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> >
> > v5 is a rebase.
> > v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >    branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
> >    missed in v3.
> > v3 is against acme/perf/core and removes a diagnostic warning.
> > v2 of this patch makes the --pfm-events man page documentation
> > conditional on libpfm4 behing configured. It tidies some of the
> > documentation and adds the feature test missed in the v1 patch.
> >
> > Author: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I still have some conflicts, but I merged it by hand
>
>
>         patching file tools/build/Makefile.feature
>         patching file tools/build/feature/Makefile
>         patching file tools/build/feature/test-libpfm4.c
>         patching file tools/perf/Documentation/Makefile
>         patching file tools/perf/Documentation/perf-record.txt
>         patching file tools/perf/Documentation/perf-stat.txt
>         patching file tools/perf/Documentation/perf-top.txt
>         patching file tools/perf/Makefile.config
>         patching file tools/perf/Makefile.perf
>         Hunk #3 FAILED at 834.
>         1 out of 3 hunks FAILED -- saving rejects to file tools/perf/Makefile.perf.rej
>         patching file tools/perf/builtin-list.c
>         patching file tools/perf/builtin-record.c
>         patching file tools/perf/builtin-stat.c
>         patching file tools/perf/builtin-top.c
>         Hunk #2 succeeded at 1549 (offset 2 lines).
>         Hunk #3 succeeded at 1567 (offset 2 lines).
>         patching file tools/perf/util/evsel.c
>         patching file tools/perf/util/evsel.h
>         patching file tools/perf/util/parse-events.c
>         patching file tools/perf/util/parse-events.h
>         patching file tools/perf/util/pmu.c
>         Hunk #1 succeeded at 869 (offset 5 lines).
>         patching file tools/perf/util/pmu.h
>         Hunk #1 succeeded at 65 (offset 1 line).
>
> jirka

Thanks for looking at this! I sent a new version (v7):
https://lore.kernel.org/lkml/20200407064018.158555-1-irogers@google.com/T/#u
that adds Stephane's improvements for handling fallback when
perf_event_open fails. Please let us know if there are issues we can
address with the patch set.

Thanks,
Ian
