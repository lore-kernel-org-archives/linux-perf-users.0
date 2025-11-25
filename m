Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57677325704;
	Tue, 25 Nov 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080441; cv=none; b=q+jMRbANi488Pug+1KmJFQN2uJAW70E4zMz7y3ERILMDN8ENRRJCq5VetCvVwC+QPzAmvMPDbYMmnHmP4sBZQjXuw1d4XEWFoooEWw1wDLsRrIOO81h5dF9fhCFPa3HVlnNXOpJEVGgcdkUJCs/IREIsECkqMRiV1+M9Zp1kGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080441; c=relaxed/simple;
	bh=b/BnQEcMnKh6wPyN5PICy5P66y0vxLhzL7vLu1MIkQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMbn+NqULzCeeW6sAP4y1VYdgE4LaTEppYhnMY3cB3WnsjhsDEY3izXIGc9JgISwO069hSpJq+cvCqj6kPVlgnuaDnSIriqU2hbupX3Ucwspf2MBOswtOm8BUcpcvGVnjaslNYIL91vOx49OfX+1+K9eT1sQHxnc4lzRnPonoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 368AF168F;
	Tue, 25 Nov 2025 06:20:31 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B743F86F;
	Tue, 25 Nov 2025 06:20:38 -0800 (PST)
Date: Tue, 25 Nov 2025 14:20:36 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <20251125142036.GE724103@e132581.arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
 <aSSrrmX_nAl82GKE@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSrrmX_nAl82GKE@willie-the-truck>

On Mon, Nov 24, 2025 at 07:02:06PM +0000, Will Deacon wrote:

[...]

> > > If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
> > > with the TRUNCATED flag set, which should then disable the event
> > > via arm_spe_pmu_del() and update the state there.
> > > 
> > > Is that not happening?
> > 
> > Correct.  However, this patch is not for the flow you mentioned.
> 
> How is it not for this flow? You're talking about:
> 
> arm_spe_pmu_start
> 	=> arm_spe_perf_aux_output_begin
> 		=> arm_spe_pmu_next_off // Returns error
> 
> The only way arm_spe_pmu_next_off() returns an error is if
> __arm_spe_pmu_next_off() fails, and that's the flow I'm talking about.

My bad.  Because you mentioned the TRUNCATED flag, I incorrectly assumed
it had to be used in interrupt handler with the disable irq work.

> > If an error is returned from arm_spe_pmu_next_off(), because hw.state
> > is not set to PERF_HES_STOPPED, the caller arm_spe_pmu_start() cannot
> > detect error properly:
> 
> But why isn't PERF_HES_STOPPED set by the sequence I described?

Fair point.  I can confirm after settting the TRUNCATED flag,
arm_spe_pmu_del() will be invoked to disable the trace unit and state
will be updated to PERF_HES_STOPPED.

> I have a feeling you're right, but I can't piece it together from the
> information here.

Let me explain in another way:

The issue is a mismatch between the state machine and the hardware
state.  When arm_spe_perf_aux_output_begin() detects an error and does
not set PMBLIMITR_EL1_E, the trace unit is effectively stopped, but
the state machine is not updated to PERF_HES_STOPPED. This causes
callers to handle errors incorrectly [1][2].

It is arguable that the disable IRQ work will eventually disable the
trace unit and update hw.state, but the state should be updated in the
first place by the PMU driver to notify even core layer.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?//h=v6.18-rc7#n855
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n2742
