From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
Date: Mon, 20 Apr 2020 10:34:48 +0200
Message-ID: <20200420075919.GA718574@krava>
References: <20200416001303.96841-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416001303.96841-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, yuzhoujian <yuzhoujian@didichuxing.com>, Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 15, 2020 at 05:13:03PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..2f97d0c32a75 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -43,6 +43,7 @@
>  #include "util/time-utils.h"
>  #include "util/units.h"
>  #include "util/bpf-event.h"
> +#include "util/util.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  
> @@ -50,6 +51,7 @@
>  #include <inttypes.h>
>  #include <locale.h>
>  #include <poll.h>
> +#include <pthread.h>
>  #include <unistd.h>
>  #include <sched.h>
>  #include <signal.h>
> @@ -503,6 +505,20 @@ static int process_synthesized_event(struct perf_tool *tool,
>  	return record__write(rec, NULL, event, event->header.size);
>  }
>  
> +static int process_locked_synthesized_event(struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample __maybe_unused,
> +				     struct machine *machine __maybe_unused)
> +{
> +	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> +	int ret;
> +
> +	pthread_mutex_lock(&synth_lock);
> +	ret = process_synthesized_event(tool, event, sample, machine);
> +	pthread_mutex_unlock(&synth_lock);

hum, so how much faster is the synthesizing with threads in record,
given that we serialize it on every event that goes to the file?

> +	return ret;
> +}
> +
>  static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  {
>  	struct record *rec = to;
> @@ -1288,6 +1304,8 @@ static int record__synthesize(struct record *rec, bool tail)
>  	struct perf_tool *tool = &rec->tool;
>  	int fd = perf_data__fd(data);
>  	int err = 0;
> +	int (*f)(struct perf_tool *, union perf_event *, struct perf_sample *,
> +		struct machine *) = process_synthesized_event;

there's event_op typedef in util/tools.h

jirka
