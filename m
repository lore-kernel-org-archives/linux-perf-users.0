From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 04/11] perf tools report: Use less for scripts output
Date: Mon, 11 Mar 2019 14:05:04 -0300
Message-ID: <20190311170504.GQ10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-5-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-5-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:55AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The UI viewer for scripts output has a lot of limitations: limited size,
> no search or save function, slow, and various other issues.
> 
> Just use 'less' to display directly on the terminal instead.
> 
> This won't work in gtk mode, but gtk doesn't support these
> context menus anyways. If that is ever done could use an terminal
> for the output.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks. applied.
