Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570563D091A;
	Fri,  7 Aug 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091463; cv=none; b=LFDwx4EwCs/+EatvmPFKMEkH9BlOkUTbCRrW/UDndsIGOjTn3QG9TW92FLIy2i+c+Fi/gTx02ILH+9eYjzlDkT2kGDLViQ5cBiK9Oh66dC5EpEzA/rx67DgUxYA39fkgDk8fTfOGuabCZ/ZQqA37jy8wx595qGefS6XejDCrnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091463; c=relaxed/simple;
	bh=5UbV3kI7Xcb2dYZ4vNjpHLGO4HOqCxlY13VqRSx17Vg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=COGFhIYGdflLGd5QVWA2iXhui63o3GoGkG7a8lipnfhNYCI4CKT+Z/gyI82eR0cMzsj9+xbr5O9Jh0ng4JC/ZUbZb7MXAxHzFmN+8e5CR5u6NGAwccXDRXIHW0o676Vc8VyneMKsFOX03mHQkI6mxMHMtaYFoYydg2WcJzvB6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhZiPNS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhZiPNS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3904B1F000E9;
	Fri,  7 Aug 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091453;
	bh=9FQ+3lzdV8n137IFhEDYXLA29I0hoT41o9tKvZqQ7uU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhZiPNS3Gwenfpw+De9dkxmw0MBdpkZl0LvM23qUUJf4UXW4xsUG1yLMFotjHyPmE
	 uKKrJutjj80XJegr4zabifhHCuajtllR+olAuMISzRp2d4ZFtNxwValTu43Tjp3q3q
	 msgX1yO9XYEYypGoR4bzg33qxUHXnwwVIb5TfLdjnm9rkEa8VviwwujWEoUXSX7SvW
	 Ox/hCOu5TT1Zv6fvzLwbCqPuIcaulPqXVl0MURismWM6DpN51QG0deTCbpKTJXKBPT
	 CZvKrzVsvX+iwkRhXB4Z9ZQ+vV/5KZdZWsmETWG2cCb+/BkjpWtfqmQDC6A0v0fWVH
	 rPi+dF4pImFQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/20] RISC-V: perf: fix resource cleanup on driver
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807-counter_delegation-v9-1-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-1-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:30:52 +0000
Message-Id: <20260807083053.3904B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Process migration during a probe failure leaves the SBI firmwa=
re configured to write to a freed memory page (Firmware Use-After-Free).
- [High] The `sbi_pmu_snapshot_available` static key is not disabled on the=
 probe error path, leading to a potential NULL pointer dereference on subse=
quent probe attempts.
- [High] Race condition in the probe error path leads to Use-After-Free of =
the `pmu` structure.
- [Medium] Missing cleanup of the registered sysctl table on the probe erro=
r path.
- [Low] CPU hotplug state registered in init is not removed if subsequent i=
nit steps fail.
--

--- Patch [1]: [PATCH v9 01/20] RISC-V: perf: fix resource cleanup on drive=
r probe failure ---
commit e501d85892f2097d5cb521e3b393610d4683e0a4
Author: Atish Patra <atishp@meta.com>

RISC-V: perf: fix resource cleanup on driver probe failure

This patch fixes various UAF and memory leak issues around
pmu_sbi_device_probe() error paths. It ensures that registered PMUs,
per-cpu IRQs, and other data structures are correctly freed on failure.

Link: https://patch.msgid.link/20260701-counter_delegation-v8-1-7909f863a64=
5@meta.com

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dfc886dee5ad0..50220f7b46d9b 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1301,7 +1308,8 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  		}
>  	}
>  	riscv_pm_pmu_unregister(pmu);
> -	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> +	if (!hlist_unhashed(&pmu->node))
> +		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }

[Severity: Critical]
This is a pre-existing issue, but does riscv_pmu_destroy() safely disable t=
he
snapshot?

In pmu_sbi_device_probe(), pmu_sbi_snapshot_setup() is called within a
get_cpu()/put_cpu() block, configuring the SBI firmware for that specific C=
PU.

However, if probe fails and riscv_pmu_destroy() is called,
pmu_sbi_snapshot_disable() is executed without CPU pinning.

Could the thread migrate to a different CPU before disabling the snapshot,
leaving the original CPU's firmware configured to write to the snapshot
memory which is then freed by pmu_sbi_snapshot_free()?

[ ... ]

> @@ -1469,11 +1479,11 @@ static int pmu_sbi_device_probe(struct platform_d=
evice *pdev)
> =20
>  	ret =3D riscv_pm_pmu_register(pmu);
>  	if (ret)
> -		goto out_unregister;
> +		goto out_destroy;
> =20
>  	ret =3D perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>  	if (ret)
> -		goto out_unregister;
> +		goto out_destroy;

[Severity: High]
This is a pre-existing issue, but does this expose the PMU to userspace bef=
ore
fallible setups are complete?

Since perf_pmu_register() makes the PMU accessible, if userspace opens a pe=
rf
event before a subsequent initialization step fails (such as allocating
snapshot memory), the driver jumps to out_unregister and eventually calls
kfree(pmu).

Will this leave the perf core holding a pointer to a freed pmu structure?

[ ... ]

> @@ -1514,9 +1524,20 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	return 0;
> =20
>  out_unregister:
> +	perf_pmu_unregister(&pmu->pmu);
> +
> +out_destroy:

[Severity: Medium]
This is a pre-existing issue, but is the sysctl table leaked on this error
path?

Before the return 0, pmu_sbi_device_probe() calls:

    register_sysctl("kernel", sbi_pmu_sysctl_table);

If the subsequent cpuhp_state_add_instance() call fails, the error path ski=
ps
unregistering this sysctl table. Will repeated probe failures leak
ctl_table_header structures?

>  	riscv_pmu_destroy(pmu);

[Severity: High]
This is a pre-existing issue, but does the error path fail to disable the
sbi_pmu_snapshot_available static key?

If the probe fails after static_branch_enable(&sbi_pmu_snapshot_available),
the error path frees the snapshot memory in riscv_pmu_destroy() but never
disables the static key.

On a subsequent probe attempt or an interrupt, could code paths like
pmu_sbi_ovf_handler() execute assuming the snapshot memory is active, leadi=
ng
to a NULL pointer dereference when accessing sdata->ctr_overflow_mask?

> +	if (irq_requested) {
> +		free_percpu_irq(riscv_pmu_irq, pmu->hw_events);
> +		irq_dispose_mapping(riscv_pmu_irq);
> +		riscv_pmu_irq =3D 0;
> +	}
> =20
>  out_free:
> +	free_percpu(pmu->hw_events);
> +	kfree(pmu_ctr_list);
> +	pmu_ctr_list =3D NULL;
>  	kfree(pmu);
>  	return ret;
>  }

[Severity: Low]
This is a pre-existing issue, but is there a CPU hotplug state leak in
pmu_sbi_devinit() if platform registration fails?

pmu_sbi_devinit() registers a multi-state CPU hotplug hook:

    ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING, ...);

If platform_driver_register() or platform_device_register_simple() fails
afterward, the function returns directly without calling
cpuhp_remove_multi_state(), leaving the hotplug state registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D1
