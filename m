Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71C3A544F
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788670116; cv=none; b=EK30/Kb/7LYs9nELTe7IZ8Shmg1ccOkO5qS7UlcAkCA3OTjSZOPbuskCnd3LOspS1378cl4zbnlSlITHK4849BHLACzaNTcwZTbZNSx+j7wruQPmxAJAG1mxTT13qz0crVh/Jzyo8o3M2GspgUhT15QzhwCZanHTI/hv0P0rZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788670116; c=relaxed/simple;
	bh=g1MA6CUBk9+EZsX2voNoMtR890Q+TK8y6MCzSD8FmXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVlofOpmXVMF/rky9cMR49JhP28yt7FSNMSNu5rDqDNo8Cyw5r1ny3u2J4ZeFKnH398rictsmdzt2t4pPb4SURvnd4Cal3CvT2kBxNPkiv+xyB4+6FdcBP1yalm/FrSRgHvlYFeXesNcIs0GP2otGn8goLOWQ6xvs1Fox641HcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlBsEroq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlBsEroq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D0E1F00A3A;
	Sun,  6 Sep 2026 04:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788670114;
	bh=ENvmR8KRXzptQT33ZrzlY1BvndnRFzVWtmSCMaszTXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlBsEroqESOG+nqwYNZJc5TvZJLLougONLyrEz1J3Ko3eQVcJP1tg+QIpM63KXyDa
	 lBIkf1k0YwLcEhbdbYdXd449mKqhZltP8SSPJKMHnfEY1A3vx/1KJHWahJeAZKv4mp
	 HhC37wo1KBqDGtinK0TSV2l6DnE/HzJtlh+QsgsUEOdmAsqVj/F0YRCeSokmMtNJ/N
	 p32F/LeGi/TKHd7Rat4MBvHNw9WTX3dzhYEn3C0dhaWRmieqW5P2zp4aQjVx3+G0oU
	 B1B59I99ghynhMXGIUB2a0XqwOe0fi/UOXO+X4/bYpVxC/j0XwOBAsXW13vzOmJ3ml
	 TfIerYNVVnDUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/riscv: clear snapshot setup state when a CPU goes
 offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <hppiscas@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
References: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 04:48:33 +0000
Message-Id: <20260906044834.53D0E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Physical memory Use-After-Free (UAF) due to asymmetric snapshot se=
tup and incomplete hotplug rollback on probe error path.
--

commit c8b38f834fd4fa2192da97b2008485ecc2fc9177
Author: Pengpeng Hou <hppiscas@163.com>

perf/riscv: clear snapshot setup state when a CPU goes offline

pmu_sbi_dying_cpu() disables the calling hart's SBI PMU snapshot shared
memory but leaves snapshot_set_done set. When the CPU comes back online,
pmu_sbi_snapshot_setup() returns early without registering the shared
memory again. This patch clears the per-CPU setup flag after snapshot
disable succeeds so it can be registered again.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..f38a64c7b8565 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -1182,8 +1186,12 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, str=
uct hlist_node *node)
>  	/* Disable all counters access for user mode now */
>  	csr_write(CSR_SCOUNTEREN, 0x0);
> =20
> -	if (sbi_pmu_snapshot_available())
> -		return pmu_sbi_snapshot_disable();
> +	if (sbi_pmu_snapshot_available()) {
> +		ret =3D pmu_sbi_snapshot_disable();

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about how
pmu_sbi_snapshot_disable() is used during probe error handling.

In drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe(), the shared memory
is manually registered with the firmware for the current CPU:

	cpu =3D get_cpu();
	ret =3D pmu_sbi_snapshot_setup(pmu, cpu);
	put_cpu();

Later in the same function, if cpuhp_state_add_instance() fails, the
hotplug loop aborts and rolls back, but leaves the boot CPU's firmware
snapshot active. The probe aborts and calls riscv_pmu_destroy().

In drivers/perf/riscv_pmu_sbi.c:riscv_pmu_destroy():

static void riscv_pmu_destroy(struct riscv_pmu *pmu)
{
...
		if (sbi_pmu_snapshot_available()) {
			pmu_sbi_snapshot_disable();
			pmu_sbi_snapshot_free(pmu);
		}
...

Since pmu_sbi_snapshot_disable() only executes locally on the current CPU,
and we may have migrated to a different CPU during the error path (e.g.,
after perf_pmu_unregister() blocks), doesn't this leave an active dangling
physical pointer in the firmware for the original CPU?

If pmu_sbi_snapshot_free() frees the physical pages for all CPUs, and the
firmware later writes PMU event data to this freed physical memory page,
could it cause memory corruption in whatever kernel subsystem reallocates
that page?

> +		if (ret)
> +			return ret;
> +		cpu_hw_evt->snapshot_set_done =3D false;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/caplitmus-rv.75b0e9=
ee82984422ba17d833767912a8.d33@163.com?part=3D1
