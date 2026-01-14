Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312932D7F3;
	Wed, 14 Jan 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413170; cv=none; b=dkY2zcmqE9Ugq6O2NGzzj2fdTB+d6pm/OWIi8GuL3/qz81h8ESvb5w1X2jfLitNWoxXrV92I3nRQ8IeYXzvDI7zJYSShxCOKwdJGJaTHDp02IRm/6e0cj93ftik/zlAvSxLVL3bLPOrVsTh54nCjpXXRRFpTP9YeuLaBxu1fIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413170; c=relaxed/simple;
	bh=mf0jw36UOs4Dcyz/YOSmuQ+ChdZvjkozGozdgIXTDUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLUZWVOE6MrB2I1Pqn1B0YeqRae/1xp0rQRIzVR0glTWXCabhJfEHVXfd8r/HCoTDtg8+zRYJXC0RRre/cRN4XtuTUQhjTdaWlfeWS+Wm5WeVjtva97WnIPJi2/2RigwO+tCCAUvsuG9LYBAWsry+R68632JBDxCYbj4CZKNPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256A31515;
	Wed, 14 Jan 2026 09:52:36 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62CD23F632;
	Wed, 14 Jan 2026 09:52:42 -0800 (PST)
Date: Wed, 14 Jan 2026 17:52:40 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <20260114175240.GA1286628@e132581.arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
 <aSSrrmX_nAl82GKE@willie-the-truck>
 <20251125142036.GE724103@e132581.arm.com>
 <aV_aHi9BLFzjnmx7@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV_aHi9BLFzjnmx7@willie-the-truck>

On Thu, Jan 08, 2026 at 04:23:58PM +0000, Will Deacon wrote:

[...]

> > > How is it not for this flow? You're talking about:
> > > 
> > > arm_spe_pmu_start
> > > 	=> arm_spe_perf_aux_output_begin
> > > 		=> arm_spe_pmu_next_off // Returns error
> > > 
> > > The only way arm_spe_pmu_next_off() returns an error is if
> > > __arm_spe_pmu_next_off() fails, and that's the flow I'm talking about.

[...]

> > The issue is a mismatch between the state machine and the hardware
> > state.  When arm_spe_perf_aux_output_begin() detects an error and does
> > not set PMBLIMITR_EL1_E, the trace unit is effectively stopped, but
> > the state machine is not updated to PERF_HES_STOPPED. This causes
> > callers to handle errors incorrectly [1][2].
> > 
> > It is arguable that the disable IRQ work will eventually disable the
> > trace unit and update hw.state, but the state should be updated in the
> > first place by the PMU driver to notify even core layer.
> 
> From what I can tell, perf_aux_output_end() will call
> perf_event_disable_inatomic() which should end up invoking
> perf_pending_disable() via an IPI-to-self to disable the event and put
> it in the PERF_HES_STOPPED state before we return to userspace.
> 
> So I still struggle to see the problem here.

The issue is that the SPE driver does not properly propagate errors when
arm_spe_pmu_next_off() fails.  Instead, it behaves as if tracing was
enabled successfully, which leads to redundant operations and an
inconsistent state in the perf core.

Let us dig a bit.

  arm_spe_pmu_start()
  {
      hwc->state = 0;

      /* Fails inside arm_spe_pmu_next_off() */
      arm_spe_perf_aux_output_begin(handle, event);

      /* hwc->state remains 0, so execution continues */
      if (hwc->state)
          return;

      reg = arm_spe_event_to_pmsfcr(event);
      write_sysreg_s(reg, SYS_PMSFCR_EL1);
      ...
  }

In arm_spe_pmu_start(), a failure in arm_spe_perf_aux_output_begin()
does not set PERF_HES_STOPPED, so hwc->state remains zero and the
function continues to program filters even though has failed.

Moveover, the driver still returns success to the perf core.  As a
result, event_sched_in() assumes the event was started correctly and
proceeds to enable other events.

  event_sched_in()
  {
      ...

      if (event->pmu->add(event, PERF_EF_START)) {
        perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
        event->oncpu = -1;
        ret = -EAGAIN;
        goto out;
      }

      ...
  }

This breaks event group case, for example:

  perf record -e '{cs_etm//,cycles}' -- test

The perf core expects all events in a group to start and stop together,
but the SPE driver's incorrect reporting causes misalignment.

Sorry for late reply.

Thanks,
Leo
