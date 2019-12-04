From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf sched timehist: Add support for filtering on CPU
Date: Wed, 4 Dec 2019 16:28:44 -0300
Message-ID: <20191204192844.GA8535@kernel.org>
References: <20191204173925.66976-1-dsahern@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191204173925.66976-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@kernel.org>
Cc: namhyung@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 04, 2019 at 10:39:25AM -0700, David Ahern escreveu:
> From: David Ahern <dsahern@gmail.com>
> 
> Allow user to limit output to one or more CPUs. Really helpful on systems
> with a large number of cpus.

Thanks, tested and applied to perf/core, for 5.6.

- Arnaldo

> Signed-off-by: David Ahern <dsahern@gmail.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>  tools/perf/builtin-sched.c              | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 63f938b887dd..5fbe42bd599b 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
>  --max-stack::
>  	Maximum number of functions to display in backtrace, default 5.
>  
> +-C=::
> +--cpu=::
> +	Only show events for the given CPU(s) (comma separated list).
> +
>  -p=::
>  --pid=::
>  	Only show events for given process ID (comma separated list).
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8a12d71364c3..82fcc2c15fe4 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -51,6 +51,9 @@
>  #define SYM_LEN			129
>  #define MAX_PID			1024000
>  
> +static const char *cpu_list;
> +static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> +
>  struct sched_atom;
>  
>  struct task_desc {
> @@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
>  	char nstr[30];
>  	u64 wait_time;
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return;
> +
>  	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
>  	printf("%15s [%04d] ", tstr, sample->cpu);
>  
> @@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
>  
> +	if (cpu_list) {
> +		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
> +		if (err < 0)
> +			goto out;
> +	}
> +
>  	evlist = session->evlist;
>  
>  	symbol__init(&session->header.env);
> @@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
>  		   "analyze events only for given process id(s)"),
>  	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
>  		   "analyze events only for given thread id(s)"),
> +	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
>  	OPT_PARENT(sched_options)
>  	};
>  
> -- 
> 2.20.1

-- 

- Arnaldo
