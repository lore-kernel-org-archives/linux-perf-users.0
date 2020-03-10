From: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: add support for lipfm4
Date: Tue, 10 Mar 2020 14:39:23 -0700
Message-ID: <CABPqkBRQo=bEOiCFGFjwcM8TZaXMFyaL7o1hcFd6Bc3w+LhJQA@mail.gmail.com>
References: <20200310185003.57344-1-irogers@google.com> <20200310195915.GA1676879@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310195915.GA1676879@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiwei Sun <jiwe>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 10, 2020 at 12:59 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Tue, Mar 10, 2020 at 11:50:03AM -0700, Ian Rogers wrote:
> > This patch links perf with the libpfm4 library.
> > This library contains all the hardware event tables for all
> > processors supported by perf_events. This is a helper library
> > that help convert from a symbolic event name to the event
> > encoding required by the underlying kernel interface. This
> > library is open-source and available from: http://perfmon2.sf.net.
>
> For most CPUs the builtin perf JSON event support should make
> this redundant.
>
We decided to post this patch to propose an alternative to the JSON
file approach. It could be an option during the build.
The libpfm4 library has been around for 15 years now. Therefore, it
supports a lot of processors core and uncore and it  is very portable.
The key value add I see is that this is a library that can be, and has
been, used by tool developers directly in their apps. It can
work with more than Linux perf_events interface. It is not tied to the
interface. It has well defined and documented entry points.
We do use libpfm4 extensively at Google in both the perf tool and
applications. The PAPI toolkit also relies on this library.

I don't see this as competing with the JSON approach. It is just an
option I'd like to offer to users especially those familiar
with it in their apps.

> Perhaps you could list what CPUs it actually supports over
> the existing JSON tables.
>
> If it's only a few it would be likely better to add
> appropiate json files.
>
> If it's a massive number it might be useful, although
> JSON support would be better for those too.
>
> -Andi
