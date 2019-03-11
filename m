From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 07/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 11 Mar 2019 18:24:20 +0100
Message-ID: <20190311172420.GC9664@krava>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-8-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-8-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 07:44:58AM -0700, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 9e5f87558af6..cdba58447b85 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -125,7 +125,7 @@ static int list_scripts(char *script_name, bool *custom,
>  	return ret;
>  }
>  
> -static void run_script(char *cmd)
> +void run_script(char *cmd)
>  {
>  	pr_debug("Running %s\n", cmd);
>  	SLang_reset_tty();
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index fd5d02c1a521..3a0e2bb40529 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -436,6 +436,13 @@ static int hist_entry__init(struct hist_entry *he,
>  			goto err_rawdata;
>  	}
>  
> +	if (symbol_conf.res_sample) {
> +		he->res_samples = calloc(sizeof(struct res_sample),
> +					symbol_conf.res_sample);
> +		if (!he->res_samples)
> +			return -ENOMEM;
> +	}

https://lore.kernel.org/lkml/20190311123227.GA26829@krava/

jirka
