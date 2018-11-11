From: Travis Downs <travis.downs@gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Sat, 10 Nov 2018 21:54:54 -0500
Message-ID: <CAOBGo4wmMEP_uy8dHh3UvXShHDPBuac=EwJ+HqJfpuzzQRoL=g@mail.gmail.com>
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com> <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
 <20181111010702.GC6218@tassilo.jf.intel.com> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ak@linux.intel.com
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sat, Nov 10, 2018 at 8:07 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Sat, Nov 10, 2018 at 04:42:48PM -0500, Travis Downs wrote:
> > I guess this problem doesn't occur for LBR unwinding since the LBR
> > records are captured at the same
> > moment in time as the PEBS record, so reflect the correct branch
> > sequence.
>
> Actually it happens with LBRs too, but it always gives the backtrace
> consistently at the PMI trigger point.


That's weird - so the LBR records are from the PMI point, but the rest
of the PEBS record comes from the PEBS trigger point? Or the LBR isn't
part of PEBS at all?

>
> > What would this fix mean for perf report when you use cycles:pp and
> > cycles:ppp (or any PEBS based events)? The unwinding should generally
> > work, but the IP at the top of that stack (from the PMI) will
> > generally be different than that recorded by PEBS. The tree view and
> > overhead calculations will be based on the captured stacks, I guess -
> > but when I annotate, will the values I see correspond to the PEBS IPs
> > or the PMI IPs?
>
> Based on PEBS IPs.
>
> It would be a good idea to add a check to perf report
> that the two IPs are different, and if they differ
> add some indicator to the sample. This could be a new sort key,
> although that would waste some space on the screen, or something
> else.


In the case that PEBS events are used, the IP will differ essentially
100% of the time, right? That is, there will always be *some* skid.

>
>
> It wouldn't be cover all cases, for example if you have recursion
> on the same function it might report the same IP even though
> it's a different instance, but I presume that should be rare
> enough to not be a problem.
>

Well the main problem I see is that "IP inconsistency" will be the
usual case, and it will be hard to resent in a reasonable way in the
report. For example, the backtrace-based displays/reports may indicate
that 80% of your samples are in function X, but based on the PEBS IP
records, only 50% may fall in that function, so you'll always have a
weird thing where when you are investigating within the stack-display
you might see 1234 samples in a function, but when you annotate only
789 samples are accounted for, or whatever.

I don't think this is 100% solvable, it's mostly an issue of
displaying it reasonably and managing expectations.

If the LBR record came from PEBS (as I had thought, but perhaps you
are indicating otherwise above), I could imagine a hybrid mode where
LBR is used to go back some number of calls and then dwarf or FP or
whatever unwinding takes over, because the further down the stack you
do the more likely the PEBS trigger point and PMI point are likely to
have a consistent stack.
