Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5667341ADD
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047960; cv=none; b=YNNa+9QXtLSMKo5YExTp4rG2rPcee0c2toLQKHdS++IcWC23Lfi+xfDib3SjA2GjnorbmqrKX08PeUqT8gMqjaWWtnyWCVfwSBtvhKe05cnKAbP5P5y8AHfifICA2IvgaXAA9W5xji5OC1RlMcEDsmhMiKHdQLjWLmjsFWV/YPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047960; c=relaxed/simple;
	bh=qzSM5R7wD8dHF4vsW5bKAQl7H2ODGO8trBQ4mCUeMTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=He/lTe5+6u1iSMyxQ6tvuE1npGgXC3RT+hiQOPCP2Z8qdY1xI195OuF4JnKWAGqAz/AR/zl2OFY3iN/KoGMUBvhZ2itkn4thfmdO/P8EBsmj/sH9lS4a+EqqWZMNSfKPDli/a2s9Sev+Yfs6SAEqv5QyKMcK4zrIKQXZ0FI5ZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXJMN/Mh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXJMN/Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5337D1F00893;
	Fri, 29 May 2026 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780047959;
	bh=9z3A4tz8DQWh/FZ0lZmwYYI2pFxqFeuGHghx7B6h774=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXJMN/MhZC6Hs68I7Jgo5C7JXkzBOql1T6EJq0HR0eEkT6AekSogcFbk0u6r1Osmg
	 QY7lOlgMuS3N3KQYylt+uJ1gLN/+d1BA+/saADt4C0CMvwB3RjK1fxTkcYLIc6Y0NR
	 PDN71++8181Azh10C6B+LCtHZgS3kRaBUitQfqwCLbfH+/6g02oJd3ZnW+ENzBQdPB
	 k4eX8QLktiLVHFDPCvA4IaLgbMheZPc7+gsv2mCveTxjDXClULm/4bQqttIk8YtME1
	 z6vcyVgS0TczXp+tCXPvTTKa8fUHizco+WI3n04b/FzFOBvFewcmXNkKbQsrGn+XL3
	 1H1rXCoVWwUow==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 20/23] perf/x86/intel: Support arch-PEBS based
 SIMD/eGPRs/SSP sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-21-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-21-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:45:58 +0000
Message-Id: <20260529094559.5337D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Requesting the SSP (Shadow Stack Pointer) register improperly allo=
ws large PEBS to be enabled on legacy PEBS hardware, resulting in stale and=
 identical SSP values across all samples in the buffer.
--

commit 2a27d3f31fac15c7d594a6588f8dacfa2939bc9f
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Support arch-PEBS based SIMD/eGPRs/SSP sampling

This commit adds support for sampling SIMD, eGPRs, and SSP registers using
arch-PEBS. It defines the layout for these extended registers and manages
their sampling via MSRs and the XSTATE_BV bitmap.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -4695,21 +4710,113 @@ static void intel_pebs_aliases_skl(struct perf_e=
vent *event)

[ ... ]

> +static bool __regs_support_large_pebs(struct perf_event *event, bool int=
r)
> +{
> +	u64 regs =3D intr ? event->attr.sample_regs_intr :
> +			  event->attr.sample_regs_user;
> +	u64 vec_regs =3D intr ? event->attr.sample_simd_vec_reg_intr :
> +			      event->attr.sample_simd_vec_reg_user;
> +	u64 pred_regs =3D intr ? event->attr.sample_simd_pred_reg_intr :
> +			       event->attr.sample_simd_pred_reg_user;
> +	u64 xregs_mask =3D PEBS_GP_REGS | PERF_X86_EGPRS_MASK |
> +			 BIT_ULL(PERF_REG_X86_SSP);
> +
> +	if (regs & ~xregs_mask)
> +		return false;
> +
> +	if ((regs & (PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP))) &&
> +	    !intel_pebs_support_regs(event, PEBS_DATACFG_GP))
> +		return false;

[Severity: High]
Does this logic unintentionally allow large PEBS to be enabled on legacy PE=
BS
hardware when the SSP register is requested?

Looking at intel_pebs_support_regs(), it returns true for PEBS_DATACFG_GP
unconditionally on legacy PEBS hardware. If a user requests SSP on legacy
PEBS, __regs_support_large_pebs() will return true and allow large PEBS.

Since legacy PEBS hardware records do not contain the SSP, the perf core
fetches it from the thread's XSAVE buffer during the PMU interrupt via
x86_pmu_update_perf_regs().=20

Because large PEBS batches multiple samples and delays the interrupt, won't
every sample in the batch end up with the exact same stale SSP value from
the time of the interrupt?

Should large PEBS be explicitly disabled on legacy PEBS when SSP is
requested, perhaps similarly to how eGPRs are handled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D20
