Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56033AC0D8
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637966; cv=none; b=iYmPE86Cva7u5tF7bF6RO7/+6e979zd+7xqFp27etezB2Nkv52kq+V1rjix4JcLXnyojXZ9xd+zZZp5BgzlAu1tGXeSN8VQniBYCWQ/6V8NhlONx9aucj3RHlnmXwxw8fftd7K9vty+ylec+iEHNRAilSxhnmi/EyhG2UcVcV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637966; c=relaxed/simple;
	bh=uJGKs/rkKK/mAlDktDgHiVK1NiRh7qjBXheoonA4gZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdOU43z0TCUy3unJAd/NPCSAz9e/wJU+D3Nml7oqBotf88KsZS6NCt07Y0dp4Q6mHpl0C1t5B0tspZqb1g0iJdbhqcgYlizFLN1nno86MHBq5xlM0DgGantJgEKRB70LtMkb25xKB9vODaxtCrcbOFGxERZTTq3dDhZlfTwDRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QomEfi/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QomEfi/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025DDC19424;
	Wed,  8 Apr 2026 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637966;
	bh=uJGKs/rkKK/mAlDktDgHiVK1NiRh7qjBXheoonA4gZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QomEfi/DN7kDAz/MGwaguGTSd4HSKNUKYd8FOYxRD5xaLUu7cihTL4AGgM8tN/uqG
	 tN1SNH7UGV6sBJx8tL/0zB6oxp12SqH72vH0Keo9S7Dkdnl9Jf/ecJmEmU4MNo2Ryk
	 u5bdWxOJXlJGhHgp3sDQuFO/EUj+BgJt0ETZ74YtXJMNYMJpy/wQPydK+9fNgfMV0q
	 XzF6j08OilLV4aVsjhPskMAn17gqbNPOU+4brCup/ddToXU0/98bPQcp+lAxI7UMIC
	 c04Pe+vYSkSE8i/g4KSWGmWGQttgTHkiQnCeqaEl+NUBM6EG6fGlPo97LRwCJb/A4o
	 OOH0YVE4vLNew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf/arm-smmuv3: Avoid double-requesting shared
 SMMU MMIO for PMCG
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408-smmu-perf-v1-3-d75dac96e828@nxp.com>
References: <20260408-smmu-perf-v1-3-d75dac96e828@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 08:46:05 +0000
Message-Id: <20260408084606.025DDC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Incorrect error checking for `devm_ioremap()` return value leads t=
o potential NULL pointer dereference.
--

commit 9648b36d883f07ba004ca17984ae1bfebc0a29df
Author: Peng Fan <peng.fan@nxp.com>

perf/arm-smmuv3: Avoid double-requesting shared SMMU MMIO for PMCG

This commit maps the PMCG memory resources directly using devm_ioremap
to avoid double-requesting the SMMU MMIO space that is already requested
by the arm-smmu-v3 driver.

> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 621f02a7f43be..1c9585ef26183 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c

[ ... ]

> @@ -877,7 +877,16 @@ static int smmu_pmu_probe(struct platform_device *pd=
ev)
>  		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE,
>  	};
> =20
> -	smmu_pmu->reg_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, =
&res_0);
> +	res_0 =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_0)
> +		return dev_err_probe(dev, -ENOENT, "missing PMCG page 0 MMIO resource\=
n");
> +
> +	/*
> +	 * PMCG registers might be a sub-region of the parent SMMU MMIO window,
> +	 * which is already requested by the SMMU driver. Do not call
> +	 * devm_ioremap_resource() here to avoid double-requesting the region.
> +	 */
> +	smmu_pmu->reg_base =3D devm_ioremap(dev, res_0->start, resource_size(re=
s_0));
>  	if (IS_ERR(smmu_pmu->reg_base))
>  		return PTR_ERR(smmu_pmu->reg_base);

Since devm_ioremap returns NULL on failure instead of an ERR_PTR, will this
IS_ERR check fail to catch unsuccessful mappings?

If devm_ioremap returns NULL, IS_ERR(NULL) evaluates to false, which would
allow the code to proceed and potentially dereference a NULL pointer shortly
after when reading cfgr.

Would it be better to check for !smmu_pmu->reg_base here and return
-ENOMEM?

> =20
> @@ -885,7 +894,11 @@ static int smmu_pmu_probe(struct platform_device *pd=
ev)
> =20
>  	/* Determine if page 1 is present */
>  	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base =3D devm_platform_ioremap_resource(pdev, 1);
> +		res_1 =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res_1)
> +			return dev_err_probe(dev, -ENOENT, "missing PMCG page 1 MMIO resource=
\n");
> +
> +		smmu_pmu->reloc_base =3D devm_ioremap(dev, res_1->start, resource_size=
(res_1));
>  		if (IS_ERR(smmu_pmu->reloc_base))
>  			return PTR_ERR(smmu_pmu->reloc_base);

This appears to have the same issue. Does this IS_ERR check also need to be
updated to handle a NULL return from devm_ioremap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-smmu-perf-=
v1-0-d75dac96e828@nxp.com?part=3D3
