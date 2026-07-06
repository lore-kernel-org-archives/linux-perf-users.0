Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB71FF1B5
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305260; cv=none; b=KarVinjypN+XrVQde6kKuvYmtIGNYzMMn1Jb3q3FGDmp2F9EQheeQB5xpT5ngSGcm7MF2CZyRTnEspdc9Eeemxlaggr+7fuVaYO3ZIADCDwkmv6/vFSAvdtaQVlS3Uo8D+oCsa1zLsWmJrOvdIQN/O/1ci61l1Q8EN9UU9TZ0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305260; c=relaxed/simple;
	bh=WjN1sGG693Ucs4hCeb19O+lql7l/rrxXFBRIWfx/WHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQKP+NO5YEKRRch246Gk/VKQwB3IIkIETU2ZfqiRNJfH7oAGphaqF4MEo8wFXVOu8J5/Awl/uCr7yzC3yQ46z4YtxFL13IZ7Aj8JTsfAH3dEL1CooVrFqQSkkBkEYaeaK9NGY149k8sInf2ewrhcm/MnrLuPyyQm8xjn/KzCsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqSMQu9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqSMQu9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD74F1F000E9;
	Mon,  6 Jul 2026 02:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305259;
	bh=gdj2Isl8q9tIfMlTemWulqvvful4jlVGUV7hJBroJec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqSMQu9f2m4dRQVJXKUgAhQEW/k2MGibB0TwrO4PCdbGdy7CoXwDuGSMfLhzRLdMO
	 PBicnYMYSYablhGhyuwGFbB5JgufUoO2upP4SeRLf0PxKdc8jTG50Hh9BvXv33pOpO
	 vomTVv5uXWUQYFlZrHZYCwsLoO2Jufyvhp+ndENH0YxHvW7dWWuvTpuqPMcwiNrxA7
	 l9QwK5htVkwC7bklNM2RxXEWNKVK/c4+ivWEP7lUPqNXZeP7tqeOZ/R7KaE1U/l2Rq
	 sMESD6VWLY+3NaHcY6Fz5PzMfjAS/Dg+QJ3a/yDpjCBMZ65kagZsty7Ux4zkblo1lV
	 CZTqcSr5OgElQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 11/24] perf/x86: Enable XMM register sampling for
 non-PEBS events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-12-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:34:18 +0000
Message-Id: <20260706023418.CD74F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] reserve_ext_regs_buffers() fails to propagate memory allocation er=
rors and improperly uses WARN_ON_ONCE, leading to a silent feature failure =
and possible kernel panics under memory pressure.
--

commit 8262cdbae2d650c85cf4924888ecf8b4f85b98de
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Enable XMM register sampling for non-PEBS events

This commit extends XMM register sampling to non-PEBS events using the xsav=
es
instruction. It allocates a per-CPU ext_regs_buf to store SIMD and other
registers. For PEBS events, data is retrieved directly from PEBS records.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d83ea02e24577..3e52610510cdc 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -410,6 +410,56 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct pe=
rf_event *event)
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
[ ... ]
>  int x86_reserve_hardware(void)
>  {
>  	int err =3D 0;
> =20
>  	if (!atomic_inc_not_zero(&pmc_refcount)) {
>  		mutex_lock(&pmc_reserve_mutex);
>  		if (atomic_read(&pmc_refcount) =3D=3D 0) {
>  			if (!reserve_pmc_hardware()) {
>  				err =3D -EBUSY;
>  			} else {
>  				reserve_ds_buffers();
>  				reserve_lbr_buffers();
> +				reserve_ext_regs_buffers();
>  			}
>  		}
>  		if (!err)

[Severity: High]
Does this code swallow the memory allocation failure?

Since reserve_ext_regs_buffers() returns void, x86_reserve_hardware()=20
appears unaware if kzalloc_node() fails under memory pressure. The hardware=
=20
reservation will succeed anyway, and the perf event creation is permitted
even though the backing buffers do not exist.

[ ... ]
> +static void x86_pmu_sample_xregs(struct perf_event *event,
> +				 struct perf_sample_data *data,
> +				 u64 ignore_mask)
> +{
> +	struct xregs_state *xsave =3D get_ext_regs_buf(smp_processor_id());
> +	u64 sample_type =3D event->attr.sample_type;
> +	struct x86_perf_regs *perf_regs;
> +	u64 intr_mask =3D 0;
> +	u64 mask =3D 0;
> +
> +	if (WARN_ON_ONCE(!xsave) || !in_nmi())
> +		return;

[Severity: High]
Can this path be reached with a NULL xsave buffer during a PMI if the earli=
er
allocation failed?

If an unprivileged user creates an event requesting extended registers duri=
ng
memory pressure, and the allocation in reserve_ext_regs_buffers() fails,
the event is successfully created. When the PMI hits, this WARN_ON_ONCE in
NMI context will trigger.

This could panic the system if panic_on_warn is set, or otherwise silently
drop the requested register data. Should reserve_ext_regs_buffers() return
an error code so x86_reserve_hardware() can fail the event creation instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D11
