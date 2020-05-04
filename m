From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v4 01/12] perf expr: unlimited escaped characters in a
 symbol
Date: Mon, 4 May 2020 12:18:41 +0530
Message-ID: <dfa7d820-668b-2269-98b9-398093a8d894@linux.ibm.com>
References: <20200501173333.227162-1-irogers@google.com>
 <20200501173333.227162-2-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200501173333.227162-2-irogers@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org



On 5/1/20 11:03 PM, Ian Rogers wrote:
> Current expression allows 2 escaped '-,=' characters. However, some
> metrics require more, for example Haswell DRAM_BW_Use.
> 
> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 74b9b59b1aa5..73db6a9ef97e 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -86,7 +86,7 @@ number		[0-9]+
>  sch		[-,=]
>  spec		\\{sch}
>  sym		[0-9a-zA-Z_\.:@?]+
> -symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
> +symbol		({spec}|{sym})+

Acked and Tested By: Kajol Jain <kjain@linux.ibm.com>
>  
>  %%
>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> 
