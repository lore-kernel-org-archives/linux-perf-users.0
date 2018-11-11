From: Andi Kleen <ak@linux.intel.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Sat, 10 Nov 2018 17:07:02 -0800
Message-ID: <20181111010702.GC6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
 <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Travis Downs <travis.downs@gmail.com>
Cc: milian.wolff@kdab.com, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sat, Nov 10, 2018 at 04:42:48PM -0500, Travis Downs wrote:
> I guess this problem doesn't occur for LBR unwinding since the LBR
> records are captured at the same
> moment in time as the PEBS record, so reflect the correct branch
> sequence.

Actually it happens with LBRs too, but it always gives the backtrace
consistently at the PMI trigger point.
 
> What would this fix mean for perf report when you use cycles:pp and
> cycles:ppp (or any PEBS based events)? The unwinding should generally
> work, but the IP at the top of that stack (from the PMI) will
> generally be different than that recorded by PEBS. The tree view and
> overhead calculations will be based on the captured stacks, I guess -
> but when I annotate, will the values I see correspond to the PEBS IPs
> or the PMI IPs?

Based on PEBS IPs.

It would be a good idea to add a check to perf report
that the two IPs are different, and if they differ
add some indicator to the sample. This could be a new sort key,
although that would waste some space on the screen, or something
else.

It wouldn't be cover all cases, for example if you have recursion
on the same function it might report the same IP even though
it's a different instance, but I presume that should be rare
enough to not be a problem.

-Andi
