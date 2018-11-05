From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Mon, 5 Nov 2018 21:51:19 +0100
Message-ID: <20181105205119.GC25674@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <13521319.OzbRBoFVZM@agathebauer>
 <20181102112635.GD5458@krava>
 <3227038.olIWmsCzzY@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3227038.olIWmsCzzY@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Nov 02, 2018 at 06:56:50PM +0100, Milian Wolff wrote:

SNIP

> > > 
> > > Note how precise levels 0 and 1 do not produce any samples where unwinding
> > > fails. But precise level 2 produces some, and precise level 3 increases
> > > the
> > > amount (by ca. ~2x).
> > > 
> > > I can reproduce this pattern on two separate Intel CPUs and kernel
> > > versions
> > > currently:
> > > 
> > > Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz with 4.18.16-arch1-1-ARCH
> > > Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 4.14.78-1-lts
> > > 
> > > Could someone else try this? What about AMD and IBS - is it also affected?
> > > What about newer/different Intel CPUs?
> > 
> > I tried on intel and can't actualy see that.. how do the failed samples
> > look like? like is there the stack dump attached, what's in the regs?
> > 
> > could you please paste the 'perf report -D' output for some of the
> > failed samples?
> 
> See here for one case: https://paste.kde.org/prryvdilq

we should really print some helpfull debug output
for this.. like to show some markers where the stack
data starts

> 
> What Intel CPU did you use? What microcode version? Which kernel version?
> 
> Generally, isn't what I'm seeing actually a neccessary evil of the ustack 
> based unwinding in perf? I mean, the general procedure is as follows if I'm 
> not mistaken:
> 
> - PMU triggers interrupt and PEBS stores RIP etc.
> - code continous to execute, possibly changing the stack

I dont think the code continues to execute.. the stack is ok

the problem I saw in past is that the copy from user is not
100% and sometimes you might not get full stack data you
asked for

have you tried with libdw unwinder? if one of the unwinder
shows more callchains, we need to fix the other one ;-)

jirka
