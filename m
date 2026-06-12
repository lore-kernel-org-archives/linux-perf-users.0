Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18E3A5433
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256680; cv=none; b=EcUSGRo8KmuMrVf5NmB1xG3n3tWRy0Vi4HFBgkhgbR2UQ4yq9yUYg/+Zcn3Sfy6IrhxflemEu/TS2Iu7ffo1GsMAREayIX8Fjz083ZggWB9uaLbG3/3EniQzq6XjfW7qxP9gkmdYYePTBhqoP/xVSiNgPLfHs/3Y/KUTl8NPJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256680; c=relaxed/simple;
	bh=eigepc0SQ3KvCcLb38iB/AO6I9kPe2zXM2uRswz3bxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fr+18zJNGWKrZ/pez9K31u/AHZPCM6TgTn/bZ9MU9M6inQQa4XYJkSGYqi+CdgqygafASsUOfniwZDsNtkrF84Y6dOcdsjB4N9UXqnhNDrjASuAfMO4psBMU3gYuQtg9HcOisj1tH5UHkNsXexCrwEJ6q7G5h7XidEY/JHJiJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwaaXp9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwaaXp9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA3E1F000E9;
	Fri, 12 Jun 2026 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781256679;
	bh=oHH4w0OFZ7wK5HZONPnbnlR76UhbGApYCIO6WzFiGVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwaaXp9Xy52gcpqBxAGOxE4IJqSqjQO9DgjD41HE3fonoRi5M6QhnjTepagx0/lyl
	 OH2mzMNcw/OmcSGqZ5mp0w4rxCjYhPfACDPK4uyF80PswWTQS1BXmNVERC8kXUKgEu
	 AZ4QW6kHv6e6vg+LtGnB/3RPE7HQSWPUerS7I23njot+9zW4gMtB60+oQ+VJEckce5
	 QShHvOTPiHQAu50BD/VBMk2xOSm8QF7KFAWDgZqjy1Su1X8UgtJISDegpuGyx+qeeD
	 oFzSFI/jB+3n3toLwxNQYZPdAoFgMJfiFhv8gxrUqjrd6c4AyDCC3Rv1LEWaAaQCuM
	 bIis2b5Z5W/Cg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 5/8] perf/x86/intel: Validate the return value of
 intel_pmu_init_hybrid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612090114.3188886-6-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:31:19 +0000
Message-Id: <20260612093119.7FA3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Relocating `intel_pmu_arch_lbr_init()` below `intel_pmu_check_ev=
ent_constraints_all()` bypasses the dynamic constraint validation for branc=
h counters.
--

commit 4ceb25a65fdf63fe8fa33e932139cf0a5d28e924
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()

This patch validates the return value of intel_pmu_init_hybrid() to avoid a
null-pointer dereference. It also defers intel_pmu_arch_lbr_init() until af=
ter
hybrid PMU initialization succeeds to avoid destroying the kmem cache on
failure.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index db52e7e53a6cd..74dbf24b0ab63 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -8829,6 +8842,9 @@ __init int intel_pmu_init(void)
> =20
>  	intel_pmu_check_event_constraints_all(NULL);
> =20
> +	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
> +		intel_pmu_arch_lbr_init();
> +
[Severity: Medium]
Does moving intel_pmu_arch_lbr_init() below
intel_pmu_check_event_constraints_all() bypass the dynamic constraint
validation for branch counters?

When intel_pmu_check_event_constraints_all() runs, it eventually calls
intel_pmu_check_dyn_constr(). This check relies on the PMU_FL_BR_CNTR flag
and the x86_pmu.lbr_counters mask:

arch/x86/events/intel/core.c:intel_pmu_check_dyn_constr() {
    ...
		case DYN_CONSTR_BR_CNTR:
			if (x86_pmu.flags & PMU_FL_BR_CNTR)
				mask =3D x86_pmu.lbr_counters;
			break;
    ...
}

Because intel_pmu_arch_lbr_init() is now deferred until after this validati=
on,
the PMU_FL_BR_CNTR flag hasn't been set yet. Will this cause the dynamic
constraint check for branch counters to evaluate to false and be skipped?

>  	/*
>  	 * Access LBR MSR may cause #GP under certain circumstances.
>  	 * Check all LBR MSR here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090114.3188=
886-1-dapeng1.mi@linux.intel.com?part=3D5
