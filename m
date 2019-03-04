From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 04/11] perf tools report: Parse time quantum
Date: Mon, 4 Mar 2019 15:49:04 +0100
Message-ID: <20190304144904.GM30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-5-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-5-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:43AM -0800, Andi Kleen wrote:

SNIP

> +static int
> +parse_time_quantum(const struct option *opt, const char *arg,
> +		   int unset __maybe_unused)
> +{
> +	unsigned long *time_q = opt->value;
> +	char *end;
> +
> +	*time_q = strtoul(arg, &end, 0);
> +	if (end == arg)
> +		goto parse_err;
> +	if (*time_q == 0) {
> +		pr_err("time quantum cannot be 0");
> +		return -1;
> +	}
> +	while (isspace(*end))
> +		end++;
> +	if (*end == 0)
> +		return 0;
> +	if (!strcmp(end, "s")) {
> +		*time_q *= 1000000000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "ms")) {
> +		*time_q *= 1000000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "us")) {
> +		*time_q *= 1000;
> +		return 0;
> +	}
> +	if (!strcmp(end, "ns"))
> +		return 0;
> +parse_err:
> +	pr_err("Cannot parse time quantum `%s'\n", arg);
> +	return -1;
> +}
> +
>  int
>  report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
>  				const char *arg, int unset __maybe_unused)
> @@ -1148,6 +1186,9 @@ int cmd_report(int argc, const char **argv)
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
>  	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
> +	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns)",

missing 's' unit in ()

jirka
