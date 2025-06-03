Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1822331C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990668; cv=none; b=Xls5hWsobckC/BBnF/96EenFuEUGkruJIT9vc7xtD03i9Vi0EZNrwrVMCAIIe7fAxywqMiTHOfOwicbUIYrRstulrMJ6/A53ayXhDsNNkQpLZWtnm9imjElFdZgMw2vYSqBOjTkgDhOU2uuPDw8ig1As5HjFfEjGWK8UuBD+dQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990668; c=relaxed/simple;
	bh=LLoqeM/UCB0mh20l/3/Xv9BmLg+WjY+M+SHRDQyeuwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaBRWXx6c0uSZbZCCcv03lP9jHFTZFxi+f4RdFy/VmDrcyjinpXYbv6DQPxZin74bBaulWnI/ytbDAaJaetnu8ZjNchRjqC/6hDP8DP7goUqTSvcoHcDwSuGtR0TCa2O8ozDvIubJ01nGvZiX7BvI1edpaRWcHDFH6qXPnU8NSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzCIQEGZ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzCIQEGZ"
Date: Tue, 3 Jun 2025 15:43:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748990654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoKlMc1lHrduXpDbBbVFy4M8aj5m5zbNDdssxMr5tdc=;
	b=lzCIQEGZ9FI8wt89dqHEjgAakygFlEyD4l9ip53qVy9LfjTGPS95wVhPcy/2qmUyOYVAjE
	JRaFapvUKpqg/O3lcUMMPEcYcp7ibaVQc7D6mRAMyy7cTKnSFcjae5MS7anwW9DSr5vcUV
	rFDNBe0JSQRHTY/ygvKnzMkxuvVGfU8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/17] ARM64 PMU Partitioning
Message-ID: <aD96rn78BSUDbEu1@linux.dev>
References: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:26:45PM +0000, Colton Lewis wrote:
> Caveats:
> 
> Because the most consistent and performant thing to do was untrap
> PMCR_EL0, the number of counters visible to the guest via PMCR_EL0.N
> is always equal to the value KVM sets for MDCR_EL2.HPMN. Previously
> allowed writes to PMCR_EL0.N via {GET,SET}_ONE_REG no longer affect
> the guest.
> 
> These improvements come at a cost to 7-35 new registers that must be
> swapped at every vcpu_load and vcpu_put if the feature is enabled. I
> have been informed KVM would like to avoid paying this cost when
> possible.
> 
> One solution is to make the trapping changes and context swapping lazy
> such that the trapping changes and context swapping only take place
> after the guest has actually accessed the PMU so guests that never
> access the PMU never pay the cost.

You should try and model this similar to how we manage the debug
breakpoints/watchpoints. In that case the debug register context is
loaded if either:

 (1) Self-hosted debug is actively in use by the guest, or

 (2) The guest has accessed a debug register since the last vcpu_load()

> This is not done here because it is not crucial to the primary
> functionality and I thought review would be more productive as soon as
> I had something complete enough for reviewers to easily play with.
> 
> However, this or any better ideas are on the table for inclusion in
> future re-rolls.

One of the other things that I'd like to see is if we can pare down the
amount of CPU feature dependencies for a partitioned PMU. Annoyingly,
there aren't a lot of machines out there with FEAT_FGT yet, and you
should be able to make all of this work in VHE + FEAT_PMUv3p1.

That "just" comes at the cost of extra traps (leaving TPM and
potentially TPMCR set). You can mitigate the cost of this by emulating
accesses in the fast path that don't need to go out to a kernel context
to be serviced. Same goes for requiring FEAT_HPMN0 to expose 0 event
counters, we can fall back to TPM traps if needed.

Taking perf out of the picture should still give you a significant
reduction vPMU overheads.

Last thing, let's table guest support for FEAT_PMUv3_ICNTR for the time
being. Yes, it falls in the KVM-owned range, but we can just handle it
with a fine-grained undef for now. Once the core infrastructure has
landed upstream we can start layering new features into the partitioned
implementation.

Thanks,
Oliver
