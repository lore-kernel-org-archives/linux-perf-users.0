Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212130;
	b=aEXATfZTe4NMWsGBun2mg/BuroMhjuOy15NZr7q3xtAqigUpwRMf6agCmBGOv8xgurnr
	 QZiZg+9zW+2hWqX/rMX0y1Ec1VmegF7eJzCYB3KGWegmCZF+RyTg9ITgwxRAYzfpUvdGG
	 vEl+7GFIl8Dsuym+q/aPtYqAgPG2UbtexP15YZC5CzL9iqf0PpMIKBxjoyiTEdlrrby1J
	 LFq52wLiJA4Rl6kTzpeQcF/4r/npzZKEW5Nr7ymUYRralBFkt2+XisuZTanQG+1laMEh8
	 nUsehz7SI5Nzo2U/7wlClRP5nzyEUjPFqXrdwwFManKC2u8lPuzMkrOvRbf10dS7Dcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BfIc08y3naB+NIO2v1ca/wpqLeSCy44yCOdFRZHR2uo=;
	b=PLwSIt3c/hGS055bw8mRFk7TLTCoGEqvyYPJTn/fXWvwo1R53N7KqiMvLusmXXheiB7y
	 EB50RvWDddHrmYO68wKdhJzQT4qj1vzEblwiNWo5T2Lzfr17YXhiGYimDs6wgUbcX1AK7
	 0RoACEjumD9KI4OXbKXQujB6pyCmuHXjYFCz8xg6nlWRSd6DOlzNXgEBDEUtgGykhv3Rr
	 6VAVyUjk7qH08BRHkfOPCy3SDSC0eD5P3lAj8y+NnUQNFMyLF0jXaxzfMOLMM8jrwi5LP
	 KfaR8snfjBeI7QuklfJfB2pHOukQYD+4qsWALnohyPOTl4AL68ndE2K8Foe3rPZCaQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyJwaiqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2430606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyJwaiqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491551F01828;
	Wed, 28 Oct 2026 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212129;
	bh=BfIc08y3naB+NIO2v1ca/wpqLeSCy44yCOdFRZHR2uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lyJwaiqqjLdbpZhhC2Zl5lLQ8UuyaWmmJ5YkO9AH98EWPq5saU2cZB0BGcZOwj3Kk
	 Xa3jNYECjjc8C/LBAdPhoadzqh64EdIgsayahBwQKSBG1vMf0M+M8MrIHPJHIXDLnj
	 UbD7KSMv4eyBcIgEcfONTVAC1/LD/uJbGPiIFCJ/NvTuQbAs/qLt3PO+vWxLksXorg
	 cVTjj56AZZDho8CrVkk10eb0GtDswv54+XfEQnHr0Tt4ilezBvi6gzkq33ykNtP+hz
	 a9Nfk5tVwkRfuMFU01iC99/eGPLoVFLC30uk05qiSp2fCumzCI66+aFTSAJP7C4lhy
	 MngaBG/5atPjA==
Message-ID: <sashiko-outbox-188288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-alpha-profileme-v1-3-d44b52bf2500@gmail.com>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-3-d44b52bf2500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:28:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] alpha/perf: wrong register and stack state in alpha_perf_event_pro=
fileme()
--

commit 4ba1c82f19c556ae6c582ff386ff198b05c6a1eb
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: implement ProfileMe sampling

This commit implements ProfileMe performance counter sampling on Alpha
EV67 and later processors, selecting it via the profileme config attribute
or precise_ip and attributing samples to the PC latched in PMPC.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 70840c05d39bf..24c96feda9424 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -832,6 +904,61 @@ void perf_event_print_debug(void)
>  }
> =20
> =20
> +/*
> + * Handle the close of a ProfileMe window on PCTR0.
> + *
> + * PCTR0 stops counting when the window closes and does not start again
> + * until PCTR_CTL is written, so the status must be read first and the
> + * counters then rearmed unconditionally.
> + */
> +static void alpha_perf_event_profileme(struct perf_event *event,
> +				       struct hw_perf_event *hwc,
> +				       struct pt_regs *regs)
> +{
> +	struct perf_sample_data data;
> +	struct pt_regs pm_regs;
> +	unsigned long i_stat, pmpc, ovr;
> +
> +	i_stat =3D wrperfmon(PERFMON_CMD_I_STAT, 0);
> +	pmpc =3D wrperfmon(PERFMON_CMD_PMPC, 0);
> +
> +	alpha_perf_event_update(event, hwc, 0, alpha_pmu->pmc_max_period[0]+1);
> +
> +	/*
> +	 * When PCTR0 counts instructions, up to 7 of them are counted after
> +	 * the overflow but before the window opens. I_STAT reports how many.
> +	 */
> +	if (!(hwc->config_base & EV67_PCTR_PCTR0_CYCLES)) {
> +		ovr =3D (i_stat >> EV67_I_STAT_OVR_SHIFT) & EV67_I_STAT_OVR_MASK;
> +		local64_sub(ovr, &event->count);
> +		local64_add(ovr, &hwc->period_left);
> +	}
> +
> +	/*
> +	 * Attribute the sample to the profiled instruction rather than to
> +	 * wherever the interrupt landed, including the user/kernel mode that
> +	 * perf derives from regs. A PALmode PMPC is a physical address that
> +	 * perf cannot resolve. That happens for ITB miss, Istream access
> +	 * violation and interrupt redirects, and for instructions inside
> +	 * PALcode. Keep the interrupted PC, which for redirects is the
> +	 * instruction that trapped.
> +	 */
> +	pm_regs =3D *regs;
> +	if (!(pmpc & EV67_PMPC_PAL)) {
> +		pm_regs.pc =3D pmpc & EV67_PMPC_PC_MASK;
> +		/* PS bit 3 is the mode bit that user_mode() tests. */
> +		if (pm_regs.pc < TASK_SIZE)
> +			pm_regs.ps |=3D 8UL;
> +		else
> +			pm_regs.ps &=3D ~8UL;
> +	}
> +
> +	perf_sample_data_init(&data, 0, hwc->last_period);
> +
> +	if (alpha_perf_event_set_period(event, hwc, 0))
> +		perf_event_overflow(event, &data, &pm_regs);
> +}

[Severity: High]
When a user-mode instruction is profiled (pm_regs.pc < TASK_SIZE), but the
PMI is delivered after the CPU has entered kernel mode (!user_mode(regs)),
regs is the kernel interrupt trap frame containing live kernel GPRs, while
the user task's registers live in task_pt_regs(current).

By copying *regs into pm_regs and setting pm_regs.ps |=3D 8UL before calling
perf_event_overflow(), user_mode(&pm_regs) evaluates to true in
kernel/events/core.c:perf_sample_regs_user():

	if (user_mode(regs)) {
		regs_user->abi =3D perf_reg_abi(current);
		regs_user->regs =3D regs;
	} else if (is_user_task(current)) {
		perf_get_regs_user(regs_user, regs);
	}

and in kernel/events/core.c:perf_sample_regs_intr():

	if (exclude_kernel && !user_mode(regs)) {
		regs_intr->abi =3D PERF_SAMPLE_REGS_ABI_NONE;
		regs_intr->regs =3D NULL;
	} else {
		regs_intr->regs =3D regs;
		regs_intr->abi =3D perf_reg_abi(current);
	}

Doesn't this cause PERF_SAMPLE_REGS_USER and PERF_SAMPLE_REGS_INTR (even
when attr.exclude_kernel is set) to record live kernel registers from the
kernel interrupt trap frame into the user-visible perf ring buffer instead
of fetching task_pt_regs(current), while also corrupting user DWARF
callgraph unwinding?

Additionally, if current is a kernel thread when this happens,
perf_sample_regs_user() sets regs_user->regs =3D &pm_regs while
perf_sample_ustack_size() returns 0 (since current->mm is NULL), which
causes perf_prepare_sample() and perf_output_sample_ustack() to disagree
on the PERF_SAMPLE_STACK_USER record size.

Similarly, when !user_mode(&pm_regs) is true (pm_regs.pc >=3D TASK_SIZE),
passing the stack-local &pm_regs to perf_event_overflow() affects
arch/alpha/kernel/perf_regs.c:perf_reg_value():

	if (idx =3D=3D PERF_REG_ALPHA_SP) {
		if (user_mode(regs))
			return user_stack_pointer(regs);
		if (!object_is_on_stack(regs))
			return 0;
		/* Same kernel sp approximation as stacktrace.c. */
		return (unsigned long)(regs + 1);
	}

and arch/alpha/kernel/stacktrace.c:arch_stack_walk():

	if (regs && task =3D=3D current) {
		ksp =3D (unsigned long)(regs + 1);
	}

Because pm_regs is a local variable on the stack, object_is_on_stack(&pm_re=
gs)
is true, so &pm_regs + 1 points inside alpha_perf_event_profileme()'s own
stack frame rather than the end of the interrupted trap frame (regs + 1).
And if the PMI landed in user mode after a profiled kernel instruction,
clearing bit 3 of pm_regs.ps causes perf_callchain_kernel() and
PERF_SAMPLE_REGS_INTR to treat the user register frame as a kernel frame
and unwind the kernel stack starting from &pm_regs + 1.

Could the PC and PS adjustments be made in-place on regs (and restored
after perf_event_overflow()) only when the PMPC mode matches the
interrupted mode in regs, or how should mode-mismatched samples handle regi=
ster
and stack sampling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-alpha-prof=
ileme-v1-0-d44b52bf2500@gmail.com?part=3D3
