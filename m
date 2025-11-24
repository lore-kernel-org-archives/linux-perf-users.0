Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB586323;
	Mon, 24 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010934; cv=none; b=E9d1F6Y9eYwBqtF43d8A7pI1cCj6zwMx5Z+LG6XY1H6+2lRTTpkBofnF1W4NPnWiUZ4eEwkbZbli0JkigVGy3+ZGGKW2slEK5seyBEzEA7pwshSwvI0KPYzM6hzcW4UT5/DHFAqg8k10tnfTG1y8yEJ14nTRJJZhNVTu+BDF9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010934; c=relaxed/simple;
	bh=uD7Maoubwz/B9JiuTc7YFA7RBSK4vwlOgZPF2XYEwFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rajv0BLdwCziZl+3F+lqvjJIUWiGJMmYJdrT/k5k8xVjkvUQseolWafvEyjTQwHT8eYHLqSJVSvQml4CWU/BnX6+NvDjlB6R0qQQkTS4WjhjkSmY17IeSCuNwJyiYuiinJmVYoy62QHEVGJ3osfk3H+6+kbfsy+LqmfZ6zCGgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r30mEbj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r30mEbj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33823C4CEF1;
	Mon, 24 Nov 2025 19:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010931;
	bh=uD7Maoubwz/B9JiuTc7YFA7RBSK4vwlOgZPF2XYEwFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r30mEbj+WvnJRyOhTtrNhs+NqNMXjUVtxUST6L9f42xGeJtj5MikU7F0SgCiTGgIG
	 M/MfliWdX44MhVcYIbncUgfkHL57LunAUnTEzbgjq9hsnlvhpg+Kby9xbhjjiMIeC/
	 SYCNIsKIDE/CtUxNTozDDsSzdJDk9gkeMkqi1lEytgMgjCnTggMnDxH37B5L939s7c
	 cYlZ8xM3i9JIwsAOz5U385JyDwkVXyAybrF39QQie0k7wzFRMGA+o7r7zxM5d7uXrU
	 qGPAAySKuL/p9igksvocIgb0YSif5cxJF0gCEIMQ02FZR+Q3aUC1wpd0U7ZnexqedX
	 S2jXnWoZsywoQ==
Date: Mon, 24 Nov 2025 19:02:06 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <aSSrrmX_nAl82GKE@willie-the-truck>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124184815.GC724103@e132581.arm.com>

On Mon, Nov 24, 2025 at 06:48:15PM +0000, Leo Yan wrote:
> On Mon, Nov 24, 2025 at 04:14:23PM +0000, Will Deacon wrote:
> > On Mon, Nov 10, 2025 at 04:28:31PM +0000, Leo Yan wrote:
> > > In arm_spe_perf_aux_output_begin(), if the calculation of limit fails
> > > and arm_spe_pmu_next_off() returns zero, the driver misses to set the
> > > PERF_HES_STOPPED flag for the event.  As a result, hwc->state does not
> > > reflect the latest state, which can mislead subsequent operations.
> > > 
> > > Validate the limit when exiting the function: if the limit is 0,
> > > that tracing is disabled, set the PERF_HES_STOPPED flag accordingly.
> > > 
> > > Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >  drivers/perf/arm_spe_pmu.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > > index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..fc8f908c2c3a270f2d1ae574c2badb1fbcf51484 100644
> > > --- a/drivers/perf/arm_spe_pmu.c
> > > +++ b/drivers/perf/arm_spe_pmu.c
> > > @@ -597,7 +597,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > >  	/* Start a new aux session */
> > >  	buf = perf_aux_output_begin(handle, event);
> > >  	if (!buf) {
> > > -		event->hw.state |= PERF_HES_STOPPED;
> > >  		/*
> > >  		 * We still need to clear the limit pointer, since the
> > >  		 * profiler might only be disabled by virtue of a fault.
> > > @@ -608,15 +607,19 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > >  
> > >  	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
> > >  			      : arm_spe_pmu_next_off(handle);
> > > -	if (limit)
> > > -		limit |= PMBLIMITR_EL1_E;
> > > +	if (!limit)
> > > +		goto out_write_limit;
> > 
> > Is 'limit == 0' always indicative of an error, even in snapshot mode?
> 
> Yes, the 'limit' would never be zero unless an error occurs.
> 
> > If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
> > with the TRUNCATED flag set, which should then disable the event
> > via arm_spe_pmu_del() and update the state there.
> > 
> > Is that not happening?
> 
> Correct.  However, this patch is not for the flow you mentioned.

How is it not for this flow? You're talking about:

arm_spe_pmu_start
	=> arm_spe_perf_aux_output_begin
		=> arm_spe_pmu_next_off // Returns error

The only way arm_spe_pmu_next_off() returns an error is if
__arm_spe_pmu_next_off() fails, and that's the flow I'm talking about.

> If an error is returned from arm_spe_pmu_next_off(), because hw.state
> is not set to PERF_HES_STOPPED, the caller arm_spe_pmu_start() cannot
> detect error properly:

But why isn't PERF_HES_STOPPED set by the sequence I described?

I have a feeling you're right, but I can't piece it together from the
information here.

Will
