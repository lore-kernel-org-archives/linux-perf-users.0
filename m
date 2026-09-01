Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870748167E;
	Tue,  1 Sep 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282403; cv=none; b=JBo73mDMnWpR71pefgPiCKdMUnMVYNWiEv91JDgbnuJP+wEBmtQsa/99WjmDGV9DY2J+amlp2xhDGTfBP21Nqm+74SdmMk6c8u6Vw9IHaKBkJwfklvevL53KUObeRs4E8lUnPdTxjpxZ2GHFVfvumV0h5boXaeIf72cFrkJrR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282403; c=relaxed/simple;
	bh=Lpma1BsFTfB984TFon8DGswojmIW60uY158QAd/sNt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEzz1/X8miZiFKcR65tjrZWxnqnyn7vEcpOFM/5oK5NF0xuJRCSyKp2YVTnjyf5wPq56fUVhDPR7GyXt7kjteShJO1BACKc4gZxn5snm3R1XeoGETItwC+0G7kfuFFlASWyOr7/dYpEbnEgtYcCmBt3e8PzkVN9hAMFj07i7kvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WSMmqxbv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WSMmqxbv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 637CE1756;
	Tue,  1 Sep 2026 10:06:36 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B23E23F7D8;
	Tue,  1 Sep 2026 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788282400; bh=Lpma1BsFTfB984TFon8DGswojmIW60uY158QAd/sNt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSMmqxbv72Ix7wOT4SWzA7e04uqe1FtpdK7e0FSRluLERMDVrnKJhTJkC/6YIV2xD
	 ClC+CklAMN76P/n5SZHCtHD2TRJgL/hfa/FD+LvdVafPhgJoKcrru1PKsj63AS1R8G
	 u/TEJfg2nG5O4Gvkm41u52/PsMdgYOlBnXMlV+mY=
Date: Tue, 1 Sep 2026 18:06:37 +0100
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
Message-ID: <20260901170637.GS8904@e132581.arm.com>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck>
 <20260810174159.GC15499@e132581.arm.com>
 <8c8f6c2a-8fc2-4181-87fa-e64101dfce6f@linaro.org>
 <20260811101742.GE15499@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811101742.GE15499@e132581.arm.com>

Hi Will, Yabin,

On Tue, Aug 11, 2026 at 11:17:42AM +0100, Leo Yan wrote:

> > > The question is how "allocating contiguous AUX pages unnecessarily
> > > exacerbates memory fragmentation." The relevant information I could find
> > > is [1]:
> > > 
> > >   "On Android, we collect ETM data periodically on internal user devices
> > >    for AutoFDO optimization (for both userspace libraries and the
> > >    kernel). Allocating a large chunk of contiguous AUX pages (4M for each
> > >    CPU) periodically is almost unbearable. The kernel may need to kill
> > >    many processes to fulfill the request. It affects user experience even
> > >    after using PMU."

> > This sounds like it could be an attribute to perf_event_open. We can do
> > PREFER_LARGE by default for performance and fewer discontinuities, but on
> > Android or small systems users can enable an option to revert back to single
> > pages.

> > Or can this bit be determined at allocation time: "The kernel may need to
> > kill many processes to fulfill the request"? If this memory pressure exists
> > on allocation then do it one way, if not do it the other way.
> 
> Be careful with "The kernel may need to kill many processes ...".
> 
> The AUX allocator uses:
> 
>   #define PERF_AUX_GFP    (GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY) 
> 
> Documentation/core-api/memory-allocation.rst says that __GFP_NORETRY
> causes the allocator to "fail early rather than cause disruptive
> reclaim" and that "the OOM killer is not invoked".
> 
> Therefore, it is unlikely to me that AUX allocation itself would cause
> the kernel OOM killer to kill processes in order to satisfy the request.
> 
> I am a bit suspect the original observation was related to Android's
> lmkd [1], where allocating the AUX buffers increased overall memory
> pressure and indirectly caused processes to be killed. If so, I think it
> is important to understand what actually triggered those kills.

I'd like to follow up on this, as I am not sure how we should proceed
without more information about the original process-kill issue.

If the original process-kill killer issue can be handled on the Android
side (e.g., configure lmkd), we could consider preferring large AUX
mappings by default. Otherwise, we may need to add an perf_event_open()
attribute as James suggested, but that would add complexity to both the
kernel and tools.

Could you share what actually triggered the process kills? That would
help us decide which direction to take.

Thanks,
Leo
