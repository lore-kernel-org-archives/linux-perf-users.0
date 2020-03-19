From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf tools: add support for libpfm4
Date: Wed, 18 Mar 2020 21:15:16 -0700
Message-ID: <CAP-5=fU0AAmW7B5Qw+mmA9PhLYgMxKtiuxo3UcPbbowKJPhg8A@mail.gmail.com>
References: <20200311213613.210749-1-irogers@google.com> <20200318102254.GC821557@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200318102254.GC821557@krava>
Sender: netdev-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 18, 2020 at 3:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Mar 11, 2020 at 02:36:13PM -0700, Ian Rogers wrote:
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
> > v3 is against acme/perf/core removes a diagnostic warning
> > v2 of this patch makes the --pfm-events man page documentation
> > conditional on libpfm4 behing configured. It tidies some of the
> > documentation and adds the feature test missed in the v1 patch.
> >
> > Author: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> hi,
> is this the latest version? I can't apply it on Arnaldo's perf/core
>
> jirka


Sorry, I'd failed to re-add the feature test when I shifted branches.
The complete patch should be here:
https://lkml.org/lkml/2020/3/19/4

Thanks,
Ian
