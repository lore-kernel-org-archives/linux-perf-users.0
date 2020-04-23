From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 06/11] perf expr: parse numbers as doubles
Date: Thu, 23 Apr 2020 13:29:28 +0200
Message-ID: <20200423112928.GI1136647@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-7-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422220430.254014-7-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 03:04:25PM -0700, Ian Rogers wrote:
> This is expected in expr.y and metrics use floating point values such as
> x86 broadwell IFetch_Line_Utilization.

ugh, I wonder why we did not get any compiler warning when expr.y
expects double.. good catch

jirka

> 
> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 95bcf3629edf..0efda2ce2766 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -10,12 +10,12 @@
>  char *expr_get_text(yyscan_t yyscanner);
>  YYSTYPE *expr_get_lval(yyscan_t yyscanner);
>  
> -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> +static double __value(YYSTYPE *yylval, char *str, int token)
>  {
> -	u64 num;
> +	double num;
>  
>  	errno = 0;
> -	num = strtoull(str, NULL, base);
> +	num = strtod(str, NULL);
>  	if (errno)
>  		return EXPR_ERROR;
>  
> @@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
>  	return token;
>  }
>  
> -static int value(yyscan_t scanner, int base)
> +static int value(yyscan_t scanner)
>  {
>  	YYSTYPE *yylval = expr_get_lval(scanner);
>  	char *text = expr_get_text(scanner);
>  
> -	return __value(yylval, text, base, NUMBER);
> +	return __value(yylval, text, NUMBER);
>  }
>  
>  /*
> @@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
>  }
>  %}
>  
> -number		[0-9]+
> +number		[0-9]*\.?[0-9]+
>  
>  sch		[-,=]
>  spec		\\{sch}
> @@ -92,7 +92,7 @@ min		{ return MIN; }
>  if		{ return IF; }
>  else		{ return ELSE; }
>  #smt_on		{ return SMT_ON; }
> -{number}	{ return value(yyscanner, 10); }
> +{number}	{ return value(yyscanner); }
>  {symbol}	{ return str(yyscanner, ID); }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 
