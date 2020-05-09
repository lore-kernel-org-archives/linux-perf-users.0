From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH v3 06/14] perf evsel: fix 2 memory leaks
Date: Fri, 8 May 2020 17:39:36 -0700
Message-ID: <20200509003936.GH3538@tassilo.jf.intel.com>
References: <20200508053629.210324-1-irogers@google.com>
 <20200508053629.210324-7-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200508053629.210324-7-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>Kim
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 07, 2020 at 10:36:21PM -0700, Ian Rogers wrote:
> If allocated, perf_pkg_mask and metric_events need freeing.

All these patches at the beginning look like straight forward
bug fixes and are really independent of the new features.

For them

Reviewed-by: Andi Kleen <ak@linux.intel.com>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 28683b0eb738..05bb46baad6a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1263,6 +1263,8 @@ void evsel__exit(struct evsel *evsel)
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  	zfree(&evsel->pmu_name);
> +	zfree(&evsel->per_pkg_mask);
> +	zfree(&evsel->metric_events);
>  	perf_evsel__object.fini(evsel);
>  }
>  
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
