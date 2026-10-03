Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3C376BEA;
	Sat,  3 Oct 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991209; cv=none; b=WvqQ7nPlHU6l4IaXDQ+K7MniIkO0YMiGuVVr0cDgQot2sB8oIHKXVQ9buwJIjkRRYHqAksFIRoIryoyTBZvABF92MtI1w9q79ejJLXMb2HGGKr7BB9bC9P3+0Q0dyK02uLXz68d8yICkypvv13uhM1Vu53/PfJ8pQS0y9TbsKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991209; c=relaxed/simple;
	bh=jqAgTBgyLB9in13H5pvqeM/pQK2NV8lj9aFgxj0cjjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dbDzZ4bQOhjEuNvIF9RL2ztLveZOFgHnucHjvxyz0VnRKz4ub/WZR1kBngdMol1lBbFWAr5euu8PMLEaD/a54p6n88oaonH7peXBELP4PF8yP7fhEax/a6D0LkDp1uFdSKT+nGiqo5rtYJCD0qonll5hnIsUA1QVbQAajRy0kp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpYqAPjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpYqAPjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5849F1F00899;
	Sat,  3 Oct 2026 01:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991207;
	bh=qkuLg96MVQmWm2nFIXHAj8tPzinEiR5Ik5JjHLPLSbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpYqAPjVlZeCGuVs2cYySFzjzxlo+bsiqpIyqu78B4FcYu+v8JRYSknDl1x2m2UzD
	 hzGfxmlsR5dbJ58oxmCls4BBR5VZs5RzjBIzz/hRaCqC15AcTquAc6cjFjdTnHAxme
	 3qo+wmwZ2xZaivK5u0zy6Yu3/45pn9N6dyYucsV0hoCqVUGXcE/lD91KUlpoDUDONC
	 YN1FASV7aNgrDz7A/mkDrseEEon65R098/dnfCQwIbhQAMX7qT9GRZPa6KeyBnZuBE
	 efsXkFbeb3DuEpC8boYe0HL+XSWkhMD19USx/wlOyJMMzjAgSXPsfhxge8Ps8KOyue
	 G57YqcdunzQQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261002175738.3242646-3-irogers@google.com>
References: <20261002175738.3242646-1-irogers@google.com>
 <20261002175738.3242646-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:27 +0000
Message-Id: <20261003013327.5849F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/rpi_axi_pmu: Endianness bug in VPU mailbox IPC payloads
--

commit 5a995c8809331bd8433a8a216b6077dd563f9f07
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

Adds a PMU driver for the Raspberry Pi AXI performance monitors, providing
access to the System and VideoCore performance counters natively through
the perf subsystem on Broadcom BCM2835 and BCM2711 platforms.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +static void set_monitor_control(struct rpi_axi_pmu *pmu, enum monitor mo=
n, u32 set)
> +{
> +	if (pmu->monitor[mon].use_mailbox_interface) {
> +		u32 tmp[3] =3D {pmu->monitor[mon].mailbox + GEN_CTRL, 1, set};

[Severity: Medium]
Will this payload work correctly on big-endian architectures?=20

The VPU mailbox communication appears to use native u32 arrays for its=20
payloads here without explicit cpu_to_le32() conversions. Does this cause
the little-endian VideoCore VPU to read swapped bytes when the driver is
compiled for big-endian systems?

> +		int err;

[ ... ]

> +static void set_bus_watcher_control(struct rpi_axi_pmu *pmu, enum monito=
r mon, int idx, u32 set)
> +{
> +	int watcher =3D watcher_offset(idx);
> +
> +	if (pmu->monitor[mon].use_mailbox_interface) {
> +		u32 tmp[3] =3D {pmu->monitor[mon].mailbox + watcher, 1, set};

[Severity: Medium]
Similarly, does this watcher configuration payload require endianness
conversions to prevent hardware communication failures on big-endian
systems?

> +		int err;

[ ... ]

> +static u32 rpi_axi_pmu_read_counter(struct rpi_axi_pmu *pmu, enum monito=
r mon, int idx,
> +				    enum counter counter)
> +{
> +	int watcher =3D watcher_offset(idx);
> +	int offset =3D counter_offset(counter);
> +	u32 ret;
> +	/* Use READ_ONCE to prevent KCSAN data race warnings during lockless IP=
C reads */
> +	if (!READ_ONCE(pmu->monitor[mon].hw_events.enabled[idx]))
> +		return 0;
> +	if (pmu->monitor[mon].use_mailbox_interface) {
> +		u32 tmp[3] =3D {
> +			pmu->monitor[mon].mailbox + watcher + offset,
> +			1, -1
> +		};
> +		int err;
> +
> +		might_sleep();
> +		lockdep_assert_held(&pmu->vpu_mutex);
> +		if (WARN_ON_ONCE(in_interrupt() || irqs_disabled()))
> +			return -1;
> +		err =3D rpi_firmware_property(pmu->firmware,
> +					    RPI_FIRMWARE_GET_PERIPH_REG,
> +					    tmp, sizeof(tmp));
> +		if (err < 0 || tmp[1] !=3D 1) {
> +			dev_err_ratelimited(&pmu->pdev->dev, "Failed to read bus watcher\n");
> +			/* Return U32_MAX on IPC failure. */
> +			return U32_MAX;
> +		}
> +		ret =3D tmp[2];

[Severity: Medium]
When the read response is received, is a le32_to_cpu() conversion needed on
tmp[2] before it is consumed?

Using proper endianness conversions would align with other Broadcom
firmware drivers like clk-raspberrypi to correctly interface with the
hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002175738.3242=
646-1-irogers@google.com?part=3D2
