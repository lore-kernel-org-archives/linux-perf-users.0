Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E6273D8F
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940412; cv=none; b=KXnJ9im5aRyONNO1TP3Ehzq8DqNVG/ar3+AvrBJ7pdBIP1vghVORuZHwGbyFWZ+BUnK+/yY0N41wNpaL9zDex8rBPEnxogThhllRMpJHu9q4ljkEA246HXqIOWA8dpczSpMQJV5tMY1cF3BfsKTgdZB5UqLXdXjer39tvfG67ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940412; c=relaxed/simple;
	bh=9OsJUE590fghqj3BDNXHV+8qAiSF20Y7ksf0uyy9Si0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK4vik20vls8WmQBDed9KPZkfn0N2jQlrqdnIEiDDRz/8xMMNlSFGKSQzROyU2qInsD7ca4G7mlnWeaZP7zlp7L5k6PPpLdc8fv8oVOln3U4USDPlxLHhdhmRVjlzwNqocmEA+dE2Ch7KCGlPeVmGLmJM3CP0ziJdlO1dvK9ZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bT1xECyG; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bT1xECyG"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so4570674a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 19:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765940408; x=1766545208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/2RYz5g89Oo7ClB5gtL8Za3r2Xr3F25uufbNGZ7CVQ=;
        b=bT1xECyGPNnqTvQuuK4wO0IrGkv8Y5F8rrxdiAcPuK+wjKEGwoE7HfbNT25bIr9kG3
         oTXWXuBVb0IR3aKzNoRahKyNGRMQ6D1CXyHWcBEijjV3CBVRKDkOWd2Y09/fVV6PM+x/
         nby7K8ABXr/mgyQCB/VEj509c+Sls2wjw5wpGaI/qU0cWwS/2uBeQXRyVfgd/jWVcE1H
         36n+wxiG05zhoam89r+QcZtxobw9rtt6Ky1yB4u6WdpZFEcJ+jDocYcxHAi8Pi2ikM8k
         8jmnD5vZHVt60FaR6jY8CmjcpgV/59fWTT0A74fhGScMl9UdfBYB3W17tmQTnN9dJvqd
         vNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765940408; x=1766545208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/2RYz5g89Oo7ClB5gtL8Za3r2Xr3F25uufbNGZ7CVQ=;
        b=nyGoZ8jtS5kVS7PHNtkPidg5T6bl/EoG4JGYfvu73edb+fD0BU/jzZHsMt7Qxx7cvE
         wQtdy5+JhA1sSyZgR9PQGTBeD0rhEfWPYFqGPbmK5nWS3Eq+zELtnKa+V7A9xyxorcqu
         5hRHq/wpnSLylt+uR23cTAJWFVjWsWK9RTyTTwiJaXP0qLTnoOBQBNfqDZK4TZ+NjbZr
         xdlXKPrNdAc4dmSIHrcvusv+f/QV60yrJJcpk8lPNRqS9dWvoxe0YU+lie8LG++F5+eH
         5DOzcwTm85DufMBTGJrQ7PAr+7wdOE5LQaw9LNqyeWRKu9vDHUJpf3uU5pPDt5kzwDC9
         uGMw==
X-Forwarded-Encrypted: i=1; AJvYcCXtCLNPkgJ6V0SK4znBAiSzwNucql61p3HXWTs1H+lOSHw164dCj0GHsX94D90O2Yh5dPBFs2ZaQ6EjaQYE4v0T@vger.kernel.org
X-Gm-Message-State: AOJu0YxQP1hyc+2vFA0VEdO9hn8/MJjCaaJk+wfGAIk8lkQdPZ4asVLV
	cDozpJ21bA8EYfVA+BrPTRrdLNX3WCwoeAlYWL7uByRUcybllaNyRzlChJrQgxY5sqRRe6sGoyw
	JcWE9R0iRuufmIvwwT3Agk+J73onSnvWsYNPIZzT+Dg==
X-Gm-Gg: AY/fxX5C9VP8+qmGGtf+rkHZQyQrKzui7IrXmq0fIE8poF8unhkRNCtQuoOtZokAwoH
	Fr4tGc3/KTuz27pKAtDv6W72qxrh+rhHRNZG6rZMeInqTH9PQ95Qh+CHt5wfH8QvyCVP/aB9LY0
	tMwPcHy30nA/pQJbYrvM46k60r2zajd7BTNC7TluvpePaS16nmft2J5VYjLmYJ7P+xf+wmBcmix
	Ofot54Sb3HsjBkQK05RWfVQ4wA1RRSRdpyaXdmWrc6v8ODFuzTTe2wWJwKIyXnDNn5rjb8G5T2l
	mA==
X-Google-Smtp-Source: AGHT+IGOsDttJF6uFgQs8b9z12RN3EHncAP/ev9NC4wtQBWY1BR7zun1IGjSOjiTZhdxNQQtrm1spYA/0On3N4VLzFM=
X-Received: by 2002:a05:6808:a5d7:20b0:455:d5d1:8abe with SMTP id
 5614622812f47-455d5d1a911mr2707386b6e.34.1765940408215; Tue, 16 Dec 2025
 19:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114033243.76509-1-cuiyunhui@bytedance.com>
 <20251114033243.76509-3-cuiyunhui@bytedance.com> <96fd2a69-baf4-4109-8341-0d4bb6c60393@picoheart.com>
In-Reply-To: <96fd2a69-baf4-4109-8341-0d4bb6c60393@picoheart.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 17 Dec 2025 10:59:57 +0800
X-Gm-Features: AQt7F2oBwdHtfuscheWe6RG8WNJwqi88AjsGeaDU19qa6XfrY_huTLBuOPV3-Pk
Message-ID: <CAEEQ3wkq5P=WE_XsPDFOK5ESZDP6igQ9dAcN7Bd6-LkEv7N17g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	dianders@chromium.org, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, geshijian@picoheart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yicong,

On Fri, Dec 5, 2025 at 2:12=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> Hi Yunhui,
>
> this has conflicts on the mainline master. looks like you have a dependen=
cy
> on the SSE PMU support patchset [1], need to mention it for the maintaine=
r
> to apply.
>
> [1] https://lore.kernel.org/linux-riscv/20250908181717.1997461-5-cleger@r=
ivosinc.com/
>
> one comment below.
>
> On 2025/11/14 11:32, Yunhui Cui wrote:
> > Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Acked-by: Paul Walmsley <pjw@kernel.org>
> > ---
> >  arch/riscv/Kconfig           |  3 +++
> >  drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fadec20b87a8e..46ccd33732fa8 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -186,6 +186,9 @@ config RISCV
> >       select HAVE_PAGE_SIZE_4KB
> >       select HAVE_PCI
> >       select HAVE_PERF_EVENTS
> > +     select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
> > +     select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_=
EVENTS_NMI
> > +     select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
> >       select HAVE_PERF_REGS
> >       select HAVE_PERF_USER_STACK_DUMP
> >       select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index c852f64a50221..0c7c5924687c9 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/sched/clock.h>
> >  #include <linux/soc/andes/irq.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/nmi.h>
> >
> >  #include <asm/errata_list.h>
> >  #include <asm/sbi.h>
> > @@ -1192,6 +1193,13 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *p=
mu)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > +bool arch_perf_nmi_is_available(void)
> > +{
> > +     return IS_ENABLED(CONFIG_RISCV_PMU_SBI_SSE);
>
> this looks incorrect per implementation in [1]. we'll fallback to the nor=
mal
> interrupt if failed to register the SSE event, in which case NMI is not
> available for the PMU. Check the kconfig is not sufficient.
>
> you can check pmu->sse_evt instead for the NMI support here, or cached th=
e
> NMI status somewhere like how arm_pmu does.
>
> Thanks.
>

Well, based on CONFIG_RISCV_PMU_SBI_SSE, further check registration success=
.

> > +}
> > +#endif
> > +
> >  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *n=
ode)
> >  {
> >       struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct riscv_pmu=
, node);
> > @@ -1618,6 +1626,8 @@ static int __init pmu_sbi_devinit(void)
> >       /* Notify legacy implementation that SBI pmu is available*/
> >       riscv_pmu_legacy_skip_init();
> >
> > +     lockup_detector_retry_init();
> > +
> >       return ret;
> >  }
> >  device_initcall(pmu_sbi_devinit)

Thanks,
Yunhui
