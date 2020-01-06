From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf report: Clarify in help that --children is default
Date: Mon, 6 Jan 2020 19:16:47 -0300
Message-ID: <20200106221647.GA16851@kernel.org>
References: <20200103183643.149150-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200103183643.149150-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jan 03, 2020 at 10:36:43AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Refer to --no-children, which is what most people probably
> want.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 387311c67264..059639f437e5 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1163,7 +1163,8 @@ int cmd_report(int argc, const char **argv)
>  			     report_callchain_help, &report_parse_callchain_opt,
>  			     callchain_default_opt),
>  	OPT_BOOLEAN(0, "children", &symbol_conf.cumulate_callchain,
> -		    "Accumulate callchains of children and show total overhead as well"),
> +		    "Accumulate callchains of children and show total overhead as well. "
> +		    "Enabled by default, use --no-children to disable."),
>  	OPT_INTEGER(0, "max-stack", &report.max_stack,
>  		    "Set the maximum stack depth when parsing the callchain, "
>  		    "anything beyond the specified depth will be ignored. "
> -- 
> 2.23.0

-- 

- Arnaldo
