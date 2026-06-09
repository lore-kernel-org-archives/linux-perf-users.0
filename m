Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEB3C81BE;
	Tue,  9 Jun 2026 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986071; cv=none; b=cNgrMd55GTHPqlyqHePY8fihvRXyn/AjdRgLUVV2S0BwRIpsO2kGTCgYU1xT1igEkUHtD1LgCVgtzznEC7maRdshkbopYcc6voQ+r2wtTMRhH1Yk0MQTh9IKMR492kfdoaXxBMZnoDy8XyeJTCOzbxE1PEiavGaG8ES9UoQlH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986071; c=relaxed/simple;
	bh=lCYOVFjZnn/dqd4JysEpxoFbB3vDUg8XYkeOKikWN9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eeOSFvQ6oAp8x+SUicP4UAFDr40Iy7A4N+2nhyJt9N2gK64imwSEQvE0GZjk8zdo3HMRFkOdv0uIP+LyB4vhCtlPEIbMaYo716UiheD0XmydySe5BsGE/mwmkDgLKyOLMwRlkrDYS9yo2sv++vBGBSL5xQQ6qYibnODbwkqgsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny62LY2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny62LY2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0C61F00893;
	Tue,  9 Jun 2026 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986070;
	bh=louNFoHGH9YW/D0y4u7a9GN6KCIAkRWFDoK74/e51S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ny62LY2iCQ/6WlI14pu83D8eZwjeDAPqgTYitODHMATZrGZTXGFNI8SYZChX0pd2L
	 D7np5JCPrdqh0zDOZaqsLzyDZ4w0DofFph3yX2iKZ/xT8ntWErUF8G44778UwmDw1/
	 LF8+7QKCfMOxtk4f11fQmusM2isr5Tqrxtdsm08btdR4fiXTYAnuivHCsah4aHpong
	 FyHaRFah37OVufTvyNLRcbZUL/Ehg92Ii6rjeARKVMCR4zenD/OFJHLLku/T88dTKx
	 EU4IPI5xrEh9bGKKzRC17UiV58zv4a4LNzqDtzz1A+spV7hNymrTEpKY1rJ15gDvB3
	 T7Vna3ELxxoVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/21] RISC-V: perf: Add legacy event encodings via
 sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-16-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-16-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:21:09 +0000
Message-Id: <20260609062110.1D0C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The globally scoped pmu_ctr_list array is leaked if PMU counter =
discovery fails, compounded by a flawed error code cast.
--

commit 7d64e724e6eff197f10e62cdd709e07f0a5c9a7d
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Add legacy event encodings via sysfs

Define sysfs details for the legacy events so that any tool can
parse these to understand the minimum set of legacy events
supported by the platform. The sysfs entry will describe both event
encoding and corresponding counter map so that an perf event can be
programmed accordingly.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 4b4f151a0744d..00b84b28117a8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -130,7 +130,20 @@ static struct attribute_group riscv_cdeleg_pmu_forma=
t_group =3D {
>  	.attrs =3D riscv_cdeleg_pmu_formats_attr,
>  };

[ ... ]

[Severity: Medium]
Does this code leak the pmu_ctr_list array if PMU counter discovery fails?

In rvpmu_find_ctrs(), pmu_ctr_list is allocated via kcalloc(), but the func=
tion
bails out without freeing it if num_sbi_counters or num_deleg_counters
exceeds RISCV_MAX_COUNTERS:

drivers/perf/riscv_pmu_sbi.c:rvpmu_find_ctrs() {
...
	pmu_ctr_list =3D kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
			       GFP_KERNEL);
	if (!pmu_ctr_list)
		return -ENOMEM;

	if (riscv_pmu_cdeleg_available_boot())
		num_deleg_counters =3D rvpmu_deleg_find_ctrs();

	/* This is required for firmware counters even if the above is true */
	if (riscv_pmu_sbi_available_boot())
		num_sbi_counters =3D rvpmu_sbi_find_num_ctrs();

	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV_MA=
X_COUNTERS)
		return -ENOSPC;
...
}

Also, could num_sbi_counters inadvertently capture negative error codes?=20

rvpmu_sbi_find_num_ctrs() returns an int which can be a negative error=20
code. Storing it in the u32 num_sbi_counters implicitly casts=20
it to a very large positive value.=20

This triggers the RISCV_MAX_COUNTERS check and causes the function to abort=
=20
with -ENOSPC, losing the original error.

The caller rvpmu_device_probe() then fails to clean up the leaked globally=
=20
scoped pmu_ctr_list pointer during its error handling:

drivers/perf/riscv_pmu_sbi.c:rvpmu_device_probe() {
...
	num_counters =3D rvpmu_find_ctrs();
	if (num_counters < 0) {
		pr_err("SBI PMU extension doesn't provide any counters\n");
		goto out_free;
	}
...
out_free:
	kfree(pmu);
	return ret;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D16
