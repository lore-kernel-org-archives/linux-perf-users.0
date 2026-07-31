Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C747DF99;
	Fri, 31 Jul 2026 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541514; cv=none; b=aJMRWCTctxAU11fMOmSOXDvUQfSLeK0SK5/jc/448jUNylgFCa+bFBcerLnk0XPhxjAxF9voRYtXc4zrOIoZIRfLJceFaDu2lsOXcVAvRXfEoJ0DW8LQBnCMKRP7Rd6TcELVpLS7gSa8+PMe5EQvceDnlY21ugLPvcyg+hmzVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541514; c=relaxed/simple;
	bh=unFWOJg9QVDQhSuJ3wbhIllEBy4ZvR6jQWgX9R7IR6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlSUGz01QeBan/NhAj5ZP6ydwXulcszfSj07QqZqPqv68fDQrv/ZhIaeYGZZpqVivjT3ZgDoH0k9i61PeIAnIq+HfUtkG+xxTjRl8IONyDRK0R1uPjygYB2IshhsmzfcT2Ookt5O9V4cLD4DzaXjDyLbbTJg6fIb3D8kSc94Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHeZdwSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHeZdwSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474A1F00AC4;
	Fri, 31 Jul 2026 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541513;
	bh=ciuXeGUVPS/XYsdHyOz9SMrnvZDkNAL9VymGj8dLgBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHeZdwSrsCp7Zr9rTKfAI9TEJZniUMrjs+H9zT3N+jgAbqmYWOcWPVbOy0J8Ja8qn
	 SKo8MKTcUMDYvZ/gKR+g2VI6GiN89XVT/EFHs6GxivtDzHb/vd68GYBTxw027OVZ2E
	 syv9eW0Cg+gPZjUwJoqf8eRSKT1Wsr5m8HWGOJnjVFmkjdrXLss9yz81UOONBREv3G
	 iBJpRBbBGXwkpOC3JPgAuCatEtrauh8z4udqSX+Z+AeqZmbgdGHoNbpTGtniubNkqY
	 jHPAKUGDkkJvkNCQcJ/lxwIZOmXL/gddR7Hh//XwtBIO/cqQBP3W/ejU5U4oflkOv0
	 kiK0yjWGlU6aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] perf/cxl: Split the MSI vector out of info->irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260731232827.401447-5-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:45:12 +0000
Message-Id: <20260731234513.5474A1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The check `info->msi_vec <=3D 0` incorrectly rejects valid MSI vec=
tor index 0.
- [High] Incorrect registration order of the PMU and CPU hotplug instance l=
eads to a Use-After-Free or NULL pointer dereference during hotplug events.
- [High] PMU hardware is not frozen during CPU hotplug migration, and the i=
nterrupt is shared, leading to concurrent SMP execution of `local64_t` oper=
ations without SMP safety.
- [High] The driver dynamically changes the CPU affinity of an interrupt re=
quested with IRQF_SHARED, forcibly breaking affinity for other devices shar=
ing the IRQ.
- [Medium] The PMU firmware's counter width is used without validation, whi=
ch can cause undefined behavior via out-of-bounds bit shifts.
- [Medium] Silent truncation of user-provided PMU threshold values.
--

--- Patch [4]: [PATCH v3 4/9] perf/cxl: Split the MSI vector out of info->i=
rq ---
commit ad9898396611ac9af6c4819fa48aba52e6dbeb08
Author: Dave Jiang <dave.jiang@intel.com>
Subject: perf/cxl: Split the MSI vector out of info->irq

The commit separates the MSI/MSI-X message number from the Linux virq by
introducing a new msi_vec field in struct cxl_pmu_info. This clarifies
the use of the field during probe before it gets overwritten with the virq.

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 3511d049aea40..56e6ae7bebf7c 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -874,10 +875,10 @@ static int cxl_pmu_probe(struct device *dev)
>  		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
>  	};
> =20
> -	if (info->irq <=3D 0)
> +	if (info->msi_vec <=3D 0)

[Severity: High]
This is a pre-existing issue, but does this incorrectly reject a valid MSI
vector index of 0?

The CXL PMU capability register provides a 0-based MSI vector number (0-15).
If the firmware specifies MSI message number 0, info->msi_vec becomes 0.
cxl_pmu_probe() then erroneously aborts with -EINVAL, causing valid
devices using MSI vector 0 to fail probing completely.

>  		return -EINVAL;
> =20
> -	rc =3D pci_irq_vector(pdev, info->irq);
> +	rc =3D pci_irq_vector(pdev, info->msi_vec);
>  	if (rc < 0)
>  		return rc;
>  	irq =3D rc;

I also noticed a few other pre-existing issues in this file:

[Severity: High]
This isn't a bug introduced by this patch, but could the PMU registration
order cause a NULL pointer dereference or use-after-free during hotplug?

In cxl_pmu_probe(), cpuhp_state_add_instance() is called before
perf_pmu_register(). If a CPU hotplug event triggers immediately:

cxl_pmu_offline_cpu()
  perf_pmu_migrate_context()

Since perf_pmu_register() hasn't allocated pmu->pmu_cpu_context yet,
could this result in a NULL pointer dereference?=20

Furthermore, upon module unload, devm executes teardown in reverse order.
perf_pmu_unregister() is called before removing the hotplug instance,
creating a window where a CPU offline event could trigger a use-after-free
on the unregistered PMU context.

[Severity: High]
This is a pre-existing issue, but is it safe to use local64_cmpxchg() when
the PMU interrupt is shared and not disabled during migration?

cxl_pmu_offline_cpu() migrates PMU events without disabling the PMU hardwar=
e.
Because the interrupt is shared (IRQF_SHARED), it can fire on any CPU at any
time due to other devices sharing the line:

cxl_pmu_irq()
  __cxl_pmu_read()
    local64_cmpxchg()

Concurrently, the new CPU can start or read events, also invoking
__cxl_pmu_read(). Since local64_t operations are only safe for single-CPU
access, could cross-CPU concurrent access corrupt the performance counters?

[Severity: Medium]
This isn't a bug introduced by this patch, but could an unvalidated counter
width from firmware cause undefined behavior?

In cxl_pmu_parse_caps(), info->counter_width is read directly from the hard=
ware
capability register. If firmware reports a width of 0, __cxl_pmu_read()
computes GENMASK_ULL(0 - 1, 0).

Since 0 - 1 promotes to an int value of -1, passing it to GENMASK_ULL
evaluates to a negative bit shift (~0ULL >> 64), which is undefined behavio=
r.

[Severity: High]
This is a pre-existing issue, but does this driver dynamically alter the
affinity of a shared interrupt?

cxl_pmu_probe() requests the PMU interrupt with the IRQF_SHARED flag.
However, during CPU hotplug events, cxl_pmu_online_cpu() and
cxl_pmu_offline_cpu() unconditionally call irq_set_affinity() to bind the
interrupt to a specific CPU.

Dynamically changing the hardware affinity of a shared interrupt can reroute
interrupts for all other unrelated devices sharing that IRQ line, violating
system isolation and potentially causing performance regressions or timeouts
for other drivers.

[Severity: Medium]
This isn't a bug introduced by this patch, but does the configuration
accessor truncate user-provided threshold values?

The format attribute threshold is exposed via sysfs as config1:0-15 (16 bit=
s).
However, cxl_pmu_config1_get_threshold() uses a u8 return type:

static u8 cxl_pmu_config1_get_threshold(struct perf_event *event)
{
	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_THRESHOLD_MSK, event->attr.config1);
}

This silently truncates any 16-bit user input to 8 bits, resulting in the P=
MU
being configured with an incorrect threshold without returning any error to
userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D4
