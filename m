Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996565;
	b=jomr7w/l7d7JZ+Ukb12RcIexTAxeM9psAMjkQlq22murmq5/+VRgEKptEwC8xUTkTEf9
	 hVRJo8HN4WS+5fKD5mleWH/uZh/ml23Q7elKI6ItRtR8T/eI1Ug2uCihAstps+6qv637+
	 RwUiY4Pb+YHMPJ/f2s6csqXQ/E4neigomdg+vXKRzHUqpHyYC41ppj7rFtJLEOxYOW4an
	 vGg9UhJwMRdEAJ4LsBjLJsB5Tws/XIhOBZ+b5WiXi8R27pajxUDsQqifcn2IN4PB5aU4m
	 WZXqMPqtxibGBk5Lla5bQ18R/QULu2XN5a2Qk9j87lX2C1H9ZCBB7U+qiMiZGmX6HVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+GjRvx6oEOPOyFxvO1NLqHjd7nKl1AZRHsiOQyn58mI=;
	b=yX8xacjGg2Rwmun64bzM5lVYz9lILRTwp0IWInop+q2/QaV9+A4PuYCc1M3SRXM5o1Ev
	 mLhRxdHpMs4qqAGC94iWBRC0kcCAUCnHmsAgrC6vkUV5Eo8cFdusaa1r8hWTalweKef6Z
	 t2QtECORLpzsL3aQzij1P025DfZRcB66P310gFMXd80L5DIXSpwSV58qihLH/LgGGLa8I
	 cexhwdtCpKR+tdRTVjRwWSUX7SyFLlAgz9CCBECMTZ1csJvKjoAdKmNHUFw1siz9KYjQb
	 /oLnzuEqgaPoZiBNiT0oBLoZo3WWzukL0HZ0/h2cn65N1UFSx3xQXD79AOuyq7ZvLXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSvvSZWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854C606A332;
	Wed, 18 Nov 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSvvSZWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0341F000CA;
	Wed, 18 Nov 2026 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996564;
	bh=+GjRvx6oEOPOyFxvO1NLqHjd7nKl1AZRHsiOQyn58mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSvvSZWbL8gfFaDrVTG00fTTDhsU5EtheG2tpqhu7H8OKruRXyZIU26Z8fkkdkSQK
	 DoGsLc52JCMDSzkFIM1l/g5cnnSFttIoWoTMQg0ZX39zALEi+uSPDhK3cqXzyoddAN
	 fRoWd/w6QxKZJzGdUfyh7gWnaBXjIPN1NvJmSUDH3oST7LoNxhdc6WjjTbnHIMU/wt
	 r9pjWkEK5U3EeWep3Io3/icyi3TPGIKJmJL/h9Z0NrGT+viDGtUmbOMUPpP67ml2Hh
	 5dQIeAfyj75wNApyicH3mWePr4jKCLc8KtSyERdTxiQYphlDbOIyrmjs78PKi1Dd1t
	 9QCpVqMsm68rQ==
Message-ID: <sashiko-outbox-220656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] riscv: pmu: Add infrastructure for Control
 Transfer Record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-5-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-5-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:09:24 +0000
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

commit 7e8e6b1d16d64b45e5fbc2ee239b9a0170cb2964
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Add infrastructure for Control Transfer Record

This commit adds branch stack sampling data structures and PMU callbacks
to struct riscv_pmu and struct cpu_hw_events to prepare for Control
Transfer Records (CTR) support.

Link: https://lore.kernel.org/r/20261106173942.3175069-5-vikram.singh3@oss.=
qualcomm.com

> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index ecaa40370830a..c748a06ad7514 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h

[ ... ]

> @@ -60,17 +74,22 @@ struct riscv_pmu {
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
Does changing the return type of struct riscv_pmu::event_init here break
the build with -Werror=3Dincompatible-pointer-types when CONFIG_RISCV_PMU_S=
BI
is enabled?

In this commit, pmu_sbi_event_init() in drivers/perf/riscv_pmu_sbi.c still
returns void while pmu_sbi_device_probe() assigns it to pmu->event_init;
its signature is only updated in a later patch in the series, commit
"riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver", breaking
bisection.

In addition, riscv_pmu_event_init() in drivers/perf/riscv_pmu.c calls
rvpmu->event_init(event) without checking or returning its int result, so
initialization errors from the backend callback are silently ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D4
