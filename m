From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Tue, 24 Mar 2020 11:25:28 +0100
Message-ID: <20200324102528.GM1534489@krava>
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

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 616fbda7c3fc..11421f5dc9cb 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -869,6 +869,17 @@ static struct perf_pmu *pmu_find(const char *name)
>  	return NULL;
>  }
>  
> +struct perf_pmu *perf_pmu__find_by_type(unsigned int type)
> +{
> +	struct perf_pmu *pmu;
> +
> +	list_for_each_entry(pmu, &pmus, list)
> +		if (pmu->type == type)
> +			return pmu;
> +
> +	return NULL;
> +}

please move this to separate patch

thanks,
jirka

> +
>  struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
>  {
>  	/*
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 5fb3f16828df..de3b868d912c 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -65,6 +65,7 @@ struct perf_pmu_alias {
>  };
>  
>  struct perf_pmu *perf_pmu__find(const char *name);
> +struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
>  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
>  		     struct list_head *head_terms,
>  		     struct parse_events_error *error);
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
