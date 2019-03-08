From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v4 05/15] perf tools report: Parse time quantum
Date: Fri, 8 Mar 2019 10:52:36 -0300
Message-ID: <20190308135236.GF26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-6-andi@firstfloor.org>
 <20190308134532.GC26260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308134532.GC26260@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 08, 2019 at 10:45:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 05, 2019 at 06:47:48AM -0800, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > +	if (*end == 0)
> > +		return 0;
> 
> We have tools/include/linux/time64.h, just like the kernel, so please
> use:
> 
> #include <linux/time64.h>

I'll do that this time.

- Arnado
