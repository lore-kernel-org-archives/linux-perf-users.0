From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] perf record: add dummy event during system wide
 synthesis
Date: Thu, 23 Apr 2020 14:03:51 +0200
Message-ID: <20200423120318.GK1136647@krava>
References: <20200422173615.59436-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422173615.59436-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 10:36:15AM -0700, Ian Rogers wrote:
> During the processing of /proc during event synthesis new processes may
> start. Add a dummy event if /proc is to be processed, to capture mmaps
> for starting processes. This reuses the existing logic for
> initial-delay.
> 
> v3 fixes the attr test of test-record-C0

SNIP

> +config2=0
> +branch_sample_type=0
> +sample_regs_user=0
> +sample_stack_user=0
> diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
> index 93818054ae20..317730b906dd 100644
> --- a/tools/perf/tests/attr/test-record-C0
> +++ b/tools/perf/tests/attr/test-record-C0
> @@ -9,6 +9,14 @@ cpu=0
>  # no enable on exec for CPU attached
>  enable_on_exec=0
>  
> -# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PERIOD
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
>  # + PERF_SAMPLE_CPU added by -C 0
> -sample_type=391
> +sample_type=455

aah, so because now there's 2 events now, so PERF_SAMPLE_ID was added

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
