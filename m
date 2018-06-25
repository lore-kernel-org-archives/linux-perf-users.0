From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/4 v3] perf stat: Add transaction flag (-T) support for
 s390
Date: Tue, 26 Jun 2018 00:11:27 +0200
Message-ID: <20180625221127.GA4181@krava>
References: <20180625125856.20262-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625125856.20262-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jun 25, 2018 at 02:58:56PM +0200, Thomas Richter wrote:
> perf stat command line flag -T to display transaction counters is
> currently supported for x86 only.
> Add support for s390. It is based on the metrics flag -M transaction
> using the architecture dependend json files. This requires a metric
> named "transaction" in the json files for the platform.
> 
> v2 --> v3:
> Introduce new function metricgroup__has_metric() to check for
> the existance of a metric named transaction.
> 
> As suggested by Andi Kleen, this is the new approach to support
> transactions counters. Other architectures will follow.
> 
> Output before:
> [root@p23lp27 perf]# ./perf stat -T -- sleep 1
> Cannot set up transaction events
> [root@p23lp27 perf]#
> 
> Output after:
> [root@s35lp76 perf]# ./perf stat -T -- ~/mytesttx 1 >/tmp/111
> 
>  Performance counter stats for '/root/mytesttx 1':
> 
>                  1      tx_c_tend           #     13.0 transaction
>                  1      tx_nc_tend
>                 11      tx_nc_tabort
>                  0      tx_c_tabort_special
>                  0      tx_c_tabort_no_special
> 
>        0.001070109 seconds time elapsed
> 
> [root@s35lp76 perf]#
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/builtin-stat.c     | 12 ++++++++++++
>  tools/perf/util/metricgroup.c | 23 +++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  1 +
>  3 files changed, 36 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a4f662a462c6..e309279e7b04 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2425,6 +2425,18 @@ static int add_default_attributes(void)
>  	if (transaction_run) {
>  		struct parse_events_error errinfo;
>  
> +		/* Handle -T as -M transaction. Once platform specific metrics
> +		 * support has been added to the json files, all archictures
> +		 * will use this approach. To determine transaction support
> +		 * on an architecture test for such a metric name.
> +		 */
> +		if (metricgroup__has_metric("transaction")) {
> +			struct option opt = { .value = &evsel_list };
> +
> +			return metricgroup__parse_groups(&opt, "transaction",
> +							 &metric_events);
> +		}
> +

this won't apply now..  needs rebase to current Arnaldo's perf/core

but other than that and with Andi's comment

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
