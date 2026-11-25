Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596735;
	b=nWNplUMQBj3vdqEIk32hbWsdxf4Fs9sO1uAGrgAQDcLr2b5K/cStXV0QV5yEHTRo9Rlt
	 AdGWWNIk5b4zlICWqnrgKmxL9WAhV1JUDX5K9vv/kx71Tvds1iBASrp83SALEJyeG3omD
	 PEuVMVQRJ7ZQRndj99y/WOU1huSTMo7clEOOIAgmbfHwUdFHVZn/3EYP3inoqzcEsA3OK
	 r1sQIsXd1SzyMfHDAmKedqDK/4bYrxQJpu1jeGiaAIn4seellYUCt1O8GVWWy9vngCDtS
	 GblDekNJLXJCIwV3DYeP3dG96nsFy4ipwuDTT8XTfhprpaJ0IZB3fsDV/k99IIJso7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tRIKJtyWPaaqUrMV3Km3q6QvCOXPiAHb8+QM8HZySrc=;
	b=OkuA3KzS3C+CcW72uIadseZB3XWkKHoWz4U3aQ3H6VvzdNweBXfHthD0g28meejycjtr
	 1/vC054FOgjCPluxRZ7XcLzcl9LjfdAXJicDthl1z/9L/BgkSK9Ib9vj7+z0ADBpZXd5o
	 twQdeqAkDD0qBtJ+FRZIzlw5tpSGnqCj2wc0WYAPYcWbhas9+akuQ1Ejv5OiefcXVOtCi
	 IvKLY2MKQgQUwnxrfDCI+ZsG5seESs+5Fw0XQfQsWkzV4P98WKZ0E5osM3KaKdtOdmeAn
	 Cmih0ibRnpp8endyiPQYXa/KmGW4RFKliJLA2KXMfaByAohiaqgIjlXDLncJHLHOzOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGjUWBZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54379606A31E;
	Wed, 25 Nov 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGjUWBZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0071F000D0;
	Wed, 25 Nov 2026 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596734;
	bh=tRIKJtyWPaaqUrMV3Km3q6QvCOXPiAHb8+QM8HZySrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGjUWBZY4evWe7kKZtelwyRachI7bJHix7EWsli1wR95QbiieFiFMcBiuJXwBIyDi
	 fcWm2jsZrFHTVm2SOfQVT61p2cycWMssWzOAZ7z4TvPSboh6tiZxm/x/BmdINITqd0
	 7OTUgAZNz5BIJguEZGwQbhmcuhbq1Hh9wv02vcbqnuxIYSRYEvU6KA8gVP+j7tp05V
	 xu1i+xJjt4BdKNl8WIpI47vqKz+l5svqiJTkUMooUHmACG2fnaGRMXFnGWKrVDZ16X
	 Slv4SdUp6rdyg5NZHa+Ln8Xwktv5qCgIjPib3YofLsR1KYeIWQDJBgbEoLcJNOodjJ
	 kF/V0gOXZm7Yg==
Message-ID: <sashiko-outbox-232948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] riscv: pmu: Add infrastructure for Control
 Transfer Record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125083942.3695072-5-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
 <20261125083942.3695072-5-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:52:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] riscv: pmu: incompatible event_init() pointer type and ignored
  return value
--

commit 15d211fd87e46912144256300103f163e02625b4
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Add infrastructure for Control Transfer Record

This commit extends the RISC-V PMU framework with callbacks and data
structures for Control Transfer Record branch stack sampling.

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index ecaa40370830a..448e0589875e5 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
[ ... ]
> @@ -60,17 +71,22 @@ struct riscv_pmu {
>  	int		(*ctr_get_idx)(struct perf_event *event);
>  	int		(*ctr_get_width)(int idx);
>  	void		(*ctr_clear_idx)(struct perf_event *event);
> +	void		(*ctr_add)(struct perf_event *event, int flags);
> +	void		(*ctr_del)(struct perf_event *event, int flags);
>  	void		(*ctr_start)(struct perf_event *event, u64 init_val);
>  	void		(*ctr_stop)(struct perf_event *event, unsigned long flag);
>  	int		(*event_map)(struct perf_event *event, u64 *config);
> -	void		(*event_init)(struct perf_event *event);
> +	int		(*event_init)(struct perf_event *event);

[Severity: High]
Does changing event_init() to return int here break compilation with
CONFIG_RISCV_PMU_SBI enabled?

pmu_sbi_event_init() in drivers/perf/riscv_pmu_sbi.c still returns void
in this patch, so assigning pmu->event_init =3D pmu_sbi_event_init in
pmu_sbi_device_probe() fails the build under
-Werror=3Dincompatible-pointer-types (breaking bisection until later commit
"riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver" updates
pmu_sbi_event_init()).

In addition, riscv_pmu_event_init() in drivers/perf/riscv_pmu.c still
ignores the return value of rvpmu->event_init(event), so errors returned
by the backend callback are silently dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125083942.3695=
072-1-vikram.singh3@oss.qualcomm.com?part=3D4
