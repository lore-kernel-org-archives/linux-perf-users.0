From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 07/11] perf tools report: Support running scripts for
 current time range
Date: Mon, 4 Mar 2019 15:48:40 +0100
Message-ID: <20190304144840.GJ30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-8-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-8-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:46AM -0800, Andi Kleen wrote:

SNIP

> +add_script_opt(struct hist_browser *browser,
> +	       struct popup_action *act, char **optstr,
> +	       struct thread *thread, struct symbol *sym)
> +{
> +	int n, j;
> +	struct hist_entry *he;
> +
> +	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
> +
> +	he = hist_browser__selected_entry(browser);
> +	if (sort_order && strstr(sort_order, "time")) {
> +		char tstr[128];
> +
> +		optstr++;
> +		act++;
> +		j = sprintf(tstr, " in ");
> +		j += timestamp__scnprintf_usec(he->time, tstr + j,
> +					       sizeof tstr - j);
> +		j += sprintf(tstr + j, "-");
> +		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
> +				          tstr + j,
> +				          sizeof tstr - j);

no need to put sizeof on extra line

jirka
