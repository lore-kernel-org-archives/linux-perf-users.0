Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC026A0D0
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032244; cv=none; b=L3bJUnrtx4xPKOOOgfz0/qcY9MkXaBPbOVjUSy3stpYuCiyEsOwy9i3vu94taZmOSCphoE7e+FMcRd3FCxy/K3u0vVa2NMhB1uSlDVXdXNVYbr9Dk52qTMFibIjVWcgiw/ECvZyYapGmxK28TLI+QGJxEzUUQfTyylssXz+m3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032244; c=relaxed/simple;
	bh=48UOnyvhTmbV8Trpua0BmgJ29gPVoXU+h4a6qjsGv6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioz8NTQnRBVCIvrc3P7Wyad9YEC1PllS0SyXjwc4ZeT220WVCL0PfpzGv/nlEPE19GA+JaUUpnbsOqaRNEnV93Y6wGthcH/Ut705140f+fb+gViFmIjolB4iwSHlXpzsqYLgS7gGv4PRwX+QmOLjyyoUdcvRs4Rxc8CM1Lacplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC9221007;
	Fri, 27 Jun 2025 06:50:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21123F66E;
	Fri, 27 Jun 2025 06:50:41 -0700 (PDT)
Date: Fri, 27 Jun 2025 14:50:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 RESEND] perf: arm_spe: Relax period restriction
Message-ID: <20250627135039.GQ794930@e132581.arm.com>
References: <20250627091659.3316899-1-leo.yan@arm.com>
 <2996edbb-1223-4795-921b-fd86a4dc3f88@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2996edbb-1223-4795-921b-fd86a4dc3f88@arm.com>

On Fri, Jun 27, 2025 at 05:10:47PM +0530, Anshuman Khandual wrote:
> On 27/06/25 2:46 PM, Leo Yan wrote:
> > The minimum interval specified the PMSIDR_EL1.Interval field is a
> > hardware recommendation. However, this value is set by hardware designer
> > before the production. It may not accurately reflects actual hardware
> > limitations, and tools currently have no way to test shorter periods.
> > 
> > This change relaxes the limitation by allowing any non-zero periods.
> > This gives chance for experimenting smaller periods.
> 
> Is this going to be safe on all SPE implementations ?

AFAIK, this change applies on all Arm SPE versions.

> > The downside is that small periods may increase the risk of AUX ring
> > buffer overruns. When an overrun occurs, the perf core layer will
> > trigger an irq work to disable the event and wake up the tool in user
> > space to read the trace data. After the tool finishes reading, it will
> > re-enable the AUX event.
> > 
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  drivers/perf/arm_spe_pmu.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index 3efed8839a4e..e40e5daa838d 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -308,12 +308,16 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
> >  
> >  static void arm_spe_event_sanitise_period(struct perf_event *event)
> >  {
> > -	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> >  	u64 period = event->hw.sample_period;
> >  	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
> >  
> > -	if (period < spe_pmu->min_period)
> > -		period = spe_pmu->min_period;
> > +	/*
> > +	 * As per the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
> > +	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
> > +	 * states: "Software must set this to a nonzero value."
> > +	 */The motivation (as explained in the commit message) for using arch permitted
> minimum value instead of the recommended (PMSIDR_EL1.Interval) value, should
> be explained in the comment here as well.

Will update the comment to make it clear.

> > +	if (period < FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1))
> > +		period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
> Given that FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1) is a constant - should
> not it be defined as a macro e.g PMSIRR_EL1_MINIMUM_INTERVAL or something
> similar instead of deriving it twice.

I assume the compiler will evaluate the macro, so defining a new macro
should make no difference.

For more readable, I will try to add the macro in next spin.

Thanks,
Leo

> >  	else if (period > max_period)
> >  		period = max_period;
> >  	else
> 
