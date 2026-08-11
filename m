Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561243B6D9;
	Tue, 11 Aug 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443472; cv=none; b=NNsJcArHUF5ENLk34KJa9WV/QMxNbNtdWsOSmHoTRbq7UkMd1v8ciXZBg89rBRdpre2D4cyy0royZEUx105o/n/orCsSAvZy9VqAugG3qgYKJizSnhyiwpsTPXSIw453w81x8loutg7/2pvVuw1rLQz+HJrN1y7kIMajfC7YXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443472; c=relaxed/simple;
	bh=ZE7nm7ffD93BfMT8HVYKCGTJj/+7QxUldSFCAd+HgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYx1z/F5VszdhQz2eHerjerd6FP6re/4ILxMaU9CBpzk++y1eF6F39LxH0095yu+69OiwUp2S8ZMY1grChHEDIwlTQTdOtTY4tXJ61xykAflcO0Qx9p7ObkVaM8EajKNpHwSPX0f9tIVZNTHFFdDgtZ8DT2srAxN0Jj1pOhjVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GfDmzwVp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GfDmzwVp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B1D14BF;
	Tue, 11 Aug 2026 03:17:40 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573883F86F;
	Tue, 11 Aug 2026 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786443464; bh=ZE7nm7ffD93BfMT8HVYKCGTJj/+7QxUldSFCAd+HgnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfDmzwVp6hox1IdOhr4CkTgrII9BC/aPtQ+CsaNYGnwMUuTn2WmZFcM8dT9zU5apC
	 VJ4nZ0tn1xd/tYEk+msKedPgBfBoKTFFPf94b+45LR+aZd5IemiOBPqcaHUrOdmUVn
	 rV0BJ0lhyNLymFjbsKMoALJn3c9gAK95MLqJNC8M=
Date: Tue, 11 Aug 2026 11:17:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Leach <mike.leach@arm.com>,
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
Message-ID: <20260811101742.GE15499@e132581.arm.com>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck>
 <20260810174159.GC15499@e132581.arm.com>
 <8c8f6c2a-8fc2-4181-87fa-e64101dfce6f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8f6c2a-8fc2-4181-87fa-e64101dfce6f@linaro.org>

On Tue, Aug 11, 2026 at 10:02:44AM +0100, James Clark wrote:

[...]

> > The question is how "allocating contiguous AUX pages unnecessarily
> > exacerbates memory fragmentation." The relevant information I could find
> > is [1]:
> > 
> >   "On Android, we collect ETM data periodically on internal user devices
> >    for AutoFDO optimization (for both userspace libraries and the
> >    kernel). Allocating a large chunk of contiguous AUX pages (4M for each
> >    CPU) periodically is almost unbearable. The kernel may need to kill
> >    many processes to fulfill the request. It affects user experience even
> >    after using PMU."
> > 
> 
> This sounds like it could be an attribute to perf_event_open. We can do
> PREFER_LARGE by default for performance and fewer discontinuities, but on
> Android or small systems users can enable an option to revert back to single
> pages.
> 
> Or can this bit be determined at allocation time: "The kernel may need to
> kill many processes to fulfill the request"? If this memory pressure exists
> on allocation then do it one way, if not do it the other way.

Be careful with "The kernel may need to kill many processes ...".

The AUX allocator uses:

  #define PERF_AUX_GFP    (GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY) 

Documentation/core-api/memory-allocation.rst says that __GFP_NORETRY
causes the allocator to "fail early rather than cause disruptive
reclaim" and that "the OOM killer is not invoked".

Therefore, it is unlikely to me that AUX allocation itself would cause
the kernel OOM killer to kill processes in order to satisfy the request.

I am a bit suspect the original observation was related to Android's
lmkd [1], where allocating the AUX buffers increased overall memory
pressure and indirectly caused processes to be killed. If so, I think it
is important to understand what actually triggered those kills.

Thanks,
Leo

[1] https://source.android.com/docs/core/perf/lmkd?hl=en&utm_source=chatgpt.com
