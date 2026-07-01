Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC83A48F4;
	Wed,  1 Jul 2026 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897650; cv=none; b=klogvj3cX3YI5G9gim1vXPZY/KSqjCKoYWQBYqmmX4LJf+zWu5dOoUqhqzrI3zqZx5HEvsabDUfprs+T3EHkbB3Ce2K03zh2c2bQjTmQCC7lqd4QVLoAdPwjLPQErVY9LyEX2Q/ymUpVPbSFcGFl7jK8/v0dkuAYFtGNw1zWcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897650; c=relaxed/simple;
	bh=PIMoTpWEDv6PtVd6AZbffHeGKRgsNc9MHG0HSKGKeLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hWjYp99zct7FJi4Q9ozepEgOps2kcESB9lc8JiO4mY5I6/C02zX7UuOjc7P7Sjb8od9P5bE1LanMz7pGAIQFn/P/zDdUgzghSgW5mx48vcMV5Yv/v+pU9pX8BLO/uSZU2MjwQJ3tdHHBX02TTTCClSrurfRYXEFvnu2AZYAsMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq1jFYQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq1jFYQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE991F00AC4;
	Wed,  1 Jul 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897649;
	bh=Q25jbUiUkD8jh5m/zMKgF/DrmWCsWp20fD/1JrDao/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wq1jFYQ+ZTutakzyFQODujgJ6PKAPMidQZxYr29gwoJmUo6eaIai5D8Xv0TRCUHKj
	 35P1+OvKVpjBfKzbz4LEicGqwZcYXsJ0sfNDNOi8ACyEzzBRS2gN4yXUS8m5kffCvP
	 F0x+ZTRsVAUihf9rD7Nc7lSbw3wyh9KvlkT0ZLDYSBUkhrauG603cGac8W1DeHGCR+
	 Pq9KTTrAHLkf8VrWxnc2PEZvxmu47DX6l78lw/tJ6uC19bxBN7HDCulhM56kYsFxjv
	 FmLhVSoCQyi3fpGXO9Fb02dQ2b/4AT1A1Jywdn7R5BYpmj3O9TIEkfMNi73shs1GMl
	 3qtAITyfkZvwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:20:48 +0000
Message-Id: <20260701092048.BBE991F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Hardware counter CSR indices and firmware counter SBI logical indi=
ces share the same index namespace, leading to silent overwriting of hardwa=
re counters in `pmu_ctr_list`.
- [High] Bitwise shift overflow on 32-bit architectures when processing PMU=
 firmware counters with indices >=3D 32.
- [Medium] A failure to discover firmware counters unconditionally aborts P=
MU initialization, erroneously discarding successfully delegated hardware c=
ounters.

Pre-existing issues:
- [High] Invalid counter base index passed to `sbi_ecall` in `rvpmu_sbi_sta=
rt_ovf_ctrs_snapshot`.
--

commit 96c77115054b0358f4d8c8c58dd7977dd68ff1d2
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Modify the counter discovery mechanism

This commit modifies the PMU counter discovery mechanism to support a hybrid
scheme where hardware counters use counter delegation and firmware counters
use the SBI PMU extension. It queries the counters info via SBI PMU to
distinguish the firmware counters and track them in separate bitmasks.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 74d9342388212..c20f1e33c65d5 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -868,34 +885,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
>  		return sbi_err_map_linux_errno(ret.error);
>  }
> =20
> -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> +static u32 rvpmu_deleg_find_ctrs(void)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num=
_hw_ctr)
>  {
>  	struct sbiret ret;
> -	int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> +	int i;
>  	union sbi_pmu_ctr_info cinfo;
> =20
> -	for (i =3D 0; i < nctr; i++) {
> +	for (i =3D 0; i < nsbi_ctr; i++) {
>  		ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, =
0, 0, 0);
>  		if (ret.error)
>  			/* The logical counter ids are not expected to be contiguous */
>  			continue;
> =20
>  		cinfo.value =3D ret.value;
> -		if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> -			num_fw_ctr++;
> -		else
> -			num_hw_ctr++;
> -		pmu_ctr_list[i].value =3D cinfo.value;
> +		if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> +			/* Track firmware counters in a different mask */
> +			firmware_cmask |=3D BIT(i);

[Severity: High]
Does this code trigger a bitwise shift out of bounds on 32-bit architecture=
s?

The firmware_cmask variable is an unsigned long, which is 32 bits wide on R=
V32.
Since the SBI PMU specification allows up to 64 counters, and standard firm=
ware
implementations (like OpenSBI) typically assign firmware counters to logical
indices 32 and above, the BIT(i) macro will execute a shift greater than or
equal to the width of the type when i >=3D 32.=20

Will this cause firmware counters to be dropped or corrupted on 32-bit
platforms?

> +			pmu_ctr_list[i].value =3D cinfo.value;

[Severity: High]
Can this overwrite hardware counter entries in the pmu_ctr_list array?

The rvpmu_deleg_find_ctrs() function iterates over hardware counters and ma=
ps
them using their architectural CSR indices (0-31). The rvpmu_sbi_get_ctrinf=
o()
function then maps firmware counters using their SBI logical indices ('i'
from 0 to N-1).

Since the SBI PMU specification does not restrict firmware counters to indi=
ces
>=3D 32, if a platform assigns a firmware counter to a logical index <=3D 3=
1,
wouldn't using 'i' directly here silently overwrite the delegated hardware
counter entry?

> +			*num_fw_ctr =3D *num_fw_ctr + 1;
> +		} else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW &&
> +			   !riscv_pmu_cdeleg_available_boot()) {
> +			*num_hw_ctr =3D *num_hw_ctr + 1;
> +			cmask |=3D BIT(i);
> +			pmu_ctr_list[i].value =3D cinfo.value;
> +		}
>  	}
> =20
>  	return 0;
>  }
[ ... ]
> @@ -1159,16 +1180,48 @@ static void rvpmu_ctr_stop(struct perf_event *eve=
nt, unsigned long flag)
>  	/* TODO: Counter delegation implementation */
>  }
> =20
> -static int rvpmu_find_num_ctrs(void)
> +static int rvpmu_find_ctrs(void)
>  {
> -	return rvpmu_sbi_find_num_ctrs();
> -	/* TODO: Counter delegation implementation */
> -}
> +	int num_sbi_counters =3D 0;
> +	u32 num_deleg_counters =3D 0;
> +	u32 num_hw_ctr =3D 0, num_fw_ctr =3D 0, num_ctr =3D 0;
> +	/*
> +	 * We don't know how many firmware counters are available. Just allocate
> +	 * for maximum counters the driver can support. The default is 64 anywa=
ys.
> +	 */
> +	pmu_ctr_list =3D kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
> +			       GFP_KERNEL);
> +	if (!pmu_ctr_list)
> +		return -ENOMEM;
> =20
> -static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
> -{
> -	return rvpmu_sbi_get_ctrinfo(nctr, mask);
> -	/* TODO: Counter delegation implementation */
> +	if (riscv_pmu_cdeleg_available_boot())
> +		num_deleg_counters =3D rvpmu_deleg_find_ctrs();
> +
> +	/* This is required for firmware counters even if the above is true */
> +	if (riscv_pmu_sbi_available_boot()) {
> +		num_sbi_counters =3D rvpmu_sbi_find_num_ctrs();
> +		if (num_sbi_counters < 0) {
> +			kfree(pmu_ctr_list);
> +			pmu_ctr_list =3D NULL;
> +			return num_sbi_counters;

[Severity: Medium]
Should this gracefully continue with the available delegated hardware count=
ers
instead of aborting PMU initialization?

If counter delegation for hardware performance counters succeeds, but the
optional firmware extension returns an error via rvpmu_sbi_find_num_ctrs(),
this error path frees the entire pmu_ctr_list array and returns an error.

This unnecessarily disables the system's hardware performance monitoring
instead of simply ignoring the broken firmware counters.

> +		}
> +		if (num_sbi_counters > RISCV_MAX_COUNTERS)
> +			num_sbi_counters =3D RISCV_MAX_COUNTERS;
> +	}
[ ... ]

[Severity: High]
This is a pre-existing issue, but there appears to be a logic error in
rvpmu_sbi_start_ovf_ctrs_snapshot() when passing the counter base index to
the firmware:

drivers/perf/riscv_pmu_sbi.c:rvpmu_sbi_start_ovf_ctrs_snapshot() {
    ...
    for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
        ...
        for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i], BITS_PER_LONG)
            sdata->ctr_values[idx] =3D
                cpu_hw_evt->snapshot_cval_shcopy[idx + i * BITS_PER_LONG];
       =20
        /* Start all the counters in a single shot */
        sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS_PER_LO=
NG,
                  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
    ...
}

Because idx is the exhausted iterator of for_each_set_bit(), its value will=
 be
BITS_PER_LONG. When multiplied by BITS_PER_LONG, the base index evaluates to
an invalid out-of-bounds value (e.g., 4096 on RV64).=20

Should this pass i * BITS_PER_LONG instead of idx * BITS_PER_LONG to correc=
tly
start the chunk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D12
