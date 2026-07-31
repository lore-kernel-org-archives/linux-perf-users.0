Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F023431A5D;
	Fri, 31 Jul 2026 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541829; cv=none; b=juPmR7ba2QBvF4qcsrw0cRDeJaEqOKcCIiqgNmDMPsaW1BS3cPjgL1qWvr3FuQ/U2Vp1qec/Edo7eYS6D5K8fZS18O0KXCw6/zRKZlYf7Fo3rS4m8XOhBnUhfLwNykoXy2SHisGTOQEn9B4plSM9VQodPzacRak/QlrW/iEJIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541829; c=relaxed/simple;
	bh=kqMaWa1FCag+NtCdeeB8TCxKLZyixxt9i16q+KbzabE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MWMllnvsGBCKDf11CA4VnCyFksfPWODuPxWMWUpkrh8uc68mOw+EXkxSIe5rYBVzwnyQ2d4t7IYm/ul9oCzcgzsiPRsjiLvCrkg7Ti3VC/LPurQL+yQ0OozYquVbeeJnpMlv5cuSMaNaZoC/eFtztKUkEIL6W6hTFDNlza5Vp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLE4C5Z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLE4C5Z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DCA1F00ACA;
	Fri, 31 Jul 2026 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541828;
	bh=K2rASlh3KZ2ijAo+2nw1CQhEYWafIoll8F+wpCz/Aa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLE4C5Z8Et5xT2g0JHGBXlEFxkPKsKuYKjKP3LtjYewW5cWEZMe5jVZLc53rE7DSz
	 hM7u/K9mwZA4fFAU6kIhyudi4n+ktEllph2NXGe7g5kNnoj36cMDOb6BImHx+3Jrdl
	 Ys7mAb2YEJIRPPwAq0v02/n2KpIkJgXXolorfPKSzQuQawd/uep2NfxnmJGvVES7n5
	 jmpYpr6yUretDnpFKpadyW86KlTSiGWpxxyelBTBCpKlBO1l8QSQsAjKj3/O3N8peK
	 yinRTK+dl5zNTuGImf5E3rjnjKXb7gVw3YZn8DOyxla9n/f4Vmeq1+Oqr40mw1/wj7
	 5KueP9tis1sRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] perf/cxl: Don't share the overflow interrupt,
 and keep it pinned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260731232827.401447-7-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:50:27 +0000
Message-Id: <20260731235027.B8DCA1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CPU hotplug migration race causes cross-CPU data corruption on in-=
flight interrupts.
--

--- Patch [6]: [PATCH v3 6/9] perf/cxl: Don't share the overflow interrupt,=
 and keep it pinned ---
commit 0c52a628eb5f3fcd46d4c3f0c11a1448687ffd14
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Don't share the overflow interrupt, and keep it pinned

The PMU pins its overflow interrupt to info->on_cpu in the hotplug
callbacks, but requests it with only IRQF_SHARED | IRQF_NO_THREAD. Without
IRQF_NOBALANCING, irqbalance or a userspace smp_affinity write can move the
interrupt to another CPU. cxl_pmu_irq() then runs local64_cmpxchg() and
local64_add() on hwc->prev_count and event->count there, at the same time
as the managing CPU. local64_t is only atomic against same-CPU access, so
the counts get corrupted.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index c9e30cb149dfa..6fdc66a01fb67 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -784,7 +784,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> =20
>  	overflowed =3D readq(base + CXL_PMU_OVERFLOW_REG);
> =20
> -	/* Interrupt may be shared, so maybe it isn't ours */
> +	/* Nothing overflowed, so the device did not raise this */
>  	if (!overflowed)
>  		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but can this IRQ handler race with CPU hotplug
migration and cause cross-CPU data corruption?

Looking at cxl_pmu_offline_cpu(), the context is migrated to a new CPU befo=
re
the IRQ affinity is updated:

cxl_pmu_offline_cpu() {
    ...
    perf_pmu_migrate_context(&info->pmu, cpu, target);
    info->on_cpu =3D target;
    /*
     * CPU HP lock is held so we should be guaranteed that this CPU hasn't
     * yet gone away.
     */
    WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
    ...
}

During installation on the new CPU, the hardware counters and interrupts are
re-enabled. If the hardware generates a PMU overflow interrupt in this
window before irq_set_affinity() completes, the interrupt is delivered to
the old CPU.

The old CPU's IRQ handler (cxl_pmu_irq()) will then see the newly installed
event in the globally shared info->hw_events[i] array:

cxl_pmu_irq() {
    ...
	for_each_set_bit(i, overflowedbm, info->num_counters) {
		struct perf_event *event =3D info->hw_events[i];
    ...
		__cxl_pmu_read(event, true);
	}
    ...
}

This causes the old CPU to execute non-atomic local64_cmpxchg() and
local64_add() operations concurrently with the new managing CPU. Since
local64_t operations are only safe for same-CPU access, won't this corrupt
the hardware event counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D6
