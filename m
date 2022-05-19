Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D720C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 04:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiESEEm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 00:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiESEEl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 00:04:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AF9A98A
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:04:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u30so6939034lfm.9
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0WqSjbtSNE0NhAHgkhktuyznGvAC8Z94X7uXLT1JRM=;
        b=R65X9/wZQ3VbcRybUFv5mw1ZkIK7CbmY/GaBWVAGu+8mz27BQjtGFIrK2bX304qQZ5
         ZzM7S0FnLJwJjxb274CqqQnWT8IqHvg4ODdbU5+J9BRLxyqwtpLvf3mmWSH3ahNdA+lU
         c8Efs+pWoo5h5RKep40f2yXNenX29elRD6qaHkDvcyfgx+XTwf8z/lGiwy77I3qJ8iO5
         Msyv3mSYSCeTng1tDcR7HpxuQ8FE80dO+/pMZwWNWKIv0u0AHR0sUlNTJZCFfQlgalUw
         I/r05dcAjKfvsyEGSCIo3Ai4sIK0Fr2P+GB5lOX99pziuTLNnr/4EmiI26FETKi49NbO
         ZRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0WqSjbtSNE0NhAHgkhktuyznGvAC8Z94X7uXLT1JRM=;
        b=AZeGVAz860u/yNd80aVOV0M/XnO9vp1yFFRmBxYNthXLSIfAz6UI6oZX1u0E/RG7cH
         t9HxbRuT9FjxmiBigvPPFOmauocpEbXn4K6gtJd6gOnTBxf5nPQGhH9kBmvTl/gwWEN7
         QP2n3bPDht9jBPjTMaVPquW6hKRiJty9nAV2VN0DmeXRvFA3pneGzr3b8iATqRZWL4m+
         gSBtZUeJrv9Q+UJV+mIHEwfR9ga7z21iLjfnmR7c0qAf70mi87aEF7qyhm9F2c6Qe8LU
         LfrhCCdhtuOUlIRHuiUPz9F04DztLfjzx70J5PFQ0j3RujGo+SY5BP2BxAaVuAPtGf8j
         yFJg==
X-Gm-Message-State: AOAM5304sQ/R9V55tPEDeM59e5gZrKE/i4gJr1KbKn95LSTSNNP3qwvw
        3JGyuKAmAet+/33Vnm7VaTqlVQv6fz/d8tRRVVdhxSNcGJn09Q==
X-Google-Smtp-Source: ABdhPJz5zh4yFjz2+uzcc9OKuxkhf+RSeDOAf14JMNpky3U/o33GKfx9oY9pcnkFZLayOWUyFgtRpijetQErtJJ0LLc=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr2110281wrb.300.1652933067274; Wed, 18
 May 2022 21:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220518224725.742882-1-namhyung@kernel.org> <20220518224725.742882-5-namhyung@kernel.org>
In-Reply-To: <20220518224725.742882-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:04:15 -0700
Message-ID: <CAP-5=fVUxdKY5Uvi8k=_1kJ8_Qw_PuGbfTY5EbF4j35DxSDFFA@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf record: Handle argument change in sched_switch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Recently sched_switch tracepoint added a new argument for prev_state,
> but it's hard to handle the change in a BPF program.  Instead, we can
> check the function prototype in BTF before loading the program.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_off_cpu.c          | 28 +++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 35 ++++++++++++++++++--------
>  2 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index b5e2d038da50..874856c55101 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -89,6 +89,33 @@ static void off_cpu_finish(void *arg __maybe_unused)
>         off_cpu_bpf__destroy(skel);
>  }
>
> +/* v5.18 kernel added prev_state arg, so it needs to check the signature */
> +static void check_sched_switch_args(void)
> +{
> +       const struct btf *btf = bpf_object__btf(skel->obj);
> +       const struct btf_type *t1, *t2, *t3;
> +       u32 type_id;
> +
> +       type_id = btf__find_by_name_kind(btf, "bpf_trace_sched_switch",
> +                                        BTF_KIND_TYPEDEF);
> +       if ((s32)type_id < 0)
> +               return;
> +
> +       t1 = btf__type_by_id(btf, type_id);
> +       if (t1 == NULL)
> +               return;
> +
> +       t2 = btf__type_by_id(btf, t1->type);
> +       if (t2 == NULL || !btf_is_ptr(t2))
> +               return;
> +
> +       t3 = btf__type_by_id(btf, t2->type);
> +       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
> +               /* new format: pass prev_state as 4th arg */
> +               skel->rodata->has_prev_state = true;
> +       }
> +}
> +
>  int off_cpu_prepare(struct evlist *evlist, struct target *target)
>  {
>         int err, fd, i;
> @@ -117,6 +144,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
>         }
>
>         set_max_rlimit();
> +       check_sched_switch_args();
>
>         err = off_cpu_bpf__load(skel);
>         if (err) {
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 78cdcc8ff863..986d7db6e75d 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -72,6 +72,8 @@ int enabled = 0;
>  int has_cpu = 0;
>  int has_task = 0;
>
> +const volatile bool has_prev_state = false;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> @@ -121,22 +123,13 @@ static inline int can_record(struct task_struct *t, int state)
>         return 1;
>  }
>
> -SEC("tp_btf/sched_switch")
> -int on_switch(u64 *ctx)
> +static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> +                       struct task_struct *next, int state)
>  {
>         __u64 ts;
> -       int state;
>         __u32 stack_id;
> -       struct task_struct *prev, *next;
>         struct tstamp_data *pelem;
>
> -       if (!enabled)
> -               return 0;
> -
> -       prev = (struct task_struct *)ctx[1];
> -       next = (struct task_struct *)ctx[2];
> -       state = get_task_state(prev);
> -
>         ts = bpf_ktime_get_ns();
>
>         if (!can_record(prev, state))
> @@ -180,4 +173,24 @@ int on_switch(u64 *ctx)
>         return 0;
>  }
>
> +SEC("tp_btf/sched_switch")
> +int on_switch(u64 *ctx)
> +{
> +       struct task_struct *prev, *next;
> +       int prev_state;
> +
> +       if (!enabled)
> +               return 0;
> +
> +       prev = (struct task_struct *)ctx[1];
> +       next = (struct task_struct *)ctx[2];
> +
> +       if (has_prev_state)
> +               prev_state = (int)ctx[3];
> +       else
> +               prev_state = get_task_state(prev);
> +
> +       return off_cpu_stat(ctx, prev, next, prev_state);
> +}
> +
>  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> --
> 2.36.1.124.g0e6072fb45-goog
>
