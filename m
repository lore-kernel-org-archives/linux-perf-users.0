Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC42C83F12
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjH2KhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjH2Kgp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 06:36:45 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42459198
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:36:42 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44d526f96fcso1285147137.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305401; x=1693910201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hVBkVLH3QC7fHZ/BEssrc+xOo41yz88ko37ylycWuSU=;
        b=nETByJ1aa8cIYUWQbOS4D/ZJLgtAcE17So4tLSCO2AI0v8zsS9r0J7i1o10MrVinUD
         jh9aPRpFjwK29fS65/wBJpt8ojCEfb1vjWz1gDVnxxuG7zmYwxFfX9OUu92DTBHMynrC
         9GS/meqbm92mrtUGt4Rz2n1dzhhOJtp9me7y2NvDQWynXDNq/NGP4DlSFUy23omBoJHX
         k4MpUe0cOGitK0YP6fR7j4MgQcnEF4+o0flBLOjtBXzyXFKPULr6ZWK/BAFfbWdAFWpQ
         FduhvcMOlvHFkaDF73u4C0CvOQSfgn9H3aTNACnthq3EP6qDanXPM2mVVP+zwSdB3n4b
         /+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305401; x=1693910201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVBkVLH3QC7fHZ/BEssrc+xOo41yz88ko37ylycWuSU=;
        b=e5i87y6AmUEnR9f8AnS2CNTSMHB0zSvmc4DYvz7lFPi1V29TtkJk/skKX4ddFbbzY4
         6fk7QvT5LKukGrq1eguMnbL21Y77ZW0gM05RbNc76/M+9/Ju/2KTSsobRR0ZZgleh3PC
         1hSA8R+DwOU3Adhj1RlyHKDGbWpwz7RdPE4MEDNL4ptmt9FkxaKg3QxclilPJpq4nNsa
         deM4YTs45CmZwRn/UeYOYGV/UoIvOf8YBpjav0/Ub0omBGAfAOV4y+MLnf0kAlhQEnpf
         qTt/5A16BeMDqYAewx34GsyXJvT9+WlELKDMAkTgznEd6T9FMFf8whjbxSGHLbq1ZLiO
         sIyw==
X-Gm-Message-State: AOJu0YzZ7g/Rm6C/yHScKYNhHp+PekFFMzLoi3NoW5grY6RESUKIsuLW
        LCGKh1fIxqN3ttLX8Q1SovxwEXfeMlNMLGdWDPro1A==
X-Google-Smtp-Source: AGHT+IHrytUJH5I8zDaQ5yGNluZPFNS9cgWFNHOsNNTu4Do+ZfLoGsBEhECaztap0PP4+h41sb3j5k/P8KpBhAaNXrM=
X-Received: by 2002:a05:6102:b09:b0:44f:c528:6252 with SMTP id
 b9-20020a0561020b0900b0044fc5286252mr248799vst.2.1693305401145; Tue, 29 Aug
 2023 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
In-Reply-To: <20230824083012.v11.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:06:30 +0530
Message-ID: <CAFA6WYO7u5WTS8dfzqPUcLpHWTH+3sMNVL-9ob0stHE_nJw24Q@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> and use handle_percpu_devid_irq() by default. Unfortunately,
> handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> context those should use handle_percpu_devid_fasteoi_nmi().
>
> In order to accomplish this, we just have to make room for SGIs in the
> array of refcounts that keeps track of which interrupts are set as
> NMI. We also rename the array and create a new indexing scheme that
> accounts for SGIs.
>
> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> as IRQs/NMIs happen as part of this routine.
>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> In v10 I removed the previous Reviewed-by and Tested-by tags since the
> patch contents changed pretty drastically.
>
> I'll also note that this change is a little more black magic to me
> than others in this series. I don't have a massive amounts of
> familiarity with all the moving parts of gic-v3, so I mostly just
> followed Mark Rutland's advice [1]. Please pay extra attention to make
> sure I didn't do anything too terrible.

The changes look good to me. I am not sure if my review tag will be
valuable here since I am a co-developer here.

-Sumit

>
> Mark's advice wasn't a full patch and I ended up doing a bit of work
> to translate it to reality, so I did not add him as "Co-developed-by"
> here. Mark: if you would like this tag then please provide it and your
> Signed-off-by. I certainly won't object.
>
> [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com
>
> (no changes since v10)
>
> Changes in v10:
> - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
>
>  drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index eedfa8e9f077..49d18cf3f636 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -78,6 +78,8 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>  #define GIC_LINE_NR    min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
>  #define GIC_ESPI_NR    GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
>
> +#define SGI_NR         16
> +
>  /*
>   * The behaviours of RPR and PMR registers differ depending on the value of
>   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
> @@ -125,8 +127,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
>                 __priority;                                             \
>         })
>
> -/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
> -static refcount_t *ppi_nmi_refs;
> +/* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
> +static refcount_t *rdist_nmi_refs;
>
>  static struct gic_kvm_info gic_v3_kvm_info __initdata;
>  static DEFINE_PER_CPU(bool, has_rss);
> @@ -519,9 +521,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
>         }
>  }
>
> -static u32 gic_get_ppi_index(struct irq_data *d)
> +static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
> +{
> +       switch (__get_intid_range(hwirq)) {
> +       case SGI_RANGE:
> +       case PPI_RANGE:
> +               return hwirq;
> +       case EPPI_RANGE:
> +               return hwirq - EPPI_BASE_INTID + 32;
> +       default:
> +               unreachable();
> +       }
> +}
> +
> +static u32 gic_get_rdist_idx(struct irq_data *d)
>  {
> -       return __gic_get_ppi_index(d->hwirq);
> +       return __gic_get_rdist_idx(d->hwirq);
>  }
>
>  static int gic_irq_nmi_setup(struct irq_data *d)
> @@ -545,11 +560,14 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>
>         /* desc lock should already be held */
>         if (gic_irq_in_rdist(d)) {
> -               u32 idx = gic_get_ppi_index(d);
> +               u32 idx = gic_get_rdist_idx(d);
>
> -               /* Setting up PPI as NMI, only switch handler for first NMI */
> -               if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
> -                       refcount_set(&ppi_nmi_refs[idx], 1);
> +               /*
> +                * Setting up a percpu interrupt as NMI, only switch handler
> +                * for first NMI
> +                */
> +               if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
> +                       refcount_set(&rdist_nmi_refs[idx], 1);
>                         desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>                 }
>         } else {
> @@ -582,10 +600,10 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>
>         /* desc lock should already be held */
>         if (gic_irq_in_rdist(d)) {
> -               u32 idx = gic_get_ppi_index(d);
> +               u32 idx = gic_get_rdist_idx(d);
>
>                 /* Tearing down NMI, only switch handler for last NMI */
> -               if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
> +               if (refcount_dec_and_test(&rdist_nmi_refs[idx]))
>                         desc->handle_irq = handle_percpu_devid_irq;
>         } else {
>                 desc->handle_irq = handle_fasteoi_irq;
> @@ -1279,10 +1297,10 @@ static void gic_cpu_init(void)
>         rbase = gic_data_rdist_sgi_base();
>
>         /* Configure SGIs/PPIs as non-secure Group-1 */
> -       for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
> +       for (i = 0; i < gic_data.ppi_nr + SGI_NR; i += 32)
>                 writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
>
> -       gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
> +       gic_cpu_config(rbase, gic_data.ppi_nr + SGI_NR, gic_redist_wait_for_rwp);
>
>         /* initialise system registers */
>         gic_cpu_sys_reg_init();
> @@ -1939,12 +1957,13 @@ static void gic_enable_nmi_support(void)
>                 return;
>         }
>
> -       ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
> -       if (!ppi_nmi_refs)
> +       rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
> +                                sizeof(*rdist_nmi_refs), GFP_KERNEL);
> +       if (!rdist_nmi_refs)
>                 return;
>
> -       for (i = 0; i < gic_data.ppi_nr; i++)
> -               refcount_set(&ppi_nmi_refs[i], 0);
> +       for (i = 0; i < gic_data.ppi_nr + SGI_NR; i++)
> +               refcount_set(&rdist_nmi_refs[i], 0);
>
>         pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
>                 gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
> @@ -2061,6 +2080,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>
>         gic_dist_init();
>         gic_cpu_init();
> +       gic_enable_nmi_support();
>         gic_smp_init();
>         gic_cpu_pm_init();
>
> @@ -2073,8 +2093,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>                         gicv2m_init(handle, gic_data.domain);
>         }
>
> -       gic_enable_nmi_support();
> -
>         return 0;
>
>  out_free:
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
