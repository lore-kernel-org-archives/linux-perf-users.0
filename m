From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v1 04/10] perf, tools, record: Clarify help for
 --switch-output
Date: Tue, 12 Mar 2019 11:30:22 +0100
Message-ID: <20190312103022.GA13071@krava>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-5-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311202446.10210-5-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 01:24:40PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The help description for --switch-output looks like there
> are multiple comma separated fields. But it's actually a choice
> of different options. Make it clear and less confusing.
> 
> Before:
> 
> % perf report -h

s/report/record/


> ...
>         --switch-output[=<signal,size,time>]
>                           Switch output when receive SIGUSR2 or cross size,time threshold
> 
> After:
> 
> % perf report -h

ditto

jirka

> ...
> 
>         --switch-output[=<signal or size[BKMG] or time[smhd]>]
>                           Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 02d7c40b2d10..e7144a1c1c82 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1989,8 +1989,8 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
>  		    "Record timestamp boundary (time of first/last samples)"),
>  	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
> -			  &record.switch_output.set, "signal,size,time",
> -			  "Switch output when receive SIGUSR2 or cross size,time threshold",
> +			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
> +			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
>  			  "signal"),
>  	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
>  		   "Limit number of switch output generated files"),
> -- 
> 2.20.1
> 
