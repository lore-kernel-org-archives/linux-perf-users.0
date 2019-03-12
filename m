From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/3] perf, tools, report: Set up samples correctly in
 hierarchy mode
Date: Tue, 12 Mar 2019 12:12:59 +0100
Message-ID: <20190312111259.GA24700@krava>
References: <20190312035224.30350-1-andi@firstfloor.org>
 <20190312035224.30350-4-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312035224.30350-4-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 11, 2019 at 08:52:24PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> In hierarchy mode the res samples need to be cloned from the parent
> entry. Copy them in this case. This fixes res sample browsing
> with --hierarchy.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/hist.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 1f230285d78a..dcf24581dfbd 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
>  	}
>  
>  	if (symbol_conf.res_sample) {
> -		he->res_samples = calloc(sizeof(struct res_sample),
> -					symbol_conf.res_sample);
> +		if (he->res_samples) {

I dont think this leg will ever execute because we don't set
res_samples in template

jirka

> +			he->res_samples = memdup(he->res_samples,
> +						sizeof(struct res_sample) *
> +						symbol_conf.res_sample);
> +		} else {
> +			he->res_samples = calloc(sizeof(struct res_sample),
> +						 symbol_conf.res_sample);
> +			he->num_res = 0;
> +		}
>  		if (!he->res_samples)
>  			goto err_srcline;
>  	}
> -- 
> 2.20.1
> 
