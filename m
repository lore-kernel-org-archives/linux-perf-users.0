Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643721A457;
	Mon,  9 Jun 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494172; cv=none; b=bJvc5KORlyickVvmCcFbfkD/VDelnVfXeLjquA9imvHjYx6v7PBngTxqGbNm/0VKDtp163m1Kx8VFzI6sWXrlGxYlZ+esDKYHTxtGferHffYN9h9tIl+KxXa8VWqGkuJujAbD6AmWjvbrs3MjUfg8fHEIZgZHn6OLiWf8A4I2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494172; c=relaxed/simple;
	bh=44A7002utCBEPUuoju0t5n9X09SGYJUJuABq0b/70vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuRjcNrdP7mwD++UavJvg5jkcDzhBl9TfcMMV4autN/rDO/QQogch7KuafcXfNWQFgA22mtouY88Ob7IGOzNEITzyAauoNXTtlM4OE5ykWdYeh+2IYOjiI+/Mt9kfB78wI99FN6fIhCKp4r5DDYME8k8/rMGcV4cbiPxcZktD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F40150C;
	Mon,  9 Jun 2025 11:35:50 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407503F673;
	Mon,  9 Jun 2025 11:36:09 -0700 (PDT)
Date: Mon, 9 Jun 2025 19:36:04 +0100
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
Message-ID: <20250609183604.GP8020@e132581.arm.com>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
 <20250609123415.GJ8020@e132581.arm.com>
 <e763b0bd-cb51-4a76-816d-e12e59b02214@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e763b0bd-cb51-4a76-816d-e12e59b02214@linux.intel.com>

On Mon, Jun 09, 2025 at 09:48:12AM -0400, Liang, Kan wrote:

[...]

> >> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
> >> the order the same as perf_event_unthrottle(). Except the patch, no one
> >> checks the hw.interrupts in the stop(). There is no impact from the
> >> order change.
> >>
> >> When stops in the throttle, the event should not be updated,
> >> stop(event, 0).
> > 
> > I am confused for this conclusion. When a CPU or task clock event is
> > stopped by throttling, should it also be updated? Otherwise, we will
> > lose accouting for the period prior to the throttling.
> > 
> > I saw you exchanged with Alexei for a soft lockup issue, the reply [1]
> > shows that skipping event update on throttling does not help to
> > resolve the lockup issue.
> > 
> > Could you elaberate why we don't need to update clock events when
> > throttling?
> > 
> 
> This is to follow the existing behavior before the throttling fix*.
>
> When throttling is triggered, the stop(event, 0); will be invoked.
> As my understanding, it's because the period is not changed with
> throttling. So we don't need to update the period.

> But if the period is changed, the update is required. You may find an
> example in the perf_adjust_freq_unthr_events(). In the freq mode,
> stop(event, PERF_EF_UPDATE) is actually invoked for the triggered event.

> For the clock event, the existing behavior before the throttling fix* is
> not to invoke the stop() in throttling. It relies on the
> HRTIMER_NORESTART instead. My previous throttling fix changes the
> behavior. It invokes both stop() and HRTIMER_NORESTART. Now, this patch
> change the behavior back.

Actually, the "event->count" has been updated in perf_swevent_hrtimer(),
this is why this patch does not cause big deviation if skip updating
count in the ->stop() callback:

  perf_swevent_hrtimer()
   ` event->pmu->read(event);               => Update count
   ` __perf_event_overflow()
      ` perf_event_throttle()
         ` event->pmu->stop(event, 0) / cpu_clock_event_stop()
            ` perf_swevent_cancel_hrtimer() => Skip to cancel timer
            ` task_clock_event_update()     => Skip to update count
   ` return HRTIMER_NORESTART;              => Stop timer

It is a bit urgly that we check the throttling separately in two
places: one is in perf_swevent_cancel_hrtime() for skipping cancel
timer, and then we skip updating event count in
cpu_clock_event_stop().

One solution is it would be fine to update count in ->stop() callback
for the throttling. This should not cause any issue (though it is a bit
redundant that the count is updated twice).

Or even more clear, we can define a flag PERF_EF_THROTTLING:

    #define PERF_EF_THROTTLING  0x20

    event->pmu->stop(event, PERF_EF_THROTTLING);

    cpu_clock_event_stop(struct perf_event *event, int flags)
    {
        if (flags == PERF_EF_THROTTLING)
            return;

        ....
    }

This might need to do a wider checking to ensure this new flags will not
cause any issues.

Thanks,
Leo
