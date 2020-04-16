From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v9 4/4] perf tools: add support for libpfm4
Date: Thu, 16 Apr 2020 11:55:48 +0200
Message-ID: <20200416095548.GD369437@krava>
References: <20200416063551.47637-1-irogers@google.com>
 <20200416063551.47637-5-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416063551.47637-5-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 15, 2020 at 11:35:51PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..80ac598f125b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -43,6 +43,7 @@
>  #include "util/time-utils.h"
>  #include "util/units.h"
>  #include "util/bpf-event.h"
> +#include "util/pfm.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  
> @@ -64,6 +65,9 @@
>  #include <linux/zalloc.h>
>  #include <linux/bitmap.h>
>  
> +
> +
> +

extra new lines..

jirka

>  struct switch_output {
>  	bool		 enabled;
>  	bool		 signal;
> @@ -2421,6 +2425,11 @@ static struct option __record_options[] = {
>  #endif
>  	OPT_CALLBACK(0, "max-size", &record.output_max_size,
>  		     "size", "Limit the maximum size of the output file", parse_output_max_size),
> +#ifdef HAVE_LIBPFM
> +	OPT_CALLBACK(0, "pfm-events", &record.evlist, "event",
> +		"libpfm4 event selector. use 'perf list' to list available events",
> +		parse_libpfm_events_option),
> +#endif
>  	OPT_END()
>  };

SNIP
