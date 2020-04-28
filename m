From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 7/7] perf record: Introduce --switch-output-event
Date: Tue, 28 Apr 2020 11:48:39 +0200
Message-ID: <20200428094839.GD1476763@krava>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200427211935.25789-8-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 27, 2020 at 06:19:35PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> ---
>  tools/perf/Documentation/perf-record.txt | 13 ++++++++
>  tools/perf/builtin-record.c              | 40 +++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 6e8b4649307c..561ef55743e2 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -556,6 +556,19 @@ overhead. You can still switch them on with:
>  
>    --switch-output --no-no-buildid  --no-no-buildid-cache
>  
> +--switch-output-event::
> +Events that will cause the switch of the perf.data file, auto-selecting
> +--switch-output=signal, the results are similar as internally the side band
> +thread will also send a SIGUSR2 to the main one.
> +
> +Uses the same syntax as --event, it will just not be recorded, serving only to
> +switch the perf.data file as soon as the --switch-output event is processed by
> +a separate sideband thread.
> +
> +This sideband thread is also used to other purposes, like processing the
> +PERF_RECORD_BPF_EVENT records as they happen, asking the kernel for extra BPF
> +information, etc.

first I thought we should follow the --switch-output 'xxx' way,
but then you need to specify an event, so I guess --switch-output-event
is better

> +
>  --switch-max-files=N::
>  
>  When rotating perf.data with --switch-output, only keep N files.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ed2244847400..8ff5eaec26e9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -87,6 +87,7 @@ struct record {
>  	struct evlist	*evlist;
>  	struct perf_session	*session;
>  	struct evlist		*sb_evlist;
> +	pthread_t		thread_id;
>  	int			realtime_prio;
>  	bool			no_buildid;
>  	bool			no_buildid_set;
> @@ -1436,6 +1437,13 @@ static int record__synthesize(struct record *rec, bool tail)
>  	return err;
>  }
>  
> +static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
> +{
> +	struct record *rec = data;
> +	pthread_kill(rec->thread_id, SIGUSR2);
> +	return 0;
> +}
> +
>  static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
>  	int err;
> @@ -1580,12 +1588,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> -	if (!opts->no_bpf_event) {
> -		rec->sb_evlist = evlist__new();
> +	if (rec->sb_evlist != NULL) {
> +		/*
> +		 * We get here if --switch-output-event populated the
> +		 * sb_evlist, so associate a callback that will send a SIGUSR2
> +		 * to the main thread.
> +		 */
> +		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
> +		rec->thread_id = pthread_self();
> +	}
>  
> +	if (!opts->no_bpf_event) {
>  		if (rec->sb_evlist == NULL) {
> -			pr_err("Couldn't create side band evlist.\n.");
> -			goto out_child;
> +			rec->sb_evlist = evlist__new();
> +
> +			if (rec->sb_evlist == NULL) {
> +				pr_err("Couldn't create side band evlist.\n.");
> +				goto out_child;
> +			}
>  		}
>  
>  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {

it's getting bigger, I wonder we should put all the sb_* setup in
separated functions like sb_start/sb_stop


> @@ -2179,10 +2199,19 @@ static int switch_output_setup(struct record *rec)
>  	};
>  	unsigned long val;
>  
> +	/*
> +	 * If we're using --switch-output-events, then we imply its 
> +	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
> +	 *  thread to its parent.
> +	 */
> +	if (rec->sb_evlist != NULL)
> +		goto do_signal;
> +
>  	if (!s->set)
>  		return 0;

hum, it looks like this jump is not necessay and can be avoided
by some bool checks.. could we add some bool when --switch-output-event
is used, so we don't depend on wether rec->sb_evlist was allocated for
whatever reason?

jirka

>  
>  	if (!strcmp(s->str, "signal")) {
> +do_signal:
>  		s->signal = true;
>  		pr_debug("switch-output with SIGUSR2 signal\n");
>  		goto enabled;
> @@ -2440,6 +2469,9 @@ static struct option __record_options[] = {
>  			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
>  			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
>  			  "signal"),
> +	OPT_CALLBACK(0, "switch-output-event", &record.sb_evlist, "switch output event",
> +		     "switch output event selector. use 'perf list' to list available events",
> +		     parse_events_option_new_evlist),
>  	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
>  		   "Limit number of switch output generated files"),
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
> -- 
> 2.21.1
> 
