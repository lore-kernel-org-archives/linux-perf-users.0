Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17C33FE15;
	Thu, 19 Feb 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511448; cv=none; b=m7YQ8UVXpB9NtKt3jQNCXGYFhXC/AFkoAgmRUIspCf6xfMdBKk25zJNcic/QxmVV2skVkk4u5mj0EFImsP2YhgTqMPxYUGSkbszQBZUMhU5oGWUDzmA6vGKAXsSmFWDUKu2BfD1uJFgszanA0O+2hekK5EUbdGdmlgdg+1W0GR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511448; c=relaxed/simple;
	bh=+OrAAseb34CaQcQ+I8Dtr967mWYl4z2U6tOouXx/dfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CarH1et+hckQ/sVByXRH8qw7jdSHt+jjFqg639R682CmJECLJCLcicMj768Am1ayiU+xUpA7QraM3uVH767hn1ZJM8i2Djs6BXUkGBJSyOiClJsNhWBxVhBDexMMw1hR7KVmko0QqDZlaTfgP3NBjsjLAVhpejMYoDWMW2F9FlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53503339;
	Thu, 19 Feb 2026 06:30:39 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 928143F62B;
	Thu, 19 Feb 2026 06:30:43 -0800 (PST)
Date: Thu, 19 Feb 2026 14:30:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Williams <Michael.Williams@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aZcekSK5fGEkw_1P@J2N7QTR9R3.cambridge.arm.com>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
 <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
 <aZcIy1Or4c5-i7Tm@willie-the-truck>
 <7b692e5c-d376-4023-80e0-76c9d9c0604f@linaro.org>
 <aZcYLZ9wETnRDJ7P@willie-the-truck>
 <2d5f6207-afa2-4880-b34d-f03b5ebf3b5f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d5f6207-afa2-4880-b34d-f03b5ebf3b5f@linaro.org>

On Thu, Feb 19, 2026 at 02:15:22PM +0000, James Clark wrote:
> On 19/02/2026 2:03 pm, Will Deacon wrote:
> > On Thu, Feb 19, 2026 at 01:51:26PM +0000, James Clark wrote:
> > > On 19/02/2026 12:57 pm, Will Deacon wrote:
> > > > On Thu, Feb 19, 2026 at 12:08:27PM +0000, James Clark wrote:
> > > > > I'm back to drag this up again. So I think all of the above discussion
> > > > > relies on the ordering given by the indirect read needed for the "might
> > > > > ignore a direct write..." part. But it's _might_ ignore a direct write, it's
> > > > > possible for an implementation to not do that, so there are two possible
> > > > > implementations:
> > > > > 
> > > > > #1 Where there is an indirect read to give the write ignore outcome
> > > > > #2 Where there is no write ignore outcome so it doesn't require an
> > > > >      indirect read
> > > > > 
> > > > > For #2 there's nothing to force the ordering. We're writing to two different
> > > > > registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have the
> > > > > PMBLIMITR_EL1 write come second for the buffer to be considered configured
> > > > > correctly. For example if the old value of PMBPTR_EL1 is higher than the new
> > > > > PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens first then it's
> > > > > misconfigured. That's why we think we need the isb() here.
> > > > 
> > > > I thought profiling was disabled in these cases, so why is it
> > > > misconfigured?
> > > > 
> > > > If it is misconfigured, what can go wrong given that we're either stopped
> > > > or pmscr is clear?
> > > > 
> > > > Will
> > > 
> > > It is stopped in the interrupt handler because PMBSR_EL1.S = 1. But in
> > > arm_spe_pmu_start(), PMBSR_EL1.S = 0 so it's not stopped. And with
> > > PMBPTR_EL1 still being set to the value from the last session it could be
> > > higher than PMBLIMITR_EL1.
> > > 
> > > PMSCR_EL1 doesn't affect SPEProfilingStopped(), it's only:
> > > 
> > >    boolean stopped = (PMBSR_EL1.S == '1');
> > > 
> > > The conditions for when the buffer needs to be configured correctly from
> > > R24557 are:
> > > 
> > >    ProfilingBufferEnabled() && !SPEProfilingStopped() &&
> > >      PMBLIMITR_EL1.FM != DISCARD
> > > 
> > > I think even if PMSCR_EL1 is clear you can still get a buffer management
> > > error, even if no samples were going to be written into the buffer. It just
> > > says:
> > > 
> > >    While the Profiling Buffer is enabled, profiling is not stopped, and
> > >    Discard mode is not enabled, all of the following must be true:
> > > 
> > >    * The current write pointer must be at least one sample record below
> > >      the write limit pointer.
> > 
> > ... but doesn't that mean that R24557 is a breaking change to the
> > architecture? The current Arm ARM doesn't appear to require this,
> > existing software doesn't honour it so why should we hack extra barriers
> > into Linux?
> > 
> > Will
> 
> Yes I suppose it is. The current Arm ARM doesn't require it, but R24577 is
> in the "known issues" document for the Arm ARM, so it's saying the ARM is
> incorrect here and you shouldn't trust what it says.
> 
>   Arm Architecture Reference Manual for A-profile architecture: Known
>   issues
> 
>   This document includes the Known Issues for the following documents:
> 
>     Arm Architecture Reference Manual for A-profile architecture
>     (DDI0487)
> 
> Presumably the fix will make it into the Arm ARM eventually. 

While that document is called "Known issues" it really means "Key
changes since the last ARM ARM". The items in that are not all bug
fixes.

In this case, R24577 is intended to be a relaxation (that's what the "R"
stands for), which breaks existing widely-deployed SW. It fails to meet
the usual acceptability requirements for a relaxation.

IMO this should not have made it into the architecture as-is.

> I suppose there is a chance that this could be deleted from the known issues
> and not make it into a future Arm ARM. TBH I have no experience or feeling
> to say how likely that would be.

Broken changes have made it into the architecture before, and have been
subsequently reverted. In general, we try to avoid that in the first
place.

I will raise this internally within Arm.

Mark.
