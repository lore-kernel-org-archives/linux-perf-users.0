Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EA274FF5;
	Thu,  8 Jan 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889444; cv=none; b=RqrtUY2/IxoC18zG35kVr+bgFvmXpqHBmiRXjrJlAi9DUL7+6klNa39ViNfbB3i0IT5y7OWs6c+SQgWHkVLkG/CHfhclpJCxGROP1g3IIDCQf3tMFMfmuP7+CR8lbR2wR97gbJmBj8kniy9fCglg5y7kYQIGJxtR2whlD2R9Ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889444; c=relaxed/simple;
	bh=0OpJxL0ZfJjzU+rADilRhLH8eNcLAwN3xdBX/MHTSpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5AIr2xrRToL9HjuEdN3WVsaH7azC7yL//1RWlyaRlX98sLyG81XSMg3OK4/0yBG6HM7pl9v8roMMn5oaERUIMFbUVmSoQtF5Y7FDBXj0uO6h1aSRA4ILKqPi9whq5VGw5TBRB6KkHtcBSMZdkj6quEbnZa4j73qdpKhPvWvpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7LmxENw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7LmxENw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53863C16AAE;
	Thu,  8 Jan 2026 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767889443;
	bh=0OpJxL0ZfJjzU+rADilRhLH8eNcLAwN3xdBX/MHTSpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7LmxENwwRg0TYsfSeCh2f2XPjwy9+w07avTbSP11JtQAgc8rJBGFoHuC313e6zj3
	 VPcq7KMRIobeNKL+j0wi1toMggKJmlAVZJ9TwAB0iHKfxQRirvPOy5CEkVdKiBsT7q
	 2nHa6t/rC3TVIz16BPmayA+dgb15Pm+bDQ/+6JCgonC6G3HUMATbVuGClwZmRd39f9
	 nfG9SQ3gqMcMqeFEu5m9Lt+K5ApPo9GqHln6cHYBYbLhUsUpUckJIMf7hufjwOjJBi
	 ZSLxOXo5kXmMANq4JHh+11oRj3sMVePhO/gXklRob4jQ1cMlEB5twcAwtLftlf5RBG
	 Lls+c8IyBpCvQ==
Date: Thu, 8 Jan 2026 16:23:58 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <aV_aHi9BLFzjnmx7@willie-the-truck>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
 <aSSrrmX_nAl82GKE@willie-the-truck>
 <20251125142036.GE724103@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125142036.GE724103@e132581.arm.com>

On Tue, Nov 25, 2025 at 02:20:36PM +0000, Leo Yan wrote:
> On Mon, Nov 24, 2025 at 07:02:06PM +0000, Will Deacon wrote:
> 
> [...]
> 
> > > > If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
> > > > with the TRUNCATED flag set, which should then disable the event
> > > > via arm_spe_pmu_del() and update the state there.
> > > > 
> > > > Is that not happening?
> > > 
> > > Correct.  However, this patch is not for the flow you mentioned.
> > 
> > How is it not for this flow? You're talking about:
> > 
> > arm_spe_pmu_start
> > 	=> arm_spe_perf_aux_output_begin
> > 		=> arm_spe_pmu_next_off // Returns error
> > 
> > The only way arm_spe_pmu_next_off() returns an error is if
> > __arm_spe_pmu_next_off() fails, and that's the flow I'm talking about.
> 
> My bad.  Because you mentioned the TRUNCATED flag, I incorrectly assumed
> it had to be used in interrupt handler with the disable irq work.
> 
> > > If an error is returned from arm_spe_pmu_next_off(), because hw.state
> > > is not set to PERF_HES_STOPPED, the caller arm_spe_pmu_start() cannot
> > > detect error properly:
> > 
> > But why isn't PERF_HES_STOPPED set by the sequence I described?
> 
> Fair point.  I can confirm after settting the TRUNCATED flag,
> arm_spe_pmu_del() will be invoked to disable the trace unit and state
> will be updated to PERF_HES_STOPPED.
> 
> > I have a feeling you're right, but I can't piece it together from the
> > information here.
> 
> Let me explain in another way:
> 
> The issue is a mismatch between the state machine and the hardware
> state.  When arm_spe_perf_aux_output_begin() detects an error and does
> not set PMBLIMITR_EL1_E, the trace unit is effectively stopped, but
> the state machine is not updated to PERF_HES_STOPPED. This causes
> callers to handle errors incorrectly [1][2].
> 
> It is arguable that the disable IRQ work will eventually disable the
> trace unit and update hw.state, but the state should be updated in the
> first place by the PMU driver to notify even core layer.

From what I can tell, perf_aux_output_end() will call
perf_event_disable_inatomic() which should end up invoking
perf_pending_disable() via an IPI-to-self to disable the event and put
it in the PERF_HES_STOPPED state before we return to userspace.

So I still struggle to see the problem here.

Will
