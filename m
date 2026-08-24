Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEE23C368
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564342; cv=none; b=VTo80BSomnsGHR54KJbFsmc2yGEQuKyL3txuA/T580j1TGOr6pK27QtwSS+1s9yWsF3WnUKz8s0yMLTAfQfDf8KkZk4T4xmqdCgg1xiCvoXdAJ5kkTWP8glwiaMwJIy49pdRvgwbzZvmvhK9fZvK6YeslPHW6a2/ZU26f0Q1gKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564342; c=relaxed/simple;
	bh=pIkAFq/hLzyHe4Js+3lb/wL5Vo+xOlkNF/rbQGd33Mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4JHivCPx8turTlBkfI4qH22stJ9UWQjwr2bNWgof8n2BRZhWMNSTK9Mpg9zDOy2JyQugyB9jH9pVNyjRzSDmy6W/iSKUGuGSJLYPSLXhAgpEr9GqFtpbbDu5NwRfdFt7uzdjZspGGruHPkpDT/v9bZwt4ZpQC4tmFq0b/EEmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtE18kB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtE18kB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BBB1F000E9;
	Mon, 24 Aug 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787564340;
	bh=knviqPbV3LwctM9d67MN1E2Ky/AUsK0HTWF4e7hQITI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DtE18kB0ab0qJMrCOvABWa+s85TfvAtlObp7XFFGT0dl99NqVpP+8M3ZRps5PMUBh
	 uoXP36RP+bT7+ogF563mbBdy6a/OY0e9whdTRYuBzgwOsu8jhlofYpyFS6pdjudL/D
	 r7LHVIwStN+rXA1ycgYX/Xvr9yJOkw2oRwqvTYGKr7taWuXvMXCVLRQE4oXI77ITxq
	 S/eCZ/KpQ+rwiqhq+DWoli2KkMwvNObmWYkxeV7xeg5CNX0xmHaa1QFxe9S/N3kEFu
	 lk+aauJRVKTZkepgzp0nPBcHWpeLERNTJCKmZzCL4yA9xS7pmhtNq/EIikXPhjc/Kf
	 Yt2/yCP5/pH9Q==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 19/23] perf/x86: Support SSP sampling using
 sample_regs_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-20-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-20-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:39:00 +0000
Message-Id: <20260824093900.A8BBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Arbitrary kernel memory read or kernel panic (page fault) via =
out-of-bounds pointer dereference in `perf_reg_value()` when triggering a h=
ardware event via BPF.
--

--- Patch [19]: [RESEND Patch v10 19/23] perf/x86: Support SSP sampling usi=
ng sample_regs_* fields ---
commit f68aca90e443a6b899f0ff2729c1f378ec1fb548
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support SSP sampling using sample_regs_* fields

This commit adds support for sampling the CET SSP register via the
sample_regs_* fields. It uses the spare space reclaimed from the original
XMM space and is gated behind the sample_simd_regs_enabled flag.

> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 7d4233ed859cd..f8952f7c36cce 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -72,6 +72,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  					return 0;
>  				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
>  			}
> +			if (idx =3D=3D PERF_REG_X86_SSP) {
> +				if (!perf_regs->ssp)
> +					return 0;
> +				return *perf_regs->ssp;
> +			}

[Severity: Critical]
This is a pre-existing issue, but does this function correctly handle the c=
ase
where regs is not embedded in a struct x86_perf_regs?

If a hardware event is added to a BPF_MAP_TYPE_PERF_EVENT_ARRAY map and
triggered by a BPF program calling bpf_perf_event_output(),
perf_prepare_sample() uses the raw pt_regs from the BPF context.
perf_sample_regs_user() then sets the sample's user regs to
task_pt_regs(current).

When perf_output_sample_regs() subsequently calls perf_reg_value(), it blin=
dly
casts this raw pt_regs pointer to struct x86_perf_regs using container_of():

arch/x86/kernel/perf_regs.c:perf_reg_value() {
    ...
    if (idx > PERF_REG_X86_R15) {
        perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
        if (perf_regs->abi =3D=3D PERF_SAMPLE_REGS_ABI_NONE)
            return 0;
    ...
}

Since task_pt_regs(current) is located at the very end of the task's stack
page, reading fields like the abi or xmm_regs pointer accesses the vmap sta=
ck
guard page, which can trigger a kernel panic. Can this be avoided by verify=
ing
the origin of the regs pointer before casting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D19
