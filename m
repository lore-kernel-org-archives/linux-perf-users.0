Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B02E6CB3
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304323; cv=none; b=WGlHg0ovUbr0/GE1hlvRz4dhBtt7Qb69RaIr5KtyHRUJIdHrJQe1BCaJ60/telNyElsxib2IF3TzIDUv4xDnYxj7fWcWhB4RN8wC4dG9u4jgs6PmIIu7MwhRFjpq+0SqD6l1vR4dpE+w2VY0nKFsgzAPYCa2WA8hBzkYs0OMhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304323; c=relaxed/simple;
	bh=zlF4ZJireOzVfX3MW8a/YInSl/igrvm157TVFdlhULo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C65KFe/TQXz9wcuoq6TGLt+2sMTa+n4fohgGlV8Fum6HrYF/afCZuRNmRU0ojThoKXh+uZ5WhEBqEVCPNW6eT8g806yyl6fOAZVMHiFaL95U4QpNBBD2hvH2GCwDg06X0mMycK4kLgG9Mv5ZfQBQjLIjUuL1bNMYmOyhm1iEuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kknPNxFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kknPNxFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1AC1F00A3A;
	Mon,  6 Jul 2026 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304321;
	bh=MEpfKPVyl0WxDslra1DX3mf2BSbsR25tel3MfroNiGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kknPNxFq9mulfns49k64qoSjWqo1yIDxnBUKuGgp/mlbpUwxLpkZBeljFCqDNA0vw
	 E6VI1HflRSoTwesagIW2XLmA7imzhqdw+LD1ZI/ScKNYr0qMcxQ66btvDn9R4IChRj
	 SI+RB+cIaZhO6DeMB1xEHiqitw5Cxo6Z+a7gVZTNGL4mkIqbgyQ4eXYHPPCRP+DdPt
	 I4H02nDOwHJ1FHlTc12ANBmPIWx1UWx/UVPKztM2jblP6nUVulP662qDjLLgy7geTN
	 rlSzo3I2jwaekiFClta6HgOnrDvXYkwEwu1reyiUotcaVVjrlOSrhP6HOd91homPrz
	 UK/I9/ti85IvA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 07/24] x86/fpu/xstate: Add xsaves_nmi() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-8-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:18:41 +0000
Message-Id: <20260706021841.9F1AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The use of the XSAVES instruction in xsaves_nmi() breaks FPU snaps=
hotting to independent buffers due to the hardware's 'modified optimization=
', leading to a cross-process information leak.
--

commit e8d6f39a5d4512be90e9976febc30b8f46c0ea64
Author: Kan Liang <kan.liang@linux.intel.com>

x86/fpu/xstate: Add xsaves_nmi() helper

This commit adds a new xsaves_nmi() helper to safely save supported xsave
states from within an NMI handler. The helper is intended for the perf
subsystem to snapshot SIMD and APX eGPRs registers.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea2..d39c01546dee7 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c

[ ... ]

> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
> +{
> +	int err;
> +
> +	if (!in_nmi())
> +		return;
> +
> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);

[Severity: High]
Does this code leak stale data into the perf samples?=20

The XSAVES instruction uses a hardware modified optimization that tracks
whether a state component was modified since the last XRSTORS. If a
component is unmodified, XSAVES skips writing it to memory while still
setting its presence bit in the XSTATE_BV header.

When the perf subsystem calls xsaves_nmi() in x86_pmu_sample_xregs()
with an independent per-CPU buffer like ext_regs_buf, skipping the memory
write leaves whatever stale data was previously in that buffer.

Because the bit in XSTATE_BV is still set, won't the perf subsystem
read this stale data (potentially from other tasks) and leak it to
user-space?

> +	WARN_ON_ONCE(err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D7
