Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B04287246
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195394; cv=none; b=rGnVqMGZcNywDAVnM1JBIHQ2l9Hn2YopTyQ5Q506xoGPDIqc0RUMCXDa017utSd+q6a3wi6Nplx+Qe1iyCuHVNptmWuXpqyXxmsctrFSI7KoYB2qYwUosEPCIbIxuyOjARVApKQKoV2qskd+TdT3+UVuWNrGhExBhgDcjyNMiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195394; c=relaxed/simple;
	bh=1d1fGkuMiO1sFsU3lLM1hIS5Q2oK1gRscR0SVFduhBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=upFNw1DsQMQLbF4iWi1bmXEo+1MVcrnvy3VuR/tqCoR2YDH8Tm4kmqPJtlQurIMFZKJEHz36tcmA0alwBl/0ca8/Lc0+SSj3ZCEzMTGDdqeMQ7P20h9oukJ2ZX3R/R7bq2Otxdbvli+TLWJyeHEahyqwr4qeu96aao26EYpX3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB+byVhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB+byVhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD18A1F00893;
	Thu, 11 Jun 2026 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195392;
	bh=qjX8rVQJiWp9SnOoVFaPxIOCUGQZMlXwWJoHQrEiPPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB+byVhCb65i8ECUdox/Cyc+zElbZkcgUUfyd69LihbrliFOLjFc+K7m8GD25eVSt
	 wNwiFunQ8c0qq76PQJI4BmPm1HkIzhluLluBidJyyR8T+KJEVIwxjwHU/JTqHVmZN+
	 LF7gi2qGvKkFeweYzJNQ/5wypWWcRboS/IUFlz6aaw8EFFNCy8ecOfA+VrgedtciCs
	 4uprVDW8pzw1pHbS5U6cJhlr0fA+tPyiBmK2F0Vqb7pOGmZ01GhSErkhEKccTuat9f
	 jAwkQF/rzM+0UNTnh0HJ44etIUeCAi+5tYd/tUiyVhZWyvsIt3GHKtXsjUO4T6NLto
	 MK90VqjpSa3nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 7/8] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611160033.66760-8-zide.chen@intel.com>
References: <20260611160033.66760-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 16:29:52 +0000
Message-Id: <20260611162952.AD18A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tearing down the uncore box (unmapping MMIO) before the perf core =
stops active events causes a use-after-unmap during CPU offline, leading to=
 a kernel panic.
--

commit e2e044b2e3ac13715fc0c671d7186d9b5f0626a5
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Fix uncore_box ref/unref ordering

This commit swaps the call order in the CPU online and offline paths
so that uncore_box_{ref,unref}() runs at the point where the box CPU
reflects the correct context.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index feb8c3b0076b2..b9ac2f7d31caa 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1580,9 +1580,15 @@ static int uncore_event_cpu_offline(unsigned int c=
pu)
>  {
>  	int die, target;
> =20
> +	/* Clear the references */
> +	die =3D topology_logical_die_id(cpu);
> +	uncore_box_unref(uncore_msr_uncores, die);
> +	uncore_box_unref(uncore_mmio_uncores, die);

[Severity: High]
Will this early unref cause a use-after-unmap panic during CPU offline?

During CPU offline, the CPUHP_AP_PERF_X86_UNCORE_ONLINE teardown callback
runs before the CPUHP_AP_PERF_ONLINE callback.

When the last CPU on a die goes offline, this uncore_box_unref() drops refc=
nt
to 0 and calls uncore_box_exit(). For MMIO PMUs, this leads to
iounmap(box->io_addr) without clearing the box->io_addr pointer.

Later in the offline process, the CPUHP_AP_PERF_ONLINE callback runs
perf_event_exit_cpu_context(), which stops active events via:

uncore_pmu_event_stop() -> uncore_perf_event_update() -> uncore_mmio_read_c=
ounter()

Since uncore_mmio_read_counter() does this:

arch/x86/events/intel/uncore.c:uncore_mmio_read_counter() {
    ...
    return readq(box->io_addr + event->hw.event_base);
}

Will it proceed to read from the unmapped box->io_addr because the active
events have not been stopped yet?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611160033.6676=
0-1-zide.chen@intel.com?part=3D7
