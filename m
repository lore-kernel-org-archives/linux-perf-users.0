From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Thu, 12 Mar 2020 11:52:31 +0100
Message-ID: <20200312105231.GE311223@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200309062552.29911-7-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 09, 2020 at 11:55:50AM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 9377538f4097..d17664e628db 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -15,6 +15,7 @@ struct parse_ctx {
>  	struct parse_id ids[MAX_PARSE_ID];
>  };
>  
> +int expr__runtimeparam;
>  void expr__ctx_init(struct parse_ctx *ctx);
>  void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
>  int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 1928f2a3dddc..ec4b00671f67 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -45,6 +45,21 @@ static char *normalize(char *str)
>  			*dst++ = '/';
>  		else if (*str == '\\')
>  			*dst++ = *++str;
> +        else if (*str == '?') {
> +
> +			int size = snprintf(NULL, 0, "%d", expr__runtimeparam);
> +			char * paramval = (char *)malloc(size);

can't we agree that any reasonable number in here
wouldn't cross 20 bytes in string or so and use
buffer for that instead of that malloc exercise?

thanks,
jirka

> +			int i = 0;
> +
> +			if(!paramval)
> +				*dst++ = '0';
> +			else {
> +				sprintf(paramval, "%d", expr__runtimeparam);
> +				while(i < size)
> +					*dst++ = paramval[i++];
> +				free(paramval);
> +			}
> +		}

SNIP
