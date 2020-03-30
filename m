From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v7 4/6] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Mon, 30 Mar 2020 21:35:58 +0200
Message-ID: <20200330193558.GD2490231@krava>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
 <20200327102528.4267-5-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200327102528.4267-5-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 27, 2020 at 03:55:26PM +0530, Kajol Jain wrote:

SNIP

>  
>  %%
>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> @@ -93,7 +106,7 @@ if		{ return IF; }
>  else		{ return ELSE; }
>  #smt_on		{ return SMT_ON; }
>  {number}	{ return value(yyscanner, 10); }
> -{symbol}	{ return str(yyscanner, ID); }
> +{symbol}	{ return str(yyscanner, ID, sctx->runtime_param); }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
>  "&"		{ return '&'; }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b905eaa907a7..66695b4a358d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -90,6 +90,7 @@ struct egroup {
>  	const char *metric_name;
>  	const char *metric_expr;
>  	const char *metric_unit;
> +	int param;

could you please use runtime_param everywhere? ... s/param/runtime_param/
or maybe just 'runtime' to keep it short..? it's param in any case ;-)

other than that it looks ok

jirka
