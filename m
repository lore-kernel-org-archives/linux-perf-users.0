Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B93BED08;
	Wed,  1 Jul 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897119; cv=none; b=uRS5Gn/grHZeiftHJrrQyydl3nqPtU4vHmHwV5fzm1wnsyoKarPM2RE3uRtWiXNRXHbTIoPw4jhDjkvIV9+ajZf/bTyN1orO5MY+1lGC6qq0v3nEcU7d9mOBNL82yKDNhPB2TDNHRS8IT9gIkhmHvmyLbCvQdK6vr0v5kaYfbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897119; c=relaxed/simple;
	bh=D0/Oc6rmcDZzqhUTAK0bAQgtfiJ7n+4REp6wn/irWxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzmPq5HEBeZ6ZQi36O0QIfPLnsTrlS63rwqs68JB5qa6/qeTmTFfoc7hkcHk8SCVqhzsuJnAK+sO6RJ58yH/+Hf+eV1aSIP9iHcs/oKy/qtpYFUS5oWCgcuv6NzLAbuS8rnZocbiHNzmf1ZtFS+HBRFMFqm49KwcM/SqcK8fW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AakVCOzk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AakVCOzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36DE1F00A3A;
	Wed,  1 Jul 2026 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897118;
	bh=nF/WQ+WE6wr6Oo021CEFFzY6uhDx2SobKoXIBiLlh8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AakVCOzkkhq/YqCy5KqgwHjWTg31FYes/u67RE15Sxw0yxqDbDNaPWUvG8icJc1Yr
	 QWzgwleG88w/ZYBd8psyd1AVs8MJaG2ApbTkFPNU04mMSqUPc3t+nxnC9kNcyYhNHu
	 72l1LrljpCGoFLJBYXomcuX6EiMvtO2533SxUp3Gje4lQFNQVIrbHtO65KeYlPwv1n
	 eHDU8k/oO37fvFP4lxu730aB4sAmJJuOjoJqV4Zd/WAtNIcKeDP/3si5Ohzav41bJO
	 7ktLbNzZ6T5jQN8vyDneoiRtxqvaxeaQygisRhLK4dilQMsU41k6El/UeNOG73cTKh
	 Lc+O0dyOyQY+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/22] RISC-V: perf: fix resource cleanup on driver
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:11:57 +0000
Message-Id: <20260701091157.B36DE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting race condition and ignored -EBUSY return from perf_pmu=
_unregister() leads to UAF if events are active during probe failure.
- [High] The global bitmask `cmask` is modified during device probe but not=
 cleared on error paths, leading to a guaranteed NULL pointer dereference i=
n exported functions.
- [High] The static key `sbi_pmu_snapshot_available` is never disabled on p=
robe failure, leading to a potential NULL pointer dereference.
--

commit 4312c8eb8c51217703e557d54647da346fae9bf0
Author: Atish Patra <atishp@meta.com>
Subject: RISC-V: perf: fix resource cleanup on driver probe failure

This commit reorganizes the error handling paths in pmu_sbi_device_probe()
to properly free registered PMUs, per-cpu IRQs, the pmu_ctr_list, and
CPU hotplug states if the probe fails.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 385af5e6e6d0d..5c8924ce1f387 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -1515,9 +1525,20 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	return 0;
> =20
>  out_unregister:
> +	perf_pmu_unregister(&pmu->pmu);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this error path ignore a
potential -EBUSY return from perf_pmu_unregister()?

If perf_pmu_register() previously succeeded, an unprivileged user might race
to open an event on it. If a subsequent initialization step fails and trigg=
ers
this cleanup path, perf_pmu_unregister() can return -EBUSY and fail to remo=
ve
the PMU from the core structures.

Since the return value is ignored, the code will proceed to call kfree(pmu)
below. Can this leave a dangling pointer in the perf subsystem and result i=
n a
use-after-free if those events are still active?

> +out_destroy:
>  	riscv_pmu_destroy(pmu);
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

[Severity: High]
This is a pre-existing issue, but does this error path leave the global cma=
sk
variable set when pmu_ctr_list is freed?

During probe, pmu_sbi_get_ctrinfo() populates the global cmask. If the probe
fails and we take this error path, pmu_ctr_list is freed and set to NULL,
but cmask is never cleared.

If a subsequent call to the exported function riscv_pmu_get_hpm_info()
occurs (e.g., triggered by KVM vCPU initialization), could it bypass the
safety check because cmask is non-zero, and dereference the NULL pointer?

drivers/perf/riscv_pmu_sbi.c:riscv_pmu_get_hpm_info() {
    ...
    for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
        info =3D &pmu_ctr_list[i];
        if (!info)
            continue;
    ...
}


[Severity: High]
This is also a pre-existing issue, but does this error path need to disable
the sbi_pmu_snapshot_available static key?

Earlier in pmu_sbi_device_probe(), the static key is enabled:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
    ...
    static_branch_enable(&sbi_pmu_snapshot_available);
    ...
}

If a subsequent step fails, the probe aborts and frees the snapshot memory,
but the static key remains enabled. If the driver is re-probed and setup
fails on the retry, the probe might continue successfully without snapshot
memory. Could this leave the static key true, causing functions like
pmu_sbi_ctr_read() to dereference a NULL snapshot_addr?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ctr_read() {
    ...
    struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_addr;
    ...
    if (sbi_pmu_snapshot_available() && (hwc->state & PERF_HES_STOPPED)) {
        val =3D sdata->ctr_values[idx];
    ...
}

>  	kfree(pmu);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D1
