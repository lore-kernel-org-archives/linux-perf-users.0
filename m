From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
Date: Wed, 22 Apr 2020 10:14:48 +0200
Message-ID: <20200422081448.GD962614@krava>
References: <20200416001303.96841-1-irogers@google.com>
 <20200420075919.GA718574@krava>
 <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, yuzhoujian <yuzhoujian@didichuxing.com>, Tony Jones <tonyj@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 20, 2020 at 05:31:41PM -0700, Ian Rogers wrote:

SNIP

> > > +{
> > > +     static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> > > +     int ret;
> > > +
> > > +     pthread_mutex_lock(&synth_lock);
> > > +     ret = process_synthesized_event(tool, event, sample, machine);
> > > +     pthread_mutex_unlock(&synth_lock);
> >
> > hum, so how much faster is the synthesizing with threads in record,
> > given that we serialize it on every event that goes to the file?
> 
> We see long synthesis times of the order seconds on loaded >100 core
> servers. I've not been able to create a reproduction on my desktop.
> You are right that making synthesis multithreaded will suffer from
> Amdahl's law if the write is a synchronization point. Measuring with
> the following patch in place:
> https://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com/
> without threads the portion that needs a lock is less than 1.5% of
> execution time and so there's plenty to still run in parallel:
> ...
>       - 32.59% __perf_event__synthesize_threads
>          - 32.54% __event__synthesize_thread
>             + 22.13% perf_event__synthesize_mmap_events
>             + 6.68% perf_event__get_comm_ids.constprop.0
>             + 1.49% process_synthesized_event
>             + 1.29% __GI___readdir64
>             + 0.60% __opendir
> ...
> 
> The multi-threaded benchmark in this patch (pass -t):
> https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
> shows:
> 
> Computing performance of multi threaded perf event synthesis by
> synthesizing events on CPU 0:
>  Number of synthesis threads: 1
>    Average synthesis took: 127729.000 usec (+- 3372.880 usec)
>    Average num. events: 21548.600 (+- 0.306)
>    Average time per event 5.927 usec
>  Number of synthesis threads: 2
>    Average synthesis took: 88863.500 usec (+- 385.168 usec)
>    Average num. events: 21552.800 (+- 0.327)
>    Average time per event 4.123 usec
>  Number of synthesis threads: 3
>    Average synthesis took: 83257.400 usec (+- 348.617 usec)
>    Average num. events: 21553.200 (+- 0.327)
>    Average time per event 3.863 usec
>  Number of synthesis threads: 4
>    Average synthesis took: 75093.000 usec (+- 422.978 usec)
>    Average num. events: 21554.200 (+- 0.200)
>    Average time per event 3.484 usec
>  Number of synthesis threads: 5
>    Average synthesis took: 64896.600 usec (+- 353.348 usec)
>    Average num. events: 21558.000 (+- 0.000)
>    Average time per event 3.010 usec
>  Number of synthesis threads: 6
>    Average synthesis took: 59210.200 usec (+- 342.890 usec)
>    Average num. events: 21560.000 (+- 0.000)
>    Average time per event 2.746 usec
>  Number of synthesis threads: 7
>    Average synthesis took: 54093.900 usec (+- 306.247 usec)
>    Average num. events: 21562.000 (+- 0.000)
>    Average time per event 2.509 usec
>  Number of synthesis threads: 8
>    Average synthesis took: 48938.700 usec (+- 341.732 usec)
>    Average num. events: 21564.000 (+- 0.000)
>    Average time per event 2.269 usec
> 
> The event logic there is using an atomic rather than a lock and the
> scaling isn't linear as not all the logic is threaded. Still with 8
> threads we see things going about 2.6 times faster. On a large loaded
> machine that may bring 10 seconds of event synthesis down to less than
> 4. On a desktop there's no measurable difference and the
> --num-thread-synthesize is defaulted to 1.

ok, nice ;) sorry I did not get to this before you posted v2,
but could you plz send v3 with above in the changelog?

thanks,
jirka
