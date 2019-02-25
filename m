From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/11] perf tools report: Support running scripts for
 current time range
Date: Mon, 25 Feb 2019 13:56:35 +0100
Message-ID: <20190225125635.GL19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-8-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-8-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:18AM -0800, Andi Kleen wrote:

SNIP

> +			endtime += 1*1000000;
> +		}
> +		timestamp__scnprintf_usec(starttime, start, sizeof start);
> +		timestamp__scnprintf_usec(endtime, end, sizeof end);
> +		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
> +	}
> +
>  	script_browse(script_opt);
> +	free(script_opt);
>  	return 0;
>  }
>  
>  static int
> -add_script_opt(struct hist_browser *browser __maybe_unused,
> +add_script_opt_2(struct hist_browser *browser __maybe_unused,
>  	       struct popup_action *act, char **optstr,
> -	       struct thread *thread, struct symbol *sym)
> +	       struct thread *thread, struct symbol *sym,
> +	       const char *tstr)
>  {
> +
>  	if (thread) {
> -		if (asprintf(optstr, "Run scripts for samples of thread [%s]",
> -			     thread__comm_str(thread)) < 0)
> +		if (asprintf(optstr, "Run scripts for samples of thread [%s]%s",
> +			     thread__comm_str(thread), tstr) < 0)
>  			return 0;
>  	} else if (sym) {
> -		if (asprintf(optstr, "Run scripts for samples of symbol [%s]",
> -			     sym->name) < 0)
> +		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
> +			     sym->name, tstr) < 0)
>  			return 0;
>  	} else {
> -		if (asprintf(optstr, "Run scripts for all samples") < 0)
> +		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
>  			return 0;

can't see the time ranges in the menu.. what's the path
to get them listed?

thanks,
jirka
