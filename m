From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v11 0/4] perf tools: add support for libpfm4
Date: Fri, 17 Apr 2020 11:08:10 +0200
Message-ID: <20200417090810.GA468827@krava>
References: <20200416221457.46710-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416221457.46710-1-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 16, 2020 at 03:14:53PM -0700, Ian Rogers wrote:
> This patch links perf with the libpfm4 library if it is available
> and NO_LIBPFM4 isn't passed to the build. The libpfm4 library
> contains hardware event tables for all processors supported by
> perf_events. It is a helper library that helps convert from a
> symbolic event name to the event encoding required by the
> underlying kernel interface. This library is open-source and
> available from: http://perfmon2.sf.net.
>     
> With this patch, it is possible to specify full hardware events
> by name. Hardware filters are also supported. Events must be
> specified via the --pfm-events and not -e option. Both options
> are active at the same time and it is possible to mix and match:
>     
> $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> 
> v11 reformats the perf list output to be:
> List of pre-defined events (to be used in -e):
> 
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
> ...
> 
> List of pre-defined events (to be used in --pfm-events):
> 
> ix86arch:
>   UNHALTED_CORE_CYCLES
>     [count core clock cycles whenever the clock signal on the specific core is running (not halted)]
>   INSTRUCTION_RETIRED
>     [count the number of instructions at retirement. For instructions that consists of multiple mic>
> ...
> skx:
>   UNHALTED_CORE_CYCLES
>     [Count core clock cycles whenever the clock signal on the specific core is running (not halted)]
> ...
>   BACLEARS
>     [Branch re-steered]
>       BACLEARS:ANY
>         [Number of front-end re-steers due to BPU misprediction]
> ...

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
