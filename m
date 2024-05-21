Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3471B48;
	Tue, 21 May 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299096; cv=none; b=hkAH603DTHaZSg3PVACUvYIMWUIxDDF8rZE2c6D+3SQ4K3f/9c3arUOBaPNuElyeu/t9y7WfQh7SEWV+1POlUOe5ZzovMDuNlxDA3ySp2H2RTHc39HJpgtE3vSrYpfmEoRjHmzsaKGRataHZToewoSLpI6WJllZ0A7M/CxCaQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299096; c=relaxed/simple;
	bh=H48cizhNNLDxjU+31xIZUJnQnKmSiED2ZFACjcWGzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9oQofuP5h3u8Q9so1K7nIJ2RsmE4+AmNFr+19SF9OHBGcNPMD06vt8IpWbywDvUVINBpABtyoC/F4whbfUkQ42jZqARMVbl12stc+bx1PZ0E5kPqPdKLvcwY+Vj6i1hb65vShQb/5LK6nD8F23Hg3JubkpVgAVeImQsyIb15so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2DACDA7;
	Tue, 21 May 2024 06:45:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4663F641;
	Tue, 21 May 2024 06:44:51 -0700 (PDT)
Date: Tue, 21 May 2024 14:44:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V17 3/9] drivers: perf: arm_pmu: Add infrastructure for
 branch stack sampling
Message-ID: <ZkylUT0R9lwseF4a@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405024639.1179064-4-anshuman.khandual@arm.com>

On Fri, Apr 05, 2024 at 08:16:33AM +0530, Anshuman Khandual wrote:
> In order to support the Branch Record Buffer Extension (BRBE), we need to
> extend the arm_pmu framework with some basic infrastructure for the branch
> stack sampling which arm_pmu drivers can opt-in using a new feature flag
> called 'has_branch_stack'. Subsequent patches will use this to add support
> for BRBE in the PMUv3 driver.

Please, just use ther *exact* wording I asked for last time:

| In order to support the Branch Record Buffer Extension (BRBE), we need to
| extend the arm_pmu framework with some basic infrastructure for branch stack
| sampling which arm_pmu drivers can opt-in to using. Subsequent patches will
| use this to add support for BRBE in the PMUv3 driver.

At this point in the commit message, the 'has_branch_stack' flag doesn't
matter, and dropping the 'to' after 'opt-in' makes this painful to read.

> Branch stack sampling support i.e capturing branch records during execution
> in core perf, rides along with normal HW events being scheduled on the PMU.
> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
> with required HW implementation.

Please delete this paragraph.

> With BRBE, the hardware records branches into a hardware FIFO, which will
> be sampled by software when perf events overflow. A task may be context-
> switched an arbitrary number of times between overflows, and to avoid
> losing samples we need to save the current records when a task is context-
> switched out. To do these we'll need to use the pmu::sched_task() callback,
> and we'll also need to allocate some per-task storage space via event flag
> PERF_ATTACH_TASK_DATA.

[...]

>  /* The events for a given PMU register set. */
>  struct pmu_hw_events {
>  	/*
> @@ -66,6 +78,17 @@ struct pmu_hw_events {
>  	struct arm_pmu		*percpu_pmu;
>  
>  	int irq;
> +
> +	struct branch_records	*branches;
> +
> +	/* Active context for task events */
> +	void			*branch_context;
> +
> +	/* Active events requesting branch records */
> +	unsigned int		branch_users;
> +
> +	/* Active branch sample type filters */
> +	unsigned long		branch_sample_type;
>  };

At this point in the series I understand why we have the 'branches' and
'branch_users' fields, but the 'branch_context' and 'branch_sample_type'
fields haven't been introduced and are not obvious.

What exactly is branch_context, and why is that a 'void *' ?

I can understand if that's a PMU-specific structure to track the active
branch records, but if so I don't understand why 'branch_sample_type'
isn't folded into that.

Mark.
