Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A5219FC;
	Mon,  2 Feb 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059000; cv=none; b=ciRQwLK2qowBhqe8WuxPrADwaFnO3ZJzCfGYlPaHFr0I5aKCqR5ie9VKrKbY1o6+4+Az/I6DbkWYzxMzhU4t4aDAyMnpHu6A95a8yKs7SECTZCe6YWTSsoUWlp/btKsWq6y0+ugdhDoi+sgYzMdY+MU8lPIgd1phxNtRM+cc4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059000; c=relaxed/simple;
	bh=lZPsa1GunFyucDAD7fgMY5uSKYZgjqehKmPOKc3dDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBWDNVzE8ANVrqDn0/uVbcckdK99TEbOpQgfKtyNs3OWCn3RvYj20TMOjFr5L1/TuirJ7sdyxum/rkpTxIfoKVZv7bMYZ2dwZXAmBM/dPcyb5D/c+KuVFrZX8ZukzyeIPE1QkDYDFHalLJJLHQ52KvgHBBkYOj7VqMYiy/GKkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhHaX8iw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhHaX8iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDDCC116C6;
	Mon,  2 Feb 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058999;
	bh=lZPsa1GunFyucDAD7fgMY5uSKYZgjqehKmPOKc3dDUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhHaX8iwvXw9OaAzOwaFPJ8T/Zdqy6xTmliOvyQ7VNvBAOYHdWnMhRHzGmXr5mNrC
	 wCazlmo/mUe6jn3ammP8FDXnifPcH/W1FEU7ymTUh+u97ORkQez8OFpmPCR1+5LUwc
	 kjHoUbEgppo9gyjcPg/V2sOlquV15JsqdE4KHQrfZBOQbaq4/pX4O+CuMsEOTNgrPQ
	 oZwM258Rek34NJo8poqSqC/eMXkeRRslb9zZ55/j5pBRbB9CmYVW6hf6Bavf7Hd11w
	 JHag0IJNJMMaR3iE36eKZPTt4zE2Az7kiDvUvsoUsG6BjTdReNH+xWnSFfUeGrUu3e
	 bCULUQaok3waA==
Date: Mon, 2 Feb 2026 19:03:13 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aYD08d42SewAAQCB@willie-the-truck>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>

On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
> The Arm ARM known issues document [1] states that the architecture will
> be relaxed so that the profiling buffer must be correctly configured
> when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
> PMBLIMITR_EL1.FM != DISCARD:
> 
>   R24557
> 
>   While the Profiling Buffer is enabled, profiling is not stopped, and
>   Discard mode is not enabled, all of the following must be true:
> 
>   * The current write pointer must be at least one sample record below
>     the write limit pointer.
> 
> The same relaxation also says that writes may be completely ignored:
> 
>   When the Profiling Buffer is enabled, profiling is not stopped, and
>   Discard mode is not enabled, the PE might ignore a direct write to any
>   of the following Profiling Buffer registers, other than a direct write
>   to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
> 
>   * The current write pointer, PMBPTR_EL1.
>   * The Limit pointer, PMBLIMITR_EL1.
>   * PMBSR_EL1.

Thinking about this some more, does that mean that the direct write to
PMBPTR_EL1 performs an indirect read of PMBLIMITR_EL1 so that it can
determine the write-ignore semantics? If so, doesn't that mean that
we'll get order against a subsequent direct write of PMBLIMITR_EL1
without an ISB thanks to table "D24-1 Synchronization requirements"
which says that an indirect read followed by a direct write doesn't
require synchronisation?

There's also a sentence above the table stating:

"Direct writes to System registers are not allowed to affect any
 instructions appearing in program order before the direct write."

so after all that, I'm not really sure why the ISB is required.

Will
