From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Tue, 6 Nov 2018 09:39:57 +0100
Message-ID: <20181106083957.GB8081@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181106001037.GQ6218@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Nov 05, 2018 at 04:10:37PM -0800, Andi Kleen wrote:
> > > > - PMU triggers interrupt and PEBS stores RIP etc.
> > > > - code continous to execute, possibly changing the stack
> > > 
> > > I dont think the code continues to execute.. the stack is ok
> > 
> > Are you sure about this? I mean, isn't that the whole reason why we need PEBS? 
> > Generally, if you are sure about this, can you point me to some documentation 
> > on this to allow me to understand it better?
> 
> Milian is right.
> 
> There is a execution window from PEBS capturing registers to actually triggering
> the PMU, and if there is stack manipulation in that window
> the PEBS state might be out of sync with the real stack.

hum, is this about having 'large pebs' or there's this window
if there's also only single pebs record allowed? which should
be case for dwarf unwind

> The right RIP/RSP to use for the stack unwinding is always the data
> in the PMI's exception frame on the stack.
> 
> Probably would need to modify perf to report those too in addition
> to the PEBS registers.

ok, should not be that hard

> 
> Of course it would still mean that the stack unwinding may not exactly
> match the sample RIP, but at least it should be consistent.

jirka
