Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBE377AB0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054884; cv=none; b=Xj02oRIfwe49KHBMB9ZuDKYEl2E4ztIB7JHQmlNOoPhKALQJHebCSme5pgpiPhIgYyQf3DFrN1UexcCEENaPutvgjSb8Otq3weeXbeqQ0O1ASTkIL92SeXuoCD5Hs4wjyGcu21OkKfyIxC0v+at9D/RPgkfP+TVFerb0nK+g0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054884; c=relaxed/simple;
	bh=tgca6DdcCdj6VfhCjCHBkY5RGM/VAt/20X7mr4oTUuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQQGkOvjY9N7l49XguuG9MPdxVHE4dRcxfS6KKswvIeFMfG1IAkV8oYmt6V735abV0nL9tbhhvt1q1Bqa0JpZZIJdYHk8AVQclAG6EezbFInuO1mTaDhHLJc7V4nrRdwi1oLzDxFqbx69EZcsRQ+d9C+MgJoVNhY7vt49ddYxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpHdPlG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpHdPlG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D031F000E9;
	Tue, 14 Jul 2026 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054881;
	bh=88ug2ZcSMfOiPq/ESWBU4z8emGgGCEvVMj1JCaE3R8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpHdPlG7FQXF/SCiAMht/B0UaGYhstPBWsfPbS1NOk3Vl5iPExgfa8HcjPj8gRYam
	 FcQHkGu5fxxZkQAbZwdxu+HCEHvLmMQc1iGtQ5CO1NlXQZwyDtyycQXGC8upvQUBCc
	 cSrqAsr+dohv86F8YfY9cLbmLLSnUsDW3bfzeJC+1RKTNNvySp8m3ewyyY8Nm/ga3m
	 vA604NrnGW/YjXGTlc9myM8Dl9BlqAbafM8zMam2jkx3jp7XrdUgINIZgug6ZT0Afi
	 YNNtHHRsMe3sEE9BNHMK2vbOubCw+pCwlREtq5JX3bnCVIZIhzVKzLP+eLFpmsM22k
	 QNYmC+MLV/vSw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/13] Documentation/dev-tools: document KWatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183356.13109-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183356.13109-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:48:00 +0000
Message-Id: <20260714184801.17D031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Rate-limiting in kwatch_hwbp_arm() silently fails to arm the watch=
point locally and causes state mismatches.
- [High] Using calling convention registers (arg1..arg6) to resolve watch e=
xpressions at mid-function offsets leads to reading garbage data.
--

--- Patch [13]: [RFC PATCH 13/13] Documentation/dev-tools: document KWatch =
---
commit da418fc283a833027fb7ccca30c188d2536f9a4a
Author: Jinchao Wang <wangjinchao600@gmail.com>

Documentation/dev-tools: document KWatch

Describe what KWatch is for, how it compares with KASAN and KFENCE,
the debugfs configuration interface, the watch expression syntax,
how to read hits from the trace buffer (including after a crash),
and the current limitations.

> diff --git a/mm/kwatch/deref.c b/mm/kwatch/deref.c
> new file mode 100644
> index 0000000000000..a93c76139e7cd
> --- /dev/null
> +++ b/mm/kwatch/deref.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +int kwatch_deref_resolve(const struct kwatch_config *cfg, struct pt_regs=
 *regs,
> +			 unsigned long *out_addr, u16 *out_len)
> +{
> +	unsigned long addr =3D 0;
> +	int i;
> +
> +	/* 1. Resolve the Base Anchor */
> +	if (cfg->base =3D=3D KWATCH_BASE_STACK) {
> +		addr =3D kernel_stack_pointer(regs);
> +		if (unlikely(!addr))
> +			return -EINVAL;
> +	} else if (cfg->base >=3D KWATCH_BASE_ARG1 &&
> +		   cfg->base <=3D KWATCH_BASE_ARG6) {
> +		int arg_idx =3D cfg->base - KWATCH_BASE_ARG1;
> +
> +		addr =3D regs_get_kernel_argument(regs, arg_idx);

[Severity: High]
If a watchpoint is configured with a mid-function offset (func_offset > 0),
are the calling convention registers still guaranteed to hold the arguments?

Since the compiler is free to overwrite argument registers immediately after
function entry, could this read garbage data and cause KWatch to monitor an
incorrect memory address?

[ ... ]

> diff --git a/mm/kwatch/hwbp.c b/mm/kwatch/hwbp.c
> new file mode 100644
> index 0000000000000..19498ba038260
> --- /dev/null
> +++ b/mm/kwatch/hwbp.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +void kwatch_hwbp_arm(struct kwatch_watchpoint *wp, unsigned long addr, u=
16 len)
> +{
> +	static DEFINE_PER_CPU(u64, last_ipi_time);
> +	int cur_cpu;
> +	call_single_data_t *csd;
> +	int cpu;
> +	bool is_disarm =3D (addr =3D=3D (unsigned long)&kwatch_dummy_holder);
> +
> +	wp->attr.bp_addr =3D addr;
> +	wp->attr.bp_len =3D len;
> +
> +	if (!is_disarm)
> +		wp->arm_tsk =3D current;
> +
> +	/* ensure attr update visible to other cpu before sending IPI */
> +	smp_wmb();
> +
> +	atomic_set(&wp->pending_ipis, 1);
> +	cur_cpu =3D get_cpu();
> +
> +	if (!is_disarm) {
> +		u64 now =3D local_clock();
> +		u64 last =3D this_cpu_read(last_ipi_time);
> +
> +		if (now - last < 1000000ULL) {
> +			put_cpu();
> +			return;
> +		}

[Severity: High]
Does this early return skip both the global IPI broadcast and the
kwatch_hwbp_arm_local() call?

If a user configures KWatch on a frequently invoked function and this rate
limit is hit, it looks like it will silently fail to arm the watchpoint loc=
ally.

Could this also cause state mismatches when disarm operations later broadca=
st
IPIs for a watchpoint that was never actually armed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D13
