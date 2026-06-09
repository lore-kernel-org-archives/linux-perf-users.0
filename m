Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C33D0924;
	Tue,  9 Jun 2026 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985921; cv=none; b=skEnxYxcBCVf6IAOOtonSrOns6IvdNfm9vsii1bwzEDcsQm6UiZkRNcu+bqnRHw+QzcdubfvSST0VWj3NsmcjhRlhkfDfoMohr+3vG6eqhQ+FL/ddYcMsvTV9zv715vhbx0yPZTGDq1ttzWauAKmaWXejJYOQ99p3jVtqMFK5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985921; c=relaxed/simple;
	bh=7KUJhKbfGfftEcjoYZn9xb2sQ8dkgLJeFWaSFHBhSqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GUy9D+C+5ofjC3Nh0L6jU+CR0fYhRsu9Age0T4fRwlu/0PTAx7SgWEiW7QjtQjKruXOD0hix+QwtxS6Ao8LbFcfYhxyiYLXnXf4EhCYRq/LeaglSvA9Mhlh5V/6UQAextp5yMuNdP4eWJDAxUnWrK7IPZNkH+B5ebG5kSBQiKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+3G51xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+3G51xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9B1F00893;
	Tue,  9 Jun 2026 06:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985919;
	bh=oyKW/W1KCCxAUnXLpvrza/LoeS+wlP4RZoHWDfluU1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+3G51xvIYLAgFBYZaEwSGDJJItZ9M1eYDtteln58GvaIXrcgF8YN05S+GJI4/5Uw
	 LfvXMWZxthXtCDrfyO+ae7XvurC2DJg1GI6zO4gAR+nI2kme+goL5XP2JF2y6pihx8
	 c/nsB0GD7ORbDC/+AnhbPWIW/3ppcd0Dcop2vjW5D7FfwCTwJmTVFqfiNkoFg+4N8N
	 S3AlclCETo2nPkLlL2cIadDzWJyo74xNtYczKZ47JahqF5vl1YEM1B3hABNaMzh8aQ
	 opIsx44Z6+SX/UZO3Y0fjM2t0le5rSmmPB2jAjvwCWrHuyxtqlNMYysAzoQOiKsDrs
	 VjdeMA4DdkYTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/21] RISC-V: perf: Restructure the SBI PMU code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-10-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-10-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:18:38 +0000
Message-Id: <20260609061839.70B9B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] NULL pointer dereference when tearing down the PMU on error pa=
ths in probe.
- [High] Missing cleanup on error paths in rvpmu_device_probe() leads to Us=
e-After-Free and resource leaks.
- [High] Broadcasting `SCOUNTEREN` updates to all CPUs in `mm_cpumask` leak=
s counter access to userspace.
--

commit 497e3337649afaedc330eca31dba2dda185d6179
Author: Atish Patra <atishp@rivosinc.com>

    RISC-V: perf: Restructure the SBI PMU code
   =20
    With Ssccfg/Smcdeleg, supervisor mode can program and access the hpmcou=
nters
    and events directly, without the SBI PMU extension. The SBI PMU extensi=
on is
    still required for firmware counters. Restructure the existing SBI PMU =
code so
    the hpmcounter/event helpers can be shared between the SBI and the coun=
ter
    delegation paths that follow.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 385af5e6e6d0d..7f21c16003f04 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1305,7 +1349,7 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }

[Severity: Critical]
This is a pre-existing issue, but does this code cause a NULL pointer
dereference on error paths?

In rvpmu_device_probe(), if an error occurs (such as perf_pmu_register(),
pmu_sbi_snapshot_alloc(), or cpuhp_state_add_instance() failing), the error
path jumps to out_unregister and calls riscv_pmu_destroy().

Because cpuhp_state_add_instance() either was not called yet, or failed and
did not hash the node, pmu->node.pprev is NULL. The function
cpuhp_state_remove_instance() does not check if the node is unhashed and
directly calls hlist_del(). This attempts to write to the previous node
pointer, which crashes the kernel with a NULL pointer dereference.

> -static void pmu_sbi_event_init(struct perf_event *event)
> +static void rvpmu_event_init(struct perf_event *event)

[ ... ]

> @@ -1347,14 +1391,14 @@ static void pmu_sbi_event_mapped(struct perf_even=
t *event, struct mm_struct *mm)
>  	 * that it is possible to do so to avoid any race.
>  	 * And we must notify all cpus here because threads that currently run
>  	 * on other cpus will try to directly access the counter too without
> -	 * calling pmu_sbi_ctr_start.
> +	 * calling rvpmu_sbi_ctr_start.
>  	 */
>  	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>  		on_each_cpu_mask(mm_cpumask(mm),
> -				 pmu_sbi_set_scounteren, (void *)event, 1);
> +				 rvpmu_set_scounteren, (void *)event, 1);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does broadcasting scounteren
updates to all CPUs leak counter access to userspace?

When a user-accessible event is mapped, rvpmu_set_scounteren is broadcast
across all CPUs where the process has threads running. This enables the
scounteren bit corresponding to event->hw.idx.

However, event->hw.idx is a dynamic, per-CPU hardware counter index allocat=
ed
only on the CPU where the event was scheduled. Broadcasting this index acro=
ss
all CPUs in the mask grants userspace access to that specific hardware
counter slot on CPUs where the event is not running.

Could a thread on another CPU read from that counter slot, potentially leak=
ing
the count of whatever unrelated perf event is active on that counter?

> -static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_s=
truct *mm)
> +static void rvpmu_event_unmapped(struct perf_event *event, struct mm_str=
uct *mm)

[ ... ]

> @@ -1419,7 +1463,7 @@ static const struct ctl_table sbi_pmu_sysctl_table[=
] =3D {
>  	},
>  };
> =20
> -static int pmu_sbi_device_probe(struct platform_device *pdev)
> +static int rvpmu_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu =3D NULL;
>  	int ret =3D -ENODEV;

[Severity: High]
This is a pre-existing issue, but does this probe function correctly clean
up resources on error paths?

If initialization fails after perf_pmu_register(), the code jumps to the
out_unregister label:

out_unregister:
	riscv_pmu_destroy(pmu);

out_free:
	kfree(pmu);
	return ret;

However, riscv_pmu_destroy() does not call perf_pmu_unregister(). This leav=
es
the core perf subsystem with a dangling pointer to the freed pmu structure,
which can lead to a use-after-free when the perf core attempts to access it.

Additionally, the per-CPU memory allocated for pmu->hw_events and the per-C=
PU
interrupts requested via request_percpu_irq() are never freed on these error
paths, resulting in resource leaks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D10
