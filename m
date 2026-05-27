Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489F3203B6
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914748; cv=none; b=YmxTqs/6f/3aUpcpBKMHl5JIUF8CWnrhYEUPbVrfZjPe6xKydbXQzg69T4f2WsA7zCo+H1/HY7Qe36scpms7ZGiF/ptMNnV5DvX4HH8IE40VtrS+wfV+hfAxhFFc0LK5BoCv2f22OXvWs1mqmh4sK5FUVDwGIaA4GmPfOH5EUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914748; c=relaxed/simple;
	bh=hcWBxsBepECWNMYXxlLmOuimBDC3+IfynmSXGDx8jNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bam1BT9QSG9Kt6PLGav5qxtFpKp/AmefTsS4icozS37C4JGNUwqgnAVfuwHNB+dbG2PPynfFi8MvdHy5418GZU/a9YBGacC/DwmTKcECXdN4MEoszHurAzJHX3ffNwHIXskFmNEa1X8/jp+zfq12AVgh60Di3PGSCv10sE75uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjKvMSXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjKvMSXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D11F000E9;
	Wed, 27 May 2026 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779914747;
	bh=+sd4hOCEzi9py7VRPKIzbVObDWFoZV1hsDPMcq7qSkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjKvMSXDKqg5xB6w+grhByHKRoiiurVv4nBb8iIdaZxDKyl1xjGpoUP1xvG6+HMrJ
	 tacvrlq3/JlPgu16o0kql8Mpu9s8p0UNtbp9BEfWxhHXK+BxGpkaWdGp/VHPutrnBf
	 vnr8iA4uNJqWm8HVkd6+RwTWdLzeu/XxJsMIhP4Mt5WWSH1K/bQl5lxqD/mGkbXygl
	 1adm38bybSleyVy0JMuaQl8vaEzeqyAVWTBUc9c11Q0B/pENXHyCivyewObHTWGX1r
	 YfPd0FVVRLhT+pgREYT7hvu1HHM4csegfx3jOgKQdT+flwKYQFDC5uyO2eAF0nIEAu
	 6U54R+TFn56mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527151154.130505-7-zide.chen@intel.com>
References: <20260527151154.130505-7-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 20:45:46 +0000
Message-Id: <20260527204547.2E3D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling `uncore_die_to_cpu()` without holding `cpus_read_lock()` i=
ntroduces a race condition with CPU hotplug, potentially aborting PMU disco=
very.
- [High] Use of the unsafe `wrmsrq_on_cpu()` function with an unvalidated M=
SR index can trigger a General Protection Fault (#GP) and crash the kernel.
- [High] The required global initialization write is only performed during =
discovery and is missed upon system resume, leaving PMON units uninitialize=
d after sleep.
- [Medium] PMU discovery permanently fails for a die if all of its CPUs are=
 offline during module initialization.
--

commit d885055ecaea97356a710a83b6d4de7ee7d6ba76
Author: Zide Chen <zide.chen@intel.com>
Subject: perf/x86/intel/uncore: Implement global init callback for GNR unco=
re

This commit implements a global initialization callback for GNR uncore to
explicitly write 0 to the global control register at boot. This triggers
hardware initialization properly for UBOX PMON units on Sierra Forest and
Clearwater Forest.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 4b3a1fa5b41b7..7857959c6e823 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
[ ... ]
> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>  	return 0;
>  }
> =20
> +static int uncore_msr_global_init(int die, u64 msr)
> +{
> +	int cpu =3D uncore_die_to_cpu(die);
> +
> +	if (cpu =3D=3D -1)
> +		return -ENODEV;

[Severity: Medium]
If a die has no online CPUs during module load or boot, this will return
-ENODEV and abort parsing the discovery table for that die. Since there
is no mechanism to re-trigger discovery when a CPU on that die is later
brought online via hotplug, will the uncore PMUs for that die remain
permanently unavailable?

[Severity: High]
Is this safe against CPU hotplug? uncore_discovery_pci() invokes
__parse_discovery_table() without holding cpus_read_lock(). If the
selected CPU goes offline in the narrow window between uncore_die_to_cpu()
and the subsequent wrmsrq_on_cpu() call, smp_call_function_single() will
return -ENXIO and silently abort PMU discovery for the entire die.

> +
> +	return wrmsrq_on_cpu(cpu, msr, 0);
> +}

[Severity: High]
Can this trigger a General Protection Fault (#GP)? The msr parameter is
derived from a 64-bit value dynamically read from the hardware/firmware
discovery table. If the firmware provides an invalid value, an MMIO physical
address, or if the table is corrupted, wrmsrq_on_cpu() will execute a bare
wrmsr instruction. Should this use wrmsrq_safe_on_cpu() to gracefully handle
invalid MSR indices?

[Severity: High]
Since domain->global_init() is only called once during initial uncore
discovery, what happens during S3 suspend or hibernation? The hardware drops
power and loses its state, reverting the FRZ_ALL bit back to the default.
Without a suspend/resume callback to re-trigger this explicit global
initialization write, will the UBOX PMON units silently fail to work after
the system resumes from sleep?

[ ... ]
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index af2217b44a814..e36613d934b1f 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
[ ... ]
> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_disc=
overy_domain *domain,
>  	if (!io_addr)
>  		return -ENOMEM;
> =20
> -	if (domain->global_init && domain->global_init(global.ctl)) {
> +	if (domain->global_init && domain->global_init(die, global.ctl)) {
>  		ret =3D -ENODEV;
>  		goto out;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527151154.1305=
05-1-zide.chen@intel.com?part=3D7
