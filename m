Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE3CA4E;
	Tue,  9 Jun 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986811; cv=none; b=jOQ9enk/go2l8ahW1Yey7QGQGmLrM1PDCB8UCGZO6+SOi2YBOyyvDk/JX5EWKxQNrKmYG4iBd/rBrQ9DTC2AuPgO6HrFCgO8EurpWCjsSAcNJlowDji+6O0nPsJn7L+fWkI32q45l/+FP8KHMjosDkSmyqaTf0Tbnz306jAzvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986811; c=relaxed/simple;
	bh=UA9drqngoE5zlMZbpvc86sDOGhLcAAwtPIGOQT10MBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QTTGSEG20LGi7wnj7JlCwi5S+pU27PCvY6GD6Rb0uSY2oqJNCZxxAjMad7NhYUK5m1o7NHtuhui3FbsiPmJuFIveZ05F3nm26HqN0l1hMtQZlvCwWJFNWG0U+gTvmeS5wTDefmGJKSGfa8fLON+TZdE5rufZSh4GgqY6BJHQC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2imHSZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2imHSZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D801F00893;
	Tue,  9 Jun 2026 06:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986809;
	bh=zhfXWCTQUZJATLR2jF2Bw6AjpiYZwt1mtklk/4JJLPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2imHSZM/539inWdTMF3LL3jQF4ooRC6cjK0jMW/jKRXk2S4DEsa7WhNQ00/lHDRq
	 R8LCpjQhyAcx/IpPEKm5DeBKkHP7RQQn2+K46FH4EMQxpGrYcKfHs0xjeHcMG/SSFR
	 VlQTdJ04lrkZY48DPGA/CwswgWopjlDNa4rYSXw7L84a0JT722nq6JAe+sDmSqmuxx
	 G68jvszTG17q7oPLsWltRzKRoqHIM2Ml0DqbQKgCqOi0X49iqV7WucWXv+rtrGDJdV
	 Xhiz32lrbA1ck+mLG8TaYx0QTII+HcPiSjwymomoXAjjl8OBGJTSQx7oAH296thFCM
	 xFdhOAXTyE2Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/21] RISC-V: perf: Skip PMU SBI extension when not
 implemented
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-14-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-14-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:33:28 +0000
Message-Id: <20260609063329.66D801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing perf_pmu_unregister() on error paths leads to Use-Afte=
r-Free of the pmu struct.
- [High] Unconditional cpuhp_state_remove_instance() on an uninitialized hl=
ist_node causes a kernel panic.
--

commit bd51c5655be0902a2fc1fd90b8d692c299e7265b
Author: Charlie Jenkins <charlie@rivosinc.com>

RISC-V: perf: Skip PMU SBI extension when not implemented

When the PMU SBI extension is not implemented, sbi_v2_available should
not be set to true. The SBI implementation for counter config matching
and firmware counter read  should also be skipped when the SBI extension
is not implemented.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 1f16df9d0dd00..5bfcd3821f572 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -2045,12 +2052,13 @@ static int __init rvpmu_devinit(void)
>  	int ret;
>  	struct platform_device *pdev;
> =20
> -	if (sbi_spec_version >=3D sbi_mk_version(0, 3) &&
> -	    sbi_probe_extension(SBI_EXT_PMU))
> -		static_branch_enable(&riscv_pmu_sbi_available);
> +	if (sbi_probe_extension(SBI_EXT_PMU)) {
> +		if (sbi_spec_version >=3D sbi_mk_version(0, 3))
> +			static_branch_enable(&riscv_pmu_sbi_available);
> +		if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> +			sbi_v2_available =3D true;
> +	}
> =20
> -	if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> -		sbi_v2_available =3D true;
>  	/*
>  	 * We need all three extensions to be present to access the counters
>  	 * in S-mode via Supervisor Counter delegation.

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free in t=
he
error handling path of rvpmu_device_probe() when allocating or registering
fails after perf_pmu_register() succeeds.

If an error occurs, such as pmu_sbi_snapshot_alloc() failing, the code jumps
to out_unregister:

out_unregister:
	riscv_pmu_destroy(pmu);

out_free:
	kfree(pmu);
	return ret;

However, neither the error path nor riscv_pmu_destroy() calls
perf_pmu_unregister(&pmu->pmu).

This leaves the PMU registered in the perf core subsystem while its backing
memory is freed via kfree(). Any subsequent access to the PMU could result
in a use-after-free.

Should perf_pmu_unregister() be called during teardown to avoid memory
corruption?

[Severity: High]
This is a pre-existing issue, but the error teardown path in
rvpmu_device_probe() seems to have a bug that could trigger a kernel panic.

If rvpmu_device_probe() fails before successfully calling
cpuhp_state_add_instance(), it jumps to out_unregister and calls
riscv_pmu_destroy(pmu).

Inside riscv_pmu_destroy(), it unconditionally removes the hotplug instance:

static void riscv_pmu_destroy(struct riscv_pmu *pmu)
{
	...
	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
}

Because the pmu struct is allocated with kzalloc() and the node hasn't been
added to the hotplug list yet, its hlist_node is zero-initialized.

When hlist_del() is called internally by cpuhp_state_remove_instance(), it
attempts to dereference node->pprev (which is NULL), causing a NULL pointer
dereference.

Would it be better to check if the node is actually hashed before attempting
to remove the hotplug instance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D14
