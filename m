From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v9 4/4] perf tools: add support for libpfm4
Date: Thu, 16 Apr 2020 09:02:54 -0700
Message-ID: <CAP-5=fVOb1nV2gdGGWLQvTApoMR=qzaSQHSwxsAKAXQ=wqQV+g@mail.gmail.com>
References: <20200416063551.47637-1-irogers@google.com> <20200416063551.47637-5-irogers@google.com>
 <20200416095501.GC369437@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200416095501.GC369437@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 16, 2020 at 2:55 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 11:35:51PM -0700, Ian Rogers wrote:
> > From: Stephane Eranian <eranian@google.com>
> >
> > This patch links perf with the libpfm4 library if it is available
> > and NO_LIBPFM4 isn't passed to the build. The libpfm4 library
> > contains hardware event tables for all processors supported by
> > perf_events. It is a helper library that helps convert from a
> > symbolic event name to the event encoding required by the
> > underlying kernel interface. This library is open-source and
> > available from: http://perfmon2.sf.net.
> >
> > With this patch, it is possible to specify full hardware events
> > by name. Hardware filters are also supported. Events must be
> > specified via the --pfm-events and not -e option. Both options
> > are active at the same time and it is possible to mix and match:
> >
> > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
>         # perf list
>         ...
>         perf_raw pfm-events
>           r0000
>             [perf_events raw event syntax: r[0-9a-fA-F]+]
>
>         skl pfm-events
>           UNHALTED_CORE_CYCLES
>             [Count core clock cycles whenever the clock signal on the specific core is running (not halted)]
>           UNHALTED_REFERENCE_CYCLES
>
> please add ':' behind the '* pfm-events' label

Thanks! Not sure I follow here. skl here is the pmu. pfm-events is
here just to make it clearer these are --pfm-events. The event is
selected with '--pfm-events UNHALTED_CORE_CYCLES'. Will putting
skl:pfm-events here make it look like that is part of the event
encoding?

Thanks,
Ian

> jirka
>
