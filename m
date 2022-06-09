Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D263DC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 11:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiFIL4N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbiFIL4N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 07:56:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C32C3A
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 04:56:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so37564708lfo.13
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WY4HD3Pbrvr9rNcNT3QthTekyAgPVjpj/oQPb25t2us=;
        b=F2mY2KyjStSCcJDrxpUa4qJ1im4Hog16PjQPUDWpVZi3XYmPt8z6vVKqJ4+2TkvvPH
         ei1x+gOwSxEeKIj5EW+D3FTE0rHdDFHVcGrqLmERzMrTdfEt1opS+bBiv0VyePPmO+96
         jmOgw1WzXFpE3uuuI9S4xrD5Y9Z7h0blixCxNf2DxnLvBdorDllHsSaQ0UVJO8GnMGr8
         R3eiS7HHaOpZQm9fxYeYQA6KTzMQjIquR71Upfw+8rAlvPetG9IN8I9G6FVXsmWE2vEY
         qWKkb0fgXMJsz8fvLCzHSKcUn7p6Eb/9aIrjf6CIB7gOjo/kN81R81VO7i8Uou4MHlKv
         xMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WY4HD3Pbrvr9rNcNT3QthTekyAgPVjpj/oQPb25t2us=;
        b=lVIS37CE/Ys5VMIUFyfuyOG1YpH2pIyyU8ciA7xoph8QFa6ugKoYBlWlNzt6tvrA1A
         Z8p50L9EiVuq1+1BlnnMdvFMzAM8fV40icKv3IimdrIlg7ZEZSuvSQvqcC9L08PTw+qx
         Kay/f/oZMuxrFUSPHfz3l+rk/jMsDn1V+9uY7zW0Vmicb5UXNmvs7+Rq8SBS2AP04Gv7
         Oz5oyeBlcP5f4CTqaRvzKdSeVUh71ZxstM/dzj+qZNBxZ9BH7vnYUoGnfVnF6ma3Ei/U
         w1OX58LxWGjg0FNhgMYh6I1uQ7zjyntpTUHn0+jH0UzZHtudvlps+U6nHwicA0FzXZnO
         Q98A==
X-Gm-Message-State: AOAM530WzXjjIXX/AbFxBSF7eACyJf1i28H437AEqaEblD68uUW3NzeN
        xGZK31pQ9TUpMt5j9LP+AI9KVBsHkRfr8vYRHpLaSg==
X-Google-Smtp-Source: ABdhPJz5vyDGD5qWkZDewiKp7Ua9vFpd+SeY5clxGxh/mzs4jDDxx3msKCtJAxX9ZwFYc1YO4ONn05N+8Go7CZo8B9c=
X-Received: by 2002:a05:6512:3d0:b0:478:9aca:4a06 with SMTP id
 w16-20020a05651203d000b004789aca4a06mr24033399lfp.410.1654775769284; Thu, 09
 Jun 2022 04:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-4-elver@google.com>
In-Reply-To: <20220609113046.780504-4-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 13:55:57 +0200
Message-ID: <CACT4Y+YhFT3wwtbjdjmBs5wKYjF3DOmH=AoP0Qq5bb6DAGHZxA@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/hw_breakpoint: Optimize constant number of
 breakpoint slots
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
>
> Optimize internal hw_breakpoint state if the architecture's number of
> breakpoint slots is constant. This avoids several kmalloc() calls and
> potentially unnecessary failures if the allocations fail, as well as
> subtly improves code generation and cache locality.
>
> The protocol is that if an architecture defines hw_breakpoint_slots via
> the preprocessor, it must be constant and the same for all types.
>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/sh/include/asm/hw_breakpoint.h  |  5 +-
>  arch/x86/include/asm/hw_breakpoint.h |  5 +-
>  kernel/events/hw_breakpoint.c        | 92 ++++++++++++++++++----------
>  3 files changed, 62 insertions(+), 40 deletions(-)
>
> diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
> index 199d17b765f2..361a0f57bdeb 100644
> --- a/arch/sh/include/asm/hw_breakpoint.h
> +++ b/arch/sh/include/asm/hw_breakpoint.h
> @@ -48,10 +48,7 @@ struct pmu;
>  /* Maximum number of UBC channels */
>  #define HBP_NUM                2
>
> -static inline int hw_breakpoint_slots(int type)
> -{
> -       return HBP_NUM;
> -}
> +#define hw_breakpoint_slots(type) (HBP_NUM)
>
>  /* arch/sh/kernel/hw_breakpoint.c */
>  extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index a1f0e90d0818..0bc931cd0698 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -44,10 +44,7 @@ struct arch_hw_breakpoint {
>  /* Total number of available HW breakpoint registers */
>  #define HBP_NUM 4
>
> -static inline int hw_breakpoint_slots(int type)
> -{
> -       return HBP_NUM;
> -}
> +#define hw_breakpoint_slots(type) (HBP_NUM)
>
>  struct perf_event_attr;
>  struct perf_event;
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 1f718745d569..8e939723f27d 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -41,13 +41,16 @@ struct bp_cpuinfo {
>         /* Number of pinned cpu breakpoints in a cpu */
>         unsigned int    cpu_pinned;
>         /* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
> +#ifdef hw_breakpoint_slots
> +       unsigned int    tsk_pinned[hw_breakpoint_slots(0)];
> +#else
>         unsigned int    *tsk_pinned;
> +#endif
>         /* Number of non-pinned cpu/task breakpoints in a cpu */
>         unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
>  };
>
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> -static int nr_slots[TYPE_MAX] __ro_after_init;
>
>  static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>  {
> @@ -74,6 +77,54 @@ struct bp_busy_slots {
>  /* Serialize accesses to the above constraints */
>  static DEFINE_MUTEX(nr_bp_mutex);
>
> +#ifdef hw_breakpoint_slots
> +/*
> + * Number of breakpoint slots is constant, and the same for all types.
> + */
> +static_assert(hw_breakpoint_slots(TYPE_INST) == hw_breakpoint_slots(TYPE_DATA));
> +static inline int hw_breakpoint_slots_cached(int type) { return hw_breakpoint_slots(type); }
> +static inline int init_breakpoint_slots(void)          { return 0; }
> +#else
> +/*
> + * Dynamic number of breakpoint slots.
> + */
> +static int __nr_bp_slots[TYPE_MAX] __ro_after_init;
> +
> +static inline int hw_breakpoint_slots_cached(int type)
> +{
> +       return __nr_bp_slots[type];
> +}
> +
> +static __init int init_breakpoint_slots(void)
> +{
> +       int i, cpu, err_cpu;
> +
> +       for (i = 0; i < TYPE_MAX; i++)
> +               __nr_bp_slots[i] = hw_breakpoint_slots(i);
> +
> +       for_each_possible_cpu(cpu) {
> +               for (i = 0; i < TYPE_MAX; i++) {
> +                       struct bp_cpuinfo *info = get_bp_info(cpu, i);
> +
> +                       info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(int), GFP_KERNEL);
> +                       if (!info->tsk_pinned)
> +                               goto err;
> +               }
> +       }
> +
> +       return 0;
> +err:
> +       for_each_possible_cpu(err_cpu) {
> +               for (i = 0; i < TYPE_MAX; i++)
> +                       kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> +               if (err_cpu == cpu)
> +                       break;
> +       }
> +
> +       return -ENOMEM;
> +}
> +#endif
> +
>  __weak int hw_breakpoint_weight(struct perf_event *bp)
>  {
>         return 1;
> @@ -96,7 +147,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>         unsigned int *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
>         int i;
>
> -       for (i = nr_slots[type] - 1; i >= 0; i--) {
> +       for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
>                 if (tsk_pinned[i] > 0)
>                         return i + 1;
>         }
> @@ -313,7 +364,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         fetch_this_slot(&slots, weight);
>
>         /* Flexible counters need to keep at least one slot */
> -       if (slots.pinned + (!!slots.flexible) > nr_slots[type])
> +       if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
>                 return -ENOSPC;
>
>         ret = arch_reserve_bp_slot(bp);
> @@ -688,42 +739,19 @@ static struct pmu perf_breakpoint = {
>
>  int __init init_hw_breakpoint(void)
>  {
> -       int cpu, err_cpu;
> -       int i, ret;
> -
> -       for (i = 0; i < TYPE_MAX; i++)
> -               nr_slots[i] = hw_breakpoint_slots(i);
> -
> -       for_each_possible_cpu(cpu) {
> -               for (i = 0; i < TYPE_MAX; i++) {
> -                       struct bp_cpuinfo *info = get_bp_info(cpu, i);
> -
> -                       info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
> -                                                       GFP_KERNEL);
> -                       if (!info->tsk_pinned) {
> -                               ret = -ENOMEM;
> -                               goto err;
> -                       }
> -               }
> -       }
> +       int ret;
>
>         ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
>         if (ret)
> -               goto err;
> +               return ret;
> +
> +       ret = init_breakpoint_slots();
> +       if (ret)
> +               return ret;
>
>         constraints_initialized = true;
>
>         perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>
>         return register_die_notifier(&hw_breakpoint_exceptions_nb);
> -
> -err:
> -       for_each_possible_cpu(err_cpu) {
> -               for (i = 0; i < TYPE_MAX; i++)
> -                       kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> -               if (err_cpu == cpu)
> -                       break;
> -       }
> -
> -       return ret;
>  }
> --
> 2.36.1.255.ge46751e96f-goog
>
