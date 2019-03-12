From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/3] perf, tools, report: Handle samples without time
Date: Tue, 12 Mar 2019 12:14:24 +0100
Message-ID: <20190312111424.GC24700@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-2-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312035224.30350-2-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 08:52:22PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When a sample doesn't have a time stamp (e.g. from --no-time),
> show the beginning of the trace for res samples instead of generating
> an impossible time range that errors out.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/ui/browsers/res_sample.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index c0dd73176d42..c450a3536f10 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -60,7 +60,9 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  		return -1;
>  	r = &res_samples[choice];
>  
> -	n = timestamp__scnprintf_nsec(r->time - context_len, trange, sizeof trange);
> +	n = timestamp__scnprintf_nsec(r->time > context_len ?
> +				      r->time - context_len : r->time,
> +				      trange, sizeof trange);
>  	trange[n++] = ',';
>  	timestamp__scnprintf_nsec(r->time + context_len, trange + n, sizeof trange - n);
>  
> -- 
> 2.20.1
> 
