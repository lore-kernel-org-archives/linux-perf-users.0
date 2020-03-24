From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Tue, 24 Mar 2020 11:25:57 +0100
Message-ID: <20200324102557.GN1534489@krava>
References: <20200323235846.104937-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200323235846.104937-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 23, 2020 at 04:58:46PM -0700, Ian Rogers wrote:

SNIP

> +		/* no event */
> +		if (*q == '\0')
> +			continue;
> +
> +		memset(&attr, 0, sizeof(attr));
> +		event_attr_init(&attr);
> +
> +		ret = parse_libpfm_event(q, &attr);
> +		if (ret != PFM_SUCCESS) {
> +			fprintf(stderr, "failed to parse event %s : %s\n", str, pfm_strerror(ret));
> +			goto error;
> +		}
> +
> +		evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries);
> +		if (evsel == NULL)
> +			goto error;
> +
> +		evsel->name = strdup(q);
> +		if (!evsel->name) {
> +			evsel__delete(evsel);
> +			goto error;
> +		}
> +		evsel->is_libpfm_event = true;
> +
> +		pmu = perf_pmu__find_by_type((unsigned)attr.type);
> +		if (pmu)
> +			evsel->core.own_cpus = perf_cpu_map__get(pmu->cpus);

I think you need to do more setup in here, like in __add_event function
would be great to factor those bits from __add_event function and call
it from here, so it's all in one place

jirka
