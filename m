From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 04/11] perf tools report: Parse time quantum
Date: Mon, 25 Feb 2019 13:55:44 +0100
Message-ID: <20190225125544.GE19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-5-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-5-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:15AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 669f961316f0..d25ca5bb91e6 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -20,6 +20,8 @@
>  #include <inttypes.h>
>  #include <sys/param.h>
>  
> +unsigned long time_quantum = 100000000;

could you please put this into symbol_conf? it's not ideal,
but at least we have all the global configs in one place

thanks,
jirka

> +
>  static bool hists__filter_entry_by_dso(struct hists *hists,
>  				       struct hist_entry *he);
>  static bool hists__filter_entry_by_thread(struct hists *hists,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 4af27fbab24f..8e602b486c5c 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -531,4 +531,6 @@ static inline int hists__scnprintf_title(struct hists *hists, char *bf, size_t s
>  	return __hists__scnprintf_title(hists, bf, size, true);
>  }
>  
> +extern unsigned long time_quantum;
> +
>  #endif	/* __PERF_HIST_H */
> -- 
> 2.17.2
> 
