Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E993C342D
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047090; cv=none; b=AVwBaWoiwWOu5V701c1Oo7YROSg6QVcQbvZW1bT9eZr+2GLWYcv8kqZP+W7E/9A6wvh2Db41LnEzQp46K6mgoojh0qf7xkI6xMT8hIH+9YKSPTZsGdD6mss2uFpZh+90M2cpKeFmSuXPlsDaLoiXM4ZYAYA5tk1VTU6x6RxvmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047090; c=relaxed/simple;
	bh=7zl+mf9AGkxGDEq2an2YqMHcESYFhw7+rLYVMNqUf1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GR8u/NAgPe1C4L5j+a5nWwexh/pW9ULRpEJTe1QI1MfXiPzRDAcaHJWdi34Hz9pJj9FrJOjwlm6FZrZFrEbrAhi93J+dbAp8nA+yQxhQcZJc+czBXMjIixoJi6ih4mCmE68qeeojLp/qwG0N+YMKUvwM250mqu2dQ4CTqyVz+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTGbttze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTGbttze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2681F00893;
	Fri, 29 May 2026 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780047088;
	bh=re99MbBoqhxqCAV1AwtjxDL5EMu7vsjzXbKXXuPVK0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTGbttzeH3D5EHN9ZZUhHqyqMNvZvLiM40aIojdF4fxNfI40LxybGc0gwy9zWgwHO
	 7tHsqjDgwjiBpiZVVceaNsUZkdiLK69T+PhM10zjFRg7CNrP/jyehipIjAaGSsk6gz
	 tzeqb0neR+UrP5gV+vfS3gEvlarWoDfHxKuSqWfV0lBRD0RYk9tMPLPcoGL2d+zde+
	 lYn7l32L/NZYMjI6tt4U0avnQltyyzoa6hmv4BOUPM+bbOZNc2/E+E9615RFqSp/ny
	 j1BlNyGVHfWu+Xn7YA8H9aera/f4Ig/soipN8DRtPG7I98gS9IotV9ki83cDwqTToh
	 YL/AW/VawDE7w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 18/23] perf/x86: Support eGPRs sampling using
 sample_regs_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-19-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-19-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:31:27 +0000
Message-Id: <20260529093128.5E2681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] The patch unconditionally rejects a mask of 0 when simd_enable=
d is false, breaking userspace ABI.
- [High] The patch evaluates sample_regs_user and sample_regs_intr without =
verifying their respective flag gates are set.
- [High] The 32-bit implementation of perf_reg_validate() is not updated to=
 handle extended register masks, allowing a DoS via WARN_ON_ONCE.

Pre-existing issues:
- [Critical] perf_reg_value() blindly casts the raw pt_regs pointer to stru=
ct x86_perf_regs, leading to an out-of-bounds read for software events.
- [Critical] perf_reg_validate() fails to mask out bits >=3D 32 when simd_e=
nabled is false, allowing out-of-bounds register indices.
--

commit bffe5fdaa4de39f9a6532b899d96502d48077d9a
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support eGPRs sampling using sample_regs_* fields

This patch adds support for sampling APX eGPRs (R16 ~ R31) by reclaiming
spare space in the sample_regs_* fields when sample_simd_regs_enabled is se=
t.
It updates perf_reg_value() and perf_reg_validate() to handle the new eGPRs
bitmap alongside legacy XMM registers.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -708,26 +708,24 @@ int x86_pmu_hw_config(struct perf_event *event)
[ ... ]
>  		if (event_has_simd_regs(event)) {
> +			u64 reserved =3D ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
> +
>  			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
>  				return -EINVAL;
>  			if (is_sampling_event(event) && !event->attr.precise_ip &&
>  			    !this_cpu_has(X86_FEATURE_XSAVES))
>  				return -EINVAL;
> +			/*
> +			 * The XMM space in the perf_event_x86_regs is reclaimed
> +			 * for eGPRs and other general registers.
> +			 */
> +			if ((event->attr.sample_regs_user & reserved) ||
> +			    (event->attr.sample_regs_intr & reserved))
> +				return -EINVAL;

[Severity: High]
Is it safe to evaluate both sample_regs_user and sample_regs_intr here with=
out
first verifying their respective flag gates are set?

If a user only sets one of the flags (e.g., PERF_SAMPLE_REGS_USER), does the
other field contain uninitialized garbage from userspace? If that garbage
happens to overlap with the reserved mask, it seems this could trigger
validation failures and cause valid syscalls to randomly fail.

[ ... ]
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -197,6 +197,16 @@ static inline bool event_needs_opmask(struct perf_ev=
ent *event)
>  	return false;
>  }
> =20
> +static inline bool event_needs_egprs(struct perf_event *event)
> +{
> +	if (event->attr.sample_simd_regs_enabled &&
> +	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
> +	     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
> +		return true;
> +
> +	return false;
> +}

[Severity: High]
Similarly to x86_pmu_hw_config(), does this evaluate sample_regs_user and
sample_regs_intr without verifying their respective flag gates are set?

Could uninitialized data from userspace falsely trigger this condition?

[ ... ]
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -61,14 +61,24 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
>  	struct x86_perf_regs *perf_regs;
> =20
> -	if (idx >=3D PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
> +	if (idx > PERF_REG_X86_R15) {
>  		perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
> -		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
> -		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
>  			return 0;
> -		if (!perf_regs->xmm_regs)
> -			return 0;
> -		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> +
> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {

[Severity: Critical]
This is a pre-existing issue, but does casting the raw pt_regs pointer to
struct x86_perf_regs lead to an out-of-bounds read for software events?

For software events, the generic perf code passes a standard pt_regs pointe=
r.
Because the x86_perf_regs wrapper is not allocated for software events, usi=
ng
container_of() and reading perf_regs->abi appears to access memory past the
end of the pt_regs struct.

[ ... ]
>  #ifdef CONFIG_X86_32
> -#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
> -		       (1ULL << PERF_REG_X86_R9) | \
> -		       (1ULL << PERF_REG_X86_R10) | \
> -		       (1ULL << PERF_REG_X86_R11) | \
> -		       (1ULL << PERF_REG_X86_R12) | \
> -		       (1ULL << PERF_REG_X86_R13) | \
> -		       (1ULL << PERF_REG_X86_R14) | \
> -		       (1ULL << PERF_REG_X86_R15))
> +#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_R8)
> =20
>  int perf_reg_validate(u64 mask, bool simd_enabled)

[Severity: High]
Does the 32-bit implementation of perf_reg_validate() need to be updated to
handle extended register masks?

It looks like the 64-bit version was updated to reject bits 32-63 when
simd_enabled is true, but the CONFIG_X86_32 block was missed. If a 32-bit
user sets sample_simd_regs_enabled and requests bit 32, could this fall
through to the WARN_ON_ONCE() in perf_reg_value() and allow a denial of
service?

[ ... ]
> @@ -214,8 +218,13 @@ u64 perf_reg_abi(struct task_struct *task)
> =20
>  int perf_reg_validate(u64 mask, bool simd_enabled)
>  {
> +	if (!simd_enabled &&
> +	    (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))))
> +		return -EINVAL;

[Severity: Critical]
Does rejecting a mask of 0 when simd_enabled is false break the userspace A=
BI?

Profiling tools sometimes set sample_regs_user =3D 0 to obtain the abi indi=
cator
field in the perf ring buffer without dumping any specific registers.

[Severity: Critical]
This is a pre-existing issue, but does this check fail to mask out bits >=
=3D 32
when simd_enabled is false?

PERF_REG_X86_RESERVED only covers bits 16-31. It appears to ignore bits 32-=
63.
Could an unprivileged user request bit 63 for a software event, bypassing
validation, and eventually hitting the WARN_ON_ONCE() and reading out of
bounds in perf_reg_value()?

>  	/* The mask could be 0 if only the SIMD registers are interested */
> -	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
> +	if (simd_enabled &&
> +	    (mask & (REG_NOSUPPORT | PERF_REG_X86_EXT_RESERVED)))
>  		return -EINVAL;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D18
