From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/3] perf, tools, report: Pass on -f to child perf script
Date: Tue, 12 Mar 2019 12:13:41 +0100
Message-ID: <20190312111341.GB24700@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-3-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312035224.30350-3-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 08:52:23PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Pass on -f to the child perf script, so that it can read the perf.data
> file if it's owned by a different user.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/ui/browsers/res_sample.c | 3 ++-
>  tools/perf/ui/browsers/scripts.c    | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index c450a3536f10..6e17e11a2ab9 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -70,7 +70,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  
>  	attr_to_script(extra_format, &evsel->attr);
>  
> -	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s | less +/%s",
> +	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s %s | less +/%s",
>  		     perf,
>  		     input_name ? "-i " : "",
>  		     input_name ? input_name : "",
> @@ -85,6 +85,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  		     symbol_conf.inline_name ? "--inline" : "",
>  		     "--show-lost-events ",
>  		     r->tid ? "--show-switch-events --show-task-events " : "",
> +		     symbol_conf.force ? "-f" : "",
>  		     tsample) < 0)
>  		return -1;
>  	run_script(cmd);
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 27cf3ab88d13..f4c438dead66 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -171,12 +171,13 @@ int script_browse(const char *script_opt, struct perf_evsel *evsel)
>  	if (list_scripts(script_name, &custom, evsel))
>  		return -1;
>  
> -	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
> +	if (asprintf(&cmd, "%s%s %s %s%s %s 2>&1 | less",
>  			custom ? "perf script -s " : "",
>  			script_name,
>  			script_opt ? script_opt : "",
>  			input_name ? "-i " : "",
> -			input_name ? input_name : "") < 0)
> +			input_name ? input_name : "",
> +			symbol_conf.force ? "-f " : "") < 0)
>  		return -1;
>  
>  	run_script(cmd);
> -- 
> 2.20.1
> 
