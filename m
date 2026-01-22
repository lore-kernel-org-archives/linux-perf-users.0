Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632B3BE48A;
	Thu, 22 Jan 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099428; cv=none; b=OnQuZBf/siRibvHz6OZHFCktyeLRGNEJQ5F3TJNwAKYUVGLQg4AmprJZAnpsfSWbvBWpKDVvBt/fuvzmnL9xUWp75ElN5/w7Se89M4i3X9m/uTUgeTCYJaDF1OKi5MRNL8u77asCUwHhvc7dgJka1lrAtOqgSW6+u2ndxJkJQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099428; c=relaxed/simple;
	bh=riEz4WHvULa1RVL4vzxYSOc1J0uuo2GKa1gAgNszEVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYWrxrf7fOuklqg9/Zb/AuPaG37Sfawh2Jn+aPlK8efJ4aee3vcBgtg0Fcr7TcY0qBdF61KnRx09x8244Jl1fH2wIuuVwtgvlDBcVeZlX4kitpCThTkjnFx5Ez7kJUX82bTQ9wxUSsY447kPI74xdsweMQxYViWIix69n+ex7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091131476;
	Thu, 22 Jan 2026 08:30:07 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2178A3F694;
	Thu, 22 Jan 2026 08:30:12 -0800 (PST)
Date: Thu, 22 Jan 2026 16:30:10 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: arm_spe: Properly set hw.state on failures
Message-ID: <20260122163010.GA40455@e132581.arm.com>
References: <20260121-arm_spe_fix_truncated_flag-v3-1-214747f68b50@arm.com>
 <aXIoUMLF6aClRrjv@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIoUMLF6aClRrjv@willie-the-truck>

On Thu, Jan 22, 2026 at 01:38:24PM +0000, Will Deacon wrote:
> On Wed, Jan 21, 2026 at 11:33:21AM +0000, Leo Yan wrote:

[...]

> > +static void arm_spe_pmu_stop(struct perf_event *event, int flags);
> 
> This is fine, but I'm also happy if you want to move the functions around
> to avoid the forward declaration.

I also dislike the forward declaration, but the current code is well
organized (the PMU start/stop/add/del helpers are grouped together).

Moving arm_spe_pmu_stop() elsewhere might hurt the readability.

> > @@ -642,6 +643,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> >  
> >  out_write_limit:
> >  	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> > +	return (limit & PMBLIMITR_EL1_E) ? 0 : -EAGAIN;
> 
> I'd probably go with -EIO here. -EAGAIN implies that if the caller
> retries the operation then it might succeed, which probably isn't the
> case for these failures.

Will do.

> >  static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
> > @@ -781,7 +783,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> >  		 * when we get to it.
> >  		 */
> >  		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> > -			arm_spe_perf_aux_output_begin(handle, event);
> > +			if (arm_spe_perf_aux_output_begin(handle, event)) {
> > +				arm_spe_pmu_stop(event, PERF_EF_UPDATE);
> 
> Why do you need to pass PERF_EF_UPDATE in this case?

The main purpose is to read PMSICR_EL1 and save the left count to
"hwc->period_left".  This might be used in next enable.

> It looks to me
> like we're going to get into a mess with PMBSR_EL1, as that will get
> re-read by arm_spe_pmu_buf_get_fault_act() in arm_spe_pmu_stop()
> before we've cleared it here in the irq handler.

When arm_spe_perf_aux_output_begin() fails, either because
perf_aux_output_begin() fails to start a new session or because an
invalid limit is detected and perf_aux_output_end(handle, 0) is
called.

In either case, perf_get_aux(handle) returns NULL after the failure,
and arm_spe_pmu_stop() has no chance to run into the path that
re-reads PMBSR_EL1.

> I was expecting that we would always pass 0 for the flags when handling
> the case where we get an error back from arm_spe_perf_aux_output_begin().

We can look at this another way.  If we do not call arm_spe_pmu_stop()
in the interrupt handler and instead defer stopping the trace to
arm_spe_pmu_del(), the PERF_EF_UPDATE flag is used.  This patch simply
keeps the same behavior while stopping the trace earlier in the
interrupt handler.  Make sense?

Thanks,
Leo
