From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf expr: Add < and > operators
Date: Wed, 10 Jun 2020 11:21:36 -0300
Message-ID: <20200610142136.GO24868@kernel.org>
References: <20200610051717.170457-1-irogers@google.com>
 <20200610051717.170457-2-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200610051717.170457-2-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 09, 2020 at 10:17:16PM -0700, Ian Rogers escreveu:
> These are broadly useful and necessary for Intel's top-down analysis.

Ditto.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 2 ++
>  tools/perf/util/expr.y | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 298d86660a96..13e5e3c75f56 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -111,6 +111,8 @@ else		{ return ELSE; }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> +"<"		{ return '<'; }
> +">"		{ return '>'; }
>  "-"		{ return '-'; }
>  "+"		{ return '+'; }
>  "*"		{ return '*'; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index fe145344bb39..5fcb98800f9c 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
>  %left '|'
>  %left '^'
>  %left '&'
> +%left '<' '>'
>  %left '-' '+'
>  %left '*' '/' '%'
>  %left NEG NOT
> @@ -73,7 +74,7 @@ other: ID
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
>  |
> -D_RATIO
> +'<' | '>' | D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
>  	;
> @@ -94,6 +95,8 @@ expr:	  NUMBER
>  	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
>  	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
>  	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
> +	| expr '<' expr		{ $$ = $1 < $3; }
> +	| expr '>' expr		{ $$ = $1 > $3; }
>  	| expr '+' expr		{ $$ = $1 + $3; }
>  	| expr '-' expr		{ $$ = $1 - $3; }
>  	| expr '*' expr		{ $$ = $1 * $3; }
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

-- 

- Arnaldo
