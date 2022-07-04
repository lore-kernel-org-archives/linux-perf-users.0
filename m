Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD69C43334
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiGDPKu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGDPKf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 11:10:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE68101CC
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 08:09:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a13so16247152lfr.10
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hCwDytAsB4d/o82PG/imXl6AB+798LjkY2ZfHNBYrI=;
        b=ThmQg/xxfdOOytGKZPYXFkjrB6rORV49rmwVnEzozNItIQovlnXYg1BPeS4b9eBnKn
         OuIGQ0fZkghqru/RvIC0zLh3jCDnd08wqc/mCaDkmdf8cUGR4xBtqHjEWYhfIVg06f7z
         T98O4cYhVvnA9/OHLuKcU2y2BnQrmbMlZ7TUsHxjTY+H4r2Hhzrl80a4N4BX4jnp6LNU
         3rIzy4JWOXJ+YyA3DzaNFrxJVuxyM5a/VyWFQqRuRUhXvCg5BUJx+8FUIBki6xNxiOtN
         h/YMHmeXX5Nuz5rb+LXzAFWQwWU+I/zDKBYeTdJXvOA+gdWh5NJh6H3G2G2HUZvP7YfM
         rjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hCwDytAsB4d/o82PG/imXl6AB+798LjkY2ZfHNBYrI=;
        b=FKg+J04t9QKufSnrxvFKjmfOWVUd202ilJvm3zm8GyAlhomAUBuvD3/uq3lA8k5Cei
         5+a1OeFHzWI/E/aAnvH2qjsmMQWCsjIIvGLXjs/8zGM2PggV7lEtkKFKM96BjQyqmf2h
         5dVXS4lKQcCT3GO2W12UeqwtFLIcKUi8/P/znqd+fOe7vQyvTIKC9DJb2X52Y58jjz3K
         mAcxkh+hRft/LG5hmGJBcrJv18KUaSNHr3p9eDOaCXr3p4QMsvlUZ/+HWBj/Trj1yFtc
         f7gDJMPPrnC2eJSVgmyQX2VPjs6MrU/58KAZF5EKd+HvySZelMQT5iGQjfj5NQbZf+bV
         hn/w==
X-Gm-Message-State: AJIora/OR71d0a6t6Qgw/SiiWvvTKdnB94d7+vLEyWIq6gzPqlLtw8K4
        XCoJcQi0/SFgA239G2YG4USwD4HUpiSfFCOGRrADzA==
X-Google-Smtp-Source: AGRyM1vvveNlQAUCPmccpFZXd+iaYP+qw1ex9ZueZxdiA7XY/8IwWOFpzTbiGpETzSOHGeXOl0IWYwrQOMgSTw5OWLQ=
X-Received: by 2002:a05:6512:1056:b0:47f:6f00:66c2 with SMTP id
 c22-20020a056512105600b0047f6f0066c2mr18349441lfb.410.1656947393715; Mon, 04
 Jul 2022 08:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-3-elver@google.com>
In-Reply-To: <20220704150514.48816-3-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Jul 2022 17:09:42 +0200
Message-ID: <CACT4Y+aYCkTWu+vBdX2d5GNB9z8oZ+8=a330sK9s18FS8t+6=Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] perf/hw_breakpoint: Provide hw_breakpoint_is_used()
 and use in test
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

On Mon, 4 Jul 2022 at 17:06, Marco Elver <elver@google.com> wrote:
>
> Provide hw_breakpoint_is_used() to check if breakpoints are in use on
> the system.
>
> Use it in the KUnit test to verify the global state before and after a
> test case.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v3:
> * New patch.
> ---
>  include/linux/hw_breakpoint.h      |  3 +++
>  kernel/events/hw_breakpoint.c      | 29 +++++++++++++++++++++++++++++
>  kernel/events/hw_breakpoint_test.c | 12 +++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index 78dd7035d1e5..a3fb846705eb 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -74,6 +74,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
>  extern int register_perf_hw_breakpoint(struct perf_event *bp);
>  extern void unregister_hw_breakpoint(struct perf_event *bp);
>  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> +extern bool hw_breakpoint_is_used(void);
>
>  extern int dbg_reserve_bp_slot(struct perf_event *bp);
>  extern int dbg_release_bp_slot(struct perf_event *bp);
> @@ -121,6 +122,8 @@ register_perf_hw_breakpoint(struct perf_event *bp)  { return -ENOSYS; }
>  static inline void unregister_hw_breakpoint(struct perf_event *bp)     { }
>  static inline void
>  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)        { }
> +static inline bool hw_breakpoint_is_used(void)         { return false; }
> +
>  static inline int
>  reserve_bp_slot(struct perf_event *bp)                 {return -ENOSYS; }
>  static inline void release_bp_slot(struct perf_event *bp)              { }
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index f32320ac02fd..fd5cd1f9e7fc 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -604,6 +604,35 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
>  }
>  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
>
> +/**
> + * hw_breakpoint_is_used - check if breakpoints are currently used
> + *
> + * Returns: true if breakpoints are used, false otherwise.
> + */
> +bool hw_breakpoint_is_used(void)
> +{
> +       int cpu;
> +
> +       if (!constraints_initialized)
> +               return false;
> +
> +       for_each_possible_cpu(cpu) {
> +               for (int type = 0; type < TYPE_MAX; ++type) {
> +                       struct bp_cpuinfo *info = get_bp_info(cpu, type);
> +
> +                       if (info->cpu_pinned)
> +                               return true;
> +
> +                       for (int slot = 0; slot < nr_slots[type]; ++slot) {
> +                               if (info->tsk_pinned[slot])
> +                                       return true;
> +                       }
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static struct notifier_block hw_breakpoint_exceptions_nb = {
>         .notifier_call = hw_breakpoint_exceptions_notify,
>         /* we need to be notified first */
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> index 433c5c45e2a5..5ced822df788 100644
> --- a/kernel/events/hw_breakpoint_test.c
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -294,7 +294,14 @@ static struct kunit_case hw_breakpoint_test_cases[] = {
>  static int test_init(struct kunit *test)
>  {
>         /* Most test cases want 2 distinct CPUs. */
> -       return num_online_cpus() < 2 ? -EINVAL : 0;
> +       if (num_online_cpus() < 2)
> +               return -EINVAL;
> +
> +       /* Want the system to not use breakpoints elsewhere. */
> +       if (hw_breakpoint_is_used())
> +               return -EBUSY;
> +
> +       return 0;
>  }
>
>  static void test_exit(struct kunit *test)
> @@ -308,6 +315,9 @@ static void test_exit(struct kunit *test)
>                 kthread_stop(__other_task);
>                 __other_task = NULL;
>         }
> +
> +       /* Verify that internal state agrees that no breakpoints are in use. */
> +       KUNIT_EXPECT_FALSE(test, hw_breakpoint_is_used());
>  }
>
>  static struct kunit_suite hw_breakpoint_test_suite = {
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
