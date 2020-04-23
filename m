From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] perf/record: add num-synthesize-threads option
Date: Thu, 23 Apr 2020 14:09:57 +0200
Message-ID: <20200423120957.GL1136647@krava>
References: <20200422155038.9380-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422155038.9380-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, yuzhoujian <yuzhoujian@didichuxing.com>, Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 08:50:38AM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 

SNIP

> That is the processing is 1.49% of execution time and there is plenty to
> make parallel. This is shown in the benchmark in this patch:
> https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
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
> Where average time per synthesized event goes from 5.927 usec with 1
> thread to 2.269 usec with 8. This isn't a linear speed up as not all of
> synthesize code has been made parallel. If the synthesis time was about
> 10 seconds then using 8 threads may bring this down to less than 4.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
