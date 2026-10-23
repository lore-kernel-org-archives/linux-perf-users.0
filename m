Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765987;
	b=u8IEvBbgogvlO2JnB8NJhuD+peSo2de7qhuvBa4HwdxnDRtlSzluty8TGSzB0zPFDRnH
	 T+rzCOPPDbkAEuEzvTKzS/bnb3XNlRaSgrDAi5cxVmwwzbT3v/6etgYo7GjqHxI6RhuzW
	 O08SI5QFB/lb/cjtKN5agu7uVRRk5z58Nwq1tWxdfpFLMhw9PCXYgKEfK5cwcvHi35Uys
	 jVUaEkHS+nGwgphbkpKzsvPaZ+EeyzHONpeVnStcj1r3A2I4UoGoQxqkii/4z+N+I+j9L
	 MPyO1P5xQdBn394dm3flTCvZDWF+OeYb/RGk+B192CljbKTjti94kImrXIclIb8UujA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z9n1+s+asPmDaBeXYRe4kG+xpLIMptFUgjTnOa8GCY4=;
	b=xfukWfq2jpg0Mv75JXsEF0MnNbqfPITO1PBRXaxiomXvmjte/UHO8CHfhewhO+DiP6gz
	 x4p8ylMeZfeeqsF8rBrruopNV05uOWmtGV6v+L3DFZyT/svj01fq81tx7OLAJe9GjbNi6
	 lErMIGm7DaYCR1Ac6b/PZcZD6fpVtnmuHymB4df6BgJNe3ZN6HHxTqTBcPHYH+9HQUqJd
	 7G7nt8yc+4biuuda8fhJhQYireDUzahK0+5IQFTMZtCxttfvajSYZrqrjUeBCaFelnPOa
	 0Ab0yRlQ68WFZD1DwL7/DxfR1ExkzKggOu50C+7U8t4lD+165ddy44RYeWCp5UmITvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=fsdGyEoA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B4606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 14:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438B4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=fsdGyEoA
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso9801755e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765985; cv=none;
        d=google.com; s=arc-20260327;
        b=e6grR9PMc5Ga5Y0bVRVwK0iUExu20VNggaPyCMgDQT77WqugIa3rdE53jwv6wrhfXr
         kMvZXamnpjpsyZs4o8fj4+4Ss/mxwCeyFF602weCi+qeLX3pvSKhBCg1dkh7U8Z6qL3a
         xXjS6Ne4bauqdJnBxScRAUm8f9DjGgded1pWekjDmcjn5anPROUDj+RXI18KmR2IG9LP
         ou1nMmbsGkgkIBf9H1U7etE+un6pq/SBHtHkTlGgq9+d4gGnlfKafjvuzwIrqlQJdwin
         JZQEHoXnX43OHsh7mry4l0LH3bI4Nx3uzF0v7oH+LneVZ93bLkdpUkQNYaXB3t7H8Nee
         U9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9n1+s+asPmDaBeXYRe4kG+xpLIMptFUgjTnOa8GCY4=;
        fh=dsRtbfDAOr00rPVbmuGjMEOFrdjRgdObCgjXyyxFq1Q=;
        b=LXHKKztVusx4GC9VwYSHri9/FCoOdWusUMriRipeKORgJofKbzpmL43Zo585XpFGsk
         35ehtHWh49C1qtP3+FUST5SfqY8XqrDBwVXzCm/XwcbJF7oOcNuUreMO450t3NVgofQB
         QNlrcMM3z7TeDrHOT1ZrdljNi/1jqRskeQRneNiA2MYVp4mVMAlcSOw/sNTsr1Q7Egul
         fz9Qa+2E6Tin+kZ4GzmCS5hZ3/mL7IhGPtVb54VFpWEolJTNSLP69xN9LFIImpdTIyLh
         mG4pfakRjVjojaC5p8DrBIExaV9VOJ+HqG56mfrJHh8DJqsNbg7EaQp4YLTelj7XerfL
         /EVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792765985; x=1793370785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z9n1+s+asPmDaBeXYRe4kG+xpLIMptFUgjTnOa8GCY4=;
        b=fsdGyEoAoNi9GphXvUJSQQBOizAj9ksNPCJJQuwHlnd5RHHQYkLbpKAoY+uv1IRLzt
         TWuzRRQcxFpgyKv8WFbBHEMHLpHDP2AnNMWQGVIOtekq5t95HCYUjreXwL3LiUjc1y+F
         7yHfwFi+WKk2nBx65TJ57AXzxvo/lHFdrKxzdZiBUbCk/YlcxhV7XeshEFqoug08Z8cj
         ZGzf04fBpN/PcNy3wzdqdgS/Cc7pfg5S2sYcs2naMHWnBYLR+o98FckX8aQ5fwumOaCg
         cAuR+uPp94mAvN56rwKYB9IEgiS7f4Qg6wGQ1UMNbO/v1iBP2GG9Qk3JX3U9OL750701
         xqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765985; x=1793370785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9n1+s+asPmDaBeXYRe4kG+xpLIMptFUgjTnOa8GCY4=;
        b=hvc9SxtRdq2kIf6DgH8yo2RVvg3ibk93bNU7ow5GJs7CwAYZ4RSZedMlRpj02lgXBT
         TsiEODzlSrv+9zEvVg/JbjsGHa/IdqXfnlUYcCT3IQhbYme0eqpzgfUuHbXobVdFvRal
         uP5LPJDr+foPZcGJf/OB0gToJkFLCCaKyURW8gUCJgKoKW8/VTcAYO5/9rMKTMb7ovdc
         YB1q381MuNADKS2LmzWYxLGydzNkOQGsfjKZh2ijusxQ1cMlkxhuJkMQk8uwCNKeM2iD
         ecCPx4PvZezbVJqJuAMhHghETGvHLFTBBmi/SAGkRNxrhD59CvhIzd63cP5qPRmTMa8y
         GImg==
X-Forwarded-Encrypted: i=1; AKwUvBwyuKIEkKCcgXzdC0RlEJ8dq54JRcBVxJhejy3gXpgmk6CVeaPBtjGpERuaPl+sAQB+LFvrVVQG0fdsMOa4P71l@vger.kernel.org
X-Gm-Message-State: AFq9FYK2UyGj1YQdFRhH4WJyhyfDwrinYAyYYNQhtkpL4lkHzPKUFGoT
	+JgpR6KEavg6gbyqRBKwV38U0ANuwATEfDolRQdfoqsdBVrFspDfLBUwZ6yjlSwGakfqbjJ9sTY
	YGOZTkhY0tPl5GUerCZskHNyPhVBQhCLRj1XFq7pIgQ==
X-Gm-Gg: AYBFou20bTC8CM1+j+JMeOsmLO8FQPhI0cArWhmOGMYW74J6ULAutqWK1KLpFLg6WJy
	t6JqaKiY/wCo+Ldwxk+NGaveGtd1MO5EEGUPEXzeqXp3akk7Aif9s9HRIYn2oT6/LM50TWKmTiD
	rSmQArIsd0mQq/0gXeTUTE/7sH9NfIyRf4m8HhOJjBPe0SeXey+v3AuCew1mK2t/6DnMb7l922n
	zIv6aUo061lCcMqu7SLuuYzW2P8vOzDBOnSx9dnmaaqFzolPme8KtDRzF95o4S9HZMTd0SBaE3v
	Qcl8+IuTSjDMUVLhgvguKqbq4gZqIgDAUoPDIvbuba7xGSTkfcG9wuI62sjsxGMcboy4f0WlPPF
	r95lhN9mab5Ug8A4xqN0D0Yh5DejyrQhtUlyxboR3cDRuLyrMjXE/BZv0t7QdgAuqCxny6bRYRl
	U/pnmgkpGG9/zC4aigfbsm5gRxBrHJEOrW0L/ul2LfBh/f+uOPv/BAm0pc
X-Received: by 2002:a05:600c:1392:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4a211ecf2d6mr37791005e9.27.1792765984553; Fri, 23 Oct 2026
 07:33:04 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com> <20260807-counter_delegation-v9-15-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-15-58658104e487@meta.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Oct 2026 20:02:52 +0530
X-Gm-Features: AclHuK9X4t2_Wp-iA3viS1hPfBa-r77osa46AUeHd9u6gOQJy4rh2geNlywyhlQ
Message-ID: <CAAhSdy1zHzqf0Ozgoz_nT81_tjg6ojsNgGQMUpeXNaJ6AN4yug@mail.gmail.com>
Subject: Re: [PATCH v9 15/20] RISC-V: perf: Skip PMU SBI extension when not implemented
To: Atish Patra <atish.patra@linux.dev>
Cc: Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:40=E2=80=AFPM Atish Patra <atish.patra@linux.dev> =
wrote:
>
> From: Charlie Jenkins <charlie@rivosinc.com>
>
> When the PMU SBI extension is not implemented, sbi_v2_available should
> not be set to true. The SBI implementation for counter config matching
> and firmware counter read  should also be skipped when the SBI extension
> is not implemented.
>
> Signed-off-by: Atish Patra <atishp@meta.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  drivers/perf/riscv_pmu_sbi.c | 55 ++++++++++++++++++++++++++------------=
------
>  1 file changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index fd4bf8804c9a..f0b8b6eff2ea 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -493,27 +493,32 @@ static void rvpmu_sbi_check_event(struct sbi_pmu_ev=
ent_data *edata)
>         }
>  }
>
> -static void rvpmu_sbi_check_std_events(struct work_struct *work)
> +static void rvpmu_check_std_events(struct work_struct *work)
>  {
>         int ret;
>
> -       if (sbi_v3_available) {
> -               ret =3D pmu_sbi_check_event_info();
> -               if (ret)
> -                       pr_err("pmu_sbi_check_event_info failed with erro=
r %d\n", ret);
> -               return;
> -       }
> +       if (riscv_pmu_sbi_available()) {
> +               if (sbi_v3_available) {
> +                       ret =3D pmu_sbi_check_event_info();
> +                       if (ret)
> +                               pr_err("pmu_sbi_check_event_info failed w=
ith error %d\n", ret);
> +                       return;
> +               }
>
> -       for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
> -               rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
> +               for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i=
++)
> +                       rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
>
> -       for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
> -               for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[=
i]); j++)
> -                       for (int k =3D 0; k < ARRAY_SIZE(pmu_cache_event_=
sbi_map[i][j]); k++)
> -                               rvpmu_sbi_check_event(&pmu_cache_event_sb=
i_map[i][j][k]);
> +               for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map)=
; i++)
> +                       for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_=
sbi_map[i]); j++)
> +                               for (int k =3D 0; k < ARRAY_SIZE(pmu_cach=
e_event_sbi_map[i][j]); k++)
> +                                       rvpmu_sbi_check_event(&pmu_cache_=
event_sbi_map[i][j][k]);
> +       } else {
> +               DO_ONCE_LITE_IF(1, pr_info,
> +                               "Boot time config matching not required f=
or smcdeleg\n");
> +       }
>  }
>
> -static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
> +static DECLARE_WORK(check_std_events_work, rvpmu_check_std_events);
>
>  static ssize_t rvpmu_format_show(struct device *dev,
>                                  struct device_attribute *attr, char *buf=
)
> @@ -712,6 +717,9 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *e=
vent)
>
>         cflags =3D rvpmu_sbi_get_filter_flags(event);
>
> +       if (!riscv_pmu_sbi_available())
> +               return -ENOENT;
> +
>         /*
>          * In legacy mode, we have to force the fixed counters for those =
events
>          * but not in the user access mode as we want to use the other co=
unters
> @@ -999,7 +1007,7 @@ static u64 rvpmu_ctr_read(struct perf_event *event)
>                 return val;
>         }
>
> -       if (pmu_sbi_is_fw_event(event)) {
> +       if (pmu_sbi_is_fw_event(event) && riscv_pmu_sbi_available()) {
>                 ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D,
>                                 hwc->idx, 0, 0, 0, 0, 0);
>                 if (ret.error)
> @@ -2132,12 +2140,16 @@ static int __init rvpmu_devinit(void)
>         int ret;
>         struct platform_device *pdev;
>
> -       if (sbi_spec_version >=3D sbi_mk_version(0, 3) &&
> -           sbi_probe_extension(SBI_EXT_PMU))
> -               static_branch_enable(&riscv_pmu_sbi_available);
> +       if (sbi_probe_extension(SBI_EXT_PMU)) {
> +               if (sbi_spec_version >=3D sbi_mk_version(0, 3)) {
> +                       static_branch_enable(&riscv_pmu_sbi_available);
> +                       if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> +                               sbi_v2_available =3D true;
> +                       if (sbi_spec_version >=3D sbi_mk_version(3, 0))
> +                               sbi_v3_available =3D true;
> +               }
> +       }
>
> -       if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> -               sbi_v2_available =3D true;
>         /*
>          * We need all three extensions to be present to access the count=
ers
>          * in S-mode via Supervisor Counter delegation.
> @@ -2152,9 +2164,6 @@ static int __init rvpmu_devinit(void)
>         if (!(riscv_pmu_sbi_available_boot() || riscv_pmu_cdeleg_availabl=
e_boot()))
>                 return 0;
>
> -       if (sbi_spec_version >=3D sbi_mk_version(3, 0))
> -               sbi_v3_available =3D true;
> -
>         ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>                                       "perf/riscv/pmu:starting",
>                                       rvpmu_starting_cpu, rvpmu_dying_cpu=
);
>
> --
> 2.53.0-Meta
>
