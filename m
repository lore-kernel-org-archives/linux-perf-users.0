From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v1 06/10] perf, tools, report: Print better message for
 JITed code
Date: Mon, 11 Mar 2019 17:58:52 -0300
Message-ID: <20190311205852.GE10690@kernel.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-7-andi@firstfloor.org>
 <20190311203302.GB10690@kernel.org>
 <20190311204856.GD29294@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311204856.GD29294@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 01:48:56PM -0700, Andi Kleen escreveu:
> On Mon, Mar 11, 2019 at 05:33:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Mar 11, 2019 at 01:24:42PM -0700, Andi Kleen escreveu:
> > > +		if (!strncmp(map->dso->name, "/tmp/perf-", 10)) {
> > > +			static bool warned;
> > > +			if (!warned) {
> > > +				pr_err("Cannot find executable, JITed code present? May need agent.\n");
> > > +				warned = true;
> > > +			}
 
> > Please use WARN_ON_ONCE(), we have it in tools/include/asm/bug.h, just
> > like the kernel.

> But that prints "assertation failed". This is not a perf bug, but can happen
> in normal operation.

Sorry, we also have WARN_ONCE() and that one doesn't have any extra
message printed, only what you pass to it, right?

- Arnaldo
