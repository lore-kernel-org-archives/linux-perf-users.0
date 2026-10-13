Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028451AFD4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918418; cv=none; b=lEeWZi+Cj8rr2QpD3A4TF+dTm642r8KQiR/4sifZ6B8pKs7GZ0FRboEJLpIKDGsGdLQSv1mXH5Kj5sKSxuXWMGC6AYaOM1XHj22EhaITv9yrhge3pqvI+xBhrpXgkcUC1QavhtXyinryBfJXNW/PtqHdiuOKSivwe2VLHzagj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918418; c=relaxed/simple;
	bh=JXFP5cabR7RJfSlhpAWi99rAKKLJgJQXOevTM6kmOa8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S2jgS2JTmxmMtrpWWjvzqCpfLuEU/5n+hJ1QoZQQpDpR8uUbheKbS5l+gFGB5nolOjFDcl+4hakhfva1Z+zIGsvnmPVCr85fmtXA8GEQqrV1J1uo1GSPTol19f3seQGkBLIPkUe+dBIqis4DuT01yBVDLph1reJo5CZFlOgrLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL1Apgqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL1Apgqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8659A1F00893;
	Tue, 13 Oct 2026 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918416;
	bh=oh/8NrXqARC+ijXZ5yzMrnjSIJMtJSmWZUiMGNzUAss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DL1ApgqkBKJrLN41vugUTJzJuh+U++v5c6Vqc/f2ynfUb9mfysB5AhFWrS/jICUHk
	 iG9gxaI+oMyQKHCxc5VFzlJUxcJb6TMnQMSaUBDyTbVntfcWWPMiucNtBNs7P66YgA
	 w3Y80CZ1tM51nN4MaWBIWwt3Q1vg4QG9W3uMwb30QJZNXrsOOzTpc4QoXDdp1pmelO
	 cRcVluPkP4bQTas3ZVtBs1pIP4AVAic9ELcl7FUOqS/LukxCUAX0xWG3RfsnsGD5FT
	 5U+pzKcnZu+K1CyJbEAL81aWjinfGB+1bzAaNE4n2YsuDwlg2wNecqE899y4yRn65M
	 w1ZuI44TV82Hw==
Message-ID: <sashiko-outbox-170379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf/arm-cmn: Convert to PERF_PMU_SCOPE_DEVICE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013185603.1347265-5-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-5-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 19:06:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/arm-cmn: missing hardware disable on probe error path
--

commit baed79d02fccb15f4bbc09054f99c378f1c3c918
Author: Haris Okanovic <harisokn@amazon.com>

perf/arm-cmn: Convert to PERF_PMU_SCOPE_DEVICE

This commit sets the ARM CMN PMU scope to PERF_PMU_SCOPE_DEVICE and removes
the driver-tracked cpu, hotplug hooks, and the cpumask attribute. It also
defines filter_allowed_cpus() and migrate_cpu() callbacks to keep preferenc=
es
for local NUMA node CPUs.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b162de3d9d169..00ffe45963244 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
[ ... ]
> @@ -2881,17 +2836,13 @@ static int arm_cmn_probe(struct platform_device *=
pdev)
>  	if (!name)
>  		return -ENOMEM;
> =20
> -	err =3D cpuhp_state_add_instance(arm_cmn_hp_state, &cmn->cpuhp_node);
> +	err =3D perf_pmu_register(&cmn->pmu, name, -1);
>  	if (err)
>  		return err;

[Severity: Medium]
If perf_pmu_register() fails here, does this return without explicitly
disabling the hardware, leaving it in an active state?

In arm_cmn_remove(), we see the driver disables the hardware:

    writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);

Since arm_cmn_init_dtcs() was called earlier in arm_cmn_probe(), should the=
re
be an error handling path to write 0 to CMN_DT_DTC_CTL if registration fail=
s,
to avoid leaking hardware state?

> =20
> -	err =3D perf_pmu_register(&cmn->pmu, name, -1);
> -	if (err)
> -		cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node=
);
> -	else
> -		arm_cmn_debugfs_init(cmn, this_id);
> +	arm_cmn_debugfs_init(cmn, this_id);
> =20
> -	return err;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013185603.1347=
265-1-harisokn@amazon.com?part=3D4
