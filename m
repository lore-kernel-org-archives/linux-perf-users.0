Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699841;
	b=l25VhXj3YnF8yhxlsfXDV87K7h9UBjPGJVpKeLC3VWKSv1g2SZuzRaI5LFAA3sOE2baT
	 M5N/b0r148KYTgF4vBIgC/9W+1BDRoLVObCCM483WVEUzQpudwGDB/5JmDn18hga/x+zR
	 scX5ytB8KsmQ14er7pBzNuFY0aukRRKvkXKTuCzX9gtuRJG43RsRAY0fwXbCsoul4c9zI
	 LnsIdg7JtYGK6lAWNBEFKvIocdO64nHrZgaS+DTz1DvKHvG2MfgdiQum8yjzTsToIxTdm
	 0kPz+JEKyAA7BA70W0Hjc34YeiUHPAWvPY0b5MCI5oe8vXqF3jaoUW0BJmLMCu0zmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YYaYT2MvsdKI812lDcAtf4FP/Iik2f0nueU1YRbeT0I=;
	b=Bdfulj5yqybjQBPO6YPdEHxP0F0tVLGzBCgEqQJh2Ajwed65ci8iBQ0gzLQGAQPujJK1
	 cuY0U1KsR6HAY2c6qVSGHGNAbVP7OJFVuGVycMjqnNrmmQ0pQfitDj/R/WojW1+2NRBGY
	 eZZOYvd3HOBTpT4Wh0mW0+3RNoc6+y3DuWW4UhGjiRRknlTH+KsD6kNmHU1xdK3Q+jlQB
	 Vjca4IVBJoaTeZ7RAki0Qsf8/pw9jhkKV/8rxr3r9z9lA2T2LaX+LFuY3Q+Mq4dY4T5sg
	 2G6F0yY8F0a2NxL+EvMxP+Hf8us4KQF3QjU3zA8nh1P5GnW0iTFa5FasNcl3J6ciecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGyny3fy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C3606C51E
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGyny3fy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76421F00A23;
	Tue,  3 Nov 2026 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699840;
	bh=YYaYT2MvsdKI812lDcAtf4FP/Iik2f0nueU1YRbeT0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGyny3fyVPjqThf8oLvKo34rsdvtCLgr2yJN19p4aH+NhtjWSZZzgcxJJy9Rsa8IE
	 zHbrJIN3/DX2L2VyfpRfcW6S+Dt78+rVyy2C6kMaLQfCNIL+qcutXKe19X8qLRUHBU
	 8c8ovgKbMKD+OA9N4FtNczb6KiUDDB0QwewdLL915u4D6CnOlkuKS5PTJJfv0/6/I9
	 UtjzzTMBJifI/yGsBaQmJ8Xz2VWY8S+10HcPc/9KAPn6VygUL0JgcPDmtZRIDy1F9C
	 PTq2qd4+/th27M/LQ4yxxCTmKoI1TdTCeZQt9WT7phaJO2ckdlXfB61QH/ygzuidq3
	 +bBdqKz6w5BBw==
Message-ID: <sashiko-outbox-194990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/riscv: Guard PMU counter indices and user access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103093709.81605-1-zhaogongyi@bytedance.com>
References: <20261103093709.81605-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:57:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/riscv: zero counter count in pmu_sbi_get_ctrinfo() derefs ZER=
O_SIZE_PTR
--

commit 8efed03034c08f98dfc2b34e375ed58087ac3e08
Author: Zhao Gongyi <zhaogongyi@bytedance.com>

perf/riscv: Guard PMU counter indices and user access

This commit adds bounds validation on PMU counter indices before accessing
counter state or CSR mappings, preventing out-of-bounds accesses when a
disabled event is mmaped before hw.idx is assigned or when SBI returns
invalid counter values.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 21a2078eab98a..ac0d43746b799 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -890,10 +917,18 @@ static int pmu_sbi_find_num_ctrs(void)
>  	struct sbiret ret;
> =20
>  	ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS);
> -	if (!ret.error)
> -		return ret.value;
> -	else
> +	if (ret.error)
>  		return sbi_err_map_linux_errno(ret.error);
> +
> +	if (ret.value < 0)
> +		return -EINVAL;
> +	if (ret.value > RISCV_MAX_COUNTERS) {
> +		pr_info("SBI returned too many counters, limiting to %d\n",
> +			RISCV_MAX_COUNTERS);
> +		return RISCV_MAX_COUNTERS;
> +	}
> +
> +	return ret.value;
>  }
> =20
>  static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> @@ -902,6 +937,9 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned lon=
g *mask)
>  	int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
>  	union sbi_pmu_ctr_info cinfo;
> =20
> +	if (nctr < 0 || nctr > RISCV_MAX_COUNTERS)
> +		return -EINVAL;
> +
>  	pmu_ctr_list =3D kzalloc_objs(*pmu_ctr_list, nctr);
>  	if (!pmu_ctr_list)
>  		return -ENOMEM;

[Severity: High]
Should pmu_sbi_find_num_ctrs() and pmu_sbi_get_ctrinfo() reject zero
counters as well (ret.value <=3D 0 and nctr <=3D 0)?

If SBI_EXT_PMU_NUM_COUNTERS returns 0, pmu_sbi_find_num_ctrs() returns 0,
which passes the num_counters < 0 check in pmu_sbi_device_probe():

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_device_probe() {
	num_counters =3D pmu_sbi_find_num_ctrs();
	if (num_counters < 0) {
		pr_err("SBI PMU extension doesn't provide any counters\n");
		goto out_free;
	}

	/* cache all the information about counters now */
	if (pmu_sbi_get_ctrinfo(num_counters, cmask))
		goto out_free;
}

In pmu_sbi_get_ctrinfo(), kzalloc_objs(*pmu_ctr_list, 0) returns
ZERO_SIZE_PTR, which is non-NULL, so the PMU is registered with
pmu_ctr_list set to ZERO_SIZE_PTR and an empty cmask.

When userspace later opens a non-sampling event (such as a PERF_TYPE_RAW
event), riscv_pmu_event_init() sets hwc->idx =3D -1 and calls
riscv_pmu_ctr_get_width_mask(), which falls back to counter index 0 and
dereferences ZERO_SIZE_PTR in pmu_sbi_ctr_get_width():

riscv_pmu_event_init()
  riscv_pmu_ctr_get_width_mask()
    if (!riscv_pmu_ctr_idx_valid(hwc->idx))
      cwidth =3D rvpmu->ctr_get_width(0);
        pmu_sbi_ctr_get_width(0)
          return pmu_ctr_list[idx].width;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103093709.8160=
5-1-zhaogongyi@bytedance.com?part=3D1
