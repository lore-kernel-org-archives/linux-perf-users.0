Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF463D5259;
	Thu, 28 May 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965859; cv=none; b=Ug2W9U7lMiUvSdmw4nqPrFW4cVqmKso35xZ/NPb7t0f5xKKsXgOEdovuFBLLEFKwY0pwW0hBqFMcyRbE1DHZImuXRtKFC3bpEbwlbBgDuueYZiS9h72ezjwLiAuJvLvv/9J2aUCU7o7SgTfHfKhAhoKBhZ+pxKTes2W3ffSDAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965859; c=relaxed/simple;
	bh=FpZ+I0J1cXV3xp7IHFpQM10yDcFlGjm43hsAmibYYxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbKcMSmY8vKuqs6kOA9PCdH9bzyp3Hf0MKrQ4GwC52VmhpL/UeOK6z/UnnLzFm1vVySmyKVOWxioGuO5GXUgQMpZBj3PYU7KE/imidEjo67QNXAnnrpwv4gVxilTQQ9L7uV37+Ke7yk7AXXWDUVNqHGuRffp1b2aAZKODhqTUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWhGw4cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWhGw4cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9041F000E9;
	Thu, 28 May 2026 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779965856;
	bh=kGPf2M3vKWJJvTEOjgI7sO3PUfdpRBgFDGeky9IGVdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lWhGw4cz3l6efjD2+vZ+kwl/8VpPHfeZ9XrOsIo2LtmMepiU2HsD8vW6MQLWpxKgO
	 +Wq0/curoqJR69djSFeCsUu+mBXsDXmsCF2K8ZBziZB2/3im/GPSc/cGwgr7O26/cQ
	 wooOMI0B8/aWFoHdE0WrDpJWLrKWou5HOZcBwhC3vAYpnmE+cyACjgtzyb2Vgj/h/5
	 5lKJcxVMPGrGIQjt/7RihfA1CIZO3BAfYWBEm0+hxUACnkK1skvU31gBhjWAiXCYQg
	 euxAW9z0oE20ZLuJ0N35dFcCl4iywc1cYzPdWpiyNy55XcgG7V3x8mNxQenp6kVzmf
	 fjCNaED3oeRzQ==
Date: Thu, 28 May 2026 11:57:31 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/6] arm64: hw_breakpoint: Add
 lockdep_assert_irqs_disabled() on install/uninstall
Message-ID: <ahgfmyZtPL5YPRCZ@willie-the-truck>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
 <20260407-arm-debug-8-9-v4-3-a4864e69b0ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-arm-debug-8-9-v4-3-a4864e69b0ea@kernel.org>

On Tue, Apr 07, 2026 at 09:29:45AM -0500, Rob Herring (Arm) wrote:
> The breakpoint install/uninstall/restore code depends on interrupts
> being disabled. Make this requirement explicit with a
> lockdep_assert_irqs_disabled() assertion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index bb39bc759810..a9266dc710b4 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -231,6 +231,8 @@ static int hw_breakpoint_control(struct perf_event *bp,
>  	enum dbg_active_el dbg_el = debug_exception_level(info->ctrl.privilege);
>  	u32 ctrl;
>  
> +	lockdep_assert_irqs_disabled();

This function (hw_breakpoint_control()) is static and only has three
callers:

  1. Via the cpu hotplug CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING notifier
  2. From arch_install_hw_breakpoint()
  3. From arch_uninstall_hw_breakpoint()

So if we're called with irqs enabled, the core code has gone very wrong
and I don't think we should necessarily be checking that in the arch
backend. We also already have a WARN_ON(preemptible()) in
{enable,disable}_debug_monitors() so if you really want to add this then
please can you spell out why you're specifically concerned about the
preemption-disabled but irq-enabled case in the commit message?

Will
