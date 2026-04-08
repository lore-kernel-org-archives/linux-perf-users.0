Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F243A6F06
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637545; cv=none; b=dpk8l+XJaTHO/dhER4xQXdu3SZXRs9zL74vqaHGZajzpZhNlArucYjalF/D3Ku/FLbcsT+kC0miIbBwvd/ATbLM2595xv6LbPX5VSK0iXDJWPt5Xjimp99XaNhs0RkoLVgJ3D2y8r79/YcZj7ytNIs7WRTGiKqwXJWusPo8MF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637545; c=relaxed/simple;
	bh=JaGgiV48m2Rri2NEtZhiz1RJq9PrYaz3g4r/vl6qR4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRwjnWAqPJqbp9MIauowkGfwHB0a+HMjQuBqmxGxsoZ4aT8dSOB84VA9DVaXdbf3qYfDaYrYH3bWU3ueEwUzlRPTx+fT4JNOfdsi+tnF8AUNzcdlaUnQGbm0BwnDbFAhg6G4sy108d2Hs6QAMm9g8TLJfl+J4JL1Mz2K1ujAHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXUC49aq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXUC49aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147DFC19424;
	Wed,  8 Apr 2026 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637545;
	bh=JaGgiV48m2Rri2NEtZhiz1RJq9PrYaz3g4r/vl6qR4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tXUC49aqRgSpHFS73sU1m7L1vcAQmIvS10fdCdr7dQyNjzIz7FGvU5qiX2nrbcLKb
	 zb1syHgOU5tgLBTe6fhRS7z0p+PptpzBaorkbg3f+LGQJ246Z9LQ0NDro8bi7C6iJs
	 Gqnkb9l7JDye3HSHuSg9lp3J8omJgh6WS4x1DZkkyAZc2hW8LvOxpDI4b3djF6BV0J
	 RhxY69pO2dCUShW0J58OYeXd61RJKAtU2rSonLxvA/Xmh1dKBCGMcbD2bP/pHRMjvy
	 H5JjLonHLjnoFdYNO22mgxTRnSahsfp4ov5B65nzkqflqVQH68TF2XvyoruoFmXWJA
	 Km+sJmWN3AM4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Populate PMU child devices from
 Devicetree
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408-smmu-perf-v1-2-d75dac96e828@nxp.com>
References: <20260408-smmu-perf-v1-2-d75dac96e828@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 08:39:04 +0000
Message-Id: <20260408083905.147DFC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Premature population of child devices before the parent SMMU is in=
itialized.
--

commit b6188437ce3fc797b1e6f4d35f8ab59a8362fd98
Author: Peng Fan <peng.fan@nxp.com>

iommu/arm-smmu-v3: Populate PMU child devices from Devicetree

This commit populates optional child devices of the Arm SMMU v3,
such as the PMCG-based PMU, by instantiating them during the device
tree probe phase.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5363,6 +5363,9 @@ static int arm_smmu_device_dt_probe(struct platform=
_device *pdev,
>  	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
>  		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> =20
> +	if (!ret)
> +		return devm_of_platform_populate(dev);

Will calling devm_of_platform_populate() this early cause the child
platform devices to be probed before the parent SMMU is fully
initialized?

If a child device depends on the parent being fully set up, might it
fail since arm_smmu_device_dt_probe() is called early in the parent's
probe sequence, before IO memory is mapped, hardware is initialized, or
platform_set_drvdata() is called?

Additionally, if a subsequent step in the parent's probe returns
-EPROBE_DEFER, will this result in unnecessary probing and immediate
devres teardown of the child devices?

Would it be safer to defer populating the child devices until the end
of arm_smmu_device_probe() after the parent SMMU has successfully
initialized?

> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408-smmu-perf-=
v1-0-d75dac96e828@nxp.com?part=3D2
