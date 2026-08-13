Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FB40929D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599350; cv=none; b=AzgjH3CKEwdDIxtQ620afiNdJmhrBdp2EXNk6s2dgFU/bNU1dc5iCwl44ocE/Gxo84drBnAXYPQEYq8S/KD8JyQxGOgDmtFa7EUNtROaxM1qdbr7EQ8ScTgu4PEK/9zqbVLoutOgm68O9SE488Msz8HEEZAPcoO0T8MqTTGGsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599350; c=relaxed/simple;
	bh=luJIZsju5Siw7vc+HF7LiktCmLNcqwr89xNNSb144zA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bSJx6xCSVk7Jxz4D2qLTCFjB84TftUJvtqbaDOCXaJDbUiFTMzxIEkuaI8oNGPPfj5qxakWDbRyCmN8YD4fuE0YgwloQ5x1JuyB+Vii5cJHAjk0xbJgaLqa8eGTlbMihMU/ypAl7P5S//GwVruDvsKU8bV+VNmZmQFhwOcYkVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLmrB53+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLmrB53+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4E31F000E9;
	Thu, 13 Aug 2026 05:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599346;
	bh=9DKxSnq5YwWhXgNqh9gs/Uos11+DAyeEv7Ssq28L580=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLmrB53+n81vrSRJrLFH8YcGYJPy7Vl2GtewtQ0b2yyncPwy0ikao2wA4Dv6JSjej
	 +xLzqxT2KC1o0XZm8j2VfPvWMQs6qxWaWmrQtObCEubEjttj4CzUwM61ultmfQnZex
	 pyj9kgi18mFiHY95caw9qcU1XA+Cut1gpd5GTtQ0rR/+TGDmEIB1ED3P8cFVdArM87
	 dxq0fXfCVqhuBvzvPh81p0qT+JwFJgxL/+IG/JPDBvhLWAw8+PmEIPmx7hpXBoAoXN
	 kVRSHM6xgbkwCD+CQy/1UYqUu6q6nuiyOM5t8cjXiiUksf2FyGR9NYYJP3AEONhXfv
	 qx7rxG+FnNx+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813052419.2770841-2-irogers@google.com>
References: <20260813043533.2744442-1-irogers@google.com>
 <20260813052419.2770841-1-irogers@google.com>
 <20260813052419.2770841-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:35:45 +0000
Message-Id: <20260813053546.4E4E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] VPU monitor accounting is broken, causing complete data loss durin=
g time-multiplexing and short profiling sessions.
- [High] The driver uses `spinlock_t` for `pmu->lock`, which crashes PREEMP=
T_RT kernels with "sleeping while atomic".
--

--- Patch [1]: [PATCH v7 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit a038f5a0d4388926d4738fa191fa39c1cd2e9f2a
Author: Ian Rogers <irogers@google.com>
Subject: perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a performance monitoring driver for the Raspberry Pi AXI
bus. It supports both System and VPU monitors.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index 0000000000000..bd3c79dd2ff8d
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +struct rpi_axi_pmu {
> +	struct pmu		pmu;
> +	struct platform_device	*pdev;
> +	enum rpi_axi_chip	chip;
> +	struct rpi_firmware	*firmware;
> +
> +	int			cpu;
> +	struct hlist_node	cpuhp_node;
> +
> +	spinlock_t		lock;

[Severity: High]
Will using a standard spinlock_t here cause crashes on PREEMPT_RT kernels?

The perf core invokes PMU callbacks (like add, del, start, stop, and read)
with hard IRQs disabled. On PREEMPT_RT, spinlock_t is mapped to a sleepable
rt_mutex.

Acquiring pmu->lock via spin_lock_irqsave() in these atomic paths, such as
in rpi_axi_pmu_add():

rpi_axi_pmu_add() {
    ...
    spin_lock_irqsave(&pmu->lock, spinflags);
    ...
}

will trigger a "sleeping while atomic" crash. Should this be changed to a
raw_spinlock_t to guarantee it does not sleep?

> +	struct mutex		vpu_mutex;
[ ... ]
> +static void rpi_axi_pmu_read(struct perf_event *event)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	enum counter counter =3D config_to_counter(event->attr.config);
> +	u64 prev_count, new_count;
> +	unsigned long flags;
> +	u32 delta;
> +
> +	/* Mailbox VPU counters are polled asynchronously in background vpu_wor=
k.
> +	 * MMIO monitors (System) are read synchronously.
> +	 */
> +	if (event->hw.idx < 0)
> +		return;
> +
> +	if (pmu->monitor[mon].use_mailbox_interface)
> +		return;

[Severity: High]
Does returning immediately here lead to complete data loss for VPU events
during time-multiplexing and short profiling sessions?

When the perf core stops an event (for instance, during event rotation or at
the end of a session), it calls rpi_axi_pmu_read() to capture the final cou=
nt.
Because VPU events bypass synchronous reading here, any counts accumulated
since the last 2-second background timer tick are not recorded.

When the event is subsequently restarted, the background work sets a new
baseline:

rpi_axi_pmu_vpu_work_handler() {
    ...
    if (!(event->hw.state & PERF_HES_UPTODATE)) {
        /* Initial baseline read for newly started/rotated VPU event */
        local64_set(&event->hw.prev_count, new_count);
        event->hw.state |=3D PERF_HES_UPTODATE;
    }
    ...
}

This permanently strands the uncollected counts from the previous run perio=
d.

Could this cause short-lived perf stat sessions (under 2 seconds) and
oversubscribed VPU events to systematically report near zero?

> +
> +	spin_lock_irqsave(&pmu->lock, flags);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813052419.2770=
841-1-irogers@google.com?part=3D1
