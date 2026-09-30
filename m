Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C14F85CA;
	Wed, 30 Sep 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786596; cv=none; b=TEjwYVMxSSdA6phtN7W/qDgsFYGqWG8DwjwWaANxadn9quisMraKR45rhg0ZbqHRjEGoPqcATWcMlds3Ev9Ht+DP2pxp7wgWX8D+oZDr69dBM0UBpUFbhHFj2ECgePaIy7Ya1iQx0B9Qm0Spy+AphJl4j1Tne0dbVwBf43VUL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786596; c=relaxed/simple;
	bh=+ZQQF2h9wliOPrMz684FyPaCAEQVKIU22UOLcW8B9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzVR1/Xp+GmMilWENtGWFO6lcQRiAu9+LaE3IxtzvwGC/wXoaD7MdErczOOuRuq7cCGXfJT4x1HR3VibObet/KcEjcgCwGrGR17HesDeb7M0Qf+WrNcO/s3HXfVq+WMrWfY0AgKYpYpIMtlZ5w+xG6fnCQlPtIQOTUgVvq/UzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nt7xGr1X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nt7xGr1X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118EC497;
	Wed, 30 Sep 2026 09:43:11 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3713F85F;
	Wed, 30 Sep 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790786594; bh=+ZQQF2h9wliOPrMz684FyPaCAEQVKIU22UOLcW8B9DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt7xGr1XngY7AXps+0QzGOhk/AqApXQZu9RwBkbxHcHmRvMiGAhwX/+OYrgmbQt2g
	 C8ax0Sr59DyL7okecWYUwf70W2O7KmCQBqw0XbJOAel9byN122uEuH89YRvsy2pJfe
	 a5u3N0avZIxgHNvUDykVknZ8vLnz1jVyNJrE6QHQ=
Date: Wed, 30 Sep 2026 17:43:11 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@kernel.org>,
	Yabin Cui <yabinc@google.com>, James Morse <james.morse@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
Message-ID: <20260930164311.GK14479@e132581.arm.com>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <annp-BdTviQoH6vy@willie-the-truck>

Hi Will,

On Mon, Aug 10, 2026 at 04:10:48PM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 03:44:42PM +0100, Leo Yan wrote:
> > Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
> > default") made the AUX allocator use order-0 pages by default unless a
> > PMU explicitly asks for contiguous allocations.
> 
> But that commit specifically calls out SPE as benefitting from
> non-contiguous pages:
> 
>   "For instance, ARM SPE and TRBE operate with virtual pages, and
>    Coresight ETR allocates a separate buffer. For these PMUs,
>    allocating contiguous AUX pages unnecessarily exacerbates memory
>    fragmentation. This fragmentation can prevent their use on
>    long-running devices."
> 
> so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
> problems that 18049c8cff9c was trying to solve?

How about adding a field to struct pmu to specify a preferred maximum
page order for the AUX buffer? The perf core could try that order first
and fall back to smaller orders if the allocation fails.

For example, the Neoverse V2 TRM documents:

  L1 Trace Buffer Extension (TRBE) TLB: 1 entry

Given the single L1 TRBE TLB entry, the TRBE driver could prefer
PMD_ORDER (2 MiB with 4 KiB pages) to reduce TLB pressure. This reflects
the hardware characteristic.

This could be a trade-off instead of using PERF_PMU_CAP_AUX_PREFER_LARGE,
avoiding large contiguous allocations that could reintroduce the Android
OOM issue. I did a quick test with this approach and the results look
positive.

Does this sound like a reasonable direction? I might also need Yabin's
judgement from Android side.

Thanks,
Leo
