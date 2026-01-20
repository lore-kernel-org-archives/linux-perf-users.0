Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4B31B81C;
	Tue, 20 Jan 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927365; cv=none; b=mAb/VsVHBxEt2s/qUGmOmu0G0zTykwmG5kK0GC+AaRw/FlouV+acITm4GN3M603PCy3Lxsh7LMFsYFeqlHce8ALVXBZt6wQrW8uJ8ksTw+QjkI7lBthOkbxpIX8qnTjMsesl9lNxF17yVgn3D0ayoA1+kL58Enot1MvHCLFkWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927365; c=relaxed/simple;
	bh=XfTOr/b3kCkXkd8pSzNTRxg+QJfJoP47QMmKJ8TgXxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ZbaOSnDa7ToGPvDsQTU9WPnLx7acvxQq3ns+s8oL5UU41qrmTmBRKy1HzYUzHHh9Y6b530F/Ll/bQRLH1eB4yU39E0yhnomk6Hr7bDk3DnpR61Pk6Y5MVUdWouHfESOkaEDMY5Mmh0Ocb3JWYwOvYd84RYZM5k88cBl2E4LsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVDcuf1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVDcuf1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F9BC16AAE;
	Tue, 20 Jan 2026 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768927364;
	bh=XfTOr/b3kCkXkd8pSzNTRxg+QJfJoP47QMmKJ8TgXxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVDcuf1dF4rWdHOnptrAjcgUDeFiKxzcItVFr6UyfS1D7WqxzZrQYMl5xVRiTLMl6
	 8kzRXp+NfNPE5pBW5Hge4fnA1fXMODw0uwwE/4/RBs8Oea1ZSyMVMx5Vt6GUextX6U
	 7857eSOwuhfH6RiyLVJCtOc/lA9ETQ7Si6nrYmUtRGT916SXzZvTkR09uoX3UO38NS
	 81N69DKfAoljrwICBHQj2wVvEYcoTgeC3gUEl0EbvCqQOhfzOrRStlqCZqXW7Bai56
	 7VrMWEHrAJfGnVG5vMccPve3GnfnJhNbC5NXHEgUuadv95epuNmvd6/MJ5PzJkEF91
	 ANYZ2mxWA9X2w==
Date: Tue, 20 Jan 2026 16:42:39 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <aW-wfy3u5OD3BQAQ@willie-the-truck>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
 <aSSrrmX_nAl82GKE@willie-the-truck>
 <20251125142036.GE724103@e132581.arm.com>
 <aV_aHi9BLFzjnmx7@willie-the-truck>
 <20260114175240.GA1286628@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114175240.GA1286628@e132581.arm.com>

On Wed, Jan 14, 2026 at 05:52:40PM +0000, Leo Yan wrote:
> > > The issue is a mismatch between the state machine and the hardware
> > > state.  When arm_spe_perf_aux_output_begin() detects an error and does
> > > not set PMBLIMITR_EL1_E, the trace unit is effectively stopped, but
> > > the state machine is not updated to PERF_HES_STOPPED. This causes
> > > callers to handle errors incorrectly [1][2].
> > > 
> > > It is arguable that the disable IRQ work will eventually disable the
> > > trace unit and update hw.state, but the state should be updated in the
> > > first place by the PMU driver to notify even core layer.
> > 
> > From what I can tell, perf_aux_output_end() will call
> > perf_event_disable_inatomic() which should end up invoking
> > perf_pending_disable() via an IPI-to-self to disable the event and put
> > it in the PERF_HES_STOPPED state before we return to userspace.
> > 
> > So I still struggle to see the problem here.
> 
> The issue is that the SPE driver does not properly propagate errors when
> arm_spe_pmu_next_off() fails.  Instead, it behaves as if tracing was
> enabled successfully, which leads to redundant operations and an
> inconsistent state in the perf core.
> 
> Let us dig a bit.
> 
>   arm_spe_pmu_start()
>   {
>       hwc->state = 0;
> 
>       /* Fails inside arm_spe_pmu_next_off() */
>       arm_spe_perf_aux_output_begin(handle, event);
> 
>       /* hwc->state remains 0, so execution continues */
>       if (hwc->state)
>           return;
> 
>       reg = arm_spe_event_to_pmsfcr(event);
>       write_sysreg_s(reg, SYS_PMSFCR_EL1);
>       ...
>   }
> 
> In arm_spe_pmu_start(), a failure in arm_spe_perf_aux_output_begin()
> does not set PERF_HES_STOPPED, so hwc->state remains zero and the
> function continues to program filters even though has failed.
> 
> Moveover, the driver still returns success to the perf core.  As a
> result, event_sched_in() assumes the event was started correctly and
> proceeds to enable other events.
> 
>   event_sched_in()
>   {
>       ...
> 
>       if (event->pmu->add(event, PERF_EF_START)) {
>         perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
>         event->oncpu = -1;
>         ret = -EAGAIN;
>         goto out;
>       }
> 
>       ...
>   }
> 
> This breaks event group case, for example:
> 
>   perf record -e '{cs_etm//,cycles}' -- test
> 
> The perf core expects all events in a group to start and stop together,
> but the SPE driver's incorrect reporting causes misalignment.

Ok, so looking at this and the next patch I wonder if we could simplify
things a little by having arm_spe_perf_aux_output_begin() return an 'int'
to indicate success/failure instead of touching 'hwc->state'.

Then arm_spe_pmu_start() and the interrupt handler could call into
arm_spe_pmu_stop() if they get an error code back. Would that work?

Will
