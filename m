Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB025DB1A
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940118; cv=none; b=EMrlz/9Urt3Yrnyap2eyd4ySgrS/6A567+7sM+QyGR3g9vlH426cTAJWoCJHrtjd6HhUpRnH5ANiTt+CCibSyiK38RbUM5TLqbQWMLFs6TJFNYyBycd9DS+PJOjKLtZ/gNDiKVWd3u3+/GJFPBH1gY07fSmjNhYniHP3wkSOGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940118; c=relaxed/simple;
	bh=7Og+OXrAPpul4Fa93Ib9R6y8lJ1DBS3U54Has9LzDFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvXOMAxrtcFOqXrwkOX0UIUh1Tk1ZU59r/Cp88GLGbdlASj1gkPal5UCWSGKLYNBMuz+yPbPghwxNj7yMtNjSpRWLJOSRD/WcKgdi/yBYaPy6VBCh30nZ7YIviyBFG+t5gTQECsGZaSk5C0E65fw08tX0FeHsY4JM7oPf8igWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XnOJPFmW; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XnOJPFmW"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-450c6f5ff81so91925b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 18:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765940115; x=1766544915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywmSj0m19FzwoYPNV+cCUF+HjXOkK7Y3WteoSYm0feU=;
        b=XnOJPFmWdT9pGtvwlA58XJKGpJmswGgZWu5EccEuU6lsvKJL3vdf6sopKaXDv221gU
         LHSX9igUEmPF/+RzH422rKYndcnuahP2HQkrrQIRgT9yBUz6ysmzzFMS37oHyJekxafb
         xKp7CmwlbWcgLFFUqUkcdpIkoMevXq0B67IntE9Lfauk3DtkeB4Z/jDTm2km4MaoyXLn
         IxZEBlr4esHBhBEk8esD8tG3hJNILFoFvwXYdWKAS+QNLuofwElFnFDd7LWwg/BpuDHi
         W8Pi05HT7bMSbtw3QX8ZYYiS618mipKp8tJ57I6pyMPdFmMfpMKeyRUtobUrolSFYoDM
         ozrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765940115; x=1766544915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ywmSj0m19FzwoYPNV+cCUF+HjXOkK7Y3WteoSYm0feU=;
        b=azJBvZwa+49DgnYmnCmeDxsl8DM40Ls8kwIB1Gu/sJ6jVtZgbY05x3VvYTqG1bLvXW
         Ml/rNTq9595YimE4icmARjmfJoKH1H/z7YeYBrZWim1xmVHDnDwWmjHBwhZFDbkDnk11
         w3/nrhr2X1/nrsUezg5PU0tkD8DrLUQ+iG0JVSMRuhmhLIavLJhfPP4EhKplAydIEeir
         3sVu6Fn52Y8I0wMlZ+RjMbXkNd50qWO7E31dqrtXdUeEf9k4Zk2fxO2bhMYIS4mv3Hy5
         /NTIOeb2HOCIoyPEqHYlSuj64r9ZBEVvPItZ53838y4ChtM89IMD6LJ7vCz6orrz1UyJ
         +Wug==
X-Forwarded-Encrypted: i=1; AJvYcCXzR7Wbu3Jl7NXmb0MFJ4zfQA4tcxHbPHZr6wOPsqniZHHFz7er797U2UZe2r6snKmlIWtrj/YWvS/j66X1XA0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yygt3DK48J7IjmYiUnS6UFJrXAPKmBbMG6rGftaZd/QKd4BOscZ
	vCLUvsske/EQ441xE+sXYFiCgMZrfw1kXytQF21P7/hPc89IwV++faKZNk/bgul8dn47p76JTbV
	SJis6dHeIQBZWLqF+oSacSlwhiwNTyl39HzUgJxzwfA==
X-Gm-Gg: AY/fxX6QUd9U1DaJDI3Kh+f7E/0ESK3HF4aCQxouoUpDMP3pasJV61qcjLVLwH6Z/bH
	4+WK2CoBiLJqoUQo3Vne5gf/Dm/HDRt+ecOsY1iNDnLtU3AFLlsXzQWK7glznl016rqI++lswd6
	v5xzrD5B1ZhGi4vPt3qFYhztvFaZwt0jK2oY5gYH+bks1SsN6sU3YHuCk+CQ6NybGvt9k1l99Yz
	VjVkYxcEJOyXJQuHxKVouvknweB3Y2HqTVCmP5Ozk+XBDbW2Ow6TaTQFy4nXB+s7CI3Uu4WVp6n
	nQ==
X-Google-Smtp-Source: AGHT+IHY9RKl9VZvsSWMMoj+U8wSWQRVYcbSYQgljySyqBOvWINkl4Q+i8mDMWwLwnhkjkMu3NxBLxTApdqkFFLUAc8=
X-Received: by 2002:a05:6808:178b:b0:450:36ba:f552 with SMTP id
 5614622812f47-455ab5fab7bmr7787577b6e.6.1765940114902; Tue, 16 Dec 2025
 18:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114033243.76509-1-cuiyunhui@bytedance.com>
 <20251114033243.76509-2-cuiyunhui@bytedance.com> <af5765d2-ba72-481c-8c7a-6fb09fe44709@picoheart.com>
In-Reply-To: <af5765d2-ba72-481c-8c7a-6fb09fe44709@picoheart.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 17 Dec 2025 10:55:03 +0800
X-Gm-Features: AQt7F2oEqyc2xUSGPmVq4UFxpj8k_3X7XaQ2BASdoD1uFn_2DpqQPMedV_zTX5E
Message-ID: <CAEEQ3w=c=ooNhDknfaO3_7c72n_fSXQD=WZnuXF5EcDugkgZ5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 1/2] watchdog: move arm64 watchdog_hld
 into common code
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
	geshijian@picoheart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yicong,

On Fri, Dec 5, 2025 at 2:53=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> On 2025/11/14 11:32, Yunhui Cui wrote:
> > Move the contents of arch/arm64/watchdog_hld.c to kernel/watchdog_perf.=
c
> > to create a generic implementation that can be reused by other arch,
> > such as RISC-V.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/kernel/Makefile       |  1 -
> >  arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
> >  drivers/perf/arm_pmu.c           | 10 +++-
> >  include/linux/perf/arm_pmu.h     |  2 -
> >  kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
> >  lib/Kconfig.debug                |  8 +++
> >  7 files changed, 101 insertions(+), 98 deletions(-)
> >  delete mode 100644 arch/arm64/kernel/watchdog_hld.c
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6663ffd23f252..6614ff45b1e06 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -231,6 +231,7 @@ config ARM64
> >       select HAVE_GCC_PLUGINS
> >       select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
> >               HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> > +     select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF
> >       select HAVE_HW_BREAKPOINT if PERF_EVENTS
> >       select HAVE_IOREMAP_PROT
> >       select HAVE_IRQ_TIME_ACCOUNTING
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 76f32e424065e..12d77f373fea4 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -44,7 +44,6 @@ obj-$(CONFIG_KUSER_HELPERS)         +=3D kuser32.o
> >  obj-$(CONFIG_FUNCTION_TRACER)                +=3D ftrace.o entry-ftrac=
e.o
> >  obj-$(CONFIG_MODULES)                        +=3D module.o module-plts=
.o
> >  obj-$(CONFIG_PERF_EVENTS)            +=3D perf_regs.o perf_callchain.o
> > -obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)       +=3D watchdog_hld.o
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT)     +=3D hw_breakpoint.o
> >  obj-$(CONFIG_CPU_PM)                 +=3D sleep.o suspend.o
> >  obj-$(CONFIG_KGDB)                   +=3D kgdb.o
> > diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watch=
dog_hld.c
> > deleted file mode 100644
> > index 3093037dcb7be..0000000000000
> > --- a/arch/arm64/kernel/watchdog_hld.c
> > +++ /dev/null
> > @@ -1,94 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <linux/nmi.h>
> > -#include <linux/cpufreq.h>
> > -#include <linux/perf/arm_pmu.h>
> > -
> > -/*
> > - * Safe maximum CPU frequency in case a particular platform doesn't im=
plement
> > - * cpufreq driver. Although, architecture doesn't put any restrictions=
 on
> > - * maximum frequency but 5 GHz seems to be safe maximum given the avai=
lable
> > - * Arm CPUs in the market which are clocked much less than 5 GHz. On t=
he other
> > - * hand, we can't make it much higher as it would lead to a large hard=
-lockup
> > - * detection timeout on parts which are running slower (eg. 1GHz on
> > - * Developerbox) and doesn't possess a cpufreq driver.
> > - */
> > -#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > -u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > -{
> > -     unsigned int cpu =3D smp_processor_id();
> > -     unsigned long max_cpu_freq;
> > -
> > -     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > -     if (!max_cpu_freq)
> > -             max_cpu_freq =3D SAFE_MAX_CPU_FREQ;
> > -
> > -     return (u64)max_cpu_freq * watchdog_thresh;
> > -}
> > -
> > -bool __init arch_perf_nmi_is_available(void)
> > -{
> > -     /*
> > -      * hardlockup_detector_perf_init() will success even if Pseudo-NM=
I turns off,
> > -      * however, the pmu interrupts will act like a normal interrupt i=
nstead of
> > -      * NMI and the hardlockup detector would be broken.
> > -      */
> > -     return arm_pmu_irq_is_nmi();
> > -}
> > -
> > -static int watchdog_perf_update_period(void *data)
> > -{
> > -     int cpu =3D smp_processor_id();
> > -     u64 max_cpu_freq, new_period;
> > -
> > -     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > -     if (!max_cpu_freq)
> > -             return 0;
> > -
> > -     new_period =3D watchdog_thresh * max_cpu_freq;
> > -     hardlockup_detector_perf_adjust_period(new_period);
> > -
> > -     return 0;
> > -}
> > -
> > -static int watchdog_freq_notifier_callback(struct notifier_block *nb,
> > -                                        unsigned long val, void *data)
> > -{
> > -     struct cpufreq_policy *policy =3D data;
> > -     int cpu;
> > -
> > -     if (val !=3D CPUFREQ_CREATE_POLICY)
> > -             return NOTIFY_DONE;
> > -
> > -     /*
> > -      * Let each online CPU related to the policy update the period by=
 their
> > -      * own. This will serialize with the framework on start/stop the =
lockup
> > -      * detector (softlockup_{start,stop}_all) and avoid potential rac=
e
> > -      * condition. Otherwise we may have below theoretical race condit=
ion:
> > -      * (core 0/1 share the same policy)
> > -      * [core 0]                      [core 1]
> > -      *                               hardlockup_detector_event_create=
()
> > -      *                                 hw_nmi_get_sample_period()
> > -      * (cpufreq registered, notifier callback invoked)
> > -      * watchdog_freq_notifier_callback()
> > -      *   watchdog_perf_update_period()
> > -      *   (since core 1's event's not yet created,
> > -      *    the period is not set)
> > -      *                                 perf_event_create_kernel_count=
er()
> > -      *                                 (event's period is SAFE_MAX_CP=
U_FREQ)
> > -      */
> > -     for_each_cpu(cpu, policy->cpus)
> > -             smp_call_on_cpu(cpu, watchdog_perf_update_period, NULL, f=
alse);
> > -
> > -     return NOTIFY_DONE;
> > -}
> > -
> > -static struct notifier_block watchdog_freq_notifier =3D {
> > -     .notifier_call =3D watchdog_freq_notifier_callback,
> > -};
> > -
> > -static int __init init_watchdog_freq_notifier(void)
> > -{
> > -     return cpufreq_register_notifier(&watchdog_freq_notifier,
> > -                                      CPUFREQ_POLICY_NOTIFIER);
> > -}
> > -core_initcall(init_watchdog_freq_notifier);
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 973a027d90639..294a5c3438ad1 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/cpu_pm.h>
> >  #include <linux/export.h>
> >  #include <linux/kernel.h>
> > +#include <linux/nmi.h>
> >  #include <linux/perf/arm_pmu.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched/clock.h>
> > @@ -703,10 +704,17 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu=
, int cpu)
> >       return per_cpu(hw_events->irq, cpu);
> >  }
> >
> > -bool arm_pmu_irq_is_nmi(void)
> > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > +bool arch_perf_nmi_is_available(void)
> >  {
> > +     /*
> > +      * watchdog_hardlockup_probe() will success even if Pseudo-NMI tu=
rns off,
> > +      * however, the pmu interrupts will act like a normal interrupt i=
nstead of
> > +      * NMI and the hardlockup detector would be broken.
> > +      */
>
> the comment makes me a bit confused. we'll only declare the NMI support i=
f we successfully
> registered the PMU interrupt as NMI interrupt. If pseudo-nmi is turned of=
f, we'll
> failed to register the NMI interrupt since neither the gicv3 irqchip will=
 declare NMI
> suppport [1] nor the irq_chip::irq_nmi_setup() will success [2], then the=
 has_nmi will
> be false. In this case the hardlockup detector is not probed at all [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/irqchip/irq-gic-v3.c#n1956
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/irqchip/irq-gic-v3.c#n602
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/watchdog_perf.c#n268

This patch does not modify this part of the logic itself.

>
> >       return has_nmi;
> >  }
> > +#endif
> >
> >  /*
> >   * PMU hardware loses all context when a CPU goes offline.
> > diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.=
h
> > index 52b37f7bdbf9e..8f06751f1e176 100644
> > --- a/include/linux/perf/arm_pmu.h
> > +++ b/include/linux/perf/arm_pmu.h
> > @@ -183,8 +183,6 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
> >  #define kvm_host_pmu_init(x) do { } while(0)
> >  #endif
> >
> > -bool arm_pmu_irq_is_nmi(void);
> > -
> >  /* Internal functions only for core arm_pmu code */
> >  struct arm_pmu *armpmu_alloc(void);
> >  void armpmu_free(struct arm_pmu *pmu);
> > diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> > index d3ca70e3c256a..8aa5e9a0ba20a 100644
> > --- a/kernel/watchdog_perf.c
> > +++ b/kernel/watchdog_perf.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/panic.h>
> >  #include <linux/nmi.h>
> >  #include <linux/atomic.h>
> > +#include <linux/cpufreq.h>
> >  #include <linux/module.h>
> >  #include <linux/sched/debug.h>
> >
> > @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const cha=
r *str)
> >       wd_hw_attr.type =3D PERF_TYPE_RAW;
> >       wd_hw_attr.config =3D config;
> >  }
> > +
> > +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> > +/*
> > + * Safe maximum CPU frequency in case a particular platform doesn't im=
plement
> > + * cpufreq driver. Although, architecture doesn't put any restrictions=
 on
> > + * maximum frequency but 5 GHz seems to be safe maximum given the avai=
lable
> > + * CPUs in the market which are clocked much less than 5 GHz. On the o=
ther
> > + * hand, we can't make it much higher as it would lead to a large hard=
-lockup
> > + * detection timeout on parts which are running slower (eg. 1GHz on
> > + * Developerbox) and doesn't possess a cpufreq driver.
> > + */
> > +#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > +{
> > +     unsigned int cpu =3D smp_processor_id();
> > +     unsigned long max_cpu_freq;
> > +
> > +     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > +     if (!max_cpu_freq)
> > +             max_cpu_freq =3D SAFE_MAX_CPU_FREQ;
> > +
> > +     return (u64)max_cpu_freq * watchdog_thresh;
> > +}
> > +
> > +static int watchdog_perf_update_period(void *data)
> > +{
> > +     int cpu =3D smp_processor_id();
> > +     u64 max_cpu_freq, new_period;
> > +
> > +     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > +     if (!max_cpu_freq)
> > +             return 0;
> > +
> > +     new_period =3D watchdog_thresh * max_cpu_freq;
> > +     hardlockup_detector_perf_adjust_period(new_period);
> > +
> > +     return 0;
> > +}
> > +
> > +static int watchdog_freq_notifier_callback(struct notifier_block *nb,
> > +                                        unsigned long val, void *data)
> > +{
> > +     struct cpufreq_policy *policy =3D data;
> > +     int cpu;
> > +
> > +     if (val !=3D CPUFREQ_CREATE_POLICY)
> > +             return NOTIFY_DONE;
> > +
> > +     /*
> > +      * Let each online CPU related to the policy update the period by=
 their
> > +      * own. This will serialize with the framework on start/stop the =
lockup
> > +      * detector (softlockup_{start,stop}_all) and avoid potential rac=
e
> > +      * condition. Otherwise we may have below theoretical race condit=
ion:
> > +      * (core 0/1 share the same policy)
> > +      * [core 0]                      [core 1]
> > +      *                               hardlockup_detector_event_create=
()
> > +      *                                 hw_nmi_get_sample_period()
> > +      * (cpufreq registered, notifier callback invoked)
> > +      * watchdog_freq_notifier_callback()
> > +      *   watchdog_perf_update_period()
> > +      *   (since core 1's event's not yet created,
> > +      *    the period is not set)
> > +      *                                 perf_event_create_kernel_count=
er()
> > +      *                                 (event's period is SAFE_MAX_CP=
U_FREQ)
> > +      */
> > +     for_each_cpu(cpu, policy->cpus)
> > +             smp_call_on_cpu(cpu, watchdog_perf_update_period, NULL, f=
alse);
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block watchdog_freq_notifier =3D {
> > +     .notifier_call =3D watchdog_freq_notifier_callback,
> > +};
> > +
> > +static int __init init_watchdog_freq_notifier(void)
> > +{
> > +     return cpufreq_register_notifier(&watchdog_freq_notifier,
> > +                                      CPUFREQ_POLICY_NOTIFIER);
> > +}
> > +core_initcall(init_watchdog_freq_notifier);
> > +#endif
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2cbfa3dead0be..85fdfa9b52346 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1193,6 +1193,14 @@ config HARDLOCKUP_DETECTOR_PERF
> >       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
> >       select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> >
> > +config WATCHDOG_PERF_ADJUST_PERIOD
> > +     bool
>
> it's reasonable to make it depends on HARDLOCKUP_DETECTOR_PERF.

In arch/(arm64|riscv)/Kconfig, there is the configuration line:
select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF

>
> otherwise looks good to me :)
>
> Thanks.
>
> > +     help
> > +       Adjust the watchdog hardlockup detector's period based on CPU m=
ax
> > +       frequency. Uses cpufreq if available; falls back to a safe 5 GH=
z
> > +       default otherwise. Registers a cpufreq notifier to update the p=
eriod
> > +       automatically.
> > +
> >  config HARDLOCKUP_DETECTOR_BUDDY
> >       bool
> >       depends on HARDLOCKUP_DETECTOR


Thanks,
Yunhui
