Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0E456E1E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946619; cv=none; b=jPUpmSeIvDZZDNXDPTNwGnYpQBLUaf3S6WS0qp5j0HvkZWvA9Bpei5MkaTN3OMoGCxjMQ41buV0uDGjTpUib3lB1usUDl9mWb/+z1ebQwgzgXMp5sI20I3u61qaVUQRIgPUgEbiDqQitb5GbPnjKeB9JepNgeGec8h6TwGUK1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946619; c=relaxed/simple;
	bh=MTJF82L3FvvgbAgbt9y9nJXX8nTA/A3KpeoIogHz8zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SDDtSHuZQZrWA4l90QearqwgnTi/p1XmM6RM6NvlStsFZZhkBCqzYUBvpDRMHy4CRPLhgEOs4J1XU79WMcYVZRUMhrZlTwNT3gyyWc9z0IVmFxahwjzGiWpfL9+X0g1eO31Au/bFrOasdneFmdeWFldWetgmSfONsKgPQNc7dCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngwf+Oib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngwf+Oib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330401F000E9;
	Wed,  5 Aug 2026 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946617;
	bh=pY58UlX1fa6HkSzDwxtkJdy+cePvanYjZoQWAAgjxDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngwf+OibJTycY7fvP/ZUinbd2r5aHx88LS5IgYp8uqDKkga8D4XQLfDsUCY7Mc8Ar
	 cYaN6g8kS3YB/mY4TOFfXOx4u6yPESyeuwruPtj/yO1AC8gN6JTMl0y18wmWAWeGqj
	 EwVkv8wvfc7IFavqBTYHr1EXU8jB8gSoz1roGmusGDoFkRfN0MPpw1Qlyu3ICRr84y
	 jAbizvafU6n1QgjYfUEjZws8Glaju4ym/mePKUZfkN8GuY3i6AZIjwl1oXDpg+bI2y
	 m/CzzzAXXkSzTWZxMjAm0PdykK4tNOzuiWvlv2SfkKAryKKrdrCy7LUOT/8HDgrPUn
	 fSzuCNNOd4RpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/11] perf/cxl: Don't log through pmu.dev in the
 overflow interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155501.1294472-11-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
 <20260805155501.1294472-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:16:56 +0000
Message-Id: <20260805161657.330401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in `cxl_pmu_offline_cpu()` due to devres teardown o=
rder.
--

--- Patch [10]: [PATCH v4 10/11] perf/cxl: Don't log through pmu.dev in the=
 overflow interrupt handler ---
commit 9f5d830c7ee5748e40bbe955adff5fe5abd56b9f
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Don't log through pmu.dev in the overflow interrupt handler

This commit changes the overflow interrupt handler to log through
info->pmu.parent instead of info->pmu.dev. This prevents a use-after-free
if an overflow occurs just before teardown, as perf_pmu_unregister() frees
pmu->dev without clearing the pointer.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 84ebc7da181d5..45edef53a983d 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -805,7 +805,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>  		struct perf_event *event =3D info->hw_events[i];
> =20
>  		if (!event) {
> -			dev_dbg(info->pmu.dev,
> +			dev_dbg(info->pmu.parent,

[Severity: High]
This is a pre-existing issue, but since we are fixing teardown races with
freed pmu structures, does a similar use-after-free exist in
cxl_pmu_offline_cpu() during concurrent cpu hotplug events?

In cxl_pmu_probe(), the devm actions are ordered such that the pmu is
unregistered before the cpu hotplug instance is removed:

drivers/perf/cxl_pmu.c:cxl_pmu_probe() {
	...
	rc =3D cpuhp_state_add_instance(cxl_pmu_cpuhp_state_num, &info->node);
	if (rc)
		return rc;

	rc =3D devm_add_action_or_reset(dev, cxl_pmu_cpuhp_remove, info);
	if (rc)
		return rc;

	rc =3D perf_pmu_register(&info->pmu, info->pmu.name, -1);
	if (rc)
		return rc;

	rc =3D devm_add_action_or_reset(dev, cxl_pmu_perf_unregister, info);
	...
}

Because devm executes teardown in a reverse order, cxl_pmu_perf_unregister()
runs first. This calls perf_pmu_unregister(), which frees info->pmu.dev
and info->pmu.cpu_pmu_context.

However, the cpu hotplug instance remains active until cxl_pmu_cpuhp_remove=
()
runs. If a cpu offline event occurs in this window, cxl_pmu_offline_cpu()
could be invoked:

drivers/perf/cxl_pmu.c:cxl_pmu_offline_cpu() {
	...
		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
		return 0;
	}

	perf_pmu_migrate_context(&info->pmu, cpu, target);
	...
}

Could this lead to a use-after-free when dereferencing the freed
info->pmu.dev in the error log, or info->pmu.cpu_pmu_context inside
perf_pmu_migrate_context()?

>  				"overflow but on non enabled counter %d\n", i);
>  			continue;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155501.1294=
472-1-dave.jiang@intel.com?part=3D10
