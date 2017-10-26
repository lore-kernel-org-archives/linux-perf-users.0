From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 1/2] Add new elements for per-event-dump option
Date: Thu, 26 Oct 2017 10:01:43 -0300
Message-ID: <20171026130143.GH7045@kernel.org>
References: <1508921599-10832-1-git-send-email-yuzhoujian@didichuxing.com>
 <1508921599-10832-2-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932204AbdJZNBq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 09:01:46 -0400
Content-Disposition: inline
In-Reply-To: <1508921599-10832-2-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

Em Wed, Oct 25, 2017 at 04:53:18PM +0800, yuzhoujian escreveu:
> This patch will add two elements for perf_tool struct: per_event_dump
> is used to mark the per-event-dump option, last_evsel_name is used
> to save last evsel's name. Add a new struct perf_script_evsel to
> save evsel's specific data. There are three elements in this new struct:
> dump_evsel_fp is used to save the file pointer of the dump_event file,
> filename is used to save the file name of the dump_event file, samples
> is used to save the number of samples for each evsel. The perf_script_evsel
> struct will be saved in the evsel->priv. Add the OPT_BOOLEAN for per-event-dump
> in the perf_data_file struct.
> 
> Changes since v4:
> - none.
> 
> Changes since v3:
> - remove three elements for perf_evsel struct and create a new struct:
>  perf_script_evsel to save them.
> 
> Changes since v2:
> - add the last_evsel_name for per_tool struct to save last evsel's name.
> - add three elements for perf_evsel struct:dump_event_fp is used to save
>  the file pointer of the dump_event file, filename is used to save the file
>  name of the dump_event file, samples is used to save the number of samples
>  for each evsel.
> 
> Changes since v1:
> - remove the set for script.tool.per_event_dump variable,since the OPT_BOOLEAN
>  will do the same thing.
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/builtin-script.c |  3 +++
>  tools/perf/util/evsel.h     | 11 +++++++++++
>  tools/perf/util/tool.h      |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a3add2c..81f141f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2758,6 +2758,7 @@ int cmd_script(int argc, const char **argv)
>  			.cpu_map	 = process_cpu_map_event,
>  			.ordered_events	 = true,
>  			.ordering_requires_timestamps = true,
> +			.per_event_dump	 = false,

No need for this, if you simply don't init it, it will be set to false.

>  		},
>  	};
>  	struct perf_data_file file = {
> @@ -2828,6 +2829,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Show context switch events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>  		    "Show namespace events (if recorded)"),
> +	OPT_BOOLEAN('\0', "per-event-dump", &script.tool.per_event_dump,
> +		    "Dump trace output to files named by the monitored events"),

this becomes:

+	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
+		    "Dump trace output to files named by the monitored events"),

>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_INTEGER(0, "max-blocks", &max_blocks,
>  		    "Maximum number of code blocks to dump with brstackinsn"),
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index db65878..abe728d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -5,6 +5,7 @@
>  #include <stdbool.h>
>  #include <stddef.h>
>  #include <linux/perf_event.h>
> +#include <stdio.h>
>  #include <linux/types.h>
>  #include "xyarray.h"
>  #include "symbol.h"
> @@ -51,6 +52,16 @@ enum {
>  	PERF_EVSEL__CONFIG_TERM_MAX,
>  };
>  
> +/*
> + * The struct perf_script_evsel is used to save the dump file's name,
> + * dump file's fp and the total number of samples for each evsel.
> + */
> +struct perf_script_evsel {
> +	char 		*filename;
> +	FILE		*dump_evsel_fp;
> +	unsigned long	samples;
> +};
> +

Don't pollute evsel.h with things that specific to some tool, this is
not the place to put this.

>  struct perf_evsel_config_term {
>  	struct list_head	list;
>  	int	type;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index d549e50..2cbcee4 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -75,6 +75,8 @@ struct perf_tool {
>  	bool		ordered_events;
>  	bool		ordering_requires_timestamps;
>  	bool		namespace_events;
> +	bool		per_event_dump;
> +	const char	*last_evsel_name;
>  	enum show_feature_header show_feat_hdr;

Ditto, this should be in struct perf_script.

I'm cooking a patch...

>  };
>  
> -- 
> 1.8.3.1
