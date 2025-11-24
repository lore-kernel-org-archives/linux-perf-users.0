Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56F256D;
	Mon, 24 Nov 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010100; cv=none; b=Y3iQyeL0guZfl/fI82J6+Vax3L487Ihs0unaFxdXLDUrEXYqSsJriUoXhTmOlMifJpTQletnI2qP/8y2aWlYBvVJZf9Xq/5mM+ATCUfR4nBEpYnmselvuhfAXqD0HYzKY7xiklWAP8qGS8xtwIpodWUqNSPh6vGl58YFlq6Yns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010100; c=relaxed/simple;
	bh=WCMe5MUaYBK6yshGF9tix//Or6TFicYZ4Vlny2KFvFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb9HoEngJ/Togu/++ArgBArIN7WQtxvNesYp31wbkzDoK9VlHFGckOibNRr6xuu8GZbfnLUsUgp+i94JSDQALYN5EF8F4T+KnAEKU3YhvXn1FT9KyHCep+oZdN7ORtqrlS03cJi439/9gigjC2KIL0WykqyifAM9wp/vtNun5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0F7C1477;
	Mon, 24 Nov 2025 10:48:09 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F36293F86F;
	Mon, 24 Nov 2025 10:48:16 -0800 (PST)
Date: Mon, 24 Nov 2025 18:48:15 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <20251124184815.GC724103@e132581.arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSEXzMr1drvL2zz@willie-the-truck>

On Mon, Nov 24, 2025 at 04:14:23PM +0000, Will Deacon wrote:
> On Mon, Nov 10, 2025 at 04:28:31PM +0000, Leo Yan wrote:
> > In arm_spe_perf_aux_output_begin(), if the calculation of limit fails
> > and arm_spe_pmu_next_off() returns zero, the driver misses to set the
> > PERF_HES_STOPPED flag for the event.  As a result, hwc->state does not
> > reflect the latest state, which can mislead subsequent operations.
> > 
> > Validate the limit when exiting the function: if the limit is 0,
> > that tracing is disabled, set the PERF_HES_STOPPED flag accordingly.
> > 
> > Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  drivers/perf/arm_spe_pmu.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..fc8f908c2c3a270f2d1ae574c2badb1fbcf51484 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -597,7 +597,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> >  	/* Start a new aux session */
> >  	buf = perf_aux_output_begin(handle, event);
> >  	if (!buf) {
> > -		event->hw.state |= PERF_HES_STOPPED;
> >  		/*
> >  		 * We still need to clear the limit pointer, since the
> >  		 * profiler might only be disabled by virtue of a fault.
> > @@ -608,15 +607,19 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> >  
> >  	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
> >  			      : arm_spe_pmu_next_off(handle);
> > -	if (limit)
> > -		limit |= PMBLIMITR_EL1_E;
> > +	if (!limit)
> > +		goto out_write_limit;
> 
> Is 'limit == 0' always indicative of an error, even in snapshot mode?

Yes, the 'limit' would never be zero unless an error occurs.

> If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
> with the TRUNCATED flag set, which should then disable the event
> via arm_spe_pmu_del() and update the state there.
> 
> Is that not happening?

Correct.  However, this patch is not for the flow you mentioned.

If an error is returned from arm_spe_pmu_next_off(), because hw.state
is not set to PERF_HES_STOPPED, the caller arm_spe_pmu_start() cannot
detect error properly:

    arm_spe_pmu_start()
    {
        ...

        hwc->state = 0;
        arm_spe_perf_aux_output_begin(handle, event); // Miss to set hwc->state
                                                      // for error case.
        if (hwc->state)    // Fail to detect error.
                return;

        reg = arm_spe_event_to_pmsfcr(event);
        write_sysreg_s(reg, SYS_PMSFCR_EL1);

        ...
     }

This patch consolidates arm_spe_perf_aux_output_begin() to always set
the PERF_HES_STOPPED flag for errors, ensuring consistent error
handling.

A side effect is that arm_spe_pmu_del() will skip disabling buffer unit
when "hwc->state==PERF_HES_STOPPED".  This is why we need the patch 02
to explicitly disable the buffer unit in interrupt handler.

Thanks,
Leo
