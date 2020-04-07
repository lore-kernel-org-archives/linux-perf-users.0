From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v7] perf tools: add support for libpfm4
Date: Tue, 7 Apr 2020 22:25:08 +0200
Message-ID: <20200407202508.GA3210726@krava>
References: <20200407064018.158555-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200407064018.158555-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 06, 2020 at 11:40:18PM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> This patch links perf with the libpfm4 library if it is available and
> NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
> event tables for all processors supported by perf_events. It is a helper
> library that helps convert from a symbolic event name to the event
> encoding required by the underlying kernel interface. This
> library is open-source and available from: http://perfmon2.sf.net.
> 
> With this patch, it is possible to specify full hardware events
> by name. Hardware filters are also supported. Events must be
> specified via the --pfm-events and not -e option. Both options
> are active at the same time and it is possible to mix and match:
> 
> $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> 
> v7 rebases and adds fallback code for libpfm4 events.
>    The fallback code is to force user only priv level in case the
>    perf_event_open() syscall failed for permissions reason.
>    the fallback forces a user privilege level restriction on the event string,
>    so depending on the syntax either u or :u is needed.
> 
>    But libpfm4 can use a : or . as the separator, so simply searching
>    for ':' vs. '/' is not good enough to determine the syntax needed.
>    Therefore, this patch introduces a new evsel boolean field to mark events
>    coming from  libpfm4. The field is then used to adjust the fallback string.

heya,
I made bunch of comments for v5, not sure you saw them:
  https://lore.kernel.org/lkml/20200323235846.104937-1-irogers@google.com/

jirka

> v6 is a rebase.
> v5 is a rebase.
> v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>    branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
>    missed in v3.
> v3 is against acme/perf/core and removes a diagnostic warning.
> v2 of this patch makes the --pfm-events man page documentation
> conditional on libpfm4 behing configured. It tidies some of the
> documentation and adds the feature test missed in the v1 patch.
> 

SNIP
