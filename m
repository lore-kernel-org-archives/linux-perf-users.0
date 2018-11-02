From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date: Fri, 2 Nov 2018 12:26:35 +0100
Message-ID: <20181102112635.GD5458@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <20181024144818.GF6218@tassilo.jf.intel.com>
 <2122395.LD3O1NFKj8@agathebauer>
 <13521319.OzbRBoFVZM@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13521319.OzbRBoFVZM@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Nov 01, 2018 at 11:08:18PM +0100, Milian Wolff wrote:
> On Dienstag, 30. Oktober 2018 23:34:35 CET Milian Wolff wrote:
> > On Mittwoch, 24. Oktober 2018 16:48:18 CET Andi Kleen wrote:
> > > > Can someone at least confirm whether unwinding from a function prologue
> > > > via
> > > > .eh_frame (but without .debug_frame) should actually be possible?
> > > 
> > > Yes it should be possible. Asynchronous unwind tables should work
> > > from any instruction.
> 
> <snip>
> 
> > We can find `7f91345bdaf8+1 = 7f91345bdaf9" at offset 16 (search for "f9 da
> > 5b 34 91 7f"). Using that address makes unwinding work for this sample.
> > What could be the reason for this shift?
> 
> I believe I have found the culprit: PEBS seems to be at fault here - i.e. the 
> RIP/RSP and the ustack dump of the sample simply don't fit together.
> 
> Check this out:
> 
> ```
> $ for i in $(seq 10); do perf record -q -e "cycles:" --call-graph dwarf ./cpp-
> inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:p" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:pp" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 37
> 39
> 35
> 28
> 40
> 39
> 29
> 37
> 31
> 26
> 
> $ for i in $(seq 10); do perf record -q -e "cycles:ppp" --call-graph dwarf ./
> cpp-inlining > /dev/null; perf script | pcre2grep -c -M "hypot_finite.*\n.*\
> [unknown\]"; done
> 79
> 70
> 76
> 77
> 70
> 90
> 64
> 78
> 86
> 74
> ```
> 
> Note how precise levels 0 and 1 do not produce any samples where unwinding 
> fails. But precise level 2 produces some, and precise level 3 increases the 
> amount (by ca. ~2x).
> 
> I can reproduce this pattern on two separate Intel CPUs and kernel versions 
> currently:
> 
> Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz with 4.18.16-arch1-1-ARCH
> Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 4.14.78-1-lts
> 
> Could someone else try this? What about AMD and IBS - is it also affected? 
> What about newer/different Intel CPUs?

I tried on intel and can't actualy see that.. how do the failed samples
look like? like is there the stack dump attached, what's in the regs?

could you please paste the 'perf report -D' output for some of the
failed samples?

thanks,
jirka
