From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] generate full callchain cursor entries for inlined
 frames
Date: Thu, 25 May 2017 00:02:37 +0900
Message-ID: <20170524150237.GA27760@danjae.aot.lge.com>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <20170522090643.GA20009@sejong>
 <1535446.SrsFzc0SgI@milian-kdab2>
 <4449663.nJV0hUTq9C@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4449663.nJV0hUTq9C@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 24, 2017 at 03:42:59PM +0200, Milian Wolff wrote:
> On Wednesday, May 24, 2017 1:46:04 PM CEST Milian Wolff wrote:
> > On Monday, May 22, 2017 11:06:43 AM CEST Namhyung Kim wrote:
> > > Why not making the fake symbol has start addr of the sample IP and
> > > length of 1.  The histogram sort code also compares the sym->start
> > > which might confuse the output of the children mode too IMHO.
> > 
> > I can try that out, thank you for the suggestion. But I think it can easily
> > break in different ways. I.e. when the same inline function gets used at
> > different IPs, it should actually be considered to be the same function when
> > we group/merge/aggregate. I updated the `match_chain` function accordingly,
> > to do a symname / srcline comparison on inlined frames, instead of relying
> > on the symbol start/end. I think using the IP for the fake symbols won't be
> > more reliable here, don't you think?
> > 
> > In the end, I think we'll always have to special-case inlined fake symbols
> > when we aggregate data, since the sym start/end is always going to be some
> > arbitrary value that may or may not be what we want it to be. Doing the
> > explicit comparison on e.g. srcline/symname is always going to be the most
> > reliable option, as it also directly results in a proper aggregation based
> > on the strings that the user will see in the end.
> 
> I haven't yet tried it out, but I think I can come up with a way to break your 
> approach easily. Assume the following pseudo-code:
> 
> void tail()
> {
>     instr1; // IP1
>     instr2; // IP2
> }
> 
> void mid()
> {
>     tail();
> }
> 
> void main()
> {
>     mid();
> }
> 
> Now, assume both `tail` and `mid` get inlined into `main`. If we get one 
> sample each for both IP1 and IP2, we want the following merged structure if we 
> merge based on symbol:
> 
> sym  | incl | self
> main | 2    | 0
> mid  | 2    | 0
> tail | 2    | 2
> 
> If we would give the inlined fake-symbols a start of the IP, i.e. either IP1 
> or IP2, then we would end up with this (unexpected) behavior instead:
> 
> sym  | incl | self
> main | 2    | 0
> mid  | 1    | 0
> mid  | 1    | 0
> tail | 1    | 1
> tail | 1    | 1
> 
> The reason is that the fake symbols for the inlined frames would be considered 
> to be different functions since their start/end are not equal. This is "wrong" 
> in my eyes - we really have to do symbol name comparisons for inlined frames, 
> and also include srcline if that is desired.

That would depend on how we treat inlined function instances.  Each
instance might be considered as same or not - but I think it'd be
better treating them as same for simplicity.

Also currently perf aggregates samples using symbol name, but a new
sort key might be added to use symbol address later.  Thus it'd be
better to be prepared for such change.

> 
> If you think the above is not a valid assessment, I'll try to change my patch 
> series to use the IP + 1 trick you suggest. But I really don't think it's 
> going to work.

So I agree that we should do symbol name comparison, but I still
prefer setting fake symbol address to [IP, +1].  That would reduce
memory space for annotate as well.

Thanks,
Namhyung


> 
> Cheers
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
