Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85763253359;
	Thu, 19 Feb 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509811; cv=none; b=PzpgDusCsCguwPQvPvdS+njSQQFIzsreNi28LjoRNgtvftkpfe2ctvsQPLPkYbtX7VYdGb15gsBV+yOvp33ajX/37ayXF8PEGNrm/snidvFhmYMO0rRq6qKpyIGOsQwucak5er8g4KICOSPQ6YT0USGjU78cvwFJvUsLd95YxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509811; c=relaxed/simple;
	bh=UEx+46CzqVD6fjELuE6UtRXKHwauEBQEFSxMktcvS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYuO0rwcFf3ak7xzYZvPgVzXd/AfChVS2hnGEyD89V3TrKZFq60nctVZwQ6OM2qommXWBGiGRazlhZSLh+VBTyfwGUoJyIsMBtPLlF9KDKIkEssVjbJgZcjXTBn7TTCmunzlx/8tkHbXVROdNfl9n921dyUC7jSX8e30/T2jXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUG6ovFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUG6ovFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE6C4CEF7;
	Thu, 19 Feb 2026 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771509811;
	bh=UEx+46CzqVD6fjELuE6UtRXKHwauEBQEFSxMktcvS+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUG6ovFAS7J9JWzCzj/SsEULT5PXdNlUNh94A2VEMdvWRNiwW4bckyfe/a3UhqNHD
	 ksyDF2DN/of0ZnhrIaMIoaggev5HJuyG0HIXpye1Ya/hQMIjoD8iYJc0rd9rohZ8d/
	 +hbR+AK4zhc7UwiTGRkLdCW9WYr7NZ8+D3o2hx7KOlPbDQjlqYU7EuN1hLVGfzRXF4
	 RhY4sjgf5BYi05PIG0dqCYxS+vDcBEQVtrhfo4NyT/1b/EBZz99/c2g5uDV7yAAJyi
	 58MsTOyEvLACfMG+NlRbTwK9GxppOoYsIe8w401L0bYblDKJPsuj+7WNC0bypdUtD4
	 vXYV4ZjW0wFiQ==
Date: Thu, 19 Feb 2026 14:03:25 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Michael Williams <Michael.Williams@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aZcYLZ9wETnRDJ7P@willie-the-truck>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
 <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
 <aZcIy1Or4c5-i7Tm@willie-the-truck>
 <7b692e5c-d376-4023-80e0-76c9d9c0604f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b692e5c-d376-4023-80e0-76c9d9c0604f@linaro.org>

On Thu, Feb 19, 2026 at 01:51:26PM +0000, James Clark wrote:
> On 19/02/2026 12:57 pm, Will Deacon wrote:
> > On Thu, Feb 19, 2026 at 12:08:27PM +0000, James Clark wrote:
> > > I'm back to drag this up again. So I think all of the above discussion
> > > relies on the ordering given by the indirect read needed for the "might
> > > ignore a direct write..." part. But it's _might_ ignore a direct write, it's
> > > possible for an implementation to not do that, so there are two possible
> > > implementations:
> > > 
> > > #1 Where there is an indirect read to give the write ignore outcome
> > > #2 Where there is no write ignore outcome so it doesn't require an
> > >     indirect read
> > > 
> > > For #2 there's nothing to force the ordering. We're writing to two different
> > > registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have the
> > > PMBLIMITR_EL1 write come second for the buffer to be considered configured
> > > correctly. For example if the old value of PMBPTR_EL1 is higher than the new
> > > PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens first then it's
> > > misconfigured. That's why we think we need the isb() here.
> > 
> > I thought profiling was disabled in these cases, so why is it
> > misconfigured?
> > 
> > If it is misconfigured, what can go wrong given that we're either stopped
> > or pmscr is clear?
> > 
> > Will
> 
> It is stopped in the interrupt handler because PMBSR_EL1.S = 1. But in
> arm_spe_pmu_start(), PMBSR_EL1.S = 0 so it's not stopped. And with
> PMBPTR_EL1 still being set to the value from the last session it could be
> higher than PMBLIMITR_EL1.
> 
> PMSCR_EL1 doesn't affect SPEProfilingStopped(), it's only:
> 
>   boolean stopped = (PMBSR_EL1.S == '1');
> 
> The conditions for when the buffer needs to be configured correctly from
> R24557 are:
> 
>   ProfilingBufferEnabled() && !SPEProfilingStopped() &&
>     PMBLIMITR_EL1.FM != DISCARD
> 
> I think even if PMSCR_EL1 is clear you can still get a buffer management
> error, even if no samples were going to be written into the buffer. It just
> says:
> 
>   While the Profiling Buffer is enabled, profiling is not stopped, and
>   Discard mode is not enabled, all of the following must be true:
> 
>   * The current write pointer must be at least one sample record below
>     the write limit pointer.

... but doesn't that mean that R24557 is a breaking change to the
architecture? The current Arm ARM doesn't appear to require this,
existing software doesn't honour it so why should we hack extra barriers
into Linux?

Will
