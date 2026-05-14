Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D11390992
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780074; cv=none; b=b/jI/xcxJ8enr5T0Ko0v7I3wXzLd+z2EeWB+toaqCcw6uM0R3BegIBsQm7BfYp2jggf67cQ0LysNizsUOFzNPsTBMYPGPTRO91CKS9IWRJhsSRIO3EkaKmDZeYhvutKTr8FIjgQ782yAU4iVeootb+spHCw3VfUBmT4EVA0OiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780074; c=relaxed/simple;
	bh=P19FMIXj7eBrKNpREZaHfKGmZCUMOFj+HQCMfclivL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zu1BcXMS+T6aR1jVEhUNV5Nqn4prrxFysUf9rON/FGEiFBsyEsnCVkuo/E19bz76l/2iTde7NfGJaFxZU3xu27n58EqpuCnBkb1URvPE5duioXTJBBjYnLYDMK7xfTP5YhlXAzf5L7v5aDVSXbk51/v9w5WNr3NDp4t+V6qDz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM3Cyc13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM3Cyc13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51DAC2BCB3;
	Thu, 14 May 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778780073;
	bh=P19FMIXj7eBrKNpREZaHfKGmZCUMOFj+HQCMfclivL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YM3Cyc13UaYvPucrU9svYlD1BfqJgJFJLmni575cN9jpHP+O4iqzk55JpOLtPEmxk
	 HNfjbAwMDEYoGvfkCubx0s4iYlfkKabPaJs/6hbGWHxVIchcBqTAsPIEm7RjZ2t9TK
	 gwIDfPIFzu2trOIIxogtTme97nCJpe8zfk0slrq0LjJvN+lqnG1ThKZfmp1Gdr10qY
	 PolEt1hqwDCsOKVQBPZYMElUufr15Izp9d4Dshu5eLEVmhi5O3+FvwbfLA3Nr6lcEb
	 yIpoE4WbSaFkq1YuxDuT+0/s4d9T9C2EzJ/QlIV/STZbVpYi+MHLtqDo5WmnqwHMuL
	 d6wz7YAiXTfkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf: nvidia_t410_c2c: handle PERF_EF_UPDATE in
 stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saurav Sachidanand" <sauravsc@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514010629.76558-4-sauravsc@amazon.com>
References: <20260514010629.76558-4-sauravsc@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 17:34:32 +0000
Message-Id: <20260514173433.B51DAC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Calling nv_c2c_pmu_event_update() in nv_c2c_pmu_stop() causes =
double-counting and massive counter wrap-around corruption.
- [High] Logically stopping the event fails to exclude counts because the h=
ardware counter continues running and start logic is unmodified.
- [High] nv_c2c_pmu_stop() incorrectly uses an early return on PERF_HES_STO=
PPED, permanently dropping final counter updates.
- [Medium] nv_c2c_pmu_stop() fails to set PERF_HES_UPTODATE after updating =
the event.
--

commit 1d56e58b1d1592eb3b08b91d9c3d09bd821ef6ad
Author: Saurav Sachidanand <sauravsc@amazon.com>

perf: nvidia_t410_c2c: handle PERF_EF_UPDATE in stop

This commit updates nv_c2c_pmu_stop() to read the final counter value when
called with PERF_EF_UPDATE, aiming to prevent lost counter deltas when the
perf core removes the event.

> diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t41=
0_c2c_pmu.c
> index 662fa1bc833a5..39d0e661e4c5c 100644
> --- a/drivers/perf/nvidia_t410_c2c_pmu.c
> +++ b/drivers/perf/nvidia_t410_c2c_pmu.c
> @@ -394,6 +394,12 @@ static void nv_c2c_pmu_start(struct perf_event *even=
t, int pmu_flags)
> =20
>  static void nv_c2c_pmu_stop(struct perf_event *event, int pmu_flags)
>  {
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;

Does this early return permanently drop final counter updates?

If the core stops the event without requesting an update first (for example,
via pmu->stop(event, 0) during event throttling), the event is marked
PERF_HES_STOPPED.

When the core later attempts to drain the final unread counts by calling
pmu->stop(event, PERF_EF_UPDATE), the early return will trigger and the
final update will be entirely skipped.

> +
> +	if (pmu_flags & PERF_EF_UPDATE)
> +		nv_c2c_pmu_event_update(event);

Can this cause double-counting and massive counter wrap-around?

The perf core wraps event teardowns within perf_pmu_disable() and
perf_pmu_enable(). For this PMU, nv_c2c_pmu_disable() halts global
counters, calls nv_c2c_pmu_event_update() to accumulate final counts,
and then explicitly sets event->hw.prev_count to 0.

Subsequently, pmu->del() calls nv_c2c_pmu_stop() with PERF_EF_UPDATE, which
redundantly calls nv_c2c_pmu_event_update() again. Because prev_count was
just reset to 0 but the stopped hardware counter still retains its final
value V, the second update computes V - 0 =3D V and erroneously adds the fu=
ll
lifetime count to event->count a second time.

Additionally, this second update overwrites prev_count with V. When the PMU
restarts, the physical counters clear to 0. The next update will read a
small new value W, calculate W - V, and cause a massive unsigned 64-bit
integer underflow.

Also, if the event is stopped logically without disabling the entire global
PMU, the hardware counter continues incrementing. Since nv_c2c_pmu_start()
is unmodified and does not synchronize prev_count to the new running
value, won't all counts accumulated while the event was logically stopped
still be incorrectly added to event->count upon the next update?

> +
>  	event->hw.state |=3D PERF_HES_STOPPED;

Should this also set PERF_HES_UPTODATE?

The standard PMU stop pattern usually sets PERF_HES_UPTODATE after an
update so the core knows the software counter is synchronized with the
hardware.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514010629.7655=
8-1-sauravsc@amazon.com?part=3D4
