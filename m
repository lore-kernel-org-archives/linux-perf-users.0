Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0319B3CB
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278018; cv=none; b=f8oFoOMCqhvT5y09iSkkGweOr9LyLvIDUWQIVqZ5Uf30nzyAQHYCDNAZCyH8P/3pno1P21EbiTIDgveZr0GCyOTt89csoN6WujWVoOusvvm+a7+tBknGeCV8Yf0h9Gxii13qT1XeUddKo0aiGNyPA6M7szjykZqx2/YnVlVTmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278018; c=relaxed/simple;
	bh=Db20Gd0/EPxaheDsoNo+24TPfQLLmftR3B/HWw8KoDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dws/bE/pAPZxMdKiOF+Ihf2OBkAP4WXqoFSKZdiku7OErM14rm2cevmNRltR4OuDjIL0ifEM0d5Qxue016/zyjhfeo1j4iLBZylBRIGfu+x6ZsDZFwr1umjDyQ3KRGXB1mcQOWSw0+yTkluKkaIYqLA9/fMGhRu9xui0sFKZ0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frZHy2uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frZHy2uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0FB1F000FF;
	Tue,  6 Oct 2026 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278017;
	bh=rVQfKTDwo8LpBPu5J700NBmg+3P1E4Mka0heJGy4RP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frZHy2uKs2cbsiL0fyFEtvjNTkJ3oAFCTPGge1pXwEcLHhA7z10oaoIgH5h7fnYXh
	 HxLppTof9GdYi3ULAMOhd9/GKH/g1G9U/M/SLiNeH9xbo6lYeNpwvxQZnY55oFZQ8S
	 XErCpK7xKozMM3VJUK9Hzu3cl0UWS65R1WfeHTXBGEyEHMdMmkQChWqfGSpqyyraps
	 ZeOFnynJNE23wU4rMjoVLtkNLvvjOqVxQABmtKcyPLYvAIFsWIdyeu87S052g9yl0a
	 oxIRTFguonMnludXBgBbvD/4Nl0wpG1ZkzRDhqZPHT4RoeJ7ccymtTHJJnuWyYt6hu
	 mjb70fqnQxxDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006090327.309550-2-zong.li@sifive.com>
References: <20261006090327.309550-1-zong.li@sifive.com>
 <20261006090327.309550-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 09:13:36 +0000
Message-Id: <20261006091337.1E0FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/riscv-iommu: massive bogus counter delta due to lockless read=
 race
--

commit c86414e0f5ba030fae4e375313f7b59bdf23b346
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new auxiliary device driver to support the RISC-V IOMMU
Performance Monitor. It introduces hardware counter management, event
configuration, and handles counter overflow interrupts.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx =3D hwc->idx;
> +	u64 counter_mask =3D pmu->cntr_mask[idx];
> +
> +	/*
> +	 * riscv_iommu_pmu_set_period() resets the hardware counter and
> +	 * prev_count as two separate writes, and deliberately updates
> +	 * prev_count first.
[ ... ]
> +	 * so re-checking prev_count after the hardware read detects that torn
> +	 * pairing and retries.
> +	 */
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> +	} while (prev !=3D local64_read(&hwc->prev_count) ||
> +		 local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
> +
> +	delta =3D (now - prev) & counter_mask;
> +	local64_add(delta, &event->count);
> +}

[Severity: High]
Does this lockless loop fully protect against a torn update from
riscv_iommu_pmu_set_period?

The commit notes that the IRQ handler can run on a different CPU than the
event's bound CPU due to IRQCHIP_MOVE_DEFERRED.

If riscv_iommu_pmu_set_period executes concurrently, it first updates
prev_count to the new period, and then resets the hardware counter.

If this lockless loop executes exactly between those two writes, it will
read prev as the newly updated period, and now as the old hardware counter
that has not yet been reset.

Since prev_count is not modified during the loop itself, the check for
prev !=3D local64_read(&hwc->prev_count) will evaluate to false. The
cmpxchg will succeed, corrupting prev_count with the old hardware counter
value, and calculating a very large bogus delta:

delta =3D (old_hw_counter - period) & counter_mask;

[ ... ]
> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	riscv_iommu_pmu_update(event);
> +}

[Severity: High]
Since riscv_iommu_pmu_update is exposed to the race described above, should
riscv_iommu_pmu_read acquire pmu->lock to serialize against the IRQ handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006090327.3095=
50-1-zong.li@sifive.com?part=3D1
