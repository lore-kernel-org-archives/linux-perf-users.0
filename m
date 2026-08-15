Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867531A6817
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815361; cv=none; b=JNc0rVEIxuhrxWMYpZseZHbB2fnz5O2YJJj833rdarH4mXybt2aViIYbgURgI6Q2Z23b3eugJpW7cefegbP6ejxb44z/gCUbknHypGzwybwcB7ptb+9sBxKuzxgu9sj2BAcYWowNmLxEJOG5PUxWA/Gv1qx5sDL+jgXjEADVJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815361; c=relaxed/simple;
	bh=iDZlmM+UUPEGiEgTh6GYaga1G0xnxBKVXKn7QGsTUzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZd4CBOEtkLiP22Ku8gs99TL523aPF8muIYu6aNgBWjBuuXOd8f0DkcIRuAS9p/Okh2LwvImOx7ffyykK0f8/m5BHAWBnlUvTT2HY9YUGzqyoOwWsGYnqoLF0W/1SbO1FvIw4G67Hmg2UqyVm4u4tl60R+qFRVkzMS4zhjj+vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCNhB0CN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCNhB0CN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F431F000E9;
	Sat, 15 Aug 2026 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815360;
	bh=GBfoRtJ73leNvnCeFiJUZH0TyhXNROEarMl1Ywo7he0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCNhB0CNke9DyIN7e4UX8jQzKr4cJZsSq4/pmZ/sIJ/0kmTx9/oCSztbTTRGum3d1
	 3xDSXg2WSC6nGflC+2MV4fmJH/NzplgPU4G8hoaMhPUCkVHDRjP1n1+hg3JdSYm+f3
	 sXCI7YCw7WLR+H953IQz7AAcK8+ne/zZsOfAalfO5iHO0RaK3dEeR+rKczJlcHR3Op
	 1flOiKgTlNHypwnO+EOF2hfv2VZKGtfjs+v2jls9rRHeC5qQsXLP8Rl1emJ0tqBkRY
	 aYutOv4/EpnSegGWy4ZfFrDsEO8qcSiBxCaUwiakcQW+Hf5S6HPaAIXdPfSIpdrb0u
	 TbjFFKaAPIn8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815172712.50119-3-irogers@google.com>
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:35:59 +0000
Message-Id: <20260815173600.10F431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Inclusion of LINUX_VERSION_CODE checks for out-of-tree/LTS compatib=
ility in mainline code.
--

--- Patch [2]: [PATCH v13 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU drive=
r ---
commit c667a74c49bf6e5e64002019c6914cc36bf088da
Author: Ian Rogers <irogers@google.com>
perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi
AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to
the Linux perf subsystem natively via the VideoCore mailbox interface.

> Note on out-of-tree macro compatibility:
> The inclusion of #if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> surrounding hrtimer_setup is intentionally maintained alongside
> this patch to guarantee seamless out-of-tree compilation fallback
> compatibility for Raspberry Pi Long Term Support (LTS) kernel variants.

[Severity: Low]
This isn't a bug, but does upstream accept LINUX_VERSION_CODE macros for
backward compatibility in mainline code? Upstream policy generally prohibits
adding backward compatibility ifdefs to support out-of-tree or older LTS
kernels. All code submitted to mainline is expected to compile against the
current kernel's internal API, leaving backward compatibility to stable tree
backporters or out-of-tree maintainers.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +#include <linux/io.h>
> +#include <linux/version.h>
> +
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
Can we remove rpi_hrtimer_setup() and the LINUX_VERSION_CODE check from
drivers/perf/rpi_axi_pmu.c? As mentioned above, maintaining out-of-tree
compatibility macros adds unnecessary code complexity to the mainline kerne=
l.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815172712.5011=
9-1-irogers@google.com?part=3D2
