From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf symbols: Update the list of kernel idle symbols
Date: Mon, 20 Jan 2020 10:28:44 +0100
Message-ID: <20200120092844.GC608405@krava>
References: <20200115222949.7247-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200115222949.7247-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Song Liu <songliubraving@fb.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jan 15, 2020 at 04:29:48PM -0600, Kim Phillips wrote:
> "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and "idle_cpu"
> appear in 'perf top' output, at least on AMD systems.
> 
> Add them to perf's idle_symbols list, so they don't dominate 'perf top'
> output.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/symbol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3b379b1296f1..f3120c4f47ad 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
>  static bool symbol__is_idle(const char *name)
>  {
>  	const char * const idle_symbols[] = {
> +		"acpi_idle_do_entry",
> +		"acpi_processor_ffh_cstate_enter",
>  		"arch_cpu_idle",
>  		"cpu_idle",
>  		"cpu_startup_entry",
> +		"idle_cpu",
>  		"intel_idle",
>  		"default_idle",
>  		"native_safe_halt",

ok, at some point we should put this in strlist ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com

thanks,
jirka
