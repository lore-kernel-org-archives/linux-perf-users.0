Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD61B6D1A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931605; cv=none; b=UKqNMVxEL/E3emxSlzpynl0Hn1+mDPBopMcE5jPWopheNylzlknTtUOWRT2nk5nPXidAXFJs6/5X7UpqWWmzPy9MoEcbHU2fLCgm4gwCVdcUki0fU7Qxtpq6IxiJV4+PW/SpYgoHx70HLv1Wj0LrPWWnTBFwqc8eqvFfYxOhGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931605; c=relaxed/simple;
	bh=PfIoTr03zhugWU1CNxBmX84qAnB8EaddiJQM/qOR/YQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQhAz24M1WGTBDQsk3gw9k4stB4pp9xsH9+RaHdU/OHMVPrfZvQtj7EnUwTxI3DZrYCdTPXD43itAW+UWXMW1XMGxATH18AqOGbQ2jAqXAvH6gijYpQsHyjeS1KhXPz1aCGsTckaAgLXiypdfYmUwMC92YcRTPc/68XneFmWgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXRkeNBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXRkeNBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E7C2BCB8;
	Mon,  4 May 2026 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931605;
	bh=PfIoTr03zhugWU1CNxBmX84qAnB8EaddiJQM/qOR/YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RXRkeNBqVMiW0Pl7JWeH2sL0pbT+vfNgI0zOth746xBzXV8ekyo1F/x4yoGcKaHYn
	 v+waDUzELSwEjuuKLaTNyu3uX8DxiP0pgLuxoFRlnt93h6JovXPMlvK+baj44HJ1Iq
	 Fx3dtE6j9I8zEUQ0JFQar5jVJ4PUFy95RIjfpv0RLk8rj8TdM3li2YpHF93kmOWwYN
	 rYhfZGMgc9D+F1vu8jeYNMZMUGf9FMMNPBYLWaU0yns3VUCR5hJKI6iT9B8dXObj1e
	 YsxbRcuTXvLJtBA7EDHSZcodgxJRBn8kh2TQ3soGCDTiLagrAYZHuWtEy6nfOodNwh
	 AUKjhu6Ew8d1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/20] perf: arm_pmuv3: Add method to partition the
 PMU
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-7-coltonlewis@google.com>
References: <20260504211813.1804997-7-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 21:53:24 +0000
Message-Id: <20260504215325.3A6E7C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing newlines in printk messages.
- [Low] Kernel doc for armv8pmu_partition() directly contradicts the implem=
entation.
--

commit 6d1ad2c30d1fee65c9f04a9893ee57e6ba41fe28
Author: Colton Lewis <coltonlewis@google.com>

perf: arm_pmuv3: Add method to partition the PMU

This commit creates a module parameter reserved_host_counters to reserve
a number of PMU counters for the host. It also adds the function
armv8pmu_partition() to check the validity of the reservation and record
that a partition has happened.

> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 7ff3139dda893..6e447227d801f 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c

[ ... ]

> +/**
> + * armv8pmu_partition() - Partition the PMU
> + * @pmu: Pointer to pmu being partitioned
> + * @host_counters: Number of host counters to reserve
> + *
> + * Partition the given PMU by taking a number of host counters to
> + * reserve and, if it is a valid reservation, recording the
> + * corresponding HPMN value in the max_guest_counters field of the PMU a=
nd
> + * clearing the guest-reserved counters from the counter mask.
> + *
> + * Return: 0 on success, -ERROR otherwise
> + */

Is this kernel doc description accurate for the current implementation?

The documentation states this function is responsible for clearing the
guest-reserved counters from the counter mask, but the implementation below
leaves the counter mask unmodified.

> +static int armv8pmu_partition(struct arm_pmu *pmu, int host_counters)
> +{
> +	u8 nr_counters;
> +	u8 hpmn;
> +
> +	if (!armv8pmu_reservation_is_valid(host_counters)) {
> +		pr_err("PMU partition reservation of %d host counters is not valid", h=
ost_counters);

Does this message need a trailing newline?=20

In the kernel, pr_err() does not automatically append a newline, so
subsequent kernel log messages might be appended to the same line.

> +		return -EINVAL;
> +	}
> +
> +	nr_counters =3D armv8pmu_pmcr_n_read();
> +	hpmn =3D nr_counters - host_counters;
> +
> +	pmu->max_guest_counters =3D hpmn;
> +	armv8pmu_is_partitioned =3D true;
> +
> +	pr_info("Partitioned PMU with %d host counters -> %u guest counters", h=
ost_counters, hpmn);

Similarly, does this pr_info() call also need a \n to prevent garbling the
dmesg output?

> +
> +	return 0;
> +}
> +
>  static void __armv8pmu_probe_pmu(void *info)
>  {

[ ... ]

>  	/* Add the CPU instructions counter */
>  	if (pmuv3_has_icntr())
> -		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
> +		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->hw_cntr_mask);
> +
> +	bitmap_copy(cpu_pmu->cntr_mask, cpu_pmu->hw_cntr_mask, ARMPMU_MAX_HWEVE=
NTS);
> +
> +	if (reserved_host_counters >=3D 0) {
> +		if (has_host_pmu_partition_support())
> +			armv8pmu_partition(cpu_pmu, reserved_host_counters);
> +		else
> +			pr_err("PMU partition is not supported");

Might this pr_err() also be missing a trailing newline?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D6
