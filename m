Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E71368D62
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606812; cv=none; b=O8RHhrH6Cs0SPuUubw+shMhGZaGcX4SUifcrPs7QAx5QCzR9tSW5BOCamUWJrn1b3PCl89h7iSyigHJD4Fj8zLrCHEOtFZC/hgYO/m+Wpz7UYBYMmP8FQcZ7+2gN4aaT6iMT1QX2Frgx6JtAJP5ikCXdQ4NNKWFk896Vq95H9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606812; c=relaxed/simple;
	bh=o5acrUxknRE3bOVjG9//B/7L3Bo6nrNQu2c0YsViR+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ufTWtUPxf2Zo/W2r55GgVu66/zgmUDMP4RP86Jb5O4OdDOqTez3BIRa6hcILD9DTQ9pJ9A0W/sBuN9l01/cabbpv1JLMr+JeW8F7RjqKwe1Z9LOMUElHpEDDhvLoYChFWS9PVAiJCLUDLV2JWIIBDjnPr+zjmgNQHZow0AjVg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoA8aAKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoA8aAKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE4C1F000E9;
	Thu, 13 Aug 2026 07:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786606808;
	bh=2PvFwi69ADEPhLo8gTcH8avBtRh/YjqjSjSJP+59Diw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HoA8aAKz5rxvM3SgzaTHKhweBbtMo19DEIXcxIw6snniW4OBGd1aeLD7KgDUJ3UNq
	 HlEuWKb4VQxl7v1rB2RLrAD8lrBuJN2Yhqfb4DQrw09BsSLfMoiuc3UkN1ngDgy1ND
	 vy1aWLgA54oHZYfBFzdMQ5JqOVfHHhGJkU82Mx5DY4cyetroIp/2Ycw0ENLLHTvTEW
	 ucERwdtDW8apjAucEZAIGnnBEUT7EBN7+ocn40ck9H9uwAFaT2wwSTKTHBkYXTEffZ
	 n44lAPr2TWkyPCPVKO4rULEZexJlOPHLLesSltWWZRbr8f0UPe1EGVsZjfB7W0OFlK
	 ZJmOh3EjZk5Kg==
From: sashiko-bot@kernel.org
Subject: Re: perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813073050.2823657-1-irogers@google.com>
References: <20260813064228.2799872-1-irogers@google.com>
 <cover.1691900000.git.irogers@google.com>
 <20260813073050.2823657-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:40:08 +0000
Message-Id: <20260813074008.5FE4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `num_started` field in `struct rpi_axi_hw_events` is modified b=
ut never read or utilized.
--

--- Patch [1]: perf: Add Raspberry Pi BCM2835 AXI PMU driver ---
commit 0a35d2ad48de3bdbbbe637f581c580caecb30465
Author: Ian Rogers <irogers@google.com>
Subject: perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a new performance monitoring driver for the Raspberry Pi A=
XI
bus (BCM2835/2711), exposing system-level and VideoCore PMU hardware to the
Linux perf subsystem.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..d8efc8bb205fe
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
> @@ -378,9 +378,9 @@ static bool config_is_valid(struct rpi_axi_pmu *pmu, =
__u64 config);
>  struct rpi_axi_hw_events {
>  	int monitored_bus[NUM_BUS_WATCHERS_PER_MONITOR];
>  	int filter[NUM_BUS_WATCHERS_PER_MONITOR];
>  	int refcount[NUM_BUS_WATCHERS_PER_MONITOR];
>  	int num_monitored;
>  	int num_started;

[Severity: Low]
Is this num_started field needed? It is tracked in both the start and stop
paths, but it does not appear to be evaluated or read anywhere else in the
driver, making it unused state tracking.

[ ... ]

> @@ -2033,10 +2033,10 @@ static enum hrtimer_restart rpi_axi_pmu_timer_han=
dler(struct hrtimer *timer)
>  static void rpi_axi_pmu_start(struct perf_event *event, int flags)
>  {
>  	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
>  	enum monitor mon =3D config_to_monitor(event->attr.config);
>  	enum counter counter =3D config_to_counter(event->attr.config);
>  	unsigned long spinflags;
> =20
>  	raw_spin_lock_irqsave(&pmu->lock, spinflags);
>  	event->hw.state =3D 0;
>  	pmu->monitor[mon].hw_events.num_started++;

[ ... ]

> @@ -2123,13 +2123,13 @@ static int rpi_axi_pmu_add(struct perf_event *eve=
nt, int flags)
>  static void rpi_axi_pmu_stop(struct perf_event *event, int flags)
>  {
>  	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
>  	enum monitor mon =3D config_to_monitor(event->attr.config);
>  	unsigned long spinflags;
> =20
>  	if (event->hw.state & PERF_HES_STOPPED)
>  		return;
> =20
>  	if (flags & PERF_EF_UPDATE)
>  		rpi_axi_pmu_read(event);
> =20
>  	raw_spin_lock_irqsave(&pmu->lock, spinflags);
>  	if (flags & PERF_EF_UPDATE)
>  		event->hw.state |=3D PERF_HES_UPTODATE;
>  	event->hw.state |=3D PERF_HES_STOPPED;
>  	pmu->monitor[mon].hw_events.num_started--;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813073050.2823=
657-1-irogers@google.com?part=3D1
