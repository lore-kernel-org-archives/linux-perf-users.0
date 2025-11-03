Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667F3161B7;
	Mon,  3 Nov 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190092; cv=none; b=UDtR5gZNd9xM2iekciMBrwYklK9xeZJM2jTWjcMP7RY5IT8zZsKJ8fNVWsx78X/vjp0IOQyJJoERjF9TinB3HTbPdvlI50F11Ra2XzzDrmAEyNit/vHMx8fxjveYqbbsQIh9mI8QZ8bxZ9aWR4BTciaqXit0aChBAT5tRUwzqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190092; c=relaxed/simple;
	bh=IziWsuCpYOXJRRP9wMomjaC642fsIV9pkJ7E6JMqs/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7S7mTpe6cAz6yUD9Bpyg5sepkEfgxOBPy0w4Tmf/xIVxEYgtSwhXJTOkhvixlyP2IM++mrC2aueNPAfPm28MTsTV1o+IFHGxvpiorCs1+qaK6la+BoB7xY8GeL9nKpAIQxD6Q6y0+9JIeHEdv3/63CrCwxs0/u4NPRevd2Pdhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247461D14;
	Mon,  3 Nov 2025 09:14:41 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A18D3F66E;
	Mon,  3 Nov 2025 09:14:48 -0800 (PST)
Date: Mon, 3 Nov 2025 17:14:46 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Ensure trace is disabled when TRUNCATED
 flag is set
Message-ID: <20251103171446.GY281971@e132581.arm.com>
References: <20251015-arm_spe_fix_truncated_flag-v1-1-555e328cba05@arm.com>
 <aQi44CZOiwhI19dd@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQi44CZOiwhI19dd@willie-the-truck>

On Mon, Nov 03, 2025 at 02:14:56PM +0000, Will Deacon wrote:

[...]

> > @@ -765,6 +759,15 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> >  		break;
> >  	}
> >  
> > +	/*
> > +	 * The TRUNCATED flag is set when data loss is detected by PMBSR_EL1.DL,
> > +	 * or arm_spe_perf_aux_output_begin() sets the flag if runs out of free
> > +	 * space. Ensure that all perf callbacks have completed for disabling
> > +	 * the profiling buffer.
> > +	 */
> > +	if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> > +		irq_work_run();
> 
> I'm not sure about this. afaict, perf_aux_output_begin() can fail
> (return NULL) without setting the TRUNCATED flag but with a disable
> pending in irq work. It also feels a little fragile moving the existing
> irq_work_run() call as that could easily break in future if e.g. irq
> work is used for other manipulation of the buffer controls.
> 
> Given that this isn't a fast path, isn't it simpler and safer just to
> do something like the below?

This is fine for me.  However, arm_spe_perf_aux_output_begin() misses to
set the 'hw.state' if arm_spe_pmu_next_off() fails to calculate a valid
limit. We need an extra fix for this (see the pasted code piece).

As a result, we will have two fixes:

  1) Fix 'hw.state' setting in arm_spe_perf_aux_output_begin();
  2) Invoke irq_work_run() if 'hw.state' is non-zero.

Please let me know if this works for you.  Thanks!

Leo

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645fedda..ff7b1447db0a 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -597,7 +597,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
-		event->hw.state |= PERF_HES_STOPPED;
 		/*
 		 * We still need to clear the limit pointer, since the
 		 * profiler might only be disabled by virtue of a fault.
@@ -608,14 +607,18 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 
 	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
 			      : arm_spe_pmu_next_off(handle);
-	if (limit)
-		limit |= PMBLIMITR_EL1_E;
+	if (!limit)
+		goto out_write_limit;
 
-	limit += (u64)buf->base;
+	limit |= (u64)buf->base | PMBLIMITR_EL1_E;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
 	write_sysreg_s(base, SYS_PMBPTR_EL1);
 
 out_write_limit:
+	/* Stop tracing due to an invalid limit pointer */
+	if (!limit)
+		event->hw.state |= PERF_HES_STOPPED;
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
 }
 

> Will
> 
> --->8
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index fa50645fedda..8a38d69e9600 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -758,6 +758,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>                 if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
>                         arm_spe_perf_aux_output_begin(handle, event);
>                         isb();
> +
> +                       /* Insightful comment here */
> +                       if (event->hw.state)
> +                               irq_work_run();
>                 }
>                 break;
>         case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
> 
