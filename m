Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB039098C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562747; cv=none; b=h5qMbcQwZZwPEGYDvlWzETJIB/yaKoQHRSxvas2SoWaXFQ7VRPtQlgmHVsJRY/sprB67HdlOC5h6p6WgIfcfKjH/of9ynXE3dlqU30bnEJnzFt9m5vBK02705kI6zOM4vV1ddZDOS52tEhIiQn6N6QvgKtmI7rpMKRsjZ3AT9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562747; c=relaxed/simple;
	bh=C+jd0hcJka/6vCpk/NwUcq1n0BF8ZHxmzSSPn2egGmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUXbkQUTc6qS5/qppOdt5SHr6Hd2NkdpSmJ8TZENutUtezGAJNEsyJzgQBN/xQ5bCP8x/tf42ioLHpZAKh1q6zjuHr2hRP6wCVdEaANWHWq+WccveKrDYaDGM4dMu+4oBq3DtbGFZV2CR2w0sfGoEyDq2gpDUaJb+D1oOhb0+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQTa4hEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQTa4hEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514D71F000E9;
	Mon, 24 Aug 2026 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562745;
	bh=HJkIiNugrRHz0/jyCy67DxJMUrXRXeBlGa4PQ3ssWwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQTa4hEqmq0j0wNlLlUwr6sWaxevD5Eh8tlaE6axmKtbyMQR5by9Y7s9J6gnBIY2T
	 y5sFvt2hhnG9TzHE7wmrJQ9foxc9h4ldYsuURf3eVIkbhGkoVh6OHQP0VC00y++hS3
	 RjGmX0nZrq7J813HXFRzFKvTwJvL564NQT40qBQkefZVSwjGjcA/TNncpp7322jQoM
	 0XlD/B2VCbdz/h4iBFrTbDEtSBHG4C91y1KX+N2upffBN0PZEZYf7cvBdC04Vd08vy
	 iJCAMT5aHwVUUK13eGZ76MaA7kGCP5fUNTufKDst343DM8bRlu9N0yAXyYSOpEssP+
	 OGgd+2wpItiAw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 13/23] perf/x86: Support XMM sampling using
 sample_simd_vec_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-14-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:12:24 +0000
Message-Id: <20260824091225.514D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Downcast of `struct pt_regs` to `struct x86_perf_regs` for softwar=
e events leads to an out-of-bounds read and potential arbitrary memory read=
 or local DoS.
--

--- Patch [13]: [RESEND Patch v10 13/23] perf/x86: Support XMM sampling usi=
ng sample_simd_vec_reg_* fields ---
commit 19bc56fc15fa41117febd46977ed2032c46e92f4
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields

This commit supports sampling of XMM registers using the newly introduced
sample_simd_vec_reg_* fields. A new abi field is introduced in struct
x86_perf_regs to accommodate layout information for perf_reg_value.

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 81204cb7f7239..bccf0fc275116 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -63,6 +63,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> =20
>  	if (idx >=3D PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
>  		perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
> +		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +			return 0;
>  		if (!perf_regs->xmm_regs)
>  			return 0;

[Severity: High]
This is a pre-existing issue, but does using container_of() here lead to an
out-of-bounds read for software events?

If a user creates a software event (e.g., PERF_TYPE_SOFTWARE) with
PERF_SAMPLE_REGS_USER and sets an XMM register bit in sample_regs_user,
perf_reg_validate() fails to reject bits >=3D 32. When the event triggers,
perf_output_sample_regs() calls perf_reg_value() with a raw pt_regs
pointer from task_pt_regs(current).

Because task_pt_regs is typically located at the very top of the kernel
stack page, downcasting it to struct x86_perf_regs and reading
perf_regs->abi or perf_regs->xmm_regs accesses memory past the end of
the pt_regs structure.

Can this cross into the adjacent vmap guard page and cause a kernel panic,
or leak adjacent memory if triggered via nested interrupts or kprobes
where the pt_regs is in the middle of the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D13
