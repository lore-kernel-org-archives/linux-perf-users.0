From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Mon, 5 Nov 2018 16:10:37 -0800
Message-ID: <20181106001037.GQ6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3799078.YBnU1OB0PF@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> > > - PMU triggers interrupt and PEBS stores RIP etc.
> > > - code continous to execute, possibly changing the stack
> > 
> > I dont think the code continues to execute.. the stack is ok
> 
> Are you sure about this? I mean, isn't that the whole reason why we need PEBS? 
> Generally, if you are sure about this, can you point me to some documentation 
> on this to allow me to understand it better?

Milian is right.

There is a execution window from PEBS capturing registers to actually triggering
the PMU, and if there is stack manipulation in that window
the PEBS state might be out of sync with the real stack.

The right RIP/RSP to use for the stack unwinding is always the data
in the PMI's exception frame on the stack.

Probably would need to modify perf to report those too in addition
to the PEBS registers.

Of course it would still mean that the stack unwinding may not exactly
match the sample RIP, but at least it should be consistent.

-Andi
