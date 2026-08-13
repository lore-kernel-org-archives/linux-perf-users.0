Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC489413D62
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603918; cv=none; b=j7MBHIyFR5uNq6zMf7YEA2gfp4NHGPAs43P+zcy7ncB9ech/Hmc0jryy9es9dyN2ZVz9VwfgNYWn3Loar9sNo7f2p9+LvOQpIymRCM3b80/dfgEJv2LoC90tAyCxP7z06Zc6J+IvNBuWt7qMYMBkw6fYCQCdLxkAwYi9S7rMcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603918; c=relaxed/simple;
	bh=VL4s4T7CmazyGem2nQEMAoLlPT5TqlSjXSsmY6wJhNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zda3ICKwgL8V39bGyLgt8VwL69NfatPNSsCPXKbTI0pnChTiaNLteXC0geiw9K+yPCo4f2fvP92KwXqw4YkyJ9zsZM/LMkjwtcTATf8U35lwMDt7fVYQs/yy0YPjeEdR8C1P+50D0hjJTu9xypCot0qWRTlhZK0rfOeu1CS5uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvXoRM6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvXoRM6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2051F000E9;
	Thu, 13 Aug 2026 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603917;
	bh=T6DxXIJ0slsNiwY0e2rJj3U4qhSB/9Enqjb3QXqzvPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvXoRM6RaOT5m+XizRODlW6c2/PZ+JByy62WzOZzw5kUk5Yk5WN9FqHav/lokqvdW
	 y6tqAhYJQYTYxziqaGl8/b4MlghuaQUVR+yZ6pjcg386ef9/acAsB3Utsv0muODeWP
	 QjZeSNFHyvpZJ4Lo75wieebRRaSR6K6LCq4jwZL6FGuixV93y1rExh9jv4D+VkUVXO
	 b4yp98wHMW23cpdmmddsVbD6s9ds2EYhl4CTVBlVL9e46ynfG/lFdTBBehzo94EFc0
	 35hC2BdR13/ndUZkW7bOkBl/anljg1RX5f6ZhYL1lj8FgO2ts9mlWbFuoDoU28G0/E
	 zdVo7rOnamhHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813064228.2799872-2-irogers@google.com>
References: <20260813052419.2770841-1-irogers@google.com>
 <20260813064228.2799872-1-irogers@google.com>
 <20260813064228.2799872-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:51:57 +0000
Message-Id: <20260813065157.5B2051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Registering the PMU before completing all initialization steps cre=
ates a use-after-free race condition if probe fails.
- [Low] Usage of `#if LINUX_VERSION_CODE` shim for backward compatibility i=
n an upstream patch.
--

--- Patch [1]: [PATCH v8 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit e754b178c7f623d2ebff89b932e852beed8622b9
Author: Ian Rogers <irogers@google.com>
Subject: perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi=20
AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to=
=20
the Linux perf subsystem.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..676c2a3d5962e
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> +static inline void rpi_hrtimer_setup(struct hrtimer *timer,
> +				     enum hrtimer_restart (*function)(struct hrtimer *),
> +				     clockid_t clock_id, enum hrtimer_mode mode)
> +{
> +	hrtimer_init(timer, clock_id, mode);
> +	timer->function =3D function;
> +}
> +#define hrtimer_setup rpi_hrtimer_setup
> +#endif

[Severity: Low]
This isn't a bug, but is this version compatibility shim intended for upstr=
eam=20
inclusion? Upstream patches typically target the current API of the tree th=
ey=20
are being merged into without including out-of-tree macro shims for backwar=
d=20
compatibility with older kernels.

[ ... ]
> +	ret =3D perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=3D*/-1);
> +	if (ret) {
> +		dev_err(dev, "PMU register failed %d\n", ret);
> +		goto err_teardown;
> +	}
> +
> +	ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_n=
ode);
> +	if (ret) {
> +		dev_err(dev, "Failed to add cpuhp instance %d\n", ret);
> +		goto err_pmu_unregister;
> +	}

[Severity: High]
Could this expose a use-after-free race condition if probe fails here?

When perf_pmu_register() completes, the PMU is exposed to userspace. If=20
cpuhp_state_add_instance() fails immediately after, the error path goes to=
=20
err_pmu_unregister and calls perf_pmu_unregister().=20

However, perf_pmu_unregister() does not revoke existing open events. If=20
userspace opens a perf event on this PMU in the small window between=20
registration and unregistration, the event will retain a pointer to the pmu=
=20
struct.=20

Because the pmu struct was allocated with devm_kzalloc(), it will be freed=
=20
by the devres manager as soon as the probe function returns the error, leav=
ing=20
the open event with a dangling pointer that can corrupt memory upon subsequ=
ent=20
accesses. Would it be safer to register the CPU hotplug instance before=20
exposing the PMU to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813064228.2799=
872-1-irogers@google.com?part=3D1
