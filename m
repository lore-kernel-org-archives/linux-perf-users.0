From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Tue, 24 Mar 2020 11:27:17 +0100
Message-ID: <20200324102717.GQ1534489@krava>
References: <20200323235846.104937-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200323235846.104937-1-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 23, 2020 at 04:58:46PM -0700, Ian Rogers wrote:

SNIP

> +
> +int parse_libpfm_events_option(const struct option *opt, const char *str,
> +			int unset __maybe_unused)
> +{
> +	struct evlist *evlist = *(struct evlist **)opt->value;
> +	struct perf_event_attr attr;
> +	struct perf_pmu *pmu;
> +	struct evsel *evsel, *grp_leader = NULL;
> +	char *p, *q, *p_orig;
> +	const char *sep;
> +	int grp_evt = -1;
> +	int ret;
> +
> +	p_orig = p = strdup(str);
> +	if (!p)
> +		return -1;
> +	/*
> +	 * force loading of the PMU list
> +	 */
> +	perf_pmu__scan(NULL);
> +
> +	for (q = p; strsep(&p, ",{}"); q = p) {

it seems like this code could be really easily testtable,
could you please write simple test for this?

thanks,
jirka
