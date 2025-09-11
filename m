Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15A324B24
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597059; cv=none; b=NOq/j+HSo4BegBkwpLC1WE6EaYZl/KKVH3/XiGzUQ3wJILb8vySqXQ6MI5g3wE4yUvdlEKmoPGC1+XmXyQJkAcE3f5jhR7BH4zmwIv+2v8xcw8VamkshTZ3KwJCSjfSLQEI80VLjOkFITOnc4DJ6WkZ9G5it7NJPuCLH4YNQHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597059; c=relaxed/simple;
	bh=TaQueTEoC6o4eB4nfhhT60PYphmO+Aqh4TLGtadNh0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckTJfePzfzuKQ0GaXrRzbxSMnz/YaBUnSyct9zRQ0+QgdE4xPbpYIkEZqxrt54eGVaGBL8KFKfuZHnGFklAhQSp+bnYfKmpjlFXGIzdsqlok//4hgZ23NuwmhpIvYcyHypvO3hkqz53uCV5R5moaidgHc+6elUVsLAdV1d8CLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AZe2TiuN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AZe2TiuN"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-322695f899aso528136fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757597057; x=1758201857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfBLhNXXq9Rsc8Z2YKn++Jo2sHEm+zyXMU4WnJYLHBc=;
        b=AZe2TiuNvKAyR3O64Gf1pmmac6nhibKl0D9U/RGp5QiY4wdCa9iqwGCc7mlUqEurJL
         Axull3NGyACzSOti43Eh3Rahh9250OVwGJAta2enzLZoXLgc4+139qgE8EQF3rXfnyYH
         sthP5xJ7cjaqBKnTinsd7fxYveZjjwwUTIGXajF6ANJE6DRB5lCrMGUm119ezv/LMhxW
         0TJUDGGUdGGd57wZfgOLTt2fP5BxjtD6GEQIuEw6IuTXOozMt1UQjpmqB0Og1cEUoQi7
         5neTIK5UhjJELgAtKrxVbHVkWqJKDzE7ETtWtpV8Y3psMF0XaLpYykLGG9cK2lp8D2up
         wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597057; x=1758201857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfBLhNXXq9Rsc8Z2YKn++Jo2sHEm+zyXMU4WnJYLHBc=;
        b=h5J8POgd/AvNm1YlmzrdiL+fpiDmrbzQvscHA1luGjsBzCrMA2CoKmCv34W/0hDQRa
         miSnwNR8d4mioHtEwiHaCCpaqesQ4r4dDuASdy183oTob5G8K/CjfG6uZos4J9yoecMn
         h5KdD6fPZ98JSVkPP6Dbmr4SnI2qKReB7f5Ni6KTTLnRJU3HHwqbAHA2OMyq7B8NPFry
         tgQnhz7H8VCz0tA//u9eUNFDrwaWe6S52D+Tp/QjHTgssSKZeiufXp9eUnsZ9YnLPZoM
         W7Ymup/lzoLY+4sb6t8r6lDJ1GvdV1u12iCEmJcydmwcb3XATBIMwlf7XvpcYJmEQsdM
         TrGg==
X-Forwarded-Encrypted: i=1; AJvYcCVAjq6+6JcKeeNRhs80w9Ivu9/TFuHcuuBfOQ0Tu9UwFnumw1KA+HFKpFtoa+4oJQnQZUsL2MEBuVC/yQb69Qei@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQ8tjnAz3aZLMU545X9sjo17Y/Id8OeubYFBH246l9DKeyN0J
	x0SFuv3g4GXyBZRj1JtEHtaOHyMEmejoB30TovSL9xdhiv8+unA3nz//ybdehpKZkS4XYWel6Sr
	Ns+Dy/JyJnV68IkbVbK2HmwJlmEs4nysTmbNFjjW8JQ==
X-Gm-Gg: ASbGncs3qjaUNbS7Gmtab67vvArkSJB2EJ8DQNC77GIxt9m5KbG2iq2cRtJwGz6rNKO
	b6zYOHTOQqN3FhlKiQMTqjo4O0pz0teJOQgrN2YolatbXQLgHslGxNgf8Sbc9vMAv3GpNP+z169
	EPcopAgX0LzP/1lGIShwyTD6UEBjGT8pQfweX4JirNOVrPi/Tqt1xKfbGSy1AfkFI7GROotmsUM
	c5qTM9Xt/AONg8y
X-Google-Smtp-Source: AGHT+IHRdBKXm1Bz1NHFHe2IrSKtcJoxyFdHCG+gmrlFxehDwahE40seZUC2QEjKPDn+5kw4bLLqvWTXBPHddQo3Z4w=
X-Received: by 2002:a05:6870:4e8c:b0:31d:63f9:b247 with SMTP id
 586e51a60fabf-32264607e14mr11225562fac.25.1757597056938; Thu, 11 Sep 2025
 06:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com> <20250327-counter_delegation-v5-18-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-18-1ee538468d1b@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 11 Sep 2025 21:24:04 +0800
X-Gm-Features: Ac12FXwLi65vQtG3EKjaprZe3vR6jcXi2qMAlWPQLWbqK3WvwYrKsOxiKlH-8R4
Message-ID: <CAEEQ3wk92bmHQb=EbM-Ev0ra=eS-ZH6_aGTqAw1WENXpORXUKg@mail.gmail.com>
Subject: Re: [External] [PATCH v5 18/21] RISC-V: perf: Add Qemu virt machine events
To: Atish Patra <atishp@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Atish,

On Fri, Mar 28, 2025 at 3:46=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Qemu virt machine supports a very minimal set of legacy perf events.
> Add them to the vendor table so that users can use them when
> counter delegation is enabled.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/vendorid_list.h |  4 ++++
>  drivers/perf/riscv_pmu_dev.c           | 36 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index a5150cdf34d8..0eefc844923e 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -10,4 +10,8 @@
>  #define SIFIVE_VENDOR_ID       0x489
>  #define THEAD_VENDOR_ID                0x5b7
>
> +#define QEMU_VIRT_VENDOR_ID            0x000
> +#define QEMU_VIRT_IMPL_ID              0x000
> +#define QEMU_VIRT_ARCH_ID              0x000
> +
>  #endif
> diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
> index 8a079949e3a4..cd2ac4cf34f1 100644
> --- a/drivers/perf/riscv_pmu_dev.c
> +++ b/drivers/perf/riscv_pmu_dev.c
> @@ -26,6 +26,7 @@
>  #include <asm/sbi.h>
>  #include <asm/cpufeature.h>
>  #include <asm/vendor_extensions.h>
> +#include <asm/vendorid_list.h>
>  #include <asm/vendor_extensions/andes.h>
>  #include <asm/hwcap.h>
>  #include <asm/csr_ind.h>
> @@ -391,7 +392,42 @@ struct riscv_vendor_pmu_events {
>           .hw_event_map =3D _hw_event_map, .cache_event_map =3D _cache_ev=
ent_map, \
>           .attrs_events =3D _attrs },
>
> +/* QEMU virt PMU events */
> +static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW=
_MAX] =3D {
> +       PERF_MAP_ALL_UNSUPPORTED,
> +       [PERF_COUNT_HW_CPU_CYCLES]              =3D {0x01, 0xFFFFFFF8},
> +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D {0x02, 0xFFFFFFF8}
> +};
> +
> +static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT=
_HW_CACHE_MAX]
> +                                               [PERF_COUNT_HW_CACHE_OP_M=
AX]
> +                                               [PERF_COUNT_HW_CACHE_RESU=
LT_MAX] =3D {
> +       PERF_CACHE_MAP_ALL_UNSUPPORTED,
> +       [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   =3D {0x10019, 0xFFFFFFF8}=
,
> +       [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  =3D {0x1001B, 0xFFFFFFF8}=
,
> +
> +       [C(ITLB)][C(OP_READ)][C(RESULT_MISS)]   =3D {0x10021, 0xFFFFFFF8}=
,
> +};
> +
> +RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFF=
FFF8);
> +RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFF=
FFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFF=
FFF8);

If other vendors intend to define it, would that throw a duplicate
definition error?

> +
> +static struct attribute *qemu_virt_event_group[] =3D {
> +       RVPMU_EVENT_ATTR_PTR(cycles),
> +       RVPMU_EVENT_ATTR_PTR(instructions),
> +       RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
> +       RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
> +       RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
> +       NULL,
> +};
> +
>  static struct riscv_vendor_pmu_events pmu_vendor_events_table[] =3D {
> +       RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, Q=
EMU_VIRT_IMPL_ID,
> +                               qemu_virt_hw_event_map, qemu_virt_cache_e=
vent_map,
> +                               qemu_virt_event_group)
>  };
>
>  const struct riscv_pmu_event *current_pmu_hw_event_map;
>
> --
> 2.43.0
>
>

Thanks,
Yunhui
