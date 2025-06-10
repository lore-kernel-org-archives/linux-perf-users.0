Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE128EA74;
	Tue, 10 Jun 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557586; cv=none; b=Qt2eBlB1l/qZvCGdUHj+ShnK/ViMtbVtRmfCxM8zNwpX/r5AclWCDPRK5eNCd7goH597wow79hPJek9Pxa5zrKTKkgMCWe0qgSR6i06cSgrtE/jbjt4KhqG4PgVHnV2VIxEEub0dNF0l8/zScJP+e7YqIdIsMnlyCa8I1bAi/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557586; c=relaxed/simple;
	bh=O3Xr1qP4qkjKDqL5Vuq7ZSG0t68FfrTRqAtAALM71Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Xzg39sOZbNaUDwVox0gjG5N1iiyOrQTurMpIMoWPlAQLpQutVuISj7ZRmf5GQiRqpYscmoMdYZRo2266rXLacLbk8plO9ZGdZN9xCwzZtWjTqCnk0lwhdFurs574sancbcBG/c5qwhrZQcZ3uHeFhZM0CLiv7cRTRZ6RTzHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A2D14BF;
	Tue, 10 Jun 2025 05:12:43 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC2A3F673;
	Tue, 10 Jun 2025 05:13:02 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:13:00 +0100
From: Leo Yan <leo.yan@arm.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH V4] perf: Fix the throttle error of some clock events
Message-ID: <20250610121300.GR8020@e132581.arm.com>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
 <20250609123415.GJ8020@e132581.arm.com>
 <e763b0bd-cb51-4a76-816d-e12e59b02214@linux.intel.com>
 <20250609183604.GP8020@e132581.arm.com>
 <34917979-92dd-4921-be07-f456f84b6ee1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34917979-92dd-4921-be07-f456f84b6ee1@linux.intel.com>

On Mon, Jun 09, 2025 at 03:59:41PM -0400, Liang, Kan wrote:

[...]

> >> When throttling is triggered, the stop(event, 0); will be invoked.
> >> As my understanding, it's because the period is not changed with
> >> throttling. So we don't need to update the period.
> > 
> >> But if the period is changed, the update is required. You may find an
> >> example in the perf_adjust_freq_unthr_events(). In the freq mode,
> >> stop(event, PERF_EF_UPDATE) is actually invoked for the triggered event.
> > 
> >> For the clock event, the existing behavior before the throttling fix* is
> >> not to invoke the stop() in throttling. It relies on the
> >> HRTIMER_NORESTART instead. My previous throttling fix changes the
> >> behavior. It invokes both stop() and HRTIMER_NORESTART. Now, this patch
> >> change the behavior back.
> > 
> > Actually, the "event->count" has been updated in perf_swevent_hrtimer(),
> > this is why this patch does not cause big deviation if skip updating
> > count in the ->stop() callback:
> > >   perf_swevent_hrtimer()
> >    ` event->pmu->read(event);               => Update count
> >    ` __perf_event_overflow()
> >       ` perf_event_throttle()
> >          ` event->pmu->stop(event, 0) / cpu_clock_event_stop()
> >             ` perf_swevent_cancel_hrtimer() => Skip to cancel timer
> >             ` task_clock_event_update()     => Skip to update count
> >    ` return HRTIMER_NORESTART;              => Stop timer
> > 
> > It is a bit urgly that we check the throttling separately in two
> > places: one is in perf_swevent_cancel_hrtime() for skipping cancel
> > timer, and then we skip updating event count in
> > cpu_clock_event_stop().
> 
> The second check before cpu_clock_event_stop() is not a throttling
> check. It's to implement the missed flag check.
> Usually, the stop() should check PERF_EF_UPDATE before updating an
> event. I think most of the ARCHs do so.
> Some cases may ignore the flag. For the clock event, I think it's
> because the stop(event, 0) is never invoked. So it doesn't matter if the
> flag is checked. But now, there is a case which the flag matters.
> So I think we should add the flag check.
> 
> > 
> > One solution is it would be fine to update count in ->stop() callback
> > for the throttling. This should not cause any issue (though it is a bit
> > redundant that the count is updated twice).
> 
> The clock event relies on local_clock(), which never stops.

Ah, good point!

> So it still counts between read() and stop().
> It's not just redundant. The behavior is changed if the event is updated
> in the stop() again.

> > Or even more clear, we can define a flag PERF_EF_THROTTLING:
> > 
> >     #define PERF_EF_THROTTLING  0x20
> > 
> >     event->pmu->stop(event, PERF_EF_THROTTLING);
> > 
> 
> The if (hwc->interrupts != MAX_INTERRUPTS) should be good enough to
> check the throttling case. I don't think we need a new flag here.

Makes sense to me.

Thanks,
Leo

> >     cpu_clock_event_stop(struct perf_event *event, int flags)
> >     {
> >         if (flags == PERF_EF_THROTTLING)
> >             return;
> > 
> >         ....
> >     }
> > 
> > This might need to do a wider checking to ensure this new flags will not
> > cause any issues.
> 
> Right, it may brings more troubles.
> 
> I think we should properly utilize the existing flag rather than
> introducing a new one.
> 
> Thanks,
> Kan
> 
