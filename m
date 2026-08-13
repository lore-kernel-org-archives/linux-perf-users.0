Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEB43F4C5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608794; cv=none; b=jSL9y5WvSJGKMmL3IcXsftpzYv/+0UPKYXrMyf6yu4bhyriMq1K9dY0q0UKBUJCRN2Pdwgl6dx2Fv5f97NSfxP01W3c5bwXTBfs8Ve6+wblRYnqfSPJp7Ny6mkO6lKtqCdcBzcOsf/JCNM1ePs9T9h3cSpQRQwakL7YMsbvXvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608794; c=relaxed/simple;
	bh=hUszJT7DVqqMJATEkOnMjeDnjsvph9B7XwzBVSZOLKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/ASu/RgeV7J3P5LDbEQrtokPF43LZyn4n5RQDVv4ghsmkExrWoxAjwghsxKtHzEZuvrFDqn8oNmzI812b/Ug35kD02HlL7X3Zjn1OfgCoeXgZ1j4cLQizMOGUcu/MkwCrLG67WYciwEh6WVGLjubsJfdSOrqXMy/J7/2t3yNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6yEi5S9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6yEi5S9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC7B1F000E9;
	Thu, 13 Aug 2026 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786608791;
	bh=pW3p0eSH7rzd01wy2IEMnkADfql4ralD3m/Ztbwio2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6yEi5S9F16pcSjhZne42zCxqJkyoU/gvv5ODHUTI2RAhxR0HEhzn1kbLSW7ZsVlz
	 TiFPOTO/hzyNtkase4mZPW4dfHmfuTomoc52JyX3HiWRphLgQ6G7FfPo/p7mRNdTrV
	 cjKEmL20rBEmbrTaN4FOT+gALyis7zhjy2/ftcH4csYjQ8bllX8JcYc4pC40mwlhUt
	 jQ/IFFIT3zjltG71m1YTStb3ZTVc9wUgHIsZ/XqlUPX8CjBkK3tt/jiQeMdPkwRkxe
	 rzLJUAVzJvtpbWIK9/W7mVBModxC6y6KTRwKYNBn3M+jTIiGKIZm4uRlcnsqERhH1d
	 JCGcz0BslH/yQ==
From: sashiko-bot@kernel.org
Subject: Re: perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813080314.2836027-1-irogers@google.com>
References: <cover.1691900000.git.irogers@google.com>
 <cover.1691900000.git.irogers@google.com>
 <20260813080314.2836027-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 08:13:11 +0000
Message-Id: <20260813081311.8CC7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Hardware monitors are not disabled on module unload due to cance=
l_work_sync().
- [Low] Out-of-tree version compatibility macro blocks upstream integration.
--

--- Patch [1]: perf: Add Raspberry Pi BCM2835 AXI PMU driver ---
commit bbd5d9f81c5427301be257b124dcb9150ad69d8f
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi
AXI bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to
the Linux perf subsystem.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..676e8f873163f
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
> @@ -0,0 +1,2450 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
This isn't a bug, but does this violate upstream kernel submission
guidelines by retaining out-of-tree backward compatibility code?

Upstream policy generally prohibits including LINUX_VERSION_CODE checks for
backward compatibility in mainline submissions.

[ ... ]
> +static void rpi_axi_pmu_del(struct perf_event *event, int flags)
> +{
[ ... ]
> +			if (mon =3D=3D MON__SYSTEM) {
> +				pmu->monitor[MON__SYSTEM].hw_events.enabled[idx] =3D false;
> +				rpi_axi_pmu_disable_bus_watcher(pmu, mon, idx);
> +				if (pmu->monitor[mon].hw_events.num_monitored =3D=3D 0) {
> +					set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> +					pmu->monitor[mon].hw_events.monitor_running =3D false;
> +				}
> +			} else if (mon =3D=3D MON__VPU) {
> +				pmu->monitor[MON__VPU].hw_events.enabled[idx] =3D false;
> +				pmu->monitor[MON__VPU].hw_events.vpu_disable_pending[idx] =3D true;
> +				schedule_work(&pmu->vpu_work);
> +			}
> +		}
> +	}
[ ... ]
> +static void rpi_axi_pmu__exit(struct rpi_axi_pmu *pmu)
> +{
> +	cpuhp_state_remove_instance_nocalls(rpi_axi_pmu_cpuhp_state, &pmu->cpuh=
p_node);
> +	perf_pmu_unregister(&pmu->pmu);
> +	hrtimer_cancel(&pmu->hrtimer);
> +	cancel_work_sync(&pmu->vpu_work);

[Severity: Medium]
Will this cancel_work_sync() drop the deferred hardware disable commands
scheduled by rpi_axi_pmu_del() during perf_pmu_unregister()?

If the module is unloaded while VPU perf events are active,
perf_pmu_unregister() detaches events and calls rpi_axi_pmu_del(). For VPU
events, this schedules vpu_work to disable the hardware via Mailbox IPC.
Since cancel_work_sync() drops the pending work instead of executing it,
the VideoCore VPU monitor might be left running indefinitely.

Would flush_work() be more appropriate here to ensure the hardware is prope=
rly
disabled?

> +	if (pmu->firmware)
> +		rpi_firmware_put(pmu->firmware);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813080314.2836=
027-1-irogers@google.com?part=3D1
