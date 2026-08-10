Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851F3F4128;
	Mon, 10 Aug 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374656; cv=none; b=kmMVEzT0fRNTi7NAuejHlvnFbQcJvWPcxHgzFvWgcqzBo/HGINf190B/lUinc4LdCW6sNKdOked6yvtzYKWbxGPMnDGhL+TKEHZ2e0TruW18zai7DlZEt8tyS7H7lD+/sssBWU1SBgQwUigREciaEy9tS8+1ccNz8BdQqPijQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374656; c=relaxed/simple;
	bh=OOIIvQavrAI7WDVApTU74y9Gh8QynbaCFHbTh+7lwEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUrrefaNpxYBA8Ha6hAilixwSfg3tZqtRVTDmzoyUwNNUI4AWM9HNcKmm0+huDhz4yqlq7svN4oziz5kRA8ZST+dgKGZVIHzV+kCtzYn1m65hs2dI75B0uVyrjKWyQ7tiMvGoCh8q44d1TTnS8yx1xZyNByXqhE1GN2Zzz8P/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF8fta5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF8fta5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5DF1F000E9;
	Mon, 10 Aug 2026 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786374655;
	bh=jmQRvX1k1SiKuSCh+skMmpVu8Z7eNcE8mftGlIJOuk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jF8fta5j/+/mrM3hVm4vX69fI1bUZxljfWcwWwLlrbTYVwhzgYQLijGA8xol4fxrT
	 ymOxLPxU0YM+Df7HzHy40vOpGPdhA2Y/+Uqrh3eDT+8ydsYYwFyvVaCPUj/58Nw6hc
	 UrUqCb3juBU7LblPWvsqWlwTK7y1eApb69j/im0bYqVnTtHbXCJ/MHwm4aTWz4XHvA
	 Jb+Pyq/9guNk7AV1Q4V+iXY1Scpmt8Sxu/I/+28Y7OfxNNurhcH+7iYAAod+s9++Lf
	 L8LINXKHQre61zJW8Gi4haetO0sHYI40UNG2PWJViSF9UHnCrRbUeEU4/qhuF5vLc/
	 p9+4ZzsbZT38A==
Date: Mon, 10 Aug 2026 16:10:48 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
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
Message-ID: <annp-BdTviQoH6vy@willie-the-truck>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>

On Mon, Aug 10, 2026 at 03:44:42PM +0100, Leo Yan wrote:
> Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
> default") made the AUX allocator use order-0 pages by default unless a
> PMU explicitly asks for contiguous allocations.

But that commit specifically calls out SPE as benefitting from
non-contiguous pages:

  "For instance, ARM SPE and TRBE operate with virtual pages, and
   Coresight ETR allocates a separate buffer. For these PMUs,
   allocating contiguous AUX pages unnecessarily exacerbates memory
   fragmentation. This fragmentation can prevent their use on
   long-running devices."

so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
problems that 18049c8cff9c was trying to solve?

Will
