Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8048DB21;
	Mon, 19 Oct 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395059; cv=none; b=XQgwx+CLA1DidpUo1cjqueUSM4O7bZpN8PzlnbTbOSzeLOlhcNCLH0S7gck87owrDrAL9ZbugLVUgA0UeNtBITvybjh7pSo+OVoIP7OQ9bNDaSql1xHADH7RXs/jV1DYccXZX1S2VVEcUSQkj8YkDa+U9+Gm5HX8Dd7RPW1/xss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395059; c=relaxed/simple;
	bh=Lu4hiwuTjpAksAIGW3e9a9TwV7wlG1UOt5Rq9zJzGsA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rf5NXdIq3IzFfEooH/YPplnoKS/VErzm9QcqzrPQJWptGdUPMkI6CKOP+mZExX1ZcVSmHqm+alDZCxtPoch3mKYS2h6OZ0L5sYdAZtKXjsH4Db7qr6wMVuT3cz9mNVhG+C5TeE30+urQi/DCyiwwf63kg4egrBUr4tqO0beC8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvi11DUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvi11DUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E181F000C4;
	Mon, 19 Oct 2026 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792395058;
	bh=DFid1CeN6V3NGgsrvHtYdu7x8mrFj2HJTxh6bC2t9Ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvi11DUa7SZS/kn6goF/PFRPp+VVJRDUAYnomEhHgvJQPQuDRaIShFuxX/44X6BGb
	 DrGAtfPPytJ3jvcl/YkzoQ69VbtdFTfGCSX6IN+QR4sLfrAisBoL/ewcBVBe+32A5c
	 N4zJGY20acqtjOo50KcY8sJUVEeS4+8/XSynafH6GQgSk7hEDReGumCIRhUBldv+73
	 PXqhdA8T41j1fyjbJYRm6Ws4UB8qxmg397+5Cxg5XHZxREByxDGwzrhVuxpW1O9y5+
	 ayLvByVBspFxI/BdAQfBox8qLrEU7mG1NYD4ahpE943KXlSUHTNUkTS21PXjn5atTk
	 SyMNZA0rczpjA==
Message-ID: <sashiko-outbox-176747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 3/4] perf/x86/intel/lbr: Reset the cached LBR stack
 in intel_pmu_lbr_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261019070836.2972403-4-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:30:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/x86/intel/lbr: stale lbr_stack.nr in intel_pmu_arch_lbr_read_=
xsave()
--

commit 93eb502f5c2972255761d542db115fed920f52bd
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel/lbr: Reset the cached LBR stack in intel_pmu_lbr_reset()

This commit resets cpuc->lbr_stack.nr in intel_pmu_lbr_reset() and skips
calling intel_pmu_store_lbr() in intel_pmu_arch_lbr_read_xsave() when
XFEATURE_MASK_LBR is not set in xsave->header.xfeatures.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 0b446d8912e4e..249db12e927ed 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> =20
> +	cpuc->lbr_stack.nr =3D 0;
> +
>  	if (!x86_pmu.lbr_nr)
>  		return;
> =20
> @@ -1012,7 +1014,8 @@ static void intel_pmu_arch_lbr_read_xsave(struct cp=
u_hw_events *cpuc)
>  	}
>  	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
> =20
> -	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
> +	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
> +		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>  }
> =20
>  void intel_pmu_lbr_read(void)

[Severity: High]
When xsaves() sees the hardware LBR state in its INIT configuration, the
XSAVE init optimization clears XFEATURE_MASK_LBR in
xsave->header.xfeatures without writing to xsave->lbr.entries.

If intel_pmu_store_lbr() is skipped here without resetting
cpuc->lbr_stack.nr =3D 0, can cpuc->lbr_stack.nr and cpuc->lbr_entries[]
retain stale branch entries whenever the hardware LBR state enters the
INIT configuration without going through intel_pmu_lbr_reset()?

For example, during a context switch in LBR call-stack mode,
__intel_pmu_lbr_restore() restores the incoming task's LBR state without
calling intel_pmu_lbr_reset():

arch/x86/events/intel/lbr.c:__intel_pmu_lbr_restore() {
	if (!has_lbr_callstack_users(ctx) ||
	    task_context_opt(ctx)->lbr_stack_state =3D=3D LBR_NONE) {
		intel_pmu_lbr_reset();
		return;
	}
	...
	x86_pmu.lbr_restore(ctx);

	task_context_opt(ctx)->lbr_stack_state =3D LBR_NONE;
}

If the previous task populated cpuc->lbr_stack.nr > 0 and the incoming
task had 0 branches when scheduled out (so xrstors() restores the hardware
LBR state to the INIT state), a PMI or branch snapshot in the new task
before new branches are recorded will see !(xsave->header.xfeatures &
XFEATURE_MASK_LBR) and leave the previous task's cpuc->lbr_stack.nr and
cpuc->lbr_entries[] in place.

The same situation can also occur within a single task when:
- RET instructions in call-stack mode pop all hardware LBR entries back to
  the INIT state after an earlier PMI populated cpuc->lbr_stack.nr,
- a deep C-state resets the hardware Arch LBR registers to the INIT state
  (x86_pmu.lbr_deep_c_reset) without calling intel_pmu_lbr_reset(), or
- intel_pmu_store_pebs_lbrs() populates cpuc->lbr_stack.nr from a PEBS
  record while the hardware LBR registers are in the INIT state.

In addition to leaking or repeating stale branch entries,
intel_pmu_lbr_read() then runs intel_pmu_lbr_filter(cpuc) a second time on
the stale cpuc->lbr_entries[], where e->type already holds a converted
PERF_BR_* value rather than a raw ARCH_LBR_BR_TYPE_* value, indexing
arch_lbr_br_type_map[] with the wrong value.

Should intel_pmu_arch_lbr_read_xsave() clear cpuc->lbr_stack.nr =3D 0 when
!(xsave->header.xfeatures & XFEATURE_MASK_LBR)?

	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
	else
		cpuc->lbr_stack.nr =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019070836.2972=
403-1-dapeng1.mi@linux.intel.com?part=3D3
