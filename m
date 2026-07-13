Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD23B47D7
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933169; cv=none; b=INU1s4g49txF4e5JtvwnLssAvp7pCW11q/mFT90LPsusJHWmSe4zcp6/nCZkLnIm+hgrOJRymoG8ADQxa/AZVwDftBRNpLwd50rKNcsjuewcm5rto0/DTnr7VhDT6NlU9QEQGR8w3QinVoLV+bTOTS+k6TYwyoZzFCHPQoQIej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933169; c=relaxed/simple;
	bh=oDFqAToPuaVTrPc0sct/nwWQy1wI69YCevy4I1pNqGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kf0u0ZS90JjqSrtfCbbLKsxsscFkMkb5GrGSPxDib3XMgbIot1621qSxXYvCuqewbtluM8EcPqThX3O8jaQCu8f1MVXlkx7Xi4ZFWNDsfeTKmSU2I2ImAYdUKHCkvMzTageRyGYOL2GGB6ewye17D0qkik6YXTeFH42wzDFxUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL14bv49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL14bv49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C281F000E9;
	Mon, 13 Jul 2026 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783933167;
	bh=/9CJMg0uYY6Exg4pLjDgAfw9Q24yJa21Hh54zqPBCXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FL14bv49+ntumsB8ZvPKJd8kHduaZPhn/oWZUaDhgmxubA+2jMGFo4L4WmCc4ibPi
	 YkJDedIgyLRBiTsbsx+ez8ywRLn0wz0ny1kUDK5LE5/m1pQz2hn5T1lAbEcgo191/Z
	 uh1Ghi9FdQXOHb9yhCerbx4FkoZGGyEF3CNvJpvREuQCugiMvN5/fEa6ULzkunIYCC
	 1XgKOGXDicdMaLbijF6itBoW1G07QORvozNRQiit0MVtfCGktQIN7OTjSe9fCLy9di
	 01PfA6FjIcLNr6BtTFWFTWuri0L6Xv/3HshPBpJGGna6KZ9YE6kWp9tWK13/k84pmq
	 LavUayzGo+4FQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 3/7] perf/x86: Guard intel_pmu_cpu_dead() against
 invalid hybrid PMU casts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260713082734.3162099-4-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
 <20260713082734.3162099-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:59:26 +0000
Message-Id: <20260713085927.48C281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in NMI handler causing out-of-bounds access during =
hybrid CPU bring-up.
- [High] Unhandled #GP exceptions (kernel panic) in NMI and hotplug paths i=
f hybrid PMU initialization fails.
--

--- Patch [3]: [Patch v2 3/7] perf/x86: Guard intel_pmu_cpu_dead() against =
invalid hybrid PMU casts ---
commit 419f89d32dfc7abe942483376114f8e4845bc1a8
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts

In failure paths, cpuc->pmu can point to the global static pmu instead of
an embedded x86_hybrid_pmu::pmu. This commit clears cpuc->pmu to NULL when
check_hw_exists() fails and validates cpuc->pmu before hybrid container
conversion during CPU rollback paths.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b39c6ce0efb5c..a991fc4f1575f 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
> =20
>  	intel_pmu_check_hybrid_pmus(pmu);
> =20
> -	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
> +	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
> +		cpuc->pmu =3D NULL;
>  		return false;
> +	}

[Severity: High]
This is a pre-existing issue, but is it possible for an NMI to fire before
this initialization completes during hybrid CPU bring-up?

If a secondary CPU unmasks NMIs early and an NMI fires before the
CPUHP_AP_PERF_X86_STARTING callback executes init_hybrid_pmu(),
perf_event_nmi_handler() will run.

If active_events is greater than zero globally, intel_pmu_handle_irq()
executes:

arch/x86/events/intel/core.c:intel_pmu_handle_irq() {
    ...
    bool late_ack =3D hybrid_bit(cpuc->pmu, late_ack);
    ...
}

Since cpuc->pmu is statically initialized to the global &pmu at this stage,
could this cause hybrid_pmu() to perform an invalid container_of cast and
lead to an out-of-bounds access?

[Severity: High]
This is a pre-existing issue, but if check_hw_exists() fails and we return
false here, leaving the CPU online without a functioning PMU, could this le=
ad
to unhandled #GP exceptions?

If an NMI fires while active_events is greater than zero globally,
intel_pmu_handle_irq() unconditionally reads PMU MSRs:

arch/x86/events/intel/core.c:intel_pmu_handle_irq() {
    ...
    status =3D intel_pmu_get_status();
    ...
}

Since check_hw_exists() failed, the MSRs are likely inaccessible. Would
executing rdmsrl() trigger a #GP exception and a kernel panic?

Similarly, during CPU teardown, does intel_pmu_cpu_dying() blindly write to
MSRs without checking if the PMU was successfully initialized?

arch/x86/events/intel/ds.c:fini_arch_pebs_on_cpu() {
    ...
    wrmsrq_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0);
    ...
}

Could this wrmsrq_on_cpu() without fault protection also cause a #GP panic =
if
PMU initialization had failed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713082734.3162=
099-1-dapeng1.mi@linux.intel.com?part=3D3
