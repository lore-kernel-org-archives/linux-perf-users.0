From: Travis Downs <travis.downs@gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Sat, 10 Nov 2018 16:42:48 -0500
Message-ID: <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer> <20181106001037.GQ6218@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106001037.GQ6218@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ak@linux.intel.com
Cc: milian.wolff@kdab.com, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Nov 5, 2018 at 7:11 PM Andi Kleen <ak@linux.intel.com> wrote:
> Milian is right.
>
> There is a execution window from PEBS capturing registers to actually triggering
> the PMU, and if there is stack manipulation in that window
> the PEBS state might be out of sync with the real stack.

This explains some weird results I was always getting especially when
functions were small, including
failed unwindings when using dwarf unwinder.

I guess this problem doesn't occur for LBR unwinding since the LBR
records are captured at the same
moment in time as the PEBS record, so reflect the correct branch
sequence. Of course, LBR doesn't
always let you unwind fully, right?

>
> The right RIP/RSP to use for the stack unwinding is always the data
> in the PMI's exception frame on the stack.
>
> Probably would need to modify perf to report those too in addition
> to the PEBS registers.
>
> Of course it would still mean that the stack unwinding may not exactly
> match the sample RIP, but at least it should be consistent.

What would this fix mean for perf report when you use cycles:pp and
cycles:ppp (or any PEBS based events)? The unwinding should generally
work, but the IP at the top of that stack (from the PMI) will
generally be different than that recorded by PEBS. The tree view and
overhead calculations will be based on the captured stacks, I guess -
but when I annotate, will the values I see correspond to the PEBS IPs
or the PMI IPs?

If someone is using cycles:pp or :ppp they probably care about
instruction-level accuracy, so it would be a shame to throw it away.
