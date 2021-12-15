Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8AC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Dec 2021 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbhLOQDN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbhLOQDM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Dec 2021 11:03:12 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE12C061401
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:03:12 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f186so56433724ybg.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiNYQTCx80RqOCWsDr0HEjJB5e/RmxK3bF/dCC29mWU=;
        b=CzrfEMlCyBNdUXTadBLO4zZaCHbDXbM0FdxnC6Ud6YNLkmLJ4//mLRolRf3zDw/O7a
         i/LCeqbAo8fZi97Gl9bSAwGR6iFuUNwaCv8BS7x9OIuU6B4LceDcTG9iUAGKgc7JgKP6
         +20R4ojbe6U4ogKZyJZ8RVIx55iS7RkyjTDwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiNYQTCx80RqOCWsDr0HEjJB5e/RmxK3bF/dCC29mWU=;
        b=S6xepp34PjwFpP79WgkYQnqCKBnJr6lYlFbQ3EJhJ2UCaN/anGdmLqVwNkTgbok1xR
         own/BDFvcrOBODq9GUkR/2TAy0FfNsdzRFnVQ5oZo/dzbubDC52zDcrioh5P9lo8GAIn
         BNJASmnKkKYvH6tQHGxRNpbfJgADf7/lqI9ykUB3WGrUOrDKVtD5qmso4yZGCYu3zdRF
         tXoxM4METGwpVkRUPqz0fsBH0x04BhKgeEIIFsesgCpnWnQI6Ysmp1XTKjQ/LBvlLWrq
         eb4vE6PW1RMfb9eHOaHRe7+BhmSdTvsMtvYonR8adRuDlJfjxxAwKKjTsiDNmzsMNne5
         JE2A==
X-Gm-Message-State: AOAM532QOL+rfCP/0aNP+fU6qC+RR65Z4hGgwxzj+C0gJpRttKLzpWXj
        VLDKG4/sDP+8XT4ferd7575vxEaYuVl2VLf2ROg4
X-Google-Smtp-Source: ABdhPJzXQW8xMk9WFdgxeBv6U5lUUQ9SRQofE4GMEUin6G+Dxb6DFCkBbx7Zd6eNLZ/A1IORIMM+JgB8FwA7V/caBHE=
X-Received: by 2002:a25:d157:: with SMTP id i84mr6667830ybg.703.1639584191647;
 Wed, 15 Dec 2021 08:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20211025195350.242914-1-atish.patra@wdc.com> <20211025195350.242914-6-atish.patra@wdc.com>
 <20211215110214.62ca2474@redslave.neermore.group>
In-Reply-To: <20211215110214.62ca2474@redslave.neermore.group>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 15 Dec 2021 08:03:00 -0800
Message-ID: <CAOnJCU+XGcFtJuYu5AMG07guxoaigx=fKnmnNGrrs4AdxKRLeQ@mail.gmail.com>
Subject: Re: [v4 05/11] RISC-V: Add RISC-V SBI PMU extension definitions
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 15, 2021 at 12:10 AM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
>
> Hello Atish!
>
> On Mon, 25 Oct 2021 12:53:44 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > This patch adds all the definitions defined by the SBI PMU extension.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 97
> > ++++++++++++++++++++++++++++++++++++ 1 file changed, 97 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h
> > b/arch/riscv/include/asm/sbi.h index 0d42693cb65e..7a14ca06ba8f 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -27,6 +27,7 @@ enum sbi_ext_id {
> >       SBI_EXT_IPI = 0x735049,
> >       SBI_EXT_RFENCE = 0x52464E43,
> >       SBI_EXT_HSM = 0x48534D,
> > +     SBI_EXT_PMU = 0x504D55,
> >  };
> >
> >  enum sbi_ext_base_fid {
> > @@ -70,6 +71,99 @@ enum sbi_hsm_hart_status {
> >       SBI_HSM_HART_STATUS_STOP_PENDING,
> >  };
> >
> > +
> > +enum sbi_ext_pmu_fid {
> > +     SBI_EXT_PMU_NUM_COUNTERS = 0,
> > +     SBI_EXT_PMU_COUNTER_GET_INFO,
> > +     SBI_EXT_PMU_COUNTER_CFG_MATCH,
> > +     SBI_EXT_PMU_COUNTER_START,
> > +     SBI_EXT_PMU_COUNTER_STOP,
> > +     SBI_EXT_PMU_COUNTER_FW_READ,
> > +};
> > +
> > +#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
> > +#define RISCV_PMU_RAW_EVENT_IDX 0x20000
> > +
> > +/** General pmu event codes specified in SBI PMU extension */
> > +enum sbi_pmu_hw_generic_events_t {
> > +     SBI_PMU_HW_NO_EVENT                     = 0,
> > +     SBI_PMU_HW_CPU_CYCLES                   = 1,
> > +     SBI_PMU_HW_INSTRUCTIONS                 = 2,
> > +     SBI_PMU_HW_CACHE_REFERENCES             = 3,
> > +     SBI_PMU_HW_CACHE_MISSES                 = 4,
> > +     SBI_PMU_HW_BRANCH_INSTRUCTIONS          = 5,
> > +     SBI_PMU_HW_BRANCH_MISSES                = 6,
> > +     SBI_PMU_HW_BUS_CYCLES                   = 7,
> > +     SBI_PMU_HW_STALLED_CYCLES_FRONTEND      = 8,
> > +     SBI_PMU_HW_STALLED_CYCLES_BACKEND       = 9,
> > +     SBI_PMU_HW_REF_CPU_CYCLES               = 10,
> > +
> > +     SBI_PMU_HW_GENERAL_MAX,
> > +};
> > +
> > +/**
> > + * Special "firmware" events provided by the firmware, even if the
> > hardware
> > + * does not support performance events. These events are encoded as
> > a raw
> > + * event type in Linux kernel perf framework.
> > + */
> > +enum sbi_pmu_fw_generic_events_t {
> > +     SBI_PMU_FW_MISALIGNED_LOAD      = 0,
> > +     SBI_PMU_FW_MISALIGNED_STORE     = 1,
> > +     SBI_PMU_FW_ACCESS_LOAD          = 2,
> > +     SBI_PMU_FW_ACCESS_STORE         = 3,
> > +     SBI_PMU_FW_ILLEGAL_INSN         = 4,
> > +     SBI_PMU_FW_SET_TIMER            = 5,
> > +     SBI_PMU_FW_IPI_SENT             = 6,
> > +     SBI_PMU_FW_IPI_RECVD            = 7,
> > +     SBI_PMU_FW_FENCE_I_SENT         = 8,
> > +     SBI_PMU_FW_FENCE_I_RECVD        = 9,
> > +     SBI_PMU_FW_SFENCE_VMA_SENT      = 10,
> > +     SBI_PMU_FW_SFENCE_VMA_RCVD      = 11,
> > +     SBI_PMU_FW_SFENCE_VMA_ASID_SENT = 12,
> > +     SBI_PMU_FW_SFENCE_VMA_ASID_RCVD = 13,
> > +
> > +     SBI_PMU_FW_HFENCE_GVMA_SENT     = 14,
> > +     SBI_PMU_FW_HFENCE_GVMA_RCVD     = 15,
> > +     SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
> > +     SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
> > +
> > +     SBI_PMU_FW_HFENCE_VVMA_SENT     = 18,
> > +     SBI_PMU_FW_HFENCE_VVMA_RCVD     = 19,
> > +     SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
> > +     SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
> > +     SBI_PMU_FW_MAX,
> > +};
> > +
> > +/* SBI PMU event types */
> > +enum sbi_pmu_event_type {
> > +     SBI_PMU_EVENT_TYPE_HW = 0x0,
> > +     SBI_PMU_EVENT_TYPE_CACHE = 0x1,
> > +     SBI_PMU_EVENT_TYPE_RAW = 0x2,
> > +     SBI_PMU_EVENT_TYPE_FW = 0xf,
> > +};
> > +
> > +/* SBI PMU event types */
> > +enum sbi_pmu_ctr_type {
> > +     SBI_PMU_CTR_TYPE_HW = 0x0,
> > +     SBI_PMU_CTR_TYPE_FW,
> > +};
> > +
> > +/* Flags defined for config matching function */
> > +#define SBI_PMU_CFG_FLAG_SKIP_MATCH  (1 << 0)
> > +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE (1 << 1)
> > +#define SBI_PMU_CFG_FLAG_AUTO_START  (1 << 2)
> > +#define SBI_PMU_CFG_FLAG_SET_MINH    (1 << 3)
> > +#define SBI_PMU_CFG_FLAG_SET_SINH    (1 << 4)
> > +#define SBI_PMU_CFG_FLAG_SET_UINH    (1 << 5)
> > +#define SBI_PMU_CFG_FLAG_SET_VSINH   (1 << 6)
> > +#define SBI_PMU_CFG_FLAG_SET_VUINH   (1 << 7)
>
> It looks like you have a typo here, the defines in OpenSBI are
> different:
>
> #define SBI_PMU_CFG_FLAG_SET_VUINH      (1 << 3)
> #define SBI_PMU_CFG_FLAG_SET_VSINH      (1 << 4)
> #define SBI_PMU_CFG_FLAG_SET_UINH       (1 << 5)
> #define SBI_PMU_CFG_FLAG_SET_SINH       (1 << 6)
> #define SBI_PMU_CFG_FLAG_SET_MINH       (1 << 7)
>
>

Thanks for catching that. OpenSBI has the correct one as per the
specification[1].
I will fix it in the next version.

[1] https://github.com/riscv-software-src/opensbi/blob/master/include/sbi/sbi_ecall_interface.h

> > +
> > +/* Flags defined for counter start function */
> > +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> > +
> > +/* Flags defined for counter stop function */
> > +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> > +
> >  #define SBI_SPEC_VERSION_DEFAULT     0x1
> >  #define SBI_SPEC_VERSION_MAJOR_SHIFT 24
> >  #define SBI_SPEC_VERSION_MAJOR_MASK  0x7f
> > @@ -82,6 +176,9 @@ enum sbi_hsm_hart_status {
> >  #define SBI_ERR_INVALID_PARAM        -3
> >  #define SBI_ERR_DENIED               -4
> >  #define SBI_ERR_INVALID_ADDRESS      -5
> > +#define SBI_ERR_ALREADY_AVAILABLE -6
> > +#define SBI_ERR_ALREADY_STARTED -7
> > +#define SBI_ERR_ALREADY_STOPPED -8
> >
> >  extern unsigned long sbi_spec_version;
> >  struct sbiret {
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
