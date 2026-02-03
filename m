Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C89274B3A;
	Tue,  3 Feb 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119057; cv=none; b=jZ7bOkSfOZ1fkJmP1SYQJTi2FNg4Vy9hc9VysGa2nOHWuYohWr05MUdk9Gi5YVuDbS1QrOFPCdC9YuECsghrN2S1vrlDZslJ+QukevHhCFsYuLNmwWyLCW33e4FeZLOsQP4RLWGfw0iTPuwEDSBDo6OdlEcaXKJCWG87SkOVpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119057; c=relaxed/simple;
	bh=jYtOAo2MUGPx1H/m9EPEUPjPC6O0FW2rJG/7epUUQEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx67u8DrMXwxdTVzTjphhGSZig3sfn3ouNXt/OGotbqCBLEp37ZJt4YFrgrNoX5db20NW048pTd17NXxWX4pBImfsKEOinjsq8GmuTcgtBprZ8T3ePaHvrsiqOI/D09P5UcamTXy5DoVKcNQVMXogKEyR9zGnNhGubdjmN117cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw0WSQne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw0WSQne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6AAC19421;
	Tue,  3 Feb 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770119057;
	bh=jYtOAo2MUGPx1H/m9EPEUPjPC6O0FW2rJG/7epUUQEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw0WSQneucIfNTJs13wL8bbc8Wvh/MmeCxpMJ6fybo2v6fjzLx34cYDjrxibIHYdm
	 VIytp9/E+qDwlUCyUnWBH70VjD8dWQj2EP1HU4lxL+750Rh0ySlcVzJCFm97g8Gf7r
	 scD1VVYLilHVieSjYnjsOam8itkEF/6lXvzRzaok49vcwF6z9kW/b4Z4sWFaO9UV3o
	 VNzQPx6db0RMB4LR5YKa13zSdLqLBoBJRbAi55mfGuoMLK9DuXQUXY/RNSP0JioMrt
	 ATvrwTHD49Jha2uuzWVi0uZ/U7RbRQwhi6lhbQV4O50dnmSbua9weGIj7WxzoluvZR
	 xoOlW7RKpQY2w==
Date: Tue, 3 Feb 2026 11:44:12 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: arm_spe: Properly set hw.state on failures
Message-ID: <aYHfjFp85xFE5B5X@willie-the-truck>
References: <20260121-arm_spe_fix_truncated_flag-v3-1-214747f68b50@arm.com>
 <aXIoUMLF6aClRrjv@willie-the-truck>
 <20260122163010.GA40455@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122163010.GA40455@e132581.arm.com>

On Thu, Jan 22, 2026 at 04:30:10PM +0000, Leo Yan wrote:
> On Thu, Jan 22, 2026 at 01:38:24PM +0000, Will Deacon wrote:
> > On Wed, Jan 21, 2026 at 11:33:21AM +0000, Leo Yan wrote:
> 
> [...]
> 
> > > +static void arm_spe_pmu_stop(struct perf_event *event, int flags);
> > 
> > This is fine, but I'm also happy if you want to move the functions around
> > to avoid the forward declaration.
> 
> I also dislike the forward declaration, but the current code is well
> organized (the PMU start/stop/add/del helpers are grouped together).
> 
> Moving arm_spe_pmu_stop() elsewhere might hurt the readability.

Ok, up to you.

> > > @@ -642,6 +643,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > >  
> > >  out_write_limit:
> > >  	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> > > +	return (limit & PMBLIMITR_EL1_E) ? 0 : -EAGAIN;
> > 
> > I'd probably go with -EIO here. -EAGAIN implies that if the caller
> > retries the operation then it might succeed, which probably isn't the
> > case for these failures.
> 
> Will do.

Thanks.

> > >  static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
> > > @@ -781,7 +783,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > >  		 * when we get to it.
> > >  		 */
> > >  		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> > > -			arm_spe_perf_aux_output_begin(handle, event);
> > > +			if (arm_spe_perf_aux_output_begin(handle, event)) {
> > > +				arm_spe_pmu_stop(event, PERF_EF_UPDATE);
> > 
> > Why do you need to pass PERF_EF_UPDATE in this case?
> 
> The main purpose is to read PMSICR_EL1 and save the left count to
> "hwc->period_left".  This might be used in next enable.
>
> 
> > It looks to me
> > like we're going to get into a mess with PMBSR_EL1, as that will get
> > re-read by arm_spe_pmu_buf_get_fault_act() in arm_spe_pmu_stop()
> > before we've cleared it here in the irq handler.
> 
> When arm_spe_perf_aux_output_begin() fails, either because
> perf_aux_output_begin() fails to start a new session or because an
> invalid limit is detected and perf_aux_output_end(handle, 0) is
> called.
> 
> In either case, perf_get_aux(handle) returns NULL after the failure,
> and arm_spe_pmu_stop() has no chance to run into the path that
> re-reads PMBSR_EL1.

Got it.

> > I was expecting that we would always pass 0 for the flags when handling
> > the case where we get an error back from arm_spe_perf_aux_output_begin().
> 
> We can look at this another way.  If we do not call arm_spe_pmu_stop()
> in the interrupt handler and instead defer stopping the trace to
> arm_spe_pmu_del(), the PERF_EF_UPDATE flag is used.  This patch simply
> keeps the same behavior while stopping the trace earlier in the
> interrupt handler.  Make sense?

Yes, fair enough. Please post an updated patch.

Will
