Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307C35DA55
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778639626; cv=none; b=bwKt619P99MNliSexREZfkGtgv7nWPI/saxx+uobVId4wAjg4OjF9Hoy7BZVgWGgisF/UaClfED2NpClasUDTWQ4vbjj69RHeANv71Uc2U8uIstiUeEmOk0HIr9kGKBHO9izRuaVz36pfKe8VoaiPE4UtPNq9eUsyZiKgZZPQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778639626; c=relaxed/simple;
	bh=Lq7ZeMWaeRPiE6NmeNaz/BvZJ1RPwMntIFtW7KexgKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJV6pMthfaxKTzOXRTCnhUyl+7LfKoqJWuu5HktTQ5x/itIh0Gxbz89WNvImed0z9wvgOEbcp7jNGEbh4Boc80rPv/IzVYE7wbFj+r9lplUFAsfycZzqbKdebtlS7E5iWJB6AzwybNH11VfimbQyYce1d4/DBUpz4V45cXKZWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNailBtB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNailBtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED78AC2BCB0;
	Wed, 13 May 2026 02:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778639626;
	bh=Lq7ZeMWaeRPiE6NmeNaz/BvZJ1RPwMntIFtW7KexgKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QNailBtBumTuBRSz99OOSuG6s6i2J4wcbZvBhw3wqVyyTVGxPUWTtoL/QrcLCdrCW
	 VMMIVyA7okiLSF0r3go6KiAtZmPYGVjyvwjMNiYA2oXLv+rQHiNdDd4ELIuR3dy5+J
	 Ap8haHbUIZgT2jEh15Jjrn/YicM8f8/oqWXfPIYqtFTHxzj4yCNAg3hwDuvOuiUFBL
	 WR6HmrLTZRcUZOMlXNIGCFJ7n4EPYB04qMsDARe1E3Nq2ZscQ625fvJ+tZ/1pxgIx5
	 1miJDQq1j9mjVS/6WzyR256Lbenq6+PmxtXCuwQxCmEESrkaBDQaBpwmyyGKk0leYk
	 spayFwHeVVFGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf/x86/intel/uncore: Defer ADL global PMON enable
 to enable_box()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260511230527.26096-4-zide.chen@intel.com>
References: <20260511230527.26096-4-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:33:45 +0000
Message-Id: <20260513023345.ED78AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The deferred global PMON enablement permanently leaks the hardware=
 power state after the first use, nullifying the intended power savings.
--

commit ce0046bfd8b6ed5388332db6e76ea45581716939
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()

This commit drops adl_uncore_msr_init_box() and defers programming the
ADL_UNC_PERF_GLOBAL_CTL MSR to enable_box(). The goal is to save power by
ensuring the global control register is only enabled when a box is actually
used.

> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> index 3dbc6bacbd9de..edddd4f9ab5fc 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
[ ... ]
> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> -{
> -	if (box->pmu->pmu_idx =3D=3D 0)
> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> -}
> -
>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>  {
>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);

Does this unintentionally leave the hardware power state permanently enabled
after the first use?

The Linux perf core framework unconditionally calls perf_pmu_enable(), which
maps to uncore_pmu_enable() and executes enable_box(), at the end of PMU
transactions. This includes event removal sequences:

perf_pmu_disable()
   event->pmu->del()
   perf_pmu_enable()

Since adl_uncore_msr_enable_box() unconditionally writes
SNB_UNC_GLOBAL_CTL_EN, it seems the global PMON control is immediately
re-enabled and remains active even when zero events are in use, negating
the intended power savings.

Additionally, if a check like if (box->n_active) were added here, could
that silently break concurrent perf sessions on other uncore boxes?

Because disable_box() unconditionally clears the shared MSR during
transactions if pmu_idx =3D=3D 0, failing to re-enable it would leave PMON
globally disabled for the entire die. Safely managing dynamic power for this
shared global MSR might require a package-level active reference count
across all boxes.

> @@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_unco=
re_box *box)
>  }
> =20
>  static struct intel_uncore_ops adl_uncore_msr_ops =3D {
> -	.init_box	=3D adl_uncore_msr_init_box,
>  	.enable_box	=3D adl_uncore_msr_enable_box,
>  	.disable_box	=3D adl_uncore_msr_disable_box,
>  	.exit_box	=3D adl_uncore_msr_exit_box,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511230527.2609=
6-1-zide.chen@intel.com?part=3D3
