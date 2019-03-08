From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 05/15] perf tools report: Parse time quantum
Date: Fri, 8 Mar 2019 09:39:49 -0800
Message-ID: <20190308173949.GI7535@tassilo.jf.intel.com>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-6-andi@firstfloor.org>
 <20190308134532.GC26260@kernel.org>
 <20190308135236.GF26260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308135236.GF26260@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 10:52:36AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 08, 2019 at 10:45:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Mar 05, 2019 at 06:47:48AM -0800, Andi Kleen escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > +	if (*end == 0)
> > > +		return 0;
> > 
> > We have tools/include/linux/time64.h, just like the kernel, so please
> > use:
> > 
> > #include <linux/time64.h>
> 
> I'll do that this time.

Thanks.  I already did it in my copy too.

-Andi
