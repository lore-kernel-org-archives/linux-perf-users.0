Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CE39CCF9
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284859; cv=none; b=HDsP3WIjS+Nd3hetE5y+OYQwJerKG8LlCoAL1ajjd8DBpUXCmPGHpL+1FY80X+l7h5L93lgSX12rv7LP1ka8OR4pbG2JCDWEya7SbwEewOXwZTSSNHvqrqSXvSfZgL7AODfJbA5Lb88lTwg2xVjPG0L9nfAgb5ZQLhFKa5lP/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284859; c=relaxed/simple;
	bh=m5OJ2yFx8XSdVISryowgZmGlv98eyyHSVVqMSgLXZ3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8fmIB3pAGrgzTzQpLeJr1uKIZDX0juP8D04BsS/sBwLwAH/jPVO3OxHMDsghBOcyd9pzIAEJLwU52v+5AsO4U+qsMhY7NNgXp0ANYXefc6QfeFLsfp+huxXyBkqgdwlweYQRCHryxm2sGim/38UmyIMPwBa1IE8TZLRSbdYySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JswF4DS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JswF4DS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A5C1F000E9;
	Fri, 17 Jul 2026 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784284858;
	bh=5XPTYC6qSaDIvDwrcOEPBZOVbVZO2z2G4/CQakJOgJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JswF4DS7J7U+3BVfeHmA/L24ym/3wTzSAUXAr87TLXLbOzXRLG/PMq8ufBl7Eh/+M
	 F9DiTCe68yORyD2VnWCFavDw1qg8xL1V1FEvTsywhugxqiME112Wx0TrTnB1B5+EZM
	 kPsLiK6KN3EK4ZULLGK17FAcYEqdK/DJWXVfneCiks5mfAXJqir1CcHtEGRS/uPPLS
	 3Po1VwyQLxWUTKicbRhFydi0504ikvXSLd0yLn//4+aA1w9H3nS50mZNW0YdQr1JgU
	 Uizcz5FXEnPgPek3G7kTOdaxqV/8c7hS8VlCf/aQN5PdJbcB4U8ha5kcwL44GEqyqq
	 JMhVv6lIRp0FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drivers/perf: hisi: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717103123.34887-4-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:40:57 +0000
Message-Id: <20260717104057.C8A5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array access / buffer overflow in hisi_l3c_pmu_init_=
ext() due to missing upper bound check on device tree IRQ count.
--

--- Patch [3]: [PATCH 3/3] drivers/perf: hisi: Remove redundant dev_err()/d=
ev_err_probe() ---
commit 439e35f073703c68b0687dec637faec43876da5e
Author: Pan Chuang <panchuang@vivo.com>

drivers/perf: hisi: Remove redundant dev_err()/dev_err_probe()

This commit removes redundant driver-specific error logs when calling
devm_request_irq(). The core framework automatically handles the error
reporting on failure.

> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/=
hisilicon/hisi_uncore_l3c_pmu.c
> index f963e4f9e5527..56a88fb0d3c2c 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -604,8 +604,7 @@ static int hisi_l3c_pmu_init_ext(struct hisi_pmu *l3c=
_pmu, struct platform_devic
>  				       IRQF_NOBALANCING | IRQF_NO_THREAD,
>  				       irqname, l3c_pmu);
>  		if (ret < 0)
> -			return dev_err_probe(&pdev->dev, ret,
> -				"Fail to request EXT IRQ: %d.\n", irq);
> +			return ret;
> =20
>  		hisi_l3c_pmu->ext_irq[i] =3D irq;

[Severity: High]
This is a pre-existing issue, but does this loop risk writing out of bounds
if the device tree specifies more IRQs than expected?

In hisi_l3c_pmu_init_ext(), the total number of IRQs is fetched with
platform_irq_count(pdev). The code enforces a lower bound but misses an
upper bound check:

    ext_num =3D platform_irq_count(pdev);
    if (ext_num < L3C_MAX_EXT)
        return -ENODEV;
    hisi_l3c_pmu->ext_num =3D ext_num - 1;

If a misconfigured device tree provides more IRQs than expected,
hisi_l3c_pmu->ext_num can exceed the fixed size of the ext_base and ext_irq
arrays, which are bound by L3C_MAX_EXT.

The loop iterating up to hisi_l3c_pmu->ext_num would then write out of
bounds into the ext_irq array at the end of this block.

Could we add an upper bound check for ext_num to prevent memory corruption
if too many IRQs are present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717103123.3488=
7-1-panchuang@vivo.com?part=3D3
