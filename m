From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
Date: Thu, 23 Apr 2020 13:28:47 +0200
Message-ID: <20200423112847.GF1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-12-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-12-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:

SNIP

> +
> +static int pmu_tests(void)
> +{
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	int i, j, k;
> +	const char **ids;
> +	int idnum;
> +	int ret = 0;
> +	struct expr_parse_ctx ctx;
> +	double result;
> +
> +	i = 0;
> +	for (;;) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			map = NULL;
> +			break;
> +		}
> +		j = 0;
> +		for (;;) {
> +			pe = &map->table[j++];
> +			if (!pe->name && !pe->metric_group && !pe->metric_name)
> +				break;
> +			if (!pe->metric_expr)
> +				continue;

so we go throught all the metrics for the current cpu
and test the parsing on them.. great!

thanks,
jirka
