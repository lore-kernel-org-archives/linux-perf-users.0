From: Travis Downs <travis.downs@gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Wed, 14 Nov 2018 21:15:46 -0500
Message-ID: <CAOBGo4xzvkitZvqnsPMKE3RYwfCsVSe3ng3eJkP2vdi35JSTFg@mail.gmail.com>
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com> <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
 <20181111010702.GC6218@tassilo.jf.intel.com> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
 <20181112032637.GG6218@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112032637.GG6218@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ak@linux.intel.com
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sun, Nov 11, 2018 at 10:26 PM Andi Kleen <ak@linux.intel.com> wrote:
> On Sat, Nov 10, 2018 at 09:50:05PM -0500, Travis Downs wrote:

> LBR is not part of PEBS, but is collected separately in the PMI handler.

Thanks for clearing this up - so you can ignore any earlier
suggestions on my part of trying to use LBR to fix the unwinding
inconsistency.

> >    In the case that PEBS events are used, the IP will differ essentially 100%
> >    of the time, right? That is, there will always be *some* skid.
>
> I wouldn't say that.  It depends on what the CPU is doing and the IPC
> of the code.

Well other than say a long-latency cache miss, it is my experience
that the skid is generally never zero. That is, the PEBS and ireg IP
will usually differ. This is mostly moot though: what is important is
how often the ireg skip results in a different call chain (i.e., a
return occurred between the PEBS point and the interrupt), as you have
pointed out.

>
> Also the backtrace inconsistency can only happen if the sample races with
> function return. If you don't then the backtrace will point
> to the correct function, even though the unwind IP is different.
>
> For example in the common case where you profile a long loop it
> is unlikely to happen.

Agreed.


> Could collect numbers how often it happens, but it would surprise
> me if anything complicated is worth it. I would just do the minimum fixes
> to address the unwinder errors, and perhaps add the "unwind ip differs"
> indication.

As above, I think the most important UX problem is not when the IP
differs, but when the top frame of the IP unwind is different than the
function in which the PEBS sample occurred. I think the case where the
skid ends up with both in the same function doesn't pose any
presentation difficulties [1]. When they are different though, it
seems tough to present a consistent picture.

[1] Strictly speaking, this the "IPs are in the same function" is not
sufficient. Imagine a scenario where you have T->B->A (T calls B calls
A) and the PEBS sample happens in A, and then A and B return, and now
C then A are called (T->C->A) and the PMI happens. Now the PEBS IP and
the ireg IP are in the same function, but the stacks are still
inconsistent. It is probably fine to paper this over and show the user
the T->C->A stack, as this stack is somehow accurate (it really
happened), but the user might be confused when he looks at the
annotation for A, and sees code being executed (having PEBS samples)
that he knows can never execute when C calls A (for example) since the
annotations are based on the hidden T->B->A execution...

Bleh.
