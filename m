Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513522;
	b=4SQ5o5A3ABYr203d03jfWSingh14yQhBJNK/LS7M/wmplG+hBpIw9QOBFGIm9N2FOsWN
	 31IBTE6tduW/huzZFb+NaselGVu65AWYL+U8PQexiNclEiOPwl3yAtgpI7ywxVgFVJAe/
	 r2pn62Ray6QUL21afouKO7aK45rNNhyO02t6Yzs71DSNg++ZOLzGqF19xRVQFY4JIoUoi
	 JSBhpoRZdZOr+Lu1MKfrZ2roqNa5zb442W5UEbNBMUoGKVJSnHTygnUvWa2SyFhONeYiu
	 GrIwBK9TYX4oH5g0NAuC9cvxDBT/9Vz3tFzQhjYTFxz/cWgdrY7NulfOG15r3aXUfqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513522;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=A8MVaUDS9g20qAiLWN71AYqk9LGiXjGjI7lPzPIyURY=;
	b=mkj1IbFe1V10L7jSpABFhuaCgDkoTU1pDR3L8mwj+Bb3lmLDE5y3d1n4j/ySuYH2sEWA
	 h++MApyth9UgSzqIeedEHYuuTnfS7ZE3/7jh+uM/O4vt5TD7dbpTCMbPspkFXLqGG417Q
	 H9nas94qehm36uOznERLV/Zode270JkQtkn9LZ3XBvoc2lQL1XIWdCjkCRgKD7Im1TJwg
	 2owQqJlunOQ2EjCj7a6VJU+ouP43x+IICZ+u7nLHOmqVLvA/5zC43etM8LVjobDnEu4ee
	 sTPegTNRTiEyGdaHXsC3rIg+Y2ARV3MGexBy7eSHVvefeqxQTuYRk73PGNbWwJlGXVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LIM32JOg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBF6606A325;
	Tue, 20 Oct 2026 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBF6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LIM32JOg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FE81596;
	Tue, 20 Oct 2026 09:25:18 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F027D3F7D8;
	Tue, 20 Oct 2026 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792513521; bh=AusZ5SvNx27k8Me5tZ9SxcLQrSYBKyfbvDjtzz07Dz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIM32JOgAW3tMe54KIhyIZCHSiq35zCM+fcCDc0ni2y1Sfsl4ckP3S3hpARKwtmZF
	 M4f9wZgolpLpzuPWS9/dwzVO30MOdTlIP+ogW6favk960BiBtK05+pjBpeuRJC0YBu
	 0hEg0jzlN4PDLUVN1B4e+rPCoU64Ypm/gYvqcZSU=
Date: Tue, 20 Oct 2026 17:25:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	David Hildenbrand <david@kernel.org>, Yabin Cui <yabinc@google.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
Message-ID: <20261020162510.GF26205@e132581.arm.com>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck>
 <20260810174159.GC15499@e132581.arm.com>
 <7c35e399-bc64-43c3-9588-672200758ea5@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c35e399-bc64-43c3-9588-672200758ea5@arm.com>

On Thu, Oct 08, 2026 at 04:13:27PM +0530, Dev Jain wrote:
> 
> >>> Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
> >>> default") made the AUX allocator use order-0 pages by default unless a
> >>> PMU explicitly asks for contiguous allocations.
> >>
> >> But that commit specifically calls out SPE as benefitting from
> >> non-contiguous pages:
> >>
> >>   "For instance, ARM SPE and TRBE operate with virtual pages, and
> >>    Coresight ETR allocates a separate buffer. For these PMUs,
> >>    allocating contiguous AUX pages unnecessarily exacerbates memory
> >>    fragmentation. This fragmentation can prevent their use on
> >>    long-running devices."
> >>
> >> so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
> >> problems that 18049c8cff9c was trying to solve?

> I don't have the full context here (can look in detail later) so drive-by comment:
> 
> In general, doing large order allocations should *reduce* fragmentation. If you allocate
> 16 order-0 pages as opposed to an order-4 compound page, you may end up spreading your
> allocations across different blocks, thus preventing them from merging later.
> 
> A recent example can be found in vmalloc [1].
>
> [1] https://lore.kernel.org/all/aPjrRkjiIt6HmXmT@casper.infradead.org/

Thanks, Dev. Roughly read the shared link, larger allocations can keep
pages with the same lifetime together, so order-0 allocation is not
necessarily better for fragmentation.

As mentioned in my other reply, the AUX buffer allocator already used
__GFP_NORETRY before the commit 18049c8cff9c, so those allocations do
not directly invoke the kernel OOM killer.

This calls for revisiting that rationale in 18049c8cff9c. The original
issue does not appear to have been investigated sufficiently, and we
still haven't received further details since this series.

I propose reverting 18049c8cff9c to restore the previous allocation
policy. If no objections, I will send a revert for review.

Thanks,
Leo
