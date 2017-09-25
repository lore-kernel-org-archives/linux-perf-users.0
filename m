From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 1/4] Add a new element for the struct perf_tool, and
 add the --per-event-dump option for perf script
Date: Mon, 25 Sep 2017 14:56:14 +0200
Message-ID: <20170925125614.GA15076@krava>
References: <1506251547-35909-1-git-send-email-yuzhoujian@didichuxing.com>
 <1506251547-35909-2-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934676AbdIYM4T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Sep 2017 08:56:19 -0400
Content-Disposition: inline
In-Reply-To: <1506251547-35909-2-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 24, 2017 at 07:12:24PM +0800, yuzhoujian wrote:
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>

you're missing changelogs in all 4 patches.. you need
to describe the change in here.. check 'git log' on kernel
tee for examples

jirka

> ---
>  tools/perf/builtin-script.c | 3 +++
>  tools/perf/util/tool.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9092de0..936af8b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2729,6 +2729,7 @@ int cmd_script(int argc, const char **argv)
>  			.cpu_map	 = process_cpu_map_event,
>  			.ordered_events	 = true,
>  			.ordering_requires_timestamps = true,
> +			.per_event_dump = false,
>  		},
>  	};
>  	struct perf_data_file file = {
> @@ -2799,6 +2800,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Show context switch events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>  		    "Show namespace events (if recorded)"),
> +	OPT_BOOLEAN('\0', "per-event-dump", &script.tool.per_event_dump,
> +		    "print trace output to files named by the monitored events"),
>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_INTEGER(0, "max-blocks", &max_blocks,
>  		    "Maximum number of code blocks to dump with brstackinsn"),
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index d549e50..ad40931 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -75,6 +75,7 @@ struct perf_tool {
>  	bool		ordered_events;
>  	bool		ordering_requires_timestamps;
>  	bool		namespace_events;
> +	bool		per_event_dump;
>  	enum show_feature_header show_feat_hdr;
>  };
>  
> -- 
> 1.8.3.1
> 
