Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C513A9DA1
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044975; cv=none; b=sZ36cO48eOuWAKvIXcYahVjUcM8NLPcA27Rd9KqKRELtWPSdb9y7Dl7g7r17zobONyUm6xY09lMEB9l5nDY04TJqc3C/BfZuqQqooG6ISUBCTdnTPfOSrpfgDjeP+vrZ7UHenMLUPCxnXXNzav0eglnSaBoY8d2x+zZ86ASVBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044975; c=relaxed/simple;
	bh=DaM2+AMUhuo3/OK+9Nph7Bnu3pIgrrcIjixOmi7AT2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sIg57+gitCSpToCihrtVpKvcYch6Cja2hr88a/VAGbWw8HAj55oW+D1eTJP+UvoG7VDdpCGN60GHE67T4BNvoSAYUsf+Z+re/WA6IAyrqoLuQy5wZ2ZIKoZHoxlXjUOZOYd7uupfkjbQw9xmu8nTTq1w2ensSvCQ/kO9qd0LpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp8yWK69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp8yWK69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFB1F00893;
	Fri, 29 May 2026 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044974;
	bh=sxQOwJ0+fhI8KMGcpoIBKQoJTcC9gDzhA6rKmXNIic0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pp8yWK69Z4JB12gE4eLSL+yyuw5GabfyIVMqsIJ0QMIr3yXf246H10c/wwjIEQfps
	 LKoO62aUwgT/jVdaHsVMSa7082hDUDVGSIeYMVoAwUw9FqYSuXUVIydQKyZB6u0B9g
	 Z9HD5Nv/KltRT8+oy2RZEvn6CBql9jFA5yojYh8JMnsEuZTTwZ5B3exsFo+XttOcM5
	 921S1Tmv4opuFgU6xOUn7D2HBwJqZ9195hr+b39IQQfYMw3Q5p/gzOxIBvrP4dJCOQ
	 HioXxySEBUt5ecPJQ59q/PSrJWuc+d43NIOpwDwNbT9qZzil5V1yAKPU/WAZ0bNH5A
	 ZqB8JHZT6GCeQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 07/23] x86/fpu/xstate: Add xsaves_nmi() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-8-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:56:13 +0000
Message-Id: <20260529085613.CCAFB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Executing XSAVES blindly from an NMI context captures in-flight ke=
rnel FPU state, leading to a severe information leak via perf REGS_INTR.
--

commit d34a5f4e0fb88fb36d75fc06f907af1f26922ffe
Author: Kan Liang <kan.liang@linux.intel.com>

x86/fpu/xstate: Add xsaves_nmi() helper

This commit introduces the xsaves_nmi() function to allow saving supported
xsave states directly from an NMI handler. It is currently intended for use
by the perf subsystem to snapshot SIMD and APX eGPRs registers.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea2..4394091c47910 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c

[ ... ]

> @@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
>  	WARN_ON_ONCE(err);
>  }
> =20
> +/**
> + * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
> + * @xstate:	Pointer to the buffer
> + * @mask:	Feature mask to select the components to save
> + *
> + * This function is similar to xsaves(), but should only be called within
> + * a NMI handler. This function returns the actual register contents at
> + * the moment the NMI occurs.
> + *
> + * Currently, the perf subsystem is the sole user of this helper. It uses
> + * the function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers.
> + */
> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
> +{
> +	int err;
> +
> +	if (!in_nmi())
> +		return;
> +
> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);

[Severity: High]
Could executing XSAVES directly from an NMI context capture in-flight kernel
FPU state and lead to an information leak via perf REGS_INTR?

If an unprivileged user creates a hardware perf event with exclude_kernel=
=3D1
and requests PERF_SAMPLE_REGS_INTR, they bypass the perf_allow_kernel()
privilege check. Due to hardware skid, a PMI might be delivered after the C=
PU
has already transitioned into kernel space.

If the interrupted kernel context is actively using the FPU (for example,
inside kernel_fpu_begin() for cryptographic operations), the hardware FPU
registers would contain kernel data.

Since this helper captures the hardware FPU state unconditionally, and the
perf subsystem does not discard or filter REGS_INTR samples based on
privilege when a skid into kernel mode occurs, will this export sensitive
kernel SIMD registers to the unprivileged user's ring buffer?

> +	WARN_ON_ONCE(err);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D7
