From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Mon, 2 Mar 2020 16:09:03 +0100
Message-ID: <20200302150903.GC259142@krava>
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200229094159.25573-7-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:

SNIP

> +					*dst++ = paramval[i++];
> +				free(paramval);
> +			}
> +		}
>  		else
>  			*dst++ = *str;
>  		str++;
> @@ -72,8 +86,8 @@ number		[0-9]+
>  
>  sch		[-,=]
>  spec		\\{sch}
> -sym		[0-9a-zA-Z_\.:@]+
> -symbol		{spec}*{sym}*{spec}*{sym}*
> +sym            [0-9a-zA-Z_\.:@?]+
> +symbol         {spec}*{sym}*{spec}*{sym}*{spec}*{sym}
>  
>  %%
>  	{
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 4720cbe79357..0f3ef0f37bf4 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -38,6 +38,8 @@
>  %type <num> expr if_expr
>  
>  %{
> +int expr__runtimeparam;

we don't like global variables.. could this be part of the
contaxt struct?

jirka
