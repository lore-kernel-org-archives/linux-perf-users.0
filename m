From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Date: Thu, 6 Jun 2019 11:26:44 -0300
Message-ID: <20190606142644.GA21245@kernel.org>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 escreveu:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> One can just record callchains in the kernel or user space with
> this new options. We can use it together with "--all-kernel" options.
> This two options is used just like print_stack(sys) or print_ustack(usr)
> for systemtap.
> 
> Show below is the usage of this new option combined with "--all-kernel"
> options.
> 	1. Configure all used events to run in kernel space and just
> collect kernel callchains.
> 	$ perf record -a -g --all-kernel --kernel-callchains
> 	2. Configure all used events to run in kernel space and just
> collect user callchains.
> 	$ perf record -a -g --all-kernel --user-callchains
> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 6 ++++++
>  tools/perf/builtin-record.c              | 4 ++++
>  tools/perf/perf.h                        | 2 ++
>  tools/perf/util/evsel.c                  | 4 ++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index de269430720a..b647eb3db0c6 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
>  --all-user::
>  Configure all used events to run in user space.
>  
> +--kernel-callchains::
> +Collect callchains from kernel space.

Ok, changing this to:

Collect callchains only from kernel space. I.e. this option sets
perf_event_attr.exclude_callchain_user to 1,
perf_event_attr.exclude_callchain_kernel to 0.

> +
> +--user-callchains::
> +Collect callchains from user space.

And this one to:
Collect callchains only from user space. I.e. this option sets

perf_event_attr.exclude_callchain_kernel to 1,
perf_event_attr.exclude_callchain_user to 0.


So that the user don't try using:

    pref record --user-callchains --kernel-callchains

expecting to get both user and kernel callchains and instead gets
nothing.

Ok?

- Arnaldo

> +
>  --timestamp-filename
>  Append timestamp to output file name.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e2c3a585a61e..dca55997934e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
>  			 "Configure all used events to run in user space.",
>  			 PARSE_OPT_EXCLUSIVE),
> +	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
> +		    "collect kernel callchains"),
> +	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
> +		    "collect user callchains"),
>  	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
>  		   "clang binary to use for compiling BPF scriptlets"),
>  	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index d59dee61b64d..711e009381ec 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -61,6 +61,8 @@ struct record_opts {
>  	bool	     record_switch_events;
>  	bool	     all_kernel;
>  	bool	     all_user;
> +	bool	     kernel_callchains;
> +	bool	     user_callchains;
>  	bool	     tail_synthesize;
>  	bool	     overwrite;
>  	bool	     ignore_missing_thread;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a6f572a40deb..a606b2833e27 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>  
>  	attr->sample_max_stack = param->max_stack;
>  
> +	if (opts->kernel_callchains)
> +		attr->exclude_callchain_user = 1;
> +	if (opts->user_callchains)
> +		attr->exclude_callchain_kernel = 1;
>  	if (param->record_mode == CALLCHAIN_LBR) {
>  		if (!opts->branch_stack) {
>  			if (attr->exclude_user) {
> -- 
> 2.14.1

-- 

- Arnaldo
