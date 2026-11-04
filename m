Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774672;
	b=uKfXHV0vZiMEAO6ZBaLiUfzZ3adjuxYqTt5gq2q7M3f1ydJvX3LCSwMumI+yM+wLvy6t
	 xbVY+/gAbLq/YYLc9d3jfAatUwFEmuh8yr5d8bSYVc4A4zpwS4PVmqBmFA2K9mdpQg02N
	 SpFWvB3KopESdp6t13OnJtLHvjCPnTmpxWKLmYyoE6ya2cAeep4ypMiapeY5xMwdXaOhD
	 +6NFwFVCBZIsJDTt6fywZXgRjPnG0egZ9FVnArFOAfHTchEOPAROKVLf756Bl04Iv7Qgj
	 an3P6P0+zlr7Cus4NtI/OqJZtxtcBtxXcL6J6UilRUA4qbwpzrKQgIvMFsVQ5mLFh0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eoTPgfA22ObiICSuv3ChGe1ASllNZSRO6e9LrsXAs7k=;
	b=5luTTJxaSmXnhv4QKXS7H1rMkVF/u1+xmikCcgthOASiJ6ZYKK3JlkTJ9JYngO0NnZ1i
	 IyjNLu8ANeEoU1536rQbEOR+4CvAqyvQpAlyW6FFyd3R9ILX3trRT3VH82U8WIlL5QI0d
	 w/iU3Y9CpPnXLqAY6cYX2eYZD+r18anNwmrkohM/8uJnwKZE7pz4EiQxj72pmMBxo5/P/
	 6LwLi7xpApvujA3i7ukMXt/IXM3lp6IvBN5TM0UJyFh5khrmXrvpTZgt+431IxR7JGayy
	 MDRZ5wZyfuUwEUhA3zrbVYEAxI7sZbiyHmDUyOG6/tgAbde8NCUTjvANXZtZv2W1rRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHTrq2XB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15F606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHTrq2XB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD41F00919;
	Wed,  4 Nov 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793774671;
	bh=eoTPgfA22ObiICSuv3ChGe1ASllNZSRO6e9LrsXAs7k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NHTrq2XB2GxJTQgx4tTOX3nLs5JwCqqJidniRQ/PRMu3d2yRHfJcssriWrck/n0lQ
	 xmZVgzMRsyOcXzqCf49XffjMU2+kTeJ5LRR58h9JBiWex32/ZdB/kCi6ghOU7AKxP2
	 EIMMdbM+/wYOKfCT264s4/ys2jkYeVWpgn3cQrtojQr5bNAx61B7o+9Q+DizJI5TSk
	 wqgV/+MjGic/aTknxpf6aiF+uHww+S8ums/xqTioqjbycY//RfsT7AVp9Nb6Rqewcn
	 voNxDa5Uy5ahJD/gNxGF6qkwKVAayoY0Tfuv3Aw4pR7tV3HkOJ0/M4ujjPU0fhOuHh
	 zj+jLrCpv4krg==
Message-ID: <sashiko-outbox-196767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 34/41] perf pmu: Probe user and interrupt sample
 register masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-35-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:44:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf pmu: probe_pmu_regs_one() skips non-PEBS extended GPRs via =
reg_mask()
- [Medium] perf pmu: probe_pmu_regs_one() probes invalid extended regs on a=
rm64/powerpc
--

commit 0bf5f581edb6cbd00d2dffa574e5d67ba1f8061e
Author: Ian Rogers <irogers@google.com>

perf pmu: Probe user and interrupt sample register masks

This commit extends perf_pmu__probe() with probe_pmu_regs_one() to probe
supported general-purpose, extended general-purpose, and SIMD register
sampling masks for PERF_SAMPLE_REGS_USER and PERF_SAMPLE_REGS_INTR.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 3585147c52422..9179231aa7d5a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3386,6 +3386,237 @@ static void probe_sample_types(struct perf_pmu *p=
mu,
>  	pmu->probed.can_weight =3D !!(pmu->probed.sample_types & PERF_SAMPLE_WE=
IGHT);
>  }
> =20
> +/*
> + * Probe supported general-purpose, extended GPR, and SIMD vector/predic=
ate
> + * register sampling masks for either PERF_SAMPLE_REGS_USER (!@intr) or
> + * PERF_SAMPLE_REGS_INTR (@intr).
> + */
> +static void probe_pmu_regs_one(const struct perf_pmu *pmu,
> +			       const struct perf_event_attr *base_attr,
> +			       pid_t pid, int cpu, unsigned long flags,
> +			       int max_precise, bool intr,
> +			       u64 *out_mask, int *out_abi,
> +			       u64 *out_simd_mask, u64 *out_pred_mask)
> +{
> +	int dummy_abi =3D -1;
> +	u64 gpr_mask =3D intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
> +			      perf_user_reg_mask(EM_HOST, &dummy_abi);
> +	u64 sample_type =3D intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USE=
R;
> +	u64 mask =3D 0;
> +	int abi =3D 0;
> +	struct perf_event_attr attr =3D *base_attr;
> +	int fd;
> +
> +	attr.disabled =3D 1;
> +	attr.sample_period =3D base_attr->sample_period ?: 10000;
> +	attr.sample_type =3D sample_type;
> +
> +	if (gpr_mask) {
> +		if (intr)
> +			attr.sample_regs_intr =3D gpr_mask;
> +		else
> +			attr.sample_regs_user =3D gpr_mask;
> +
> +		fd =3D sys_perf_event_open(&attr, pid, cpu, -1, flags);
> +		if (fd >=3D 0) {
> +			close(fd);
> +			mask |=3D gpr_mask;
> +		} else {
> +			for (int b =3D 0; b < 64; b++) {
> +				if (!(gpr_mask & BIT_ULL(b)))
> +					continue;
> +				if (intr)
> +					attr.sample_regs_intr =3D BIT_ULL(b);
> +				else
> +					attr.sample_regs_user =3D BIT_ULL(b);
> +				fd =3D sys_perf_event_open(&attr, pid, cpu, -1, flags);
> +				if (fd >=3D 0) {
> +					close(fd);
> +					mask |=3D BIT_ULL(b);
> +				}
> +			}
> +		}
> +	}
> +
> +	if (perf_pmu__is_software(pmu)) {
> +		*out_mask =3D mask;
> +		*out_abi =3D abi;
> +		return;
> +	}
> +
> +	/*
> +	 * Probe extended GPRs outside the base GPR mask when the host ABI
> +	 * supports PERF_SAMPLE_REGS_ABI_SIMD (e.g. APX R16-R31 and CET SSP).
> +	 * Note: perf_pmu__probe() actively probes the running host kernel via
> +	 * perf_event_open(), so EM_HOST is used intentionally here.
> +	 */
> +	{
> +		int host_abi =3D 0;
> +		u64 host_mask =3D intr ? perf_intr_reg_mask(EM_HOST, &host_abi) :
> +				       perf_user_reg_mask(EM_HOST, &host_abi);
> +		u64 ext_gpr_mask =3D host_mask & ~gpr_mask;
> +
> +		if ((host_abi & PERF_SAMPLE_REGS_ABI_SIMD) && ext_gpr_mask) {

[Severity: Medium]
Does gating this probe on perf_intr_reg_mask() and perf_user_reg_mask()
skip probing extended GPRs on x86 systems that support CET SSP or APX
extended GPRs on non-PEBS events, but do not have Architectural PEBS?

On x86, perf_intr_reg_mask() and perf_user_reg_mask() call
__perf_reg_mask_x86() -> __arch__reg_mask(), which hardcodes
attr.precise_ip =3D 1 (and on hybrid systems only checks the first core PMU=
):

tools/perf/util/perf-regs-arch/perf_regs_x86.c:__arch__reg_mask() {
	struct perf_event_attr attr =3D {
		.type				=3D PERF_TYPE_HARDWARE,
		.config				=3D PERF_COUNT_HW_CPU_CYCLES,
		.sample_type			=3D sample_type,
		.precise_ip			=3D 1,
		.disabled			=3D 1,
		.exclude_kernel			=3D 1,
		.sample_simd_regs_enabled	=3D has_simd_regs,
	};
}

In the x86 kernel, x86_pmu_hw_config() allows sampling SSP and APX extended
GPRs via xsaves_nmi() when precise_ip =3D=3D 0 (validated by
event_simd_regs_validate()), whereas precise_ip > 0 additionally runs
pebs_simd_regs_validate():

arch/x86/events/core.c:pebs_simd_regs_validate() {
	if (event_needs_ssp(event) &&
	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_GPR)))
		return -EINVAL;
	if (event_needs_ymm(event) &&
	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_YMMH)))
		return -EINVAL;
	if (event_needs_egprs(event) &&
	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_EGPRS)))
		return -EINVAL;
}

On CET-capable CPUs without Architectural PEBS (or in VMs without PEBS),
__arch__reg_mask() fails with precise_ip =3D 1, so __perf_reg_mask_x86()
returns PERF_REGS_MASK with host_abi =3D 0 and ext_gpr_mask =3D 0. Because =
the
if condition here is false, probe_pmu_regs_one() never runs the e_attr probe
below that tries base_attr->precise_ip (0) before falling back to
precise_ip =3D 1, leaving SSP and R16..R31 out of out_mask and out_abi.

[ ... ]

> +	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
> +		u64 ext_mask =3D GENMASK_ULL(63, 32) & ~gpr_mask;
> +		struct perf_event_attr x_attr =3D *base_attr;
> +		bool batch_ok =3D false;
> +
> +		x_attr.disabled =3D 1;
> +		x_attr.sample_period =3D base_attr->sample_period ?: 10000;
> +		x_attr.sample_type =3D sample_type;
> +		if (intr && max_precise > 0)
> +			x_attr.precise_ip =3D 1;
> +
> +		if (ext_mask) {
> +			if (intr)
> +				x_attr.sample_regs_intr =3D ext_mask;
> +			else
> +				x_attr.sample_regs_user =3D ext_mask;
> +
> +			fd =3D sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
> +			if (fd >=3D 0) {
> +				close(fd);
> +				mask |=3D ext_mask;
> +				batch_ok =3D true;
> +			}
> +		}
> +
> +		if (!batch_ok) {
> +			for (int b =3D 0; b < 64; b++) {
> +				const char *rname;
> +
> +				if (gpr_mask & BIT_ULL(b))
> +					continue;
> +				rname =3D perf_reg_name(b, EM_HOST, EF_HOST, 0);
> +				if (!rname || !strcmp(rname, "unknown"))
> +					continue;
> +				if (intr)
> +					x_attr.sample_regs_intr =3D BIT_ULL(b);
> +				else
> +					x_attr.sample_regs_user =3D BIT_ULL(b);
> +				fd =3D sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
> +				if (fd >=3D 0) {
> +					close(fd);
> +					mask |=3D BIT_ULL(b);
> +				}
> +			}
> +		}
> +	}

[Severity: Medium]
On non-x86 architectures such as arm64 and powerpc, can this fallback loop
record user-only extended registers in intr_regs_mask and interrupt-only
extended registers in user_regs_mask?

At the start of probe_pmu_regs_one(), dummy_abi =3D -1 is passed to
perf_intr_reg_mask() and perf_user_reg_mask():

tools/perf/util/perf_regs.c:perf_intr_reg_mask() {
	case EM_AARCH64:
		mask =3D __perf_reg_mask_arm64(/*intr=3D*/true);
		break;
	...
	case EM_PPC:
	case EM_PPC64:
		mask =3D __perf_reg_mask_powerpc(/*intr=3D*/true);
		break;
}

Because only EM_386 and EM_X86_64 inspect the abi argument in
perf_intr_reg_mask() and perf_user_reg_mask(), gpr_mask on arm64 (with SVE)
and powerpc (Power9/10/11) already includes direction-valid extended
registers. For software PMUs and PMUs without PERF_PMU_CAP_EXTENDED_REGS,
that causes the initial batch gpr_mask probe to fail in perf_event_alloc()
with -EOPNOTSUPP and fall back to 64 individual syscalls.

Then, on hardware PMUs with PERF_PMU_CAP_EXTENDED_REGS, the batch probe of
ext_mask =3D GENMASK_ULL(63, 32) & ~gpr_mask fails with -EINVAL because bits
32..63 include reserved register bits. The fallback loop then probes every
bit not in gpr_mask that has a valid perf_reg_name().

On arm64 when intr is true, __perf_reg_mask_arm64(true) intentionally
excluded PERF_REG_ARM64_VG (bit 46), and on powerpc when intr is false,
__perf_reg_mask_powerpc(false) intentionally excluded the PMU SPRs
PERF_REG_POWERPC_MMCR0..SIAR (bits 44..57). However, perf_reg_name() returns
valid names for those bits, and the kernel's perf_reg_validate() on arm64
and powerpc does not distinguish sample_regs_user from sample_regs_intr:

arch/powerpc/perf/perf_regs.c:perf_reg_validate() {
	if (!mask || mask & REG_RESERVED)
		return -EINVAL;
	return 0;
}

As a result, sys_perf_event_open() succeeds and adds PERF_REG_ARM64_VG to
pmu->probed.intr_regs_mask on arm64 and PERF_REG_POWERPC_MMCR0..SIAR to
pmu->probed.user_regs_mask on powerpc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D34
