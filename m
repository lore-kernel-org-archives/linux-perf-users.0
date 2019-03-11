From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 05/11] perf tools report: Support running scripts for
 current time range
Date: Mon, 11 Mar 2019 14:06:28 -0300
Message-ID: <20190311170628.GR10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-6-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-6-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:56AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When using the time sort key, add new context menus to run
> scripts for only the currently selected time range. Compute
> the correct range for the selection add pass it as the --time option to
> perf script.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.


- Arnaldo
