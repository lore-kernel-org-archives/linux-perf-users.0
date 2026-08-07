Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08273B8409;
	Fri,  7 Aug 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091368; cv=none; b=RjMcxt4dE1WxvPu2xNx9WiTfW3510GQ8xMg45leqhpX19zxWcTWe42jJwsRXJGfRT3WrxMN+hiEwPnkEdFr5fBGmuyq/8jetB25JhXKrnB8MyTSOMqhp2t9Vhgw75yWAWIU2mz0lnuX58jlLlRT5X9XUm6ZljCasuHYyVtD0YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091368; c=relaxed/simple;
	bh=al7/BrkIX+fnqNpK0guaHsoBLMtH/Vno/n5ykt3Z9H4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ivjm/rmZf5pJFS1NEAMRLgjBbxT93YU9kMJs/3kcOcAxGn9uGsRJeuznmQ9a/M9cbujWOHqWpKN4r0KolO1wfZ3Q8NeYQR66d8A8vLf5VTYAHd/cOTkF8tLbZKSIq7iGv375pCtSbJlbtOK/K1AUYBVxnvSNypfK5ClEVqjlObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVWwEPEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVWwEPEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43111F000E9;
	Fri,  7 Aug 2026 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091366;
	bh=YeTTA6LTHPBfrtURtIisQSla9ebz3hqjJUE80/K5BHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVWwEPEjuHHQMFdGNlQx7/BKIBONsGjB8oHozi5He27nlXfsbxQ1/btjA1yWK3mKr
	 Y/At4xZKjOLJklveBFo4NYQuzr2cvrriE9GTJkpIvIhWl0OzHrKPEd/aPHy32N3x9t
	 fsL1Arwq2rOAd++Jgkax4yiTlElVb1ojKXDf6C00lbY8dvex5PylQ3JOHhRaDKyccc
	 Sa7GZRaptFH/d04JB/ZWBuOGeQO/XKejKiPKj2PFRqcTL1Frw7F6RfH95Kg+xeLDp5
	 RAcrVbSpQoUpfdknx520EgJtzhlvG8O3qyQ+lpWE+YwJwL8L3Jk+tNuuEmIn6Fo3dj
	 rr7dvcjjgJ+cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/20] RISC-V: perf: Modify the counter discovery
 mechanism
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807-counter_delegation-v9-12-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-12-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:29:25 +0000
Message-Id: <20260807082925.D43111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Firmware PMU counters are completely disabled due to being omitted=
 from the PMU's main counter mask.
- [High] Using 32-bit `unsigned long` bitmasks with `BIT(i)` for up to 64 c=
ounters causes false ID collisions on 32-bit RISC-V platforms.
- [High] Counter delegation discovery is a stub, causing the driver to disa=
ble all hardware counters on supported systems and incorrectly use SBI for =
verification.
- [High] Memory leak and fatal UAF/NULL-dereference on platform driver re-p=
robe due to freed global pointer.
--

--- Patch [12]: [PATCH v9 12/20] RISC-V: perf: Modify the counter discovery=
 mechanism ---
commit e2768c5a0a20d7c61d402570f684ea95ebbdf2e6
Author: Atish Patra <atishp@rivosinc.com>

    RISC-V: perf: Modify the counter discovery mechanism

This commit modifies the counter discovery mechanism to accommodate hybrid
PMU schemes where counter delegation is used for hardware counters and SBI
PMU is used for firmware counters. It tracks firmware counters in a
separate bitmask and updates the informational logging to reflect the
underlying interfaces.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a8a197d341c3c..1a14300599096 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -867,34 +884,44 @@ static int rvpmu_sbi_find_num_ctrs(void)
>  		return sbi_err_map_linux_errno(ret.error);
>  }
> =20
> -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> +static u32 rvpmu_deleg_find_ctrs(void)
> +{
> +	/* TODO */
> +	return 0;
> +}

[Severity: High]
Does returning 0 from this stub cause the driver to disable all hardware
counters on systems where counter delegation is available?

When counter delegation is available, this stub returns 0 delegated
hardware counters, but the code in rvpmu_sbi_get_ctrinfo() also explicitly
ignores the SBI fallback for hardware counters:

    } else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW &&
               !riscv_pmu_cdeleg_available_boot()) {

Will this result in 0 hardware counters being registered and all standard
hardware events being marked as unsupported when they are checked against
the empty mask?

> +
> +static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num=
_hw_ctr)
>  {
>  	struct sbiret ret;
> -	int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> +	int i;
>  	union sbi_pmu_ctr_info cinfo;
> =20
> -	pmu_ctr_list =3D kzalloc_objs(*pmu_ctr_list, nctr);
> -	if (!pmu_ctr_list)
> -		return -ENOMEM;
> -
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
> +			/* FW counters use SBI logical ids; skip any that collide */
> +			if (cmask & BIT(i)) {

[Severity: High]
Could this bitwise check cause false ID collisions on 32-bit RISC-V platfor=
ms?

Since cmask is an unsigned long, on RV32 it is 32 bits wide. RISC-V supports
up to 64 PMU counters. When processing counters >=3D 32, BIT(i) will wrap a=
nd
alias to BIT(i % 32), which could incorrectly trigger this warning and drop
valid firmware counters.

> +				pr_warn_once("SBI firmware counter %d overlaps a delegated hardware =
counter, ignoring it\n",
> +					     i);
> +				continue;
> +			}
> +			/* Track firmware counters in a different mask */
> +			firmware_cmask |=3D BIT(i);
> +			pmu_ctr_list[i].value =3D cinfo.value;
> +			*num_fw_ctr =3D *num_fw_ctr + 1;
> +		} else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_HW &&
> +			   !riscv_pmu_cdeleg_available_boot()) {
> +			*num_hw_ctr =3D *num_hw_ctr + 1;
> +			cmask |=3D BIT(i);

[Severity: High]
Are firmware PMU counters inadvertently disabled by tracking them separately
from the main counter mask?

Here firmware_cmask tracks the firmware counters, but later in
rvpmu_device_probe(), the driver initializes pmu->cmask strictly using
cmask:

    pmu->cmask =3D cmask;

When a firmware event is requested, rvpmu_sbi_ctr_get_idx() validates it
against the main mask:

    if (!test_bit(idx, &rvpmu->cmask) || !pmu_ctr_list[idx].value)
        return -ENOENT;

Will this cause the validation to unconditionally fail for all firmware
counters?

> +			pmu_ctr_list[i].value =3D cinfo.value;
> +		}
>  	}

[ ... ]

> @@ -1158,16 +1185,54 @@ static void rvpmu_ctr_stop(struct perf_event *eve=
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

[Severity: High]
Does this allocation leak memory and potentially cause a fatal crash if the
driver is re-probed?

If a user unbinds and rebinds the driver via sysfs, this probe will
unconditionally allocate pmu_ctr_list without cleaning up the previous
allocation, leaking the memory.

Then, when perf_pmu_register() fails because the PMU is already registered,
the error path in rvpmu_device_probe() will free the pointer:

    out_free:
        free_percpu(pmu->hw_events);
        kfree(pmu_ctr_list);
        pmu_ctr_list =3D NULL;

Since the original PMU remains active in the subsystem, would any
subsequent perf event operation dereference this freed and NULLed
pmu_ctr_list pointer?

> +	if (!pmu_ctr_list)
> +		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D12
