Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A8431A5B;
	Mon, 10 Aug 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383727; cv=none; b=qaJbV9SH9+D/gk6Or9rM97g2NRpJC1XuC16A6wZNqXScLzHaa4l499wMyrTLqRO2+hUdtb0ARQD4JscpRz60guF7QJegIfVDPlwNslbN2Oua0nFE555nXuEymBxMt7vDsADrmS/BTz8sIrm/k8/nflkRR67TOAkPjUN5dNtTr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383727; c=relaxed/simple;
	bh=tOAcovZJNoPu8/+gOWGWNHqThToUKRwIs/Az9hkC42k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzyEtlCVc7x4957aheO6JljX7zwjiQTrDk3gfG6G08rLV3GSHQVbXTrAsWO8qXkbvCgN18aLFSIfcIAK26jJAaRoNuwDasKz8dop+sHEVNCQix8jVQkxltTRRndjIg3Z1GdPzZwiVJnqQdeassLXkCNFFNhX0CCK740dqg6hat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jenvaetT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jenvaetT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523BA14BF;
	Mon, 10 Aug 2026 10:41:58 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F383F632;
	Mon, 10 Aug 2026 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786383722; bh=tOAcovZJNoPu8/+gOWGWNHqThToUKRwIs/Az9hkC42k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jenvaetTCb8y9ElV9WBqbIvF86p+A1Lr7bOrNM/2D4ZrBq8cLTq8c7ai11RF+7fKS
	 g61ehm+rmSMPufAMc/glZJRy8Z48tSZOXoLlmSgxZ97Zs1Lj9iSn6a1dtxUMVzc4dG
	 PQhr+yc3WMV/hLCxhZTnZFiXL/SIV8sSYNXWANQw=
Date: Mon, 10 Aug 2026 18:41:59 +0100
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
	Yabin Cui <yabinc@google.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
Message-ID: <20260810174159.GC15499@e132581.arm.com>
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

The question is how "allocating contiguous AUX pages unnecessarily
exacerbates memory fragmentation." The relevant information I could find
is [1]:

 "On Android, we collect ETM data periodically on internal user devices
  for AutoFDO optimization (for both userspace libraries and the
  kernel). Allocating a large chunk of contiguous AUX pages (4M for each
  CPU) periodically is almost unbearable. The kernel may need to kill
  many processes to fulfill the request. It affects user experience even
  after using PMU."

We might have missed chance to clarify how the fragmentation issue
occurs in the first place. Let's say, a phone with 8 CPUs, allocating
4MB per CPU requires 32MB in total, which is a relatively small
portion of 4GiB or 8GiB of RAM commonly found in phones. Moreover, once
contiguous pages are freed, the buddy allocator can coalesce them
again into buddy list. It is not obvious to me that PREFER_LARGE
directly causes fragmentation.

One case where AUX allocation could exacerbate fragmentation is when the
system is already fragmented. If a high-order allocation fails and the
allocator falls back to smaller-order blocks, those allocations may
consume free blocks scattered across different buddy regions and make
subsequent high-order allocations more difficult.

If this is the main concern, I'd suggest using a smaller AUX buffer
(e.g. 1MB or even 512KB) for TRBE/SPE to reduce memory pressure.
Snapshot mode '-S' could also be considered, as it allows the buffer to
be allocated once and reused for subsequent recordings by signals.

OTOH, using only order-0 pages can significantly increase TTW overhead
on the trace path and lead to overflows, we observe this causes huge
trace discontinuity. In the end, we need to trace-off the fragmentation
concern against the trace discontinuity.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com/
