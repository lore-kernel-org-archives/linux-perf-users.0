From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [Patch 1/4] perf report: Add function for verbose dump of raw
 data
Date: Fri, 11 Jan 2019 11:00:59 -0300
Message-ID: <20190111140059.GV22483@kernel.org>
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190111115259.99438-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jan 11, 2019 at 12:52:56PM +0100, Thomas Richter escreveu:
> Add support to call an architecture dependend function to interpret
> raw data verbatim when dumping the perf.data file with
> option -D.

Please add "per-arch" to the summary, so that just by looking at my
inbox main page I can see what this is about.

Also how this will deal with processing a perf.data file generated on a
S/390 machine in another arch? I.e.

on s/390:

perf record -a sleep 10

on a x86_64:

scp that file
perf report -i perf.data.from.s390

?

report code should lookup a function for the architecture the perf.data
was recorded on, using the perf.data file header, etc.

        const char *arch_name = perf_env__arch(session->header->env);

Then lookup a table to find the right function, ok? See arch__find() for
an example used in the annotation code.

- Arnaldo
 
> This allows to display the event's raw data more verbatim
> than just plain hex data.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/session.c | 7 +++++++
>  tools/perf/util/session.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7d2c8ce6cfad..1c8d6d0ef300 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1050,6 +1050,12 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
>  			sample->read.one.id, sample->read.one.value);
>  }
>  
> +void __weak arch__trace_event(struct perf_evlist *evlist __maybe_unused,
> +			      union perf_event *event __maybe_unused,
> +			      struct perf_sample *sample __maybe_unused)
> +{
> +}
> +
>  static void dump_event(struct perf_evlist *evlist, union perf_event *event,
>  		       u64 file_offset, struct perf_sample *sample)
>  {
> @@ -1060,6 +1066,7 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
>  	       file_offset, event->header.size, event->header.type);
>  
>  	trace_event(event);
> +	arch__trace_event(evlist, event, sample);
>  
>  	if (sample)
>  		perf_evlist__print_tstamp(evlist, event, sample);
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index d96eccd7d27f..160d9cd6a3ae 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -128,4 +128,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
>  				    struct perf_evlist *evlist,
>  				    struct machine *machine);
>  
> +void arch__trace_event(struct perf_evlist *evlist __maybe_unused,
> +		       union perf_event *event __maybe_unused,
> +		       struct perf_sample *sample __maybe_unused);
>  #endif /* __PERF_SESSION_H */
> -- 
> 2.14.3

-- 

- Arnaldo
