Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6E3B14D9
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561649; cv=none; b=CB9fYtXxT2dG6RBp/gC+X5zM6FdUReNegaQvBcpc8HvCm05PWrWZ5Mytn5pLD1IUPoAD/Lk0kZgRGJ7a2rYbqDY+UvHL7y3c5zcPCP33H755Mr5xBdFfaCu6MekPeTo8TZ3t9CdnNUeqSOqAGfIr3lSwuKzV5F+uPAEOzSJFkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561649; c=relaxed/simple;
	bh=OM8tQKQPhCp02Poh7oTWR0lecG93MegjY5UU0Z9zYPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oBIiTe2hoMkOHVTeqS0lOzpJbQqxKMaPq2S2d/tPaHfcFf9ggyxyTDQ6AsE7CWNEfWb4FDiQfpvsmq2CepFk7KShEEsfs1iZasoVbhWM/ENvf95NcLHfvtWHsLizSSNxDrEbX9o9cjF5cw6duewNK+uhKZWwJuVMG9puXe7yl9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyvwb4dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyvwb4dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595F21F000E9;
	Mon, 24 Aug 2026 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561648;
	bh=JiBVzeXfPOYGLu/jt7iY3qp0LEGx2u25hx2dy812pKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hyvwb4dZLU/eISirOjh2pjSrouMCuAhLSRgHQ2iqWXVnWYPgqB0q4kmUCO6yLxmj0
	 KewSTm2lMTKCwv6Q1lEZNH5+/aaqkTwf7n9xzyoqxz1C2ipDEKBWyMajDZsR9Q2FtJ
	 0r8Sgph/+iJK9mpTYf1bngCvrPotQmAVJlFJk6sGu3tH6F0rwFgy9ohXCAHRHD1+OL
	 7aLXtmCQV8SofoMWp5rnexODNvbQML809JNPvG0MUT01OD6iqlPFNFg2Xp8XqpObu0
	 TudBhLEjVS4kdvj4rUMS2ZjW2LVgJW8Zh2V0nRiEnLlBFDGrbE4DK1Gbimfi+aV79P
	 ypkqO9NxuiBMA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 06/23] x86/fpu/xstate: Add xsaves_nmi()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-7-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:54:07 +0000
Message-Id: <20260824085408.595F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] xsaves_nmi() uses the XSAVES instruction which employs hardwar=
e 'modified optimization', causing catastrophic data corruption for the int=
errupted task.
--

--- Patch [6]: [RESEND Patch v10 06/23] x86/fpu/xstate: Add xsaves_nmi() he=
lper ---
commit 2691ef22b25df7392d6766bb1de8a6d97a6ee37c
Author: Kan Liang <kan.liang@linux.intel.com>

    x86/fpu/xstate: Add xsaves_nmi() helper

This commit introduces the xsaves_nmi() helper function to allow the perf
subsystem to save supported xsave states within an NMI handler. It is inten=
ded
to snapshot SIMD and APX eGPR registers at the exact moment an NMI occurs.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea2..d39c01546dee7 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
[ ... ]
> @@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
[ ... ]
> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
> +{
> +	int err;
> +
> +	if (!in_nmi())
> +		return;
> +
> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);

[Severity: Critical]
Does executing the xsaves instruction in this context corrupt the FPU state=
 of
the interrupted task?

According to the Intel SDM, the xsaves instruction employs a modified
optimization that unconditionally resets the CPU internal state-component
tracking, marking all components as unmodified.

If a task is interrupted by an NMI (such as a perf PMI) and this instruction
executes, won't the subsequent context switch out of the task also see the
state as unmodified? It seems the normal context-switch xsaves would silent=
ly
skip saving the state to the task FPU buffer, losing any SIMD modifications
made prior to the NMI.

Additionally, since xsaves skips writing components it considers unmodified,
could this leak stale SIMD state from previously interrupted tasks into the
current perf sample buffer?

> +	WARN_ON_ONCE(err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D6
