Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F02BCCA47B
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 12:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiFIMad (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbiFIMaa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 08:30:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B08C1DA46
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 05:30:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h23so37746465lfe.4
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqP5eMJEaejE2EE5ptLXYYiISpaJ8khY1mUkqMBz8rQ=;
        b=B6BHal5yV8fSdM9iSjA9WLco6js8fW+XR/frQ7/8ID/rUgbrY4ECSU2UFAUru3LRUT
         VNIE5mGQcn9esZejsTwHx9lw0FOFkubu8HRv71KblgCHVNSmhq7vI9tjMOdtEWTrF6v6
         H1IsU+b6PHiNFcw29yEC1nVMLZ/AyiJO2MIxwrMuz0GtdQ/Pfg/mBr5zT7fpsWUoGOOh
         v0MjTZTSQe+huyYhrGEXgOBfcr6rVUhqqVJlB6Nr1vB16D8LZU+NSzImkXOGFc+SzuxV
         1uDY2UlU2N1qx2FiM7LVD5+DexwCobIRTdQnYEl5xp8CS5s9IDgLAgCNkSErAikt6Xec
         3Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqP5eMJEaejE2EE5ptLXYYiISpaJ8khY1mUkqMBz8rQ=;
        b=gQalajJjpejTGZGpfBKmaPgJhm8GC57ic4bpBFt8EgH6AKOXcs+ptaDxE9p8AzUQfX
         Lb+l668JE2oMs2XKNBIqdTBlSf3Kc7aWXUzGwaGI/1BPKVOLb7PNtg/eqaKLbdRXPe8e
         nk+QnYOQmuFFI4EgoJW5bQkrmC9Ej9EVP+KeQWR+wq0/Qs9f4W2uFuE4lKaPZqr5WDXi
         2KpOt0B6WRemHhj4zrc1hjh2nkyiYF7mqfetyVF20H0FDBIl+GRhF681c5ffuQdsgPMD
         5fOJFYmpFu3onjBoO4uDbUinCWsjbDPACJmgttSeDxHWdPKFbPdKahjadeg1ph4A8+B/
         lVIg==
X-Gm-Message-State: AOAM530Wx+jmuO2bTlOC59Cv341ZsS2Sddm0Beu0vKgC652CJ1uLGD9r
        xTIRXuGGC6hFjm5japZxCG5uJ81HjoGPmeYFM3JU1Q==
X-Google-Smtp-Source: ABdhPJxRaHeKPL3Sa/Of+nKOcscU8hJff6vmc+SN4k/sYQVtaBvmokG0D1zUhQ6uhlFusOWmnoOkSf5SlT5Hd6czrWw=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr25273629lfa.598.1654777826331; Thu, 09
 Jun 2022 05:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
In-Reply-To: <20220609113046.780504-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:30:14 +0200
Message-ID: <CACT4Y+ZfjLCj=wvPFhyUQLwxmcOXuK9G_a53SB=-niySExQdew@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
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
> On a machine with 256 CPUs, running the recently added perf breakpoint
> benchmark results in:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 236.418 [sec]
>  |
>  |   123134.794271 usecs/op
>  |  7880626.833333 usecs/op/cpu
>
> The benchmark tests inherited breakpoint perf events across many
> threads.
>
> Looking at a perf profile, we can see that the majority of the time is
> spent in various hw_breakpoint.c functions, which execute within the
> 'nr_bp_mutex' critical sections which then results in contention on that
> mutex as well:
>
>     37.27%  [kernel]       [k] osq_lock
>     34.92%  [kernel]       [k] mutex_spin_on_owner
>     12.15%  [kernel]       [k] toggle_bp_slot
>     11.90%  [kernel]       [k] __reserve_bp_slot
>
> The culprit here is task_bp_pinned(), which has a runtime complexity of
> O(#tasks) due to storing all task breakpoints in the same list and
> iterating through that list looking for a matching task. Clearly, this
> does not scale to thousands of tasks.
>
> While one option would be to make task_struct a breakpoint list node,
> this would only further bloat task_struct for infrequently used data.
>
> Instead, make use of the "rhashtable" variant "rhltable" which stores
> multiple items with the same key in a list. This results in average
> runtime complexity of O(1) for task_bp_pinned().
>
> With the optimization, the benchmark shows:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 0.208 [sec]
>  |
>  |      108.422396 usecs/op
>  |     6939.033333 usecs/op/cpu
>
> On this particular setup that's a speedup of ~1135x.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/perf_event.h    |  3 +-
>  kernel/events/hw_breakpoint.c | 56 ++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 01231f1d976c..e27360436dc6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -36,6 +36,7 @@ struct perf_guest_info_callbacks {
>  };
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#include <linux/rhashtable-types.h>
>  #include <asm/hw_breakpoint.h>
>  #endif
>
> @@ -178,7 +179,7 @@ struct hw_perf_event {
>                          * creation and event initalization.
>                          */
>                         struct arch_hw_breakpoint       info;
> -                       struct list_head                bp_list;
> +                       struct rhlist_head              bp_list;
>                 };
>  #endif
>                 struct { /* amd_iommu */
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index f32320ac02fd..25c94c6e918d 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -28,7 +28,7 @@
>  #include <linux/sched.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/list.h>
> +#include <linux/rhashtable.h>
>  #include <linux/cpu.h>
>  #include <linux/smp.h>
>  #include <linux/bug.h>
> @@ -55,7 +55,13 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>  }
>
>  /* Keep track of the breakpoints attached to tasks */
> -static LIST_HEAD(bp_task_head);
> +static struct rhltable task_bps_ht;
> +static const struct rhashtable_params task_bps_ht_params = {
> +       .head_offset = offsetof(struct hw_perf_event, bp_list),
> +       .key_offset = offsetof(struct hw_perf_event, target),
> +       .key_len = sizeof_field(struct hw_perf_event, target),
> +       .automatic_shrinking = true,
> +};
>
>  static int constraints_initialized;
>
> @@ -104,17 +110,23 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>   */
>  static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
>  {
> -       struct task_struct *tsk = bp->hw.target;
> +       struct rhlist_head *head, *pos;
>         struct perf_event *iter;
>         int count = 0;
>
> -       list_for_each_entry(iter, &bp_task_head, hw.bp_list) {
> -               if (iter->hw.target == tsk &&
> -                   find_slot_idx(iter->attr.bp_type) == type &&
> +       rcu_read_lock();

Why do we need rcu_read_lock() here?
The patch does not change anything with respect to locking, so all
accesses to the container should still be protected by nr_bp_mutex.
Similarly for the rcu variant of for_each below.

Otherwise the change looks good to me.



> +       head = rhltable_lookup(&task_bps_ht, &bp->hw.target, task_bps_ht_params);
> +       if (!head)
> +               goto out;
> +
> +       rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
> +               if (find_slot_idx(iter->attr.bp_type) == type &&
>                     (iter->cpu < 0 || cpu == iter->cpu))
>                         count += hw_breakpoint_weight(iter);
>         }
>
> +out:
> +       rcu_read_unlock();
>         return count;
>  }
>
> @@ -187,7 +199,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
>  /*
>   * Add/remove the given breakpoint in our constraint table
>   */
> -static void
> +static int
>  toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>                int weight)
>  {
> @@ -200,7 +212,7 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>         /* Pinned counter cpu profiling */
>         if (!bp->hw.target) {
>                 get_bp_info(bp->cpu, type)->cpu_pinned += weight;
> -               return;
> +               return 0;
>         }
>
>         /* Pinned counter task profiling */
> @@ -208,9 +220,9 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>                 toggle_bp_task_slot(bp, cpu, type, weight);
>
>         if (enable)
> -               list_add_tail(&bp->hw.bp_list, &bp_task_head);
> +               return rhltable_insert(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
>         else
> -               list_del(&bp->hw.bp_list);
> +               return rhltable_remove(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
>  }
>
>  __weak int arch_reserve_bp_slot(struct perf_event *bp)
> @@ -308,9 +320,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         if (ret)
>                 return ret;
>
> -       toggle_bp_slot(bp, true, type, weight);
> -
> -       return 0;
> +       return toggle_bp_slot(bp, true, type, weight);
>  }
>
>  int reserve_bp_slot(struct perf_event *bp)
> @@ -335,7 +345,7 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
>
>         type = find_slot_idx(bp_type);
>         weight = hw_breakpoint_weight(bp);
> -       toggle_bp_slot(bp, false, type, weight);
> +       WARN_ON(toggle_bp_slot(bp, false, type, weight));
>  }
>
>  void release_bp_slot(struct perf_event *bp)
> @@ -679,7 +689,7 @@ static struct pmu perf_breakpoint = {
>  int __init init_hw_breakpoint(void)
>  {
>         int cpu, err_cpu;
> -       int i;
> +       int i, ret;
>
>         for (i = 0; i < TYPE_MAX; i++)
>                 nr_slots[i] = hw_breakpoint_slots(i);
> @@ -690,18 +700,24 @@ int __init init_hw_breakpoint(void)
>
>                         info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
>                                                         GFP_KERNEL);
> -                       if (!info->tsk_pinned)
> -                               goto err_alloc;
> +                       if (!info->tsk_pinned) {
> +                               ret = -ENOMEM;
> +                               goto err;
> +                       }
>                 }
>         }
>
> +       ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
> +       if (ret)
> +               goto err;
> +
>         constraints_initialized = 1;
>
>         perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>
>         return register_die_notifier(&hw_breakpoint_exceptions_nb);
>
> - err_alloc:
> +err:
>         for_each_possible_cpu(err_cpu) {
>                 for (i = 0; i < TYPE_MAX; i++)
>                         kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> @@ -709,7 +725,5 @@ int __init init_hw_breakpoint(void)
>                         break;
>         }
>
> -       return -ENOMEM;
> +       return ret;
>  }
> -
> -
> --
> 2.36.1.255.ge46751e96f-goog
>
