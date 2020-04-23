From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 05/11] perf expr: increase max other
Date: Thu, 23 Apr 2020 13:29:15 +0200
Message-ID: <20200423112915.GH1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-6-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-6-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:24PM -0700, Ian Rogers wrote:
> Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
> need more space.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 0938ad166ece..4938bfc608b7 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 64
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>  
>  struct expr_parse_id {
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

ok, and we should probably start to think about what Andi suggested
in here: https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/

jirka
