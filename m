From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 03/11] perf tools report: Support time sort key
Date: Mon, 11 Mar 2019 14:04:51 -0300
Message-ID: <20190311170451.GP10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-4-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-4-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:54AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a time sort key to perf report to display samples for
> different time quantums separately. This allows easier
> analysis of workloads that change over time, and also
> will allow looking at the context of samples.
> 
> % perf record ...
> % perf report --sort time,overhead,symbol --time-quantum 1ms --stdio
> ...
>      0.67%  277061.87300  [.] _dl_start
>      0.50%  277061.87300  [.] f1
>      0.50%  277061.87300  [.] f2
>      0.33%  277061.87300  [.] main
>      0.29%  277061.87300  [.] _dl_lookup_symbol_x
>      0.29%  277061.87300  [.] dl_main
>      0.29%  277061.87300  [.] do_lookup_x
>      0.17%  277061.87300  [.] _dl_debug_initialize
>      0.17%  277061.87300  [.] _dl_init_paths
>      0.08%  277061.87300  [.] check_match
>      0.04%  277061.87300  [.] _dl_count_modids
>      1.33%  277061.87400  [.] f1
>      1.33%  277061.87400  [.] f2
>      1.33%  277061.87400  [.] main
>      1.17%  277061.87500  [.] main
>      1.08%  277061.87500  [.] f1
>      1.08%  277061.87500  [.] f2
>      1.00%  277061.87600  [.] main
>      0.83%  277061.87600  [.] f1
>      0.83%  277061.87600  [.] f2
>      1.00%  277061.87700  [.] main

Thanks, applied.
