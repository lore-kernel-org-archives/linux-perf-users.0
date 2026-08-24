Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C930E821
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566565; cv=none; b=jF+GTc1x2RIzTLjm5vjsgd59PtkahYY1w76KChBNBKtX2vci8azSOebKaO2B4kMYstnJ4QVf0396XDKbFl3NscPjqn4OdepygWUCgzk/2k8eH66ypBD+zvoss231iAW6xCwIXdnL098lzHHWM8EqJZbiQq9FWHRD4Hd53ooFijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566565; c=relaxed/simple;
	bh=I26t5sybRftzNx50CyhRFNDsoXcjOhqxAl5v7ahzRxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gju700Z3XkY42i17QbX35JlEmfTjoePwo1+nxwjtVo8fZpUttM9hvNYhRoxib+YN0nn1T8or2Eie5G8G0bnpJhnhJzVBhou4yHFSdnz1I9EVKeP8CtOuyleJRsXuALOrMKDdwRulo2rRzVz/BDZOV5+zpAgYw8KoONZqpj5W7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhYjC1v6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhYjC1v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D42D1F000E9;
	Mon, 24 Aug 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787566563;
	bh=pCr3EPVbg1k1Xql3U2f4arQV5Kq7ytsmU3pCLxthLbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KhYjC1v6p5Zl20DWU/t1IzpOOfUzzRD1yVpNWX5aNufsAU+rNCEmV9rrRadSTw1/E
	 TmB+yYLGX0ymX2tJ/fQIDfk8vw5/f8XwpwMXJolFx/Z4mIHwPU474BJy68ORuAm1ui
	 aDTOrHDwu/x07YKVivGELXD1ltgJzgDW8Fzl6g+aWzA9A4cCQaaFh7eaFK0OvTBOUk
	 QnoNzzMIxmVrSoxL0UVoSuKS570zwfYw/LmEwjeWnuSpv+OUcKinmJhfkV1lxkbsoT
	 ts1M5jSNiqIQqSOZir4wmN8YuTrKxDU6HOhXEg0cAnDAijXZcxyZfYD5IgcKvoJJGr
	 hlda6vixo7fdw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 11/23] perf/x86: Enable XMM register sampling
 for REGS_USER case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-12-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:16:02 +0000
Message-Id: <20260824101603.6D42D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NMI re-entrancy corrupts per-CPU `x86_user_regs` during PEBS drains
--

--- Patch [11]: [RESEND Patch v10 11/23] perf/x86: Enable XMM register samp=
ling for REGS_USER case ---
commit 1dabe6f859e16c09faeea0ab1b864b14dc315cd4
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Enable XMM register sampling for REGS_USER case

This commit adds support for XMM register sampling in the REGS_USER case.
It introduces a per-CPU x86_user_regs variable to store REGS_USER-specific
XMM registers to prevent overwriting by REGS_INTR-specific data. A helper
function x86_pmu_update_user_xregs() is introduced to read these registers
from either cached task FPU states or hardware registers.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1c3e2bfa2673a..20140643e21c9 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -1832,14 +1826,129 @@ static void x86_pmu_update_regs_intr(struct perf=
_event *event,
>  	data->sample_flags |=3D PERF_SAMPLE_REGS_INTR;
>  }
> =20
> +static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
> +
> +static void x86_pmu_get_regs_user(struct perf_sample_data *data,
> +				  struct pt_regs *regs)
> +{
> +	struct x86_perf_regs *x86_regs_user =3D this_cpu_ptr(&x86_user_regs);
> +	struct perf_regs regs_user;
> +
> +	x86_pmu_clear_perf_regs(&x86_regs_user->regs);
> +
> +	perf_get_regs_user(&regs_user, regs);
> +	data->regs_user.abi =3D regs_user.abi;
> +	if (regs_user.regs) {
> +		x86_regs_user->regs =3D *regs_user.regs;
> +		data->regs_user.regs =3D &x86_regs_user->regs;
> +	} else {
> +		data->regs_user.regs =3D NULL;
> +	}
> +}
> +
> +/*
> + * The x86 specific variant of perf_sample_regs_user().
> + * Update data->regs_user fields for extended registers (e.g., SIMD).
> + */
> +static void x86_pmu_update_regs_user(struct perf_event *event,
> +				     struct perf_sample_data *data,
> +				     struct pt_regs *regs)
> +{
> +	struct x86_perf_regs *x86_regs_user =3D this_cpu_ptr(&x86_user_regs);
> +	struct perf_event_attr *attr =3D &event->attr;
> +	struct x86_perf_regs *perf_regs;
> +
> +	/*
> +	 * PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER can both be
> +	 * requested for one event. Keep user regs in a separate x86_perf_regs
> +	 * instance, so intr-reg collection does not overwrite user-reg data.
> +	 */
> +	if (user_mode(regs)) {
> +		x86_pmu_clear_perf_regs(&x86_regs_user->regs);
> +		perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
> +		/* Copy all sampled regs data to x86_regs_user. */
> +		*x86_regs_user =3D *perf_regs;
> +		data->regs_user.regs =3D &x86_regs_user->regs;

[Severity: High]
Does this code corrupt the un-nested per-CPU x86_user_regs during NMIs?

If a context-switch PEBS drain runs with local IRQs disabled but NMIs enabl=
ed,
a PMI (NMI) could interrupt the drain. If the PMI handler processes a perf =
event
requesting REGS_USER, it will call x86_pmu_update_regs_user(), which
unconditionally overwrites the same per-CPU x86_user_regs variable here wit=
hout
in_nmi() protection.

Upon returning from the NMI, the interrupted PEBS drain would resume copying
the now-corrupted x86_user_regs into the ring buffer, silently corrupting t=
he
recorded user registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D11
