Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424000;
	b=biE1Pj8O3exdoq7Vlcq1kVOUpSrMzFsNlOuzhE4KleatNyPSJIpfPcPEVVCKHdA9egLK
	 IY8aTe+t/rcdCssWsJYIPO5M1YA7cnAcuiVCp64UZ/IIvsiAgbzfFB90zpGaxoAYdcmwb
	 gAALFyK3G0e1tnud0WJEshtTE0onItOsR6GQEsSB/aODNzUddZAmI2ra4fX9xZGgbdwLt
	 vBwgBlwf0TP0t8F1JctfQUkdMVAgWsVgDdozNzKnVKBBD6YlncwOmr6axxmLKOl0PCqMo
	 W0I7zVdO8NfNqm6MGvqoPAYn//SlZ4LAHyhe+5JjXig4jHew+3elYrgBTNwOYzRowvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dm1c8J+N8fCpxcvJz0v5eKJA+U/tSXj4Z8hmVf6Mxms=;
	b=ZFqGYf/Ms+OAdwSe+tm73UlEXZ2Qvdvv/zKbUXDbTY3Tv2ySRnlgbMb6UDdgrqP1o6fW
	 4kGtShmS6mqqZIxwj3b5wpfpEa+FpROv1jJMy7G3xl44fWIT5UjfPLlcqtK9V/YMyDQLb
	 +nBmcVUAbbT2q/q0FbOM8xk9WM5sCwKkiZql6M3URwEdgIhJCTmDkyILz+3dvd4QJYzB9
	 F9MTROMftlaTYuzsgZiprGlmCCjt+TNPi/IgLWDqq1noqwI0F1UdS7yU/2rSsUpwzShea
	 nGer8o+NYyRf2pj4F8FcerZ4rMDdi6FNPFJV8CXa7oM1BMjSsZ/BPLVVi/CGVR9LVBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4rGynZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D260774C0
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4rGynZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530AA1F031D0;
	Mon, 19 Oct 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423999;
	bh=dm1c8J+N8fCpxcvJz0v5eKJA+U/tSXj4Z8hmVf6Mxms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4rGynZEUecQCvJ9gYscxrH4ZH4hF3R+Z0sYmjRfeJtRLcJ1KR3P6xZ31nK0gwtKr
	 OduJ5TTxbpUb5QbPv52jl5u+UARTEn1Ehnc1vVSnFgjxf2E03bWOcsIYLawaqQjwmX
	 m9HzQ1sz9kqqr+mJK584+8XaHa25yBr7/l7iW6A17g/EsjzKq1NC/jSMlvmA8ZVKDE
	 FW0XPIPbRfoW3c79+FAjKjl8hctrsVd8D/Xs9+KyNbhvZszRmJdO44JTLDUPhcJBgm
	 F6HtjZ0nkE6cOtuaW7RtKD7+ZFtArW/FhGYRoO5Rnz4Rr6rse7U/cPWDf/5oG+FX5T
	 7zcFOzoM+tvGA==
Message-ID: <sashiko-outbox-177756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] RISC-V: perf: fix resource cleanup on
 driver probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-443-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-443-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:33:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: riscv: NULL deref in riscv_pmu_get_hpm_info() after probe fa=
ilure
- [High] riscv: perf: incomplete snapshot and IRQ cleanup on probe failure
- [Medium] perf: riscv: leak sysctl table registration on pmu_sbi_device_pr=
obe() failure
--

commit 45f193117e60b41831289f45f79fab573ecae630
Author: Atish Patra <atishp@meta.com>

RISC-V: perf: fix resource cleanup on driver probe failure

This commit reorganizes the error handling in pmu_sbi_device_probe(),
pmu_sbi_setup_irqs(), and riscv_pmu_destroy() to clean up registered
PMU instances, per-CPU IRQs, pmu_ctr_list, and CPU hotplug state on
probe failure.

Link: https://patch.msgid.link/20260807-counter_delegation-v9-1-58658104e48=
7@meta.com

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7dd282da67cef..e794a40522fe6 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1515,9 +1525,20 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
>  	return 0;
> =20
>  out_unregister:
> +	perf_pmu_unregister(&pmu->pmu);

[Severity: Medium]
When cpuhp_state_add_instance() fails and jumps to out_unregister, does
this path leak the sysctl table header registered just beforehand in
pmu_sbi_device_probe()?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
	...
	register_sysctl("kernel", sbi_pmu_sysctl_table);

	ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
	if (ret)
		goto out_unregister;
}

Because the ctl_table_header pointer returned by register_sysctl() is not
saved or passed to unregister_sysctl_table() in out_unregister, the sysctl
registration remains active after probe failure.

> +
> +out_destroy:
>  	riscv_pmu_destroy(pmu);
> +	if (irq_requested) {
> +		free_percpu_irq(riscv_pmu_irq, pmu->hw_events);
> +		irq_dispose_mapping(riscv_pmu_irq);
> +		riscv_pmu_irq =3D 0;
> +	}

[Severity: High]
If cpuhp_state_add_instance() fails on a secondary CPU during
pmu_sbi_starting_cpu(), can this cleanup leave the per-CPU IRQ enabled,
snapshot shared memory registered with SBI firmware, and the
sbi_pmu_snapshot_available static branch enabled?

First, in pmu_sbi_starting_cpu(), the per-CPU IRQ is enabled before
setting up the snapshot shared memory:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_starting_cpu() {
	...
	if (riscv_pmu_use_irq) {
		cpu_hw_evt->irq =3D riscv_pmu_irq;
		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
	}

	if (sbi_pmu_snapshot_available())
		return pmu_sbi_snapshot_setup(pmu, cpu);
	return 0;
}

If pmu_sbi_snapshot_setup() fails on that CPU, pmu_sbi_starting_cpu()
returns an error with riscv_pmu_irq still enabled on the failing CPU, and
cpuhp_rollback_install() only invokes pmu_sbi_dying_cpu() on earlier CPUs.
When out_destroy then calls free_percpu_irq(riscv_pmu_irq, pmu->hw_events),
__free_percpu_irq() sees that desc->percpu_enabled is not empty, triggers a
warning, and returns without removing the irqaction before out_free calls
free_percpu(pmu->hw_events).

Second, pmu_sbi_device_probe() sets up the snapshot shared memory on the
initial probing CPU and enables the static key before calling
cpuhp_state_add_instance():

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
	...
		cpu =3D get_cpu();
		ret =3D pmu_sbi_snapshot_setup(pmu, cpu);
		put_cpu();

		if (ret) {
			/* Snapshot is an optional feature. Continue if not available */
			pmu_sbi_snapshot_free(pmu);
		} else {
			pr_info("SBI PMU snapshot detected\n");
			static_branch_enable(&sbi_pmu_snapshot_available);
		}
}

In the error path, perf_pmu_unregister() can sleep and migrate the task to
another CPU before riscv_pmu_destroy() calls pmu_sbi_snapshot_disable() on
only the current CPU and frees the pages via pmu_sbi_snapshot_free(pmu). If
the initial probing CPU was not rolled back by cpuhp_state_add_instance()
(or if the task migrated), its freed physical page remains registered with
SBI firmware. In addition, riscv_pmu_destroy() does not call
static_branch_disable(&sbi_pmu_snapshot_available).

> =20
>  out_free:
> +	free_percpu(pmu->hw_events);
> +	kfree(pmu_ctr_list);
> +	pmu_ctr_list =3D NULL;
>  	kfree(pmu);
>  	return ret;
>  }

[Severity: High]
Can freeing pmu_ctr_list and setting it to NULL here without clearing the
static global cmask cause a NULL pointer dereference in
riscv_pmu_get_hpm_info()?

In pmu_sbi_device_probe(), pmu_sbi_get_ctrinfo(num_counters, &cmask)
populates the file-scope cmask bitmask alongside allocating pmu_ctr_list.
If a later step in pmu_sbi_device_probe() fails, out_free frees
pmu_ctr_list and sets it to NULL, while cmask stays non-zero.

When kvm_riscv_vcpu_pmu_init() subsequently calls riscv_pmu_get_hpm_info():

drivers/perf/riscv_pmu_sbi.c:riscv_pmu_get_hpm_info() {
	...
	if (!cmask)
		return -EINVAL;

	for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
		info =3D &pmu_ctr_list[i];
		if (!info)
			continue;
		if (!hpm_width && info->csr !=3D CSR_CYCLE && info->csr !=3D CSR_INSTRET)
			hpm_width =3D info->width;
		if (info->type =3D=3D SBI_PMU_CTR_TYPE_HW)
			hpm_count++;
	}
	...
}

Because cmask is non-zero, &pmu_ctr_list[i] for any set bit i > 0 evaluates
to a non-NULL offset from NULL, bypassing the !info check and dereferencing
info->csr and info->type. Should out_free also reset cmask =3D 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-443-sashal@kernel.org?part=3D1
