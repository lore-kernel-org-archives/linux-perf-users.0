Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072D2D97B7;
	Thu, 12 Mar 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325728; cv=none; b=clJLaqXCOn5oWfKUUdQSJAqMUQffO2atROLT0M9bxPdrlfEH3sGg603EL+TzoI9QxglZagA2eikp/M5iqYFwJBGtd8ntL5BpqxBgKNm947msTlPNPgmGZzQnqwjhGps24+ZsoAdLiQ2fz7iZ6ra7s/KXmoPs+UV7H3/AxjxwaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325728; c=relaxed/simple;
	bh=0ml+Q98EptT34egOhj01zpNadcyKErIvcXbVRXe78rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q713b6oPZ1qt7ooYDDqC9RVByJTNSHP7hlXwCXrmSDcoybiDvE6dsRd1df4qVFXiE6tWGD3FMslIiCMb/rfkLw/3K46B+ogRc0AAo1IbLFvQAfUwK+ctguG0SkTjlklRMsJlA+y7PZ7UXsdLP8GdZ7I+DaM9U4OXMH/NmnFpGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/R2Mqkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/R2Mqkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0C1C19424;
	Thu, 12 Mar 2026 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773325728;
	bh=0ml+Q98EptT34egOhj01zpNadcyKErIvcXbVRXe78rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/R2MqkxRaFGdDrypldqAySx0xX7uGfp8X8A7zHUS7U85/Cx368kUAYo/jEGxsO3s
	 4xDzMTHXsUB764cDYP2Px27NmK7zmVOFF4hci1QSAX7cVgxhQUa8uIi4ZP1YduRsLJ
	 R6FnsuUQDBONV0meUbOY1pV1okHzQK5HO225St/TSAOXKm/IHqkX6TeY99MG+ECU6t
	 lz0F0dEh59g/fFpWOBzeyeRIxEnR+VeRnq+iAfzggGeTxVJSo2QrE7RdwfCxtgHBrl
	 pkwhtEE0SbG6GNreY8KwNbFKA/o6AfDippUvoDhEKyURQ8exW+YcSVDgbvMGiO+4u5
	 2u5CqUd9/0Uiw==
Date: Thu, 12 Mar 2026 14:28:43 +0000
From: Will Deacon <will@kernel.org>
To: "feng.zhou" <realsummitzhou@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	suzuki.poulose@arm.com, robin.murphy@arm.com
Subject: Re: [QUESTION] ARM DSU PMU: 32-bit counter assumption and handling
 of 64-bit event counters
Message-ID: <abLNm2gs8qszYVWK@willie-the-truck>
References: <20260206035138.1377-1-realsummitzhou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206035138.1377-1-realsummitzhou@gmail.com>

[+Robin and Suzuki]

On Fri, Feb 06, 2026 at 11:51:38AM +0800, feng.zhou wrote:
> Hi Will and Mark,
> 
> I have a question regarding the ARM DSU PMU driver implementation in
> drivers/perf/arm_dsu_pmu.c, specifically about the counter width
> assumptions.
> 
> Current Implementation:
> ======================
> The driver currently assumes all event counters are 32-bit wide, with
> only the cycle counter being 64-bit (lines 69-71):
> 
> /* All event counters are 32bit, with a 64bit Cycle counter */
> #define DSU_PMU_COUNTER_WIDTH(idx)	\
> 	(((idx) == DSU_PMU_IDX_CYCLE_COUNTER) ? 64 : 32)
> 
> This assumption is used throughout the code for handling counter
> overflow and calculating deltas (e.g., line 344 in dsu_pmu_event_update).
> 
> Issue Observed:
> ===============
> I've encountered overflow issues when using perf tools on newer ARM CPUs
> where the event counters appear to be 64-bit rather than 32-bit. The
> current implementation causes incorrect event counting and potential data
> loss due to premature overflow handling based on the 32-bit mask.

I suspect either the hardware or the architecture have evolved since the
driver was initially written, possibly in a non-backwards-compatible way
which is why you see problems.

> Questions:
> ==========
> 1. Is the 32-bit event counter assumption based on the ARMv8 PMU
>    specification or DSU-specific hardware documentation?
> 
> 2. Are there known ARM CPU implementations where DSU event counters
>    exceed 32 bits? If so, how should the driver handle this variation?
> 
> 3. Would it be appropriate to detect the actual counter width at runtime
>    (similar to how num_counters is probed in dsu_pmu_probe_pmu), or
>    should this be handled through device tree / ACPI properties?
> 
> 4. Should there be a mechanism to query the hardware for the actual
>    counter width to ensure compatibility with future implementations?
> 
> Thank you for your time and any insights you can provide.

Suzuki and Robin should be able to help with these...

Will
