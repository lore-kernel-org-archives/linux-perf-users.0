Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7F390222;
	Mon, 22 Jun 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117044; cv=none; b=u/oAzHoSUcmXjrGTKnP5gnnO3nWq40dnXQYpCH42UDV5r0EXdECCDMeBlQMw48oOQdpgoJGaLzTqC/ZB9gDDSlGuaP4MQXlWb0OIsdMhR4+z7+apKT35rOzDHtxZ4QHyz1RAcXKHu4Z49s3HfhD5u6520TXWhsc4zWhIVZERYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117044; c=relaxed/simple;
	bh=kwNPkfbdgu3m+/KnixphD7uEBZgttVk0+QXeTx/wgTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0k+dkW+VX7X8zek1CZSrZTScvma9P3RjG0eogdqmNa43GF0zY5P4B1ozKZmJjgrkl3+XmcyAZItO3IpvubPhpLuVgHI0yqaMDvfKzLHgpxGlllt0flTVFtuYAeQZ45TRWDZbkh5SzOYSYIrIlzas/aL06BtNxNlN35h1YH/luk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKHkJI6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKHkJI6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3387F1F000E9;
	Mon, 22 Jun 2026 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117041;
	bh=bQPdY/4hXPyZmCC6sYKpnZAGDDr/NQJXXf6xJJwskzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKHkJI6gXmSAEo4vEulgaQ3N+dqWRq910rn5oq12t83Vp4gO09xPi900NXwbqJ3Bz
	 R1Jbf5Jm7+PKkVNuaWT0sEhWbmeFQV49+NRVY/8TT2qCbJYUiOv7QwiDLrq8KPWgLj
	 ixq2luDV4sfB0WDDYq2JKmNr1M9YJpMPs5DA4H/vG67VpMdzMF+5TuN8wR502jUv7N
	 nbZYwgY2iHeVsl0anlL6loSJrd1gclXfYtqyX7H3y/fRLMPxnXdhgrsAklNXHpltjb
	 mnX0xlmRLpkRXg21Hx7wyxMrgT1bFrcACGu5dU34Vp3TWAZdIlR8sSEbH/PAJYWL9B
	 sBF0Aby8ZwaEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/22] RISC-V: perf: Use config2/vendor table for
 event to counter mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260622-counter_delegation-v7-16-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-16-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:30:40 +0000
Message-Id: <20260622083041.3387F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Generic legacy hardware events (e.g. `cycles`) on the host cannot =
use fixed counters, contradicting the commit message and breaking standard =
profiling APIs.
- [High] Arbitrary events can be forced to silently count CPU cycles or ins=
tructions by setting `config2`, leading to silent data corruption.
--

commit d9b0aaf40875147c7d5a4d9a313b2c33198f256f
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Use config2/vendor table for event to counter mapping

This commit allows platform vendors to define custom mappings between
events and hpmcounters by passing counter restrictions from the json file
to drivers via the config2 parameter. It also aims to let vendors specify
if fixed cycle and instruction counters should be used for legacy events.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4f3a30143db11..1c846cdc96cf4 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1501,24 +1503,85 @@ static int rvpmu_deleg_find_ctrs(void)
>  	return num_hw_ctr;
>  }
> =20
> +/*
> + * The json file must correctly specify counter 0 or counter 2 is availa=
ble
> + * in the counter lists for cycle/instret events. Otherwise, the drivers=
 have
> + * no way to figure out if a fixed counter must be used and pick a progr=
ammable
> + * counter if available.
> + */
>  static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct per=
f_event *event)
>  {
> -	return -EINVAL;
> +	bool guest_events =3D event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVE=
NTS;
> +	int idx;
> +
> +	/* event_base is 0 on the delegation path; match via the original perf =
attrs. */
> +	if (guest_events) {
> +		if (event->attr.type !=3D PERF_TYPE_HARDWARE)
> +			return -EINVAL;
> +		if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES)
> +			idx =3D 0; /* CY counter */
> +		else if (event->attr.config =3D=3D PERF_COUNT_HW_INSTRUCTIONS)
> +			idx =3D 2; /* IR counter */
> +		else
> +			return -EINVAL;
> +	} else if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK) {
> +		idx =3D 0; /* CY counter */
> +	} else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK) {
> +		idx =3D 2; /* IR counter */
> +	} else {

[Severity: High]
Here config2 is evaluated without validating that the event is actually a
cycle/instruction event, or at least a PERF_TYPE_RAW event.

Since counterid_mask exposes config2:0-31 to userspace, what happens if a
user passes counterid_mask=3D1 for ANY event type, such as PERF_TYPE_HW_CAC=
HE?

Will the kernel see bit 0 set, map the event to the fixed cycle counter
(idx 0), and silently return CPU cycle counts instead of rejecting the
invalid counter constraint?

> +		return -EINVAL;
> +	}
> +
> +	/* Take the fixed counter only if delegated and free, else fall back. */
> +	if (!(cmask & BIT(idx)) || test_bit(idx, cpuc->used_hw_ctrs))
> +		return -EINVAL;
> +
> +	return idx;
>  }
> =20
>  static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct =
perf_event *event)
>  {
> -	unsigned long hw_ctr_mask =3D 0;
> +	u32 hw_ctr_mask =3D 0, temp_mask =3D 0;
> +	u32 type =3D event->attr.type;
> +	u64 config =3D event->attr.config;
> +	int ret;
> =20
> -	/*
> -	 * TODO: Treat every hpmcounter can monitor every event for now.
> -	 * The event to counter mapping should come from the json file.
> -	 * The mapping should also tell if sampling is supported or not.
> -	 */
> +	/* Select only available hpmcounters */
> +	hw_ctr_mask =3D cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);

[Severity: High]
For host events, get_deleg_fixed_hw_idx() above allocates fixed counters
solely based on event->attr.config2. If a standard tool requests
PERF_TYPE_HARDWARE (like generic cycles) where config2=3D0, won't it fall
back here?

Then in get_deleg_next_hpm_hw_idx(), the fixed counters are explicitly
masked out (~0x7). If a vendor correctly maps cycles exclusively to the
fixed counter in the driver table, the fallback path results in a mask
of 0, returning -EINVAL.

Does this prevent generic legacy hardware events from using fixed
counters on the host, contrary to the commit message?

> +
> +	switch (type) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D16
