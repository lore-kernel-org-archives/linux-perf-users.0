Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C03CA4A8;
	Tue,  9 Jun 2026 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985873; cv=none; b=WR3GmSvdb4BJ68ZURC5oXYAwYlFTMDbA53BlGaa/LvbGzwmfyPnNnK6P712yxqR74vNp7neR7bl0B5OiFzpk9MpJmB0GKgYiGLGt1Ko+t82x0w3VqtTaaU8pch6yBkMWuKjMwdH0WzVdpnc1ylObivjcwiDgkne3GqbeIRHB9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985873; c=relaxed/simple;
	bh=b2awAK4L1J5b23K82t3XQ/wBw6XhNoGMmOvKa4FjCHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzVLAVDlFKhOKaky8iRdaLtRMEazR7tUsN9qnYTbNYIPNgNvozUagZMOxaWpW3x13Sx/sf7Zeb70B88yAe8M7ypa4HwpNfdfXxE1bAoTAwgr95myv2Z1xwjjtWGYthnMMAx1130eMH/jvHBSCpMn5YFdklr5HhFXwOC4Ea1W6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSUNmk4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSUNmk4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD71F00898;
	Tue,  9 Jun 2026 06:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985871;
	bh=N3bFA1mF31x3DcP7SvJ+WxuNgTJxh909rdMXGS64b+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSUNmk4K5LRI9evFjEaSoXv4eBBRi7vvGrsnC3ehWriFRq8OknPCw9lD0UvWzL31c
	 O3AfvPuPDt34xjZBoAJ84Swt4QdvGIcVELx2eIavzajmokgdCdllNU7b+15GWpT0vn
	 08XDKflX0eopC7DJU+L38hF+ckluvIozYNWX9Y+gCr2HP4euySlFv/HnP9pv1DfFwP
	 ifdBD0xzcNZW+NsFyw6ocVLl4xXxBEyqkkYTD/ImbLCO7qCHUf05/hVF8MpePWMGqJ
	 hBzXiqCPXxD9Oe5dgOKz2GJCjjfaQoQpYfGSYT4o5caeP1uZ+YGxfso/yzdLknfAzT
	 8v7oPdn05QcfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/21] RISC-V: perf: Modify the counter discovery
 mechanism
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-11-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-11-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:17:50 +0000
Message-Id: <20260609061751.59CD71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Negative error codes returned by SBI are improperly cast to an uns=
igned integer, and systems with >64 counters are incorrectly aborted instea=
d of clamped.
--

commit ea0f7376968d4f5943d9d279886b0b59e6dfd41c
Author: Atish Patra <atishp@rivosinc.com>
Subject: RISC-V: perf: Modify the counter discovery mechanism

This commit modifies the PMU counter discovery mechanism to use a hybrid
scheme. It utilizes counter delegation for hardware PMU counters while fall=
ing
back to the SBI PMU for firmware counters, and updates logging appropriatel=
y.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7f21c16003f04..57ab15beab3e1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1159,16 +1180,42 @@ static void rvpmu_ctr_stop(struct perf_event *eve=
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
> +	u32 num_sbi_counters =3D 0, num_deleg_counters =3D 0;
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
> +	if (riscv_pmu_sbi_available_boot())
> +		num_sbi_counters =3D rvpmu_sbi_find_num_ctrs();
> +
> +	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV=
_MAX_COUNTERS)
> +		return -ENOSPC;

[Severity: High]
Does this code inadvertently convert negative error codes from
rvpmu_sbi_find_num_ctrs() into large unsigned values?

Since num_sbi_counters is defined as a u32, if rvpmu_sbi_find_num_ctrs()
returns an error code like -EOPNOTSUPP, it will wrap to a large positive
integer, instantly satisfying the > RISCV_MAX_COUNTERS condition. This seems
to mask the original error code.

If the > RISCV_MAX_COUNTERS condition is met, the function returns -ENOSPC
early. Can this leak the pmu_ctr_list allocated via kcalloc() just above,
since there is no free before the return?

Additionally, could this introduce a regression for platforms legitimately
exposing more than 64 counters? Previously, the driver appeared to safely
clamp the usable count to 64 and continue, whereas this new logic seems to
abort the driver probe entirely.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D11
