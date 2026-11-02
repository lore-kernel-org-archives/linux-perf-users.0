Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623070;
	b=5JOdgbX3n610OYmxNh0Z1mFk3rgNk124/7u59UNUqPHI9RgwxOSLasXQcMvb9Tav4Jiz
	 O9CDSDvKYIxBs1ZvszRvJp0SyGGNxIfG4/YTALGlq2fQT5Pgw+Jf+pS6P05xT3qngD8i0
	 SBlo0NaYSLcyvuivANE4E0sbyZRTyBv8LICf7P5Gs3vMAMfodbO5suX9vPhCel7y/GjoX
	 B9aLc5Krwg8MmBfwc+Y8Ylg3PW3fm20lvSc4WW78Gop5lEvmiFA1tiP1YpJSmal1MN4Io
	 Y2SN1Mv0/FmvfA6fXyV4qVaOLc3OQSNpUcs1rVnnDPVB0uFtlbawnNyxGfNnmtTza6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DloFcbWR7ZqmOmt0ZS4CFgPrTdF+fyC2raZs3SGjSjU=;
	b=FhqxA7+lHGf/ejeNuzKNCq1IXjlaiw1YE7pmbEqiape5LIo2ivn3vQrSSU2u2539SQJh
	 BLS5YZAQgnkMgv+JRqZddMWhIGJA7ZSTIe0KSf6aC5Aalj94gX4aPwseGSNjQPDkrWq6s
	 xhIF+TTDmuwW6UVrbtjAIjLU3SNZiTw1AyQJq5Jf5DQwtVG+K/p2Vv4VA03BwrpweqwQv
	 MhzlJde74fvk5Tt/PhVNb/ppG4wDD77tBMq9SQoMXuBVKYSexpr26G2oVh0lsvj4iHOiu
	 KzWDV75Pf4+zb1EtNY3v+CX5oyooqTwqSRDZPB1ZdBDCq6JG5wfLyCYwdeYhBsCoOrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SB8TfAIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C358606A327
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SB8TfAIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F31F00A16;
	Mon,  2 Nov 2026 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623069;
	bh=DloFcbWR7ZqmOmt0ZS4CFgPrTdF+fyC2raZs3SGjSjU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SB8TfAIRsSOi2n88m1LnXWJt/ryM36WRYN8lQtexCKjgzXumwrApe14R6SIEFfLeW
	 OMtwqv352395SuVmXYeQeGQNraz/4NI1SRPaSHv5fKyyZCb5IOqa2+J6x8ikrg5spE
	 skFDZXdo4suJE9UI5onpc/RMH4lG5tEp/Eprr8Tc7LYw+azbLFkJkGptNAYjupw7f1
	 YDXqHNgmDBEXmRS1yXGy4kIJC1D1hIEkf7JTK5NxCRNAoEwVkdKbLi5xll5pdrC4YF
	 PK8S7Ri5R5TMpxIteQ1GgD3jfCOM3v0NphIIljUkUS77kjfHIK3gPyk3PJ0rwN+yXG
	 lNqLGNcVnRzPQ==
Message-ID: <sashiko-outbox-193430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261102121324.371157-1-huangsj@hygon.cn>
References: <20261102121324.371157-1-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:37:49 +0000
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
- [Medium] perf/amd/ibs: min_period clamp bypassed on discard in perf_ibs_h=
andle_irq()
- [Medium] perf/amd/ibs: missing ld_op/st_op check in perf_ibs_handle_irq()=
 filter
--

commit 2b588b2eb9d2eeb02990e56aab4b6d6ff659932b
Author: Huang Shijie <huangsj@hygon.cn>

perf/amd/ibs: add phy_addr_only software filter for ibs_op

This commit adds a phy_addr_only software filter attribute for the AMD IBS =
op
PMU to discard samples without a valid non-zero physical address in the
interrupt handler when used with PERF_SAMPLE_PHYS_ADDR.

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c9..12075d7d4703b 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c

[ ... ]

> @@ -1479,6 +1494,23 @@ static int perf_ibs_handle_irq(struct perf_ibs *pe=
rf_ibs, struct pt_regs *iregs)
>  		}
>  	}
> =20
> +	if (perf_ibs_phy_addr_only_event(perf_ibs, event)) {
> +		union ibs_op_data3 op_data3;
> +		u64 phys_addr;
> +
> +		op_data3.val =3D ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
> +		if (!op_data3.dc_phy_addr_valid) {
> +			throttle =3D perf_event_account_interrupt(event);
> +			goto out;
> +		}
> +		/* Also skip the case: zero address in MSR_AMD64_IBSDCPHYSAD */
> +		phys_addr =3D ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
> +		if (!phys_addr) {
> +			throttle =3D perf_event_account_interrupt(event);
> +			goto out;
> +		}
> +	}

[Severity: Medium]
When an ibs_op event is opened in frequency mode (event->attr.freq =3D=3D 1=
, the
default for perf record when -c is not specified) with phy_addr_only and
PERF_SAMPLE_PHYS_ADDR, can jumping to out after perf_event_account_interrup=
t()
in perf_ibs_handle_irq() bypass the minimum period clamp and program a
hardware period below perf_ibs->min_period?

Inside perf_event_account_interrupt() -> __perf_event_account_interrupt() ->
perf_adjust_period(), hwc->sample_period is recalculated and only clamped t=
o a
lower bound of 1. Because goto out jumps past the minimum period check at t=
he
end of perf_ibs_handle_irq():

arch/x86/events/amd/ibs.c:perf_ibs_handle_irq() {
	...
	if (event->attr.freq && hwc->sample_period < perf_ibs->min_period)
		hwc->sample_period =3D perf_ibs->min_period;

out:
	if (!throttle) {
		perf_ibs_enable_event(perf_ibs, hwc, period >> 4);
	...
}

hwc->sample_period can drop below perf_ibs->min_period (0x90 for ibs_op). On
the subsequent IBS NMI, perf_ibs_set_period() -> perf_event_set_period()
computes the next hardware period from hwc->sample_period:

arch/x86/events/amd/ibs.c:perf_event_set_period() {
	...
	if (unlikely(left < (s64)min)) {
		left +=3D period;
		local64_set(&hwc->period_left, left);
		hwc->last_period =3D period;
		overflow =3D 1;
	}
	...
}

When left <=3D 0 and period < min, left +=3D period results in a hardware p=
eriod
smaller than perf_ibs->min_period (or 0 after shifting by 4) being written =
to
MSR_AMD64_IBSOPCTL, which commit fa5d0a824e3bbd ("perf/x86/amd/ibs: Fix
 ->min_period violation") notes has undefined hardware behavior.

Should the min_period clamp in perf_ibs_handle_irq() be moved after the out:
label (or applied before enabling the event) so that discarded samples in
frequency mode also respect perf_ibs->min_period?

[Severity: Medium]
Could samples with phys_addr =3D=3D 0 still slip through this filter in
perf_ibs_handle_irq() if neither op_data3.ld_op nor op_data3.st_op is set?

In arch/x86/events/amd/ibs.c, perf_ibs_parse_ld_st_data() checks the memory
operation type before reading MSR_AMD64_IBSDCPHYSAD:

arch/x86/events/amd/ibs.c:perf_ibs_parse_ld_st_data() {
	...
	perf_ibs_get_mem_op(&op_data3, data);
	if (data->data_src.mem_op !=3D PERF_MEM_OP_LOAD &&
	    data->data_src.mem_op !=3D PERF_MEM_OP_STORE)
		return;
	...
	if (sample_type & PERF_SAMPLE_PHYS_ADDR && op_data3.dc_phy_addr_valid) {
		data->phys_addr =3D ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
		data->sample_flags |=3D PERF_SAMPLE_PHYS_ADDR;
	}
}

If an op sample has op_data3.dc_phy_addr_valid =3D=3D 1 and a non-zero
MSR_AMD64_IBSDCPHYSAD while both op_data3.ld_op and op_data3.st_op are 0 (f=
or
instance, commit f04a8a7649f9b2 ("perf amd ibs: Suppress bogus TlbRefillLat
and DCPhysAd on Zen4+") notes that Zen4+ hardware can set dc_phy_addr_valid
with a bogus non-zero IbsDCPhysAd when dc_lin_addr_valid is 0), the filter =
in
perf_ibs_handle_irq() will let the sample pass, but perf_ibs_parse_ld_st_da=
ta()
will return early without setting PERF_SAMPLE_PHYS_ADDR in data->sample_fla=
gs.

When perf_event_overflow() then calls perf_prepare_sample() in
kernel/events/core.c:

kernel/events/core.c:perf_prepare_sample() {
	...
	if (filtered_sample_type & PERF_SAMPLE_ADDR) {
		data->addr =3D 0;
		data->sample_flags |=3D PERF_SAMPLE_ADDR;
	}
	...
	if (filtered_sample_type & PERF_SAMPLE_PHYS_ADDR) {
		data->phys_addr =3D perf_virt_to_phys(data->addr);
		data->sample_flags |=3D PERF_SAMPLE_PHYS_ADDR;
	}
}

perf_prepare_sample() will fall back to perf_virt_to_phys(0) and emit a sam=
ple
with data->phys_addr =3D 0.

Should the perf_ibs_phy_addr_only_event() check in perf_ibs_handle_irq() al=
so
require (op_data3.ld_op || op_data3.st_op), matching perf_ibs_ldlat_event()
and perf_ibs_parse_ld_st_data()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102121324.3711=
57-1-huangsj@hygon.cn?part=3D1
