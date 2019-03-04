From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 4 Mar 2019 15:48:55 +0100
Message-ID: <20190304144855.GL30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now report can show whole time periods with perf script,
> but the user still has to find individual samples of interest
> manually.
> 
> It would be expensive and complicated to search for the
> right samples in the whole perf file. Typically users
> only need to look at a small number of samples for useful
> analysis.
> 
> Also the full scripts tend to show samples of all CPUs and all
> threads mixed up, which can be very confusing on larger systems.
> 
> Add a new --samples option to save a small random number of samples
> per hist entry
> 
> Use a reservoir sample technique to select a representatve
> number of samples.
> 
> Then allow browsing the samples using perf script
> as part of the hist entry context menu. This automatically
> adds the right filters, so only the thread or cpu of the sample
> is displayed. Then we use less' search functionality
> to directly jump the to the time stamp of the selected
> sample.
> 
> It uses different menus for assembler and source display.
> Assembler needs xed installed and source needs debuginfo.
> 
> Currently it only supports as many samples as fit on
> the screen due to some limitations in the slang ui code.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Free names on error path
> Pass --inline and --show-*-event to child perf as needed.
> ---
>  tools/perf/Documentation/perf-report.txt |  4 ++
>  tools/perf/builtin-report.c              |  2 +
>  tools/perf/ui/browsers/Build             |  1 +
>  tools/perf/ui/browsers/hists.c           | 47 ++++++++++++++
>  tools/perf/ui/browsers/res_sample.c      | 80 ++++++++++++++++++++++++
>  tools/perf/ui/browsers/scripts.c         |  2 +-
>  tools/perf/util/hist.c                   | 36 +++++++++++
>  tools/perf/util/hist.h                   | 19 ++++++
>  tools/perf/util/sort.h                   |  8 +++
>  tools/perf/util/symbol.c                 |  1 +
>  tools/perf/util/symbol_conf.h            |  1 +
>  11 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/ui/browsers/res_sample.c
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 546d87221ad8..f441baa794ce 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -461,6 +461,10 @@ include::itrace.txt[]
>  --socket-filter::
>  	Only report the samples on the processor socket that match with this filter
>  
> +--samples=N::
> +	Save N individual samples for each histogram entry to show context in perf
> +	report tui browser.

maybe we could set some default value (50?)

jirka
