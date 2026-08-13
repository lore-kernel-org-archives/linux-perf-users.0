Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCB478E5E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631902; cv=none; b=rIDBapfDCGEeeenmHDHI+zfX1x4l/q59b8ObPM7mtPfZ0yCOMpcdrwBtNSD+gHZVWouADkqCcnGSRFxv06XCYRkbR9DZDU3+sXsZA9TTF9oxfb9ERM4lEoZVk/AnMstQOkDRFqd6bHbpbF21owgIa+I9pQhrLARgBji3iZsOeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631902; c=relaxed/simple;
	bh=qOO1zoga4YQMUaSwpq+rhZ8vYi9VXtv/8dCfmAiiDMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+xGTuoxdiy55Cym3xQhWlYnASXDbxTsHedtvH/tSAj8R98E45EgUuqWdlUxsQK64oQe/kvZ5XOMLc0d2jMi2OcZbbrv+lVYcjjqdcxQ/Im2R9OTOFj9pgjFjRXcGuKVu8HbUsWUHaksOrA3tk/J3Nx+CJJ7MemfGkzJqszAeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQWrk08V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQWrk08V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE16A1F000E9;
	Thu, 13 Aug 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786631901;
	bh=kqevgQi/me9iENTXnQrZocUfVO++yNL/ljRa80hLbHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQWrk08VITh1XaxrluJd4U+z4aSwSSWGMqajbZ5FrjS/mW+Uskp2OiRBQnAnkvdSz
	 un+ErcvwHyZ3npkV8yJXK+avM+G4kTT2nfO9YC5IjR2rrjdidTQutIhsZHpGaKu5I8
	 imBz9LPATOtOIB7LFcdWHimyFjNYqV8EM+lR1hEJejENH6SmJ8pm9PX9DRbcdfsSRQ
	 ghnAXvOTTEY3br/8XFRf8uy1kENUqYK0146+PanYElZIFdaq2mVPLLnqcERh3dfuLo
	 u1f5XPQJxWhVPPdVbutuJK0JLZRYEdL6Lh1cXWphzCchI1lUgZPQ86WdGtRZwwGq65
	 IT1Jdxl+WK+ZQ==
From: sashiko-bot@kernel.org
Subject: Re: perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813142608.2954099-1-irogers@google.com>
References: <cover.1691900000.git.irogers@google.com>
 <cover.1691900000.git.irogers@google.com>
 <20260813142608.2954099-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:38:20 +0000
Message-Id: <20260813143820.CE16A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition leaves PMU permanently bound to an offline CPU if=
 a CPU goes offline during probe.
--

--- Patch [1]: perf: Add Raspberry Pi BCM2835 AXI PMU driver ---
commit 0a57b13469fd53b31d259c68ce322f804972b736
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi
AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to
the Linux perf subsystem.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..31fa94507f4ab
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +static int rpi_axi_pmu_offline_cpu(unsigned int cpu, struct hlist_node *=
node)
> +{
> +	struct rpi_axi_pmu *pmu =3D hlist_entry_safe(node, struct rpi_axi_pmu, =
cpuhp_node);
> +	unsigned long spinflags;
> +	unsigned int target;
> +
> +	if (!pmu->is_registered)
> +		return 0;

[Severity: Medium]
Does this early return leave the PMU permanently bound to an offline CPU if
a hotplug event occurs during probe?

Looking at rpi_axi_pmu__init(), there is a window where the hotplug state
is registered but the PMU is not yet marked as registered:

	ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node=
);
	...
	ret =3D perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=3D*/-1);
	...
	pmu->is_registered =3D true;

If the designated CPU goes offline in this window, rpi_axi_pmu_offline_cpu()
will be called but immediately return 0. This bypasses the migration logic
that would normally update pmu->cpu to an online target.

Once the probe completes, the PMU would remain assigned to an offline CPU,
which could cause perf_event_open() to fail with -ENODEV until another
hotplug event forces a reassignment.

> +
> +	if (cpu !=3D pmu->cpu)
> +		return 0;
> +
> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >=3D nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +	pmu->cpu =3D target;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813142608.2954=
099-1-irogers@google.com?part=3D1
