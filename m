From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/4] Add a new element for the struct perf_tool, and add
 the --per-event-dump option for perf script
Date: Fri, 22 Sep 2017 11:02:45 +0200
Message-ID: <20170922090245.GB15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-2-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-2-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:19PM +0800, yuzhoujian wrote:
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/builtin-script.c | 11 ++++++++++-
>  tools/perf/util/tool.h      |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 378f76c..91b5225 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -57,6 +57,7 @@
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>  static struct perf_stat_config	stat_config;
>  static int			max_blocks;
> +static FILE			*per_event_dump_file;
>  
>  unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
>  
> @@ -2690,6 +2691,7 @@ int cmd_script(int argc, const char **argv)
>  			.cpu_map	 = process_cpu_map_event,
>  			.ordered_events	 = true,
>  			.ordering_requires_timestamps = true,
> +			.per_event_dump = false,
>  		},
>  	};
>  	struct perf_data_file file = {
> @@ -2760,6 +2762,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Show context switch events (if recorded)"),
>  	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
>  		    "Show namespace events (if recorded)"),
> +	OPT_BOOLEAN('\0', "per-event-dump", &script.tool.per_event_dump,
> +		    "print trace output to files named by the monitored events"),
>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_INTEGER(0, "max-blocks", &max_blocks,
>  		    "Maximum number of code blocks to dump with brstackinsn"),
> @@ -2797,7 +2801,12 @@ int cmd_script(int argc, const char **argv)
>  
>  	file.path = input_name;
>  	file.force = symbol_conf.force;
> -
> +	for (i = 1; argv[i] != NULL; i++) {
> +		if (strcmp(argv[i], "--per-event-dump") == 0) {
> +			script.tool.per_event_dump = true;
> +			break;
> +		}

why do you need this? OPT_BOOLEAN loads the per_event_dump

jirka

> +	}
>  	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
>  		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
>  		if (!rec_script_path)
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
