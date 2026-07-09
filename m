Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B0385D8E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608584; cv=none; b=Rss8f893HMS9FUSen67gaZ1yC50cpI45eH9lVFRs1VqaznI0fh0c4cb8es5JapYBoNBpFC8g1XR5RBOrqp92Q4lK+PWumIYepgqGfIE3p1ALXk8JIrUg8yYQIh90xHGduq7W9YbffToLk1vnz34HGXPWrp0Oj+CdmGwfeaEqlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608584; c=relaxed/simple;
	bh=9miwk71wOBgFaBGGvU7XiTnEGd5hEsj9ie2dUSuaFdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+g+hvKO8gWwtFVI6m7H1yhAoHs/0jhtj407SPZgVBXgFjZQfp7M4s9n5GLh/0WuaAJKcglkujdRZJqN2p33+exENpmpplllbAmHTtJRBM2J5oud1uHhXM5UUvld3mJydi4RY99XdJP6Y4OoPsd0bxBJyfkgQH7LuuGG3lg37ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFFKg9Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFFKg9Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11391F000E9;
	Thu,  9 Jul 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608582;
	bh=DJ9VXD6hzdYrA78pjcAewLty683Smg6xTnzMD2kSt1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFFKg9Gh2rrCjCT5/5wtKi2IwX9ev1nj5ZCX2VDqHTDMOMkcQfbp03U2MhxXBO/AR
	 z9WpPMgunZkovYLuTkJxLKVMQ88P0nNAuoPOh04FySq5Qvm8lf/43TC6pyHxxnirzO
	 7Fej4rOm4P7c/mLOOleM++mS1+kBEd+5KoQ+Ol5cAEcdy0PMySdsPY6STpUlty1Ok6
	 vaItaAjzdvYNgMQf2jkv43+xshEVYbBRqiqswMdWEy+iArizVqIBd+CdHfC0ISyqjM
	 p1y7Q1dPbI923uNuXUeL88z+nyHjz+SYJuQP8/taa8F2CfSmid3IUX0gdC+xll9c/i
	 s5dEtGwv1W41w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf/arm_cspmu: Make IRQ more optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fb2cab05c714f24f703b242c8f8b8e9e4df938f8.1783605641.git.robin.murphy@arm.com>
References: <cover.1783605641.git.robin.murphy@arm.com>
 <fb2cab05c714f24f703b242c8f8b8e9e4df938f8.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:49:42 +0000
Message-Id: <20260709144942.B11391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The driver improperly ignores `-EPROBE_DEFER` errors when reques=
ting the IRQ for devices with 64-bit counters, breaking the deferred probe =
mechanism and leading to non-deterministic boot behavior.
--

--- Patch [4]: [PATCH 4/4] perf/arm_cspmu: Make IRQ more optional ---
commit 9b3f415215659b0aa95020707b757a52d3157692
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Make IRQ more optional

If we have 64-bit counters, we can reasonably assume we'll never have to
handle an overflow before the end of the universe (since we're a system
PMU with no sampling). Thus even if firmware does specify an IRQ, we can
still continue in the event of being unable to request it. This can help
systems where IRQs cannot be claimed exclusively, or are broken in other
ways.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index 1015d86957724..3e32342a609e4 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1257,8 +1257,11 @@ static int arm_cspmu_device_probe(struct platform_=
device *pdev)
>  		return ret;
> =20
>  	ret =3D arm_cspmu_request_irq(cspmu);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		if (counter_size(cspmu) < 64)
> +			return ret;
> +		dev_info(cspmu->dev, "Continuing without IRQ\n");
> +	}

[Severity: Medium]
Will this improperly ignore -EPROBE_DEFER if the interrupt controller is no=
t yet
probed?

If arm_cspmu_request_irq() returns -EPROBE_DEFER from platform_get_irq_opti=
onal():

drivers/perf/arm_cspmu/arm_cspmu.c:arm_cspmu_request_irq() {
    ...
	irq =3D platform_get_irq_optional(pdev, 0);
	if (irq < 0)
		return irq =3D=3D -ENXIO ? 0 : irq;
    ...
}

and counter_size(cspmu) >=3D 64, it looks like this code will mask the erro=
r and
continue without an IRQ, rather than deferring the probe. This could lead to
non-deterministic boot behavior depending on probe timing.

Could we explicitly check for and propagate -EPROBE_DEFER here?

> =20
>  	ret =3D arm_cspmu_get_cpus(cspmu);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783605641.gi=
t.robin.murphy@arm.com?part=3D4
