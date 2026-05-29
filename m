Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67416224D6
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045377; cv=none; b=B3Figvqxh8Z5XK1zDsdLTX2tvszPoAacToOP8xklw4iFapE+53CyTdpcRru1DdDW2uu0Bbh5gdnHGfHEQhZTnwVpSQZFdtFFMWCy3iuHi7N6STzDWtCWeF6YvpTmhSkuZKSf1uXzDEBZ/pYPSyShPlCZwnBu6EeG8xv0xYC+feE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045377; c=relaxed/simple;
	bh=3taSqyxC6QcKOZYs0oii4nFtNtNRR87oWxhBkVf0UhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIbnkMUAp0oz0br/U+LBIMBvn7z7nalkf6Bm1+AZ1A+UgPaS4Sj523nY12v9++dt2lwSzXNfQtupWlPClFLUk+Jmg4ydATW/UlDgzLHQxUNuOc47uyKC3bHcS1En3N/xLOsy9YGEBrVpqO/DV9N3g5nZLsnRnR56RDD6dY7YMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZcbyhCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZcbyhCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E801F00893;
	Fri, 29 May 2026 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045376;
	bh=6BTC79uvRjULKoTSPnIwJ2gY8O0GUTMRA6T/3459xUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZcbyhCrijYMXh5Dhh+QtvF8ktuvs81LzHdn7jY65b5YZUz6WmWC+ZYilLDwlK+/0
	 PE15Xcz1uEqdWqXjxmfahezpcGCoZS56c5BPrDnO0H4y0OlWEXSIiQzZV3ov6VFqIZ
	 mAUAGw2TO1A0tzs7KCdB1K81SzypEwb+aGr5GblR7U0cL89q1dI1x4Uhb4myVmo5cu
	 cMBgC8Lz7m4b+jRr7K2Wn4EY+x7QQKd96yKmfM1a9nAAgrt5D35eI5VDbD8mmctzWF
	 i3xrGLhP3S0D5ofOhpiLFnsfG9HV1ZBWPMIAqSCFD2eWO6NjBH+f/kyfF+vHKyH79a
	 acrikntYxDKIA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 10/23] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:02:55 +0000
Message-Id: <20260529090255.E5E801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] reserve_ext_regs_buffers() fails to propagate memory allocation er=
rors, leading to a predictable WARN_ON_ONCE in NMI context.
- [High] PEBS events on older platforms (e.g., Skylake) improperly accept `=
PERF_REG_EXTENDED_MASK`, bypassing capability checks.

Pre-existing issues:
- [High] Software PMU events (or hardware events requesting `PERF_SAMPLE_RE=
GS_USER`) can request XMM registers, causing `perf_reg_value()` to perform =
an out-of-bounds read on the kernel stack.
--

commit cee33ccbb52239e18206f79aef67c4e7ac96ca59
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Enable XMM Register Sampling for Non-PEBS Events

This commit extends XMM register sampling to non-PEBS events by utilizing t=
he
xsaves instruction. It introduces a per-CPU 64-byte aligned buffer to store
SIMD and other registers, allocating it during hardware reservation. The XMM
data is then retrieved during the REGS_INTR case.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 17c8f44ee43b3..c219a563434d4 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c

[ ... ]

> @@ -410,6 +410,56 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct pe=
rf_event *event)

[ ... ]

> +static void reserve_ext_regs_buffers(void)
> +{
> +	bool compacted =3D cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
> +	unsigned int size;
> +	int cpu;
> +
> +	if (!x86_pmu.ext_regs_mask)
> +		return;
> +
> +	/* +64 bytes for the 64 bytes alignment request of xsave area. */
> +	size =3D xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) + 64;
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu(ext_regs_buf, cpu) =3D kzalloc_node(size, GFP_KERNEL,
> +							  cpu_to_node(cpu));
> +		if (WARN_ON_ONCE(!per_cpu(ext_regs_buf, cpu)))
> +			goto err;
> +	}
> +
> +	return;
> +
> +err:
> +	release_ext_regs_buffers();
> +}

[Severity: High]
Does reserve_ext_regs_buffers() need to propagate the allocation failure ba=
ck
to the caller?

When kzalloc_node() fails, this function frees any previously allocated buf=
fers
and returns void. The caller, x86_reserve_hardware(), then assumes success
and allows the perf_event_open syscall to succeed. Later, when an event
requiring extended registers triggers a PMI, x86_pmu_sample_xregs() retriev=
es
a NULL buffer and triggers a WARN_ON_ONCE in NMI context.

Could this allow a local user to deliberately exhaust memory and repeatedly
open a perf event to trigger the warning? If the system has panic_on_warn
enabled, this could escalate to a kernel panic.

[ ... ]

> @@ -655,18 +707,26 @@ int x86_pmu_hw_config(struct perf_event *event)

[ ... ]

> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +		/*
> +		 * Besides the general purpose registers, XMM registers may
> +		 * be collected as well.
> +		 */
> +		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
> +			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
> +				return -EINVAL;
> +			if (is_sampling_event(event) && !event->attr.precise_ip &&
> +			    !this_cpu_has(X86_FEATURE_XSAVES))
> +				return -EINVAL;
> +		}
> +	}
> =20
> -		if (!event->attr.precise_ip)
> +	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
> +		/*
> +		 * Currently XMM registers sampling for REGS_USER is not
> +		 * supported yet.
> +		 */
> +		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
>  			return -EINVAL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but can software PMU events requ=
est
XMM registers and cause an out-of-bounds read on the kernel stack?

While x86_pmu_hw_config() correctly blocks PERF_REG_EXTENDED_MASK for
unsupported scenarios here, software events bypass x86_pmu_hw_config()
completely. The function perf_reg_validate() checks requested registers aga=
inst
PERF_REG_X86_RESERVED, which fails to exclude bits 32-63 (XMM registers).

If a software event requests XMM registers via PERF_SAMPLE_REGS_USER, and t=
he
event overflows, a standard pt_regs pointing to the top of the kernel stack
is passed to perf_reg_value().

When it uses container_of(regs, struct x86_perf_regs, regs) and reads
perf_regs->xmm_regs, does it read past the end of the pt_regs on the stack,
potentially leaking kernel memory or triggering a page fault?

I note this is addressed later in the patch series by commit "perf/x86: Ena=
ble
XMM register sampling for REGS_USER case", but wanted to mention it here.

[ ... ]

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 92cb9a716e83d..f5d458e3ba3f6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -6176,8 +6179,37 @@ static inline void __intel_update_large_pebs_flags=
(struct pmu *pmu)

[ ... ]

> +static void intel_extended_regs_init(struct pmu *pmu)
> +{
> +	struct pmu *dest_pmu =3D pmu ? pmu : x86_get_pmu(smp_processor_id());
> +
> +	/*
> +	 * Extend the vector registers support to non-PEBS.
> +	 * The feature is limited to newer Intel machines with
> +	 * PEBS V4+ or archPerfmonExt (0x23) enabled for now.
> +	 * In theory, the vector registers can be retrieved as
> +	 * long as the CPU supports. The support for the old
> +	 * generations may be added later if there is a
> +	 * requirement.
> +	 * Only support the extension when XSAVES is available.
> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_XSAVES))
> +		return;
> =20
> +	if (!boot_cpu_has(X86_FEATURE_XMM) ||
> +	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
> +		return;
> +
> +	/*
> +	 * On current hybrid platforms, P-cores and E-cores expose the same
> +	 * XSAVE feature set. Therefore, using the global x86_pmu.ext_regs_mask
> +	 * is sufficient to represent the hardware-supported XSAVE features.
> +	 */
> +	x86_pmu.ext_regs_mask |=3D XFEATURE_MASK_SSE;
> +	dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;
> +}

[Severity: High]
Will this allow PEBS events on older platforms like Skylake to bypass capab=
ility
checks?

Before this change, PERF_PMU_CAP_EXTENDED_REGS was only set for CPUs with P=
EBS
format >=3D 4 (Icelake+). By introducing intel_extended_regs_init(), the
capability is now set globally for any CPU supporting XSAVES, including
Skylake.

Looking back at x86_pmu_hw_config(), if an event is a PEBS event
(precise_ip > 0), it passes the capability check because the PMU now advert=
ises
it.

Since Skylake's PEBS v3 hardware cannot sample XMM registers, does this res=
ult
in a silent ABI regression where the kernel returns zeroes in the sample
payload instead of returning -EINVAL at event creation? Should
x86_pmu_hw_config() enforce that PEBS XMM requests specifically require PEBS
v4+ support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D10
