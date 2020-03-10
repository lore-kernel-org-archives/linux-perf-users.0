From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf tools: add support for lipfm4
Date: Tue, 10 Mar 2020 12:59:15 -0700
Message-ID: <20200310195915.GA1676879@tassilo.jf.intel.com>
References: <20200310185003.57344-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310185003.57344-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhoujian
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 10, 2020 at 11:50:03AM -0700, Ian Rogers wrote:
> This patch links perf with the libpfm4 library.
> This library contains all the hardware event tables for all
> processors supported by perf_events. This is a helper library
> that help convert from a symbolic event name to the event
> encoding required by the underlying kernel interface. This
> library is open-source and available from: http://perfmon2.sf.net.

For most CPUs the builtin perf JSON event support should make
this redundant.

Perhaps you could list what CPUs it actually supports over
the existing JSON tables.

If it's only a few it would be likely better to add
appropiate json files.

If it's a massive number it might be useful, although
JSON support would be better for those too.

-Andi
