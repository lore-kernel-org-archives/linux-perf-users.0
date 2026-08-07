Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AD44A41D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093896; cv=none; b=ROjrubFRMHOt6Cebf6IjNb+7Of+JFZGyXW5DzpRNXjcZ+tz2w4uu6+XZJw+O7KOwwB+/82IKgzqjIO5G6TKokAP7QcCuOdRtWs/8rp3DRaz/DuESGo50nIkJlSyZhRb9gW6SrsNUTFMDutWc1wIj/82B3fQaq7Z9lgSyN6vNk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093896; c=relaxed/simple;
	bh=2NBIqY1w0KzQ4thKM7SKcZBsUYW+6nG3dFm0SwNwIts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=boLCHMt13XR2mjP13HYtzwXvtYXuHne8JJmvqWUxhelB7isDtvurbhjhLK7emM3CBN7PnQU0XzgV39gU69hzr8LuGFIcWOPl7z+DHK8bmLPV3hmD1mIAomJbl7PTmxR4X2Abx70eeicWpK1IPTgXQT252rLiSrW0WWCm9Ag4f/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhOtFccr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhOtFccr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A135B1F000E9;
	Fri,  7 Aug 2026 09:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786093882;
	bh=pcyRv2GUrZiuUpIWT9jGvbHsTZhBbjQlFN0Rr6QSL5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhOtFccrUry6EWQ71UKRwktqk594WcB4Hwkm+NXFAugPjzP+VtnbhXwkLfWGN/bMS
	 4g1oXUV7wlUCEA+ae5ArP9WJ0x56te/nyswJc+dTbUU6BUN6OyB8DZ+4fFfRwZohAU
	 2aerrQJnGejTRnuRui2ZnX1zclCoVZMmZbNiNkA6j52faut1LvEZ+Zcs8AGNF89vHq
	 myTMTWPOkcZ7Sx0KdyYDaO+SKxJSYy/YXE2QHvoLXq9QaA4lzd2yn7Mez1qqfWgLIF
	 USmpCiWuKDhFsdTVescPUCb59O3MBvB1knHOwO8HulECZTWZ3ijffuwHsff1jZjNik
	 dd+zTWrgDV3WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf: RISC-V: store available counter mask as
 bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xixin Liu" <liuxixin@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn>
References: <cover.1786092600.git.liuxixin@kylinos.cn>
 <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:11:21 +0000
Message-Id: <20260807091122.A135B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch fails to fully support matching 64 counters on RV32, as =
it hardcodes `cmask[0]` and `cbase =3D 0` in SBI counter match queries, eff=
ectively ignoring counters 32-63.

Pre-existing issues:
- [High] An out-of-bounds counter base index is passed to `SBI_EXT_PMU_COUN=
TER_START` in the snapshot overflow handler.
- [High] Global `cmask` is not cleared on probe failure, leading to a NULL =
pointer dereference in `riscv_pmu_get_hpm_info()`.
- [High] Incorrect snapshot array indexing and overflow mask shifting for P=
MU counters >=3D 32 on RV32.
--

--- Patch [2]: [PATCH v1 2/2] perf: RISC-V: store available counter mask as=
 bitmap ---
commit 0c40d37d24749711315dcc35e091383a23b8eeb6
Author: Xixin Liu <liuxixin@kylinos.cn>
Subject: perf: RISC-V: store available counter mask as bitmap

The available-counter mask was previously a single unsigned long, which
caused out-of-bounds reads on RV32 when iterating up to RISCV_MAX_COUNTERS.
This commit transitions the mask to use DECLARE_BITMAP and related helpers
to prevent reads past the object and properly stop counters across words.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -364,7 +364,7 @@ static void pmu_sbi_check_event(struct sbi_pmu_event_=
data *edata)
>  	struct sbiret ret;
> =20
>  	ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> -			0, cmask, 0, edata->event_idx, 0, 0);
> +			0, cmask[0], 0, edata->event_idx, 0, 0);

[Severity: High]
Does this code fail to match all 64 counters on RV32?

By hardcoding cmask[0] and a base of 0, it appears to ignore counters 32-63
during the SBI counter match queries.

Should this issue subsequent sbi_ecall queries for cmask[1] with cbase =3D =
32
to ensure the upper half of the counters are checked?

[ ... ]

> @@ -541,7 +541,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *eve=
nt)
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
>  	struct sbiret ret;
>  	int idx;
> -	uint64_t cbase =3D 0, cmask =3D rvpmu->cmask;
> +	uint64_t cbase =3D 0, cmask =3D rvpmu->cmask[0];

[Severity: High]
Does this code also fail to support matching counters >=3D 32 on RV32?

Similar to pmu_sbi_check_event(), initializing cmask to rvpmu->cmask[0] and
using it as the sole mask for the match call will result in -ENOENT for
events that could be satisfied by the upper counters.

[ ... ]

> @@ -1451,7 +1458,7 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	/* cache all the information about counters now */
> -	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
> +	if (pmu_sbi_get_ctrinfo(num_counters, cmask))
>  		goto out_free;

[Severity: High]
This is a pre-existing issue, but does the global cmask get left populated
with stale data on probe failure?

If pmu_sbi_device_probe() fails after pmu_sbi_get_ctrinfo() (for instance,
during IRQ setup), the out_free error path frees and nullifies
pmu_ctr_list:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
    ...
out_free:
    free_percpu(pmu->hw_events);
    kfree(pmu_ctr_list);
    pmu_ctr_list =3D NULL;
    ...
}

However, the global cmask bitmap retains its bits. Later, if KVM calls
riscv_pmu_get_hpm_info(), it will bypass the bitmap_empty() check,
iterate over the stale bits, and dereference the NULL pmu_ctr_list array.

[Severity: High]
This is a pre-existing issue, but can the PMU counters fail to restart
after an overflow when snapshots are enabled?

In pmu_sbi_start_ovf_ctrs_snapshot(), the loop-exhausted idx variable is
used to calculate the base counter index instead of the outer loop
variable i:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_start_ovf_ctrs_snapshot() {
    ...
    for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG) {
        ...
    }
   =20
    sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LONG,
              ...
}

The for_each_set_bit() loop terminates with idx equal to BITS_PER_LONG.
Passing idx * BITS_PER_LONG (e.g., 1024 on RV32) as the counter_idx_base
to SBI_EXT_PMU_COUNTER_START will cause the firmware to reject the
out-of-bounds base index.

[Severity: High]
This is a pre-existing issue, but does this code corrupt snapshot memory
for counters >=3D 32 on RV32?

When stopping hardware counters, the snapshot counter values are read using
relative indices instead of absolute ones:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_stop_hw_ctrs() {
    ...
    for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
        cpu_hw_evt->snapshot_cval_shcopy[i * BITS_PER_LONG + idx] =3D
                    sdata->ctr_values[idx];
    ...
}

Additionally, the absolute 64-bit overflow mask is incorrectly shifted:

    temp_ctr_overflow_mask |=3D sdata->ctr_overflow_mask << (i * BITS_PER_L=
ONG);

For i =3D 1 (counters 32-63), this shifts the valid overflow bits out of
bounds.

Furthermore, in pmu_sbi_start_ovf_ctrs_snapshot(), the snapshot counter
values are written back using relative indices:

    sdata->ctr_values[idx] =3D ...

This overwrites the first 32 counters' values instead of writing to the
counters 32-63 region.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786092600.gi=
t.liuxixin@kylinos.cn?part=3D2
