Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51474468C09;
	Thu, 30 Jul 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438071; cv=none; b=JuLyYnElkS47RWNlorxP9Iu/6iZQSqesYRI/MpB76OEKSi+0Hnhh8+KaOTqhiNZz/eClko8Jz1c+3IQxnrFxIq+acLZTq2LFQ6Ps0O6hjisga+GKZPzD5uWnRjOjfAhlSdLNrNI+xfN1qlQ0UFA6X6Eh8+km6NyBfTTKEZCXR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438071; c=relaxed/simple;
	bh=zfiZM5XzcKn91pstdwU6M+kGdgqlzQlVs+AG2AyYuIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwAWIth3raehOoqYhDVUKV+GpK9gbATU1eCh/6UWDg/PEQNFOIxZYMdRbS9n+vxwh/Em3mEDbz2uzrxilFjCgB7OAqMJK/Awbb3BsYSCL16TTrQj9mvZMDYng8VrCFak2JLdhXnOlMwn1AXweO9LWLjqXbviYtxdSrPUgpZKMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONz1SCaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONz1SCaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474D1F00A3A;
	Thu, 30 Jul 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438042;
	bh=N28i5mQ3wBeE7mvDVmN3/ZFnUovgogXsQkYUz6BS3wM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ONz1SCaYZWJvvxnQbkP++SHjj/65gyjJSHEAp4BkT6FA16ScJ89ZtP1zKQxy9RyKa
	 bT3ULbwXo5iIQVpppEedoN/K1HoAIoGK4S2YNpbrHdAHbmJkpWEaJqK2bAhYD3gpsa
	 I/W0jWkE8I36F5F8XFtEXl9IyWFbvvype3FF7Q6zRm8j0t1Cv5Hhg1bH1PMK1VbeBH
	 6/zSS/OAWSAXXq5GEzrf/nJfvj1/+GgVz3WOG5fZKj3n2J0E+bEbpgKpUqomhUyELv
	 o2b0xJoS4oUCA5LeKv/G7RD7BytbmMi1/E2z6yOScq3B0qQUbAwFxm/y3ka0bwhxHi
	 wTbQLuyjH6Wdg==
Date: Thu, 30 Jul 2026 20:00:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] perf/cxl: Fix the counter overflow delta fixup
Message-ID: <20260730200037.0517df7a@jic23-huawei>
In-Reply-To: <51728f3b-e75d-4b63-a355-7d0b0398d0dc@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-4-dave.jiang@intel.com>
	<20260729232142.050ed34c@jic23-huawei>
	<51728f3b-e75d-4b63-a355-7d0b0398d0dc@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 09:56:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/29/26 3:21 PM, Jonathan Cameron wrote:
> > On Wed, 29 Jul 2026 07:55:49 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Counters are configured with Freeze on Overflow and are never reloaded: on
> >> overflow the counter wraps to 0, counts on until the CPMU freezes, and  
> > Hi Dave,
> > 
> > Thanks for looking at these.
> > 
> > Why would it count on if it froze?  I think the bot is tripping over the
> > fact we don't yet implement free running counters (and the other bug
> > about not unfreezing) for currently the ability to freeze on only some
> > counters (to do periodic sampling for instance).
> > 
> > The CXL CPMU spec is incredibly broad in what is supported, so maybe
> > we want to harden things anyway but I'm not sure the condition described
> > by most of this is real.
> >   
> >> retains that residual (CXL r4.0 8.2.7.2.3). So the masked subtraction in
> >> __cxl_pmu_read() only spans the wrap when new_cnt < prev_cnt.  
> > 
> > It's been a long time so maybe I have how this was meant to work wrong.
> > 
> > There are two paths to __cxl_pmu_read()
> > 
> > 1. We have freeze on overflow enabled so any counter that overflows results
> > in an interrupt. At that point all counters are frozen.
> > We then read only the counter that overflowed (which is 0) and that
> > will update the prev_cnt storage.  No chance of hitting the full wrap
> > around seen here.
> > 
> > 2. An on demand read (polling) In this case the counter may
> > take any value, but because we have freeze on overflow it can't have
> > wrapped (as otherwise we'd have taken path 1).
> > 
> > So slightly fun question of why we have any wrapping control and I think
> > the answer is because the freeze on overflow isn't very specific in the
> > spec for whether it freezes on max value or 0.  
> 
> Vague enough that hardware can freeze on overflow but leave greater than 0 value? Or is it always either max value or 0? If you don't think this patch is needed I can drop. 

Ah.  Good point. I think the spec at least comprehends increments of
more than 1 for some events so it might not be 0 and this patch would
therefore be needed for that corner case.


> 
> DJ
> 
> > 
> >   
> >>
> >> The fixup keys off the delta rather than the operands:
> >>
> >> 	delta = (new_cnt - prev_cnt) & GENMASK_ULL(counter_width - 1, 0);
> >> 	if (overflow && delta < GENMASK_ULL(counter_width - 1, 0))
> >> 		delta += (1UL << counter_width);
> >>
> >> and is wrong both ways. After a mid-period read the subtraction already
> >> spans the wrap, but the guard holds for all but one delta value, so a
> >> second period is added and the event over-counts. After an earlier
> >> overflow read - or after event_start(), which leaves prev_count at 0 -
> >> prev_cnt is a small residual, and once the new residual is greater or
> >> equal only the difference between the two is counted and the period is
> >> lost, which for a residual of 0 means every period after the first.
> >> 'perf stat -I' hits the former, plain 'perf stat' the latter.
> >>
> >> The shift is also undefined for counter_width == 64, and for >= 32 on
> >> 32-bit kernels where 1UL is 32 bits.  
> > 
> > That bit seems valid.
> >   
> >>
> >> Condition the fixup on new_cnt >= prev_cnt, the one case the masked
> >> subtraction cannot express, and use mask + 1 for the period: it is 0 for a
> >> 64-bit counter, the correct sum mod 2^64, and needs no shift. A
> >> userspace read landing between the wrap and the handler clearing the
> >> overflow status stays correct because the counter is frozen and cannot
> >> advance between the two reads.
> >>
> >> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> >> Reported-by: sashiko-bot@kernel.org
> >> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> v2:
> >> - Fix the fixup instead of deleting it. v1 dropped it on the rationale
> >>   that the masked subtraction already handles the wrap, which only holds
> >>   for new_cnt < prev_cnt; with freeze on overflow and no reload the
> >>   overflow path routinely sees new_cnt >= prev_cnt, where v1 silently
> >>   dropped a full period (sashiko-bot,
> >>   https://lore.kernel.org/linux-cxl/20260728211411.47B2D1F000E9@smtp.kernel.org/).
> >> - Keep the overflow argument and the __cxl_pmu_read()/cxl_pmu_read()
> >>   split; v1 folded them together once the argument went unused.
> >> - Use mask + 1 rather than 1ULL << counter_width so the 64-bit counter
> >>   case needs no special casing.
> >> ---
> >>  drivers/perf/cxl_pmu.c | 18 ++++++++++++------
> >>  1 file changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> >> index 3138514157cd..956da8202551 100644
> >> --- a/drivers/perf/cxl_pmu.c
> >> +++ b/drivers/perf/cxl_pmu.c
> >> @@ -690,7 +690,7 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
> >>  {
> >>  	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
> >>  	struct hw_perf_event *hwc = &event->hw;
> >> -	u64 new_cnt, prev_cnt, delta;
> >> +	u64 new_cnt, prev_cnt, delta, mask;
> >>  
> >>  	do {
> >>  		prev_cnt = local64_read(&hwc->prev_count);
> >> @@ -698,12 +698,18 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
> >>  	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
> >>  
> >>  	/*
> >> -	 * If we know an overflow occur then take that into account.
> >> -	 * Note counter is not reset as that would lose events
> >> +	 * The counter wraps to 0 and is never reloaded, so the masked unsigned
> >> +	 * subtraction only recovers a wrap when new_cnt < prev_cnt. On the
> >> +	 * overflow path new_cnt >= prev_cnt means the full period elapsed
> >> +	 * (prev_cnt is 0 from event_start(), or the residual left by an earlier
> >> +	 * overflow), so add the period back. mask + 1 is 2^counter_width, which
> >> +	 * evaluates to 0 for a 64-bit counter - the correct sum mod 2^64, and
> >> +	 * avoids the undefined 1 << 64.
> >>  	 */
> >> -	delta = (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
> >> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> >> -		delta += (1UL << info->counter_width);
> >> +	mask = GENMASK_ULL(info->counter_width - 1, 0);
> >> +	delta = (new_cnt - prev_cnt) & mask;
> >> +	if (overflow && new_cnt >= prev_cnt)
> >> +		delta += mask + 1;
> >>  
> >>  	local64_add(delta, &event->count);
> >>  }  
> >   
> 

