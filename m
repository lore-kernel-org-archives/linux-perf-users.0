Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D00CCA479
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiF1NZU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346345AbiF1NZG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 09:25:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCF36158
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 06:21:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g4so22226904lfv.9
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i9OmUcCYtxYmLpPV5EK9xnLGgU5ydCPjivPQxAxv/Y=;
        b=agU/nLOghT98fW7OTeKe1t8hM9IAuOqXbJvVYBkIY0pwT7jzkuo1hC7JWefLk3ZPuZ
         XCpzgUUYiwhU7daiVyX3LObunGknvxDjuw7oofsHkcBOK6FP72r4etfNToivTsbTZ7XN
         hF2Zq7SWwkX/QXrF8bs40XMZM6u7tYNztWRJUMBlqjVAUq/l4nQSXnlUItSoqAmzi1NN
         dISZhTEyFUrKYN0788YlMK6YOiEgB5xQ56h9JLInHH8arNXOw4mu1TelK8FhepHfoqHT
         WWP02IsHmnkBNCTdyKIM3cCEzk7lAh5tWAqiwRvdZfidF2UMFJkwjjptYbI8fXlg9skk
         bgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i9OmUcCYtxYmLpPV5EK9xnLGgU5ydCPjivPQxAxv/Y=;
        b=8KuFqMrU2TkuiadSQ4Pz37OG9tZCLv8svLPIX6Bke0/yzBw9KbNprxNzdO3+kRj4DE
         zfGoBXVdo6np3M53Xa+L+gYp0TqJ5C6micbYzCgBf2lJR/5xuVo3B3W4fJO5rnbDN6ap
         rWlwazO2Q7TO1eKYWR8ppJZt3rRkIPsMqrCPB4yvMvNui6IZ2mU1b3okGZjahDasJ+oo
         2r/gdOJ+vVXLFHSmq/e5nYgv9dLIMoX33zs9Qr852GkQY8bI/jlV/knZBceI+gE1rAQ4
         RZpyUCTMDacHDHa0aYsFgYw27pasGIyKtYuMJRyRBiyCuodRoUSYWA5c2dy7hN+eJi9E
         7CuA==
X-Gm-Message-State: AJIora+ew0UY/QdZAL+vrWdLQAPwYVn0+gAk8EVZgft5pG2RhjZOD8OK
        N2/QvGwv1Jg37+15EQ1N+j9gfQPR267KAYGjuLSW+w==
X-Google-Smtp-Source: AGRyM1v0fgdpjHzHv8JkI02NBZZld3DmYsZhkHLm7JBkFeSf1j0FSQ2QhutxzIkbCur8DQvQQ7UcECyAPVNgYChUaNk=
X-Received: by 2002:ac2:4906:0:b0:47f:6c71:6de5 with SMTP id
 n6-20020ac24906000000b0047f6c716de5mr12443219lfi.137.1656422518034; Tue, 28
 Jun 2022 06:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-9-elver@google.com>
In-Reply-To: <20220628095833.2579903-9-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jun 2022 15:21:46 +0200
Message-ID: <CACT4Y+Z4W4CRO+pEvDjdmGwP+CX+MuQYE9bs2mPvUFm1Np83Dg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] powerpc/hw_breakpoint: Avoid relying on caller synchronization
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
>
> Internal data structures (cpu_bps, task_bps) of powerpc's hw_breakpoint
> implementation have relied on nr_bp_mutex serializing access to them.
>
> Before overhauling synchronization of kernel/events/hw_breakpoint.c,
> introduce 2 spinlocks to synchronize cpu_bps and task_bps respectively,
> thus avoiding reliance on callers synchronizing powerpc's hw_breakpoint.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * New patch.
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 53 ++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 2669f80b3a49..8db1a15d7acb 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> +#include <linux/spinlock.h>
>  #include <linux/debugfs.h>
>  #include <linux/init.h>
>
> @@ -129,7 +130,14 @@ struct breakpoint {
>         bool ptrace_bp;
>  };
>
> +/*
> + * While kernel/events/hw_breakpoint.c does its own synchronization, we cannot
> + * rely on it safely synchronizing internals here; however, we can rely on it
> + * not requesting more breakpoints than available.
> + */
> +static DEFINE_SPINLOCK(cpu_bps_lock);
>  static DEFINE_PER_CPU(struct breakpoint *, cpu_bps[HBP_NUM_MAX]);
> +static DEFINE_SPINLOCK(task_bps_lock);
>  static LIST_HEAD(task_bps);
>
>  static struct breakpoint *alloc_breakpoint(struct perf_event *bp)
> @@ -174,7 +182,9 @@ static int task_bps_add(struct perf_event *bp)
>         if (IS_ERR(tmp))
>                 return PTR_ERR(tmp);
>
> +       spin_lock(&task_bps_lock);
>         list_add(&tmp->list, &task_bps);
> +       spin_unlock(&task_bps_lock);
>         return 0;
>  }
>
> @@ -182,6 +192,7 @@ static void task_bps_remove(struct perf_event *bp)
>  {
>         struct list_head *pos, *q;
>
> +       spin_lock(&task_bps_lock);
>         list_for_each_safe(pos, q, &task_bps) {
>                 struct breakpoint *tmp = list_entry(pos, struct breakpoint, list);
>
> @@ -191,6 +202,7 @@ static void task_bps_remove(struct perf_event *bp)
>                         break;
>                 }
>         }
> +       spin_unlock(&task_bps_lock);
>  }
>
>  /*
> @@ -200,12 +212,17 @@ static void task_bps_remove(struct perf_event *bp)
>  static bool all_task_bps_check(struct perf_event *bp)
>  {
>         struct breakpoint *tmp;
> +       bool ret = false;
>
> +       spin_lock(&task_bps_lock);
>         list_for_each_entry(tmp, &task_bps, list) {
> -               if (!can_co_exist(tmp, bp))
> -                       return true;
> +               if (!can_co_exist(tmp, bp)) {
> +                       ret = true;
> +                       break;
> +               }
>         }
> -       return false;
> +       spin_unlock(&task_bps_lock);
> +       return ret;
>  }
>
>  /*
> @@ -215,13 +232,18 @@ static bool all_task_bps_check(struct perf_event *bp)
>  static bool same_task_bps_check(struct perf_event *bp)
>  {
>         struct breakpoint *tmp;
> +       bool ret = false;
>
> +       spin_lock(&task_bps_lock);
>         list_for_each_entry(tmp, &task_bps, list) {
>                 if (tmp->bp->hw.target == bp->hw.target &&
> -                   !can_co_exist(tmp, bp))
> -                       return true;
> +                   !can_co_exist(tmp, bp)) {
> +                       ret = true;
> +                       break;
> +               }
>         }
> -       return false;
> +       spin_unlock(&task_bps_lock);
> +       return ret;
>  }
>
>  static int cpu_bps_add(struct perf_event *bp)
> @@ -234,6 +256,7 @@ static int cpu_bps_add(struct perf_event *bp)
>         if (IS_ERR(tmp))
>                 return PTR_ERR(tmp);
>
> +       spin_lock(&cpu_bps_lock);
>         cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
>         for (i = 0; i < nr_wp_slots(); i++) {
>                 if (!cpu_bp[i]) {
> @@ -241,6 +264,7 @@ static int cpu_bps_add(struct perf_event *bp)
>                         break;
>                 }
>         }
> +       spin_unlock(&cpu_bps_lock);
>         return 0;
>  }
>
> @@ -249,6 +273,7 @@ static void cpu_bps_remove(struct perf_event *bp)
>         struct breakpoint **cpu_bp;
>         int i = 0;
>
> +       spin_lock(&cpu_bps_lock);
>         cpu_bp = per_cpu_ptr(cpu_bps, bp->cpu);
>         for (i = 0; i < nr_wp_slots(); i++) {
>                 if (!cpu_bp[i])
> @@ -260,19 +285,25 @@ static void cpu_bps_remove(struct perf_event *bp)
>                         break;
>                 }
>         }
> +       spin_unlock(&cpu_bps_lock);
>  }
>
>  static bool cpu_bps_check(int cpu, struct perf_event *bp)
>  {
>         struct breakpoint **cpu_bp;
> +       bool ret = false;
>         int i;
>
> +       spin_lock(&cpu_bps_lock);
>         cpu_bp = per_cpu_ptr(cpu_bps, cpu);
>         for (i = 0; i < nr_wp_slots(); i++) {
> -               if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp))
> -                       return true;
> +               if (cpu_bp[i] && !can_co_exist(cpu_bp[i], bp)) {
> +                       ret = true;
> +                       break;
> +               }
>         }
> -       return false;
> +       spin_unlock(&cpu_bps_lock);
> +       return ret;
>  }
>
>  static bool all_cpu_bps_check(struct perf_event *bp)
> @@ -286,10 +317,6 @@ static bool all_cpu_bps_check(struct perf_event *bp)
>         return false;
>  }
>
> -/*
> - * We don't use any locks to serialize accesses to cpu_bps or task_bps
> - * because are already inside nr_bp_mutex.
> - */
>  int arch_reserve_bp_slot(struct perf_event *bp)
>  {
>         int ret;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
