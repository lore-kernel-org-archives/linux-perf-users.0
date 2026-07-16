Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8342BE98
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214686; cv=none; b=XM0d2IMl6OW99HJJBvsbZdvJK5gGU6EsMTiBV1F1FBVpTWhaPYFt2kXBc9FF0fCoANpyC0Kab/30sPLcLFVmGcHJDMAuTHPkfRo0S7hoJ8VApq21L0rr+613yd8twPjboYiOPdXUQaYwS9D0PK3mZk1c2Vjk04DOxGB5NUkuhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214686; c=relaxed/simple;
	bh=Icv69RYyQ0aT8uoFuK7BKxM84KWxTCOk3pNTK9cxCG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/risOudTiNrx9fyhyduthbgAeLhu6BH9YfKNqWYdnkS3vQ7nBTkdKVoPoUxLBjH7f576Z21I1QVLFUkgVsl5YMG+eYErKl8KDbKXV3bZxNJhYCWBWqbYVb5+x8uZd1F0C/OEzgIik3mN26X9e/AEnHRWzcts/7DEkq2bZAA8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBzVkIuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBzVkIuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC9B1F000E9;
	Thu, 16 Jul 2026 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214684;
	bh=CPQKzC4xSMklKwXcaui6Vnx4vz3J8lL68D+0XFXUidA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBzVkIuYPSGuDzsTk4B6xXUtk2fNJ5Kr7XWKLWtx+ul/vBfoweE8pCeByFC54NkUG
	 b285sUJEIh6nl0aO/WJf9nP8Jwp23f0ZJjT3vHgHzENXvTOmHX2Y81PnAjuHsOWFbh
	 9OvjLgRGI0rTRP8fawT4ZSTOiUxTaYIxw/MaianpTrVblSJvbdr+0cLTReunWbLF3o
	 u8xENXTbVCG52P+647WcXZnI1sGHNup7mLBHbTKsSA0rnnTiLJN533xyQYGaVE6yzC
	 KjXyHxze640MCCSHB0MRHJwcj/KEPoveAUI4gwTIs8iIx6QDRh+O+lACBzExmR8UTB
	 rNIGLVdW0ZmaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf/arm_cspmu: Make IRQ more optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a6bb2c54e91712e91f95d21051d2b4b173cebc93.1784213435.git.robin.murphy@arm.com>
References: <cover.1784213435.git.robin.murphy@arm.com>
 <a6bb2c54e91712e91f95d21051d2b4b173cebc93.1784213435.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:11:24 +0000
Message-Id: <20260716151124.7AC9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unconditional swallowing of `arm_cspmu_request_irq()` error codes =
(such as `-EPROBE_DEFER` and `-ENOMEM`) for PMUs with >=3D 64-bit counters.

Pre-existing issues:
- [High] Incorrect ordering between CPU hotplug state management and PMU re=
gistration causes Use-After-Free during teardown.
- [High] Missing cleanup of CPU hotplug state if `platform_driver_register(=
)` fails in module init.
- [High] Failed `driver_attach()` in `arm_cspmu_impl_register()` leaves dan=
gling pointers in the `impl_match` array.
- [High] Stack-allocated bitmap cast to `u32 *` leaves memory uninitialized=
 on Big Endian systems, causing reads of uninitialized stack memory.
--

--- Patch [4]: [PATCH v2 4/4] perf/arm_cspmu: Make IRQ more optional ---
commit e7afdbca83ffd562889abdf4a15a47f1af9fc395
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Make IRQ more optional

This commit allows the driver to continue probing even if it fails to
request an IRQ, provided the PMU has 64-bit counters. It assumes that
64-bit counters will not overflow in a realistic timeframe.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index 385d3e34694f2..007038aa7e9a6 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1256,8 +1256,11 @@ static int arm_cspmu_device_probe(struct platform_=
device *pdev)
>  		return ret;
> =20
>  	ret =3D arm_cspmu_request_irq(cspmu);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		if (counter_size(cspmu) < 64)
> +			return ret;

[Severity: High]
Does this unintentionally swallow error codes like -EPROBE_DEFER or
-ENOMEM for 64-bit PMUs?

If the interrupt controller is not yet ready, arm_cspmu_request_irq() will
return -EPROBE_DEFER via platform_get_irq_optional(). By completely ignoring
the error here, does this result in completing the probe without an IRQ when
we actually just needed to defer it?

Similarly, memory allocation failures (-ENOMEM) from devm_request_irq()
would also be silently ignored.

> +		dev_info(cspmu->dev, "Continuing without IRQ\n");
> +	}
> =20
>  	ret =3D arm_cspmu_get_cpus(cspmu);

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
window during teardown if the PMU is unregistered before the hotplug state
is removed?

In arm_cspmu_device_remove():

    perf_pmu_unregister(&cspmu->pmu);
    cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);

Calling perf_pmu_unregister() frees the PMU context. When
cpuhp_state_remove_instance() is called next, it synchronously triggers
arm_cspmu_cpu_teardown() on all online CPUs.

The teardown callback then invokes perf_pmu_migrate_context() using the
already freed PMU context.

A similar sequence appears in the error path of arm_cspmu_register_pmu() if
perf_pmu_register() fails.

[Severity: High]
This isn't a bug introduced by this patch, but does arm_cspmu_init() leak
the CPU hotplug callbacks if platform_driver_register() fails?

In arm_cspmu_init():

    arm_cspmu_cpuhp_state =3D ret;
    return platform_driver_register(&arm_cspmu_driver);

If platform_driver_register() fails, the module memory is freed. However,
cpuhp_remove_multi_state() is missing from this error path, which leaves
the kernel holding pointers to the freed module callbacks.

Can this cause a kernel panic on subsequent CPU hotplug events?

[Severity: High]
This isn't a bug introduced by this patch, but does arm_cspmu_impl_register=
()
leave dangling pointers in the static impl_match array on failure?

In arm_cspmu_impl_register():

    if (!match->impl_init_ops) {
        match->module =3D impl_match->module;
        match->impl_init_ops =3D impl_match->impl_init_ops;
    }
    ...
    if (!ret)
        ret =3D driver_attach(&arm_cspmu_driver.driver);

If driver_attach() fails, the function returns an error without clearing
the module and impl_init_ops fields. If the backend module is unloaded,
these pointers become invalid.

Would a subsequent probe of a matching device call the dangling
impl_init_ops pointer?

[Severity: High]
This isn't a bug introduced by this patch, but can the uninitialized stack
bitmap cause logic failures on Big Endian systems?

In arm_cspmu_handle_irq(), pmovs is declared on the stack:

    DECLARE_BITMAP(pmovs, ARM_CSPMU_MAX_HW_CNTRS);

And in arm_cspmu_get_reset_overflow(), it is written to as a u32 array:

    for (i =3D 0; i < cspmu->num_set_clr_reg; ++i) {
        pmovs[i] =3D readl(cspmu->base1 + pmovclr_offset);

Writing a u32 sequentially into an unsigned long array on a 64-bit Big
Endian system populates the most-significant 32 bits, leaving the
least-significant 32 bits uninitialized.

Since test_bit() checks bits based on unsigned long layout, could it read
from the uninitialized stack memory, causing spurious or missed hardware IR=
Qs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784213435.gi=
t.robin.murphy@arm.com?part=3D4
