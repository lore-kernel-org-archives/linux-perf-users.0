Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AE39022A;
	Mon, 22 Jun 2026 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116692; cv=none; b=CPSnYxNszMx0IQrwZ426ANYjRWP93aDvE+DhCt8Be9lnshuLcH9JmnpMfJnXN3v/HXIMrAt9vjhM2DHF7EbZgNB9J+EPJMNPIqv9uB6QdmIlT8aXu5krZZXWeANC0wi5T40T3eBievRnMx2bGR9r04t80ilda82F9Qw4tJm9XfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116692; c=relaxed/simple;
	bh=3F3SzcmX5K7tfwdbobEWoIO3z8bnGQ9unBaBZ9hAYME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dqyXdZxmRyqLfvWUHyBz6qorwB9u7+pXSzWXQjpNZPJR2F42awX/6CjBgV8mABVs1Mx/sO8sSzB759xa/QkZHFzXByxC0PhiQ2TheoiOcna18VXfKPlvl2g3tba2OR08nMCkSneCUxBqOJtdgIg9yreLVff3BKMC/XxbgJbs5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFBiyeeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFBiyeeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC51F000E9;
	Mon, 22 Jun 2026 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116688;
	bh=9g9LmK/2gQjWHmu1Ix4POCgGHt3oEHeL5Rsd484EacY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AFBiyeePK5xBrviQXAEW/H7rjXPUVUvpzT4LE8hdpmntishQeK4494XrTFDsM31u5
	 fb7NlIRKkqxXu43fQ9hTijGYXhowQPmW0Embhiu44GkaNfyRCO3vEAm1OKyZYRMEfY
	 C05Og02JQuTiKcCtR7iERvxqFQjdIw6YoDV7EFPj3gfz95ct5VMhOP696c3TxoJEKn
	 ARA/GR3TABEh0Dwj1EsukF8fyXhgd1LHCoz9eyC3GTZ14ZSOWBGfRSH0OR6rgwtMlw
	 z/yAxB76BWc/VdNbCBn3m2dY/OOBK5GnI998dsRXfgoabhRMLSDu6XfqeMd96xaCFS
	 zJQdZwTZn8zqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260622-counter_delegation-v7-12-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-12-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:24:47 +0000
Message-Id: <20260622082447.D0DC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Hardware counter physical indices and SBI logical counter indices =
for firmware counters can overlap, causing array overwrites and state clobb=
ering in `pmu_ctr_list` and the per-CPU `events` array.
- [Medium] Firmware counters are not stopped in `rvpmu_sbi_stop_all()` when=
 counter delegation is disabled, leaving them running unexpectedly.

Pre-existing issues:
- [High] `cmask` and `firmware_cmask` are defined as `unsigned long` and ac=
cessed via `BIT(i)` and `for_each_set_bit()`, causing shift overflow and ou=
t-of-bounds memory reads on 32-bit architectures.
- [High] Missing `.remove` hook combined with global `pmu_ctr_list` overwri=
te causes a memory leak and a subsequent NULL pointer dereference on re-pro=
be failure.
--

commit 98634f15c972a5ad2282dff7c8f2da3bfc47efa8
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Modify the counter discovery mechanism

If both counter delegation and SBI PMU are present, counter delegation
is used for hardware counters while the SBI PMU is used for firmware
counters. The driver is updated to probe via SBI PMU to distinguish
the firmware counters and cache the discovery info.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 80c7249ee1662..d44f47613aa1a 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -101,6 +116,8 @@ static unsigned int riscv_pmu_irq;
> =20
>  /* Cache the available counters in a bitmask */
>  static unsigned long cmask;
> +/* Cache the available firmware counters in another bitmask */
> +static unsigned long firmware_cmask;

[Severity: High]
This is a pre-existing issue, but on 32-bit architectures (RV32), unsigned
long is 32 bits wide, while RISCV_MAX_COUNTERS is 64.

Does this cause shift overflows when accessed via BIT(i) where i can reach
up to 63?

Additionally, does using for_each_set_bit() with this 32-bit mask cause
out-of-bounds memory reads, as the macro expects an array large enough for
64 bits?

[ ... ]
> @@ -868,34 +885,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
[ ... ]
> -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> +static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num=
_hw_ctr)
>  {
[ ... ]
> -	for (i =3D 0; i < nctr; i++) {
> +	for (i =3D 0; i < nsbi_ctr; i++) {
>  		ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, =
0, 0, 0);
>  		if (ret.error)
>  			/* The logical counter ids are not expected to be contiguous */
>  			continue;
> =20
> -		*mask |=3D BIT(i);
> -
>  		cinfo.value =3D ret.value;
> -		if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> -			num_fw_ctr++;
> -		else
> -			num_hw_ctr++;
> -		pmu_ctr_list[i].value =3D cinfo.value;
> +		if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> +			/* Track firmware counters in a different mask */
> +			firmware_cmask |=3D BIT(i);
> +			pmu_ctr_list[i].value =3D cinfo.value;

[Severity: High]
Can the hardware counter physical indices and the SBI logical counter
indices overlap, causing array overwrites in pmu_ctr_list?

When both counter delegation and the SBI PMU are available, pmu_ctr_list
is first populated using hardware physical CSR indices (0-31) in
rvpmu_deleg_find_ctrs().

Then, rvpmu_sbi_get_ctrinfo() populates firmware counters using the SBI
logical index i. Because the SBI specification allows logical indices to
start at 0, an SBI implementation might assign logical indices to firmware
counters that overlap with the physical CSR indices.

Could this silently overwrite the hardware counter definitions in
pmu_ctr_list[i], and later corrupt the active cpuc->events[idx] array when
both types of counters share overlapping indices?

[Severity: Medium]
Does splitting firmware counters into firmware_cmask and intentionally
excluding them from cmask leave firmware counters running unexpectedly?

In rvpmu_sbi_stop_all(), the code only stops counters present in pmu->cmask:

static inline void rvpmu_sbi_stop_all(struct riscv_pmu *pmu)
{
	...
	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
}

When counter delegation is disabled, the fallback path calls
rvpmu_sbi_stop_all(pmu), which now exclusively stops hardware counters.

Could this leave firmware counters running across CPU hotplug and PMU
initialization, potentially leading to stale counts and unexpected overflow=
s?

> +			*num_fw_ctr =3D *num_fw_ctr + 1;
> +		} else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW &&
> +			   !riscv_pmu_cdeleg_available_boot()) {
> +			*num_hw_ctr =3D *num_hw_ctr + 1;
> +			cmask |=3D BIT(i);
> +			pmu_ctr_list[i].value =3D cinfo.value;
> +		}
>  	}
[ ... ]
> @@ -1159,16 +1180,48 @@ static void rvpmu_ctr_stop(struct perf_event *eve=
nt, unsigned long flag)
[ ... ]
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

[Severity: High]
This is a pre-existing issue, but does missing a .remove hook combined with
this global pmu_ctr_list overwrite cause a memory leak and subsequent NULL
pointer dereference on re-probe failure?

The platform driver lacks a .remove callback and does not set
suppress_bind_attrs, meaning it can be unbound via sysfs, leaving the PMU
registered and active.

If the driver is rebound, rvpmu_device_probe() executes again and calls
rvpmu_find_ctrs(), which unconditionally allocates pmu_ctr_list via kcalloc,
overwriting the global pointer and leaking the original memory.

When perf_pmu_register() then fails because the PMU is already registered,
the error path in rvpmu_device_probe() calls kfree(pmu_ctr_list) and sets it
to NULL.

Could the still-active PMU from the first probe then dereference this NULL
pointer during any subsequent perf event operations?

> +	if (!pmu_ctr_list)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D12
