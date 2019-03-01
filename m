From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf intel-pt: Fix divide by zero
Date: Fri, 1 Mar 2019 14:49:39 -0300
Message-ID: <20190301174939.GJ13100@kernel.org>
References: <20190301103536.7197-1-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190301103536.7197-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 01, 2019 at 12:35:36PM +0200, Adrian Hunter escreveu:
> When tsc is not available, "timeless" decoding is used but a divide by
> zero occurs if perf_time_to_tsc() is called. Ensure the divisor is not
> zero.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v4.9+
> ---
>  tools/perf/util/intel-pt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 3b497bab4324..6d288237887b 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2531,6 +2531,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	}
>  
>  	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
> +	if (pt->timeless_decoding && !pt->tc.time_mult)
> +		pt->tc.time_mult = 1;
>  	pt->have_tsc = intel_pt_have_tsc(pt);
>  	pt->sampling_mode = false;
>  	pt->est_tsc = !pt->timeless_decoding;
> -- 
> 2.17.1

-- 

- Arnaldo
