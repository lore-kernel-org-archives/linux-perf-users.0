Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C348C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Apr 2022 21:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiDEVaL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573096AbiDER6q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 13:58:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D877CE7F45
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Apr 2022 10:56:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j12so12924945wrb.5
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Apr 2022 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XSThWl+PZUFMqLNS/uIAi3vardfLBgaW6ejdi55O/w=;
        b=cUte+H4u04BPbzs34V5G9+eJ8SNIxiDkuEWGf9is+YEzzGQ1EQLCqjro2iuE13EjWj
         gb3LzQki1bDzDpCyY2ius2D4+lnxAiWW0sYAG/aWFuf7fiKPERTTBngWGzHURX2T+Vbs
         LDz6QTd04M8Pdo55/3O20fxWoUryj88TNBgE2RotkPuEP4q4mXu+WFb58s/tSt60V8hQ
         O8aau9ebEUA0DSzTsDbDOs61Jts3776a+roSFGgfgfKKzIzgZBOb8JhvPWYaw/hvkwFM
         n5Dd29H6nUhwPcIRceG5Qw6YgcZ/yJ9Q9a/n81R1KbqtUhR6cdZ6KVIXLgehN2oWrLKj
         xPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XSThWl+PZUFMqLNS/uIAi3vardfLBgaW6ejdi55O/w=;
        b=Mrhk08CLGD/EraGWRa/oRCkm7VsH2yqzOOa0nGBg7p9yyaeb6W9vDtqD+GZieJ4gVA
         AIV9bSG/njd+LbQz2zNBki2HTus0g9znfe1LXe7G7AY2EXunDawSlY7FYmmU2hztzqNP
         rfGPxl0T7IDfaTqC46wPNq8ymjYThHbf4mFIaG4HiMny1dp1iOQq6en3BpuCA3FLwlT2
         dNz5DlB5EUGK0OgZpQTgavLC6vi1vmjBZzNiZEcQs7kcrBWJw0V4NFPsXxHue1BzIRSR
         ryYLQiDRHJbDWd5YvBVktBsrj96O/qYK+6g5TPLNFSeyMbDcIDsYsEXXZqzhFlM4qcQE
         S5BA==
X-Gm-Message-State: AOAM533ghzaboWdyPb/eXMTHgXt0mNS8m+7N37xGftTjhLRbUdI3O8R+
        MZ0Pcg2BBA5UAIpv1/B4HwluqiSUFQelMQorr3maWA==
X-Google-Smtp-Source: ABdhPJzgP8n462gwm0RE72/GPAAxZDwFiRP42trNQDTRiMZwhcAjJ/cAqmlG07N1+jK4G+ZtJKxhfg6D6nQqdMWrGK0=
X-Received: by 2002:a5d:50c3:0:b0:206:179f:1143 with SMTP id
 f3-20020a5d50c3000000b00206179f1143mr3674128wrt.343.1649181406206; Tue, 05
 Apr 2022 10:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220401185853.23912-1-atrajeev@linux.vnet.ibm.com> <20220401185853.23912-3-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220401185853.23912-3-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Apr 2022 10:56:34 -0700
Message-ID: <CAP-5=fUi9f5V+kEgNJQyHDVxivxz-kEXY3-pdaLwf6wJhqyO5Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] tools/perf: Fix perf bench epoll to correct usage of
 affinity for machines with #CPUs > 1K
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 1, 2022 at 12:00 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> perf bench epoll testcase fails on systems with CPU's
> more than 1K.
>
> Testcase: perf bench epoll all
> Result snippet:
> <<>>
> Run summary [PID 106497]: 1399 threads monitoring on 64 file-descriptors for 8 secs.
>
> perf: pthread_create: No such file or directory
> <<>>
>
> In epoll benchmarks (ctl, wait) pthread_create is invoked in do_threads
> from respective bench_epoll_*  function. Though the logs shows direct
> failure from pthread_create, the actual failure is from  "sched_setaffinity"
> returning EINVAL (invalid argument). This happens because the default
> mask size in glibc is 1024. To overcome this 1024 CPUs mask size
> limitation of cpu_set_t, change the mask size using the CPU_*_S macros.
>
> Patch addresses this by fixing all the epoll benchmarks to use
> CPU_ALLOC to allocate cpumask, CPU_ALLOC_SIZE for size, and
> CPU_SET_S to set the mask.
>
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/bench/epoll-ctl.c  | 25 +++++++++++++++++++------
>  tools/perf/bench/epoll-wait.c | 25 +++++++++++++++++++------
>  2 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index 1a17ec83d3c4..91c53f6c6d87 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -222,13 +222,20 @@ static void init_fdmaps(struct worker *w, int pct)
>  static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
>  {
>         pthread_attr_t thread_attr, *attrp = NULL;
> -       cpu_set_t cpuset;
> +       cpu_set_t *cpuset;
>         unsigned int i, j;
>         int ret = 0;
> +       int nrcpus;
> +       size_t size;
>
>         if (!noaffinity)
>                 pthread_attr_init(&thread_attr);
>
> +       nrcpus = perf_cpu_map__nr(cpu);
> +       cpuset = CPU_ALLOC(nrcpus);
> +       BUG_ON(!cpuset);
> +       size = CPU_ALLOC_SIZE(nrcpus);
> +
>         for (i = 0; i < nthreads; i++) {
>                 struct worker *w = &worker[i];
>
> @@ -252,22 +259,28 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
>                         init_fdmaps(w, 50);
>
>                 if (!noaffinity) {
> -                       CPU_ZERO(&cpuset);
> -                       CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
> +                       CPU_ZERO_S(size, cpuset);
> +                       CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu,
> +                                       size, cpuset);
>
> -                       ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
> -                       if (ret)
> +                       ret = pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
> +                       if (ret) {
> +                               CPU_FREE(cpuset);
>                                 err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
> +                       }
>
>                         attrp = &thread_attr;
>                 }
>
>                 ret = pthread_create(&w->thread, attrp, workerfn,
>                                      (void *)(struct worker *) w);
> -               if (ret)
> +               if (ret) {
> +                       CPU_FREE(cpuset);
>                         err(EXIT_FAILURE, "pthread_create");
> +               }
>         }
>
> +       CPU_FREE(cpuset);

A nit here you could CPU_FREE right after the ret = pthread_create...
to make it a bit shorter.

Thanks,
Ian

>         if (!noaffinity)
>                 pthread_attr_destroy(&thread_attr);
>
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 0d1dd8879197..9469a53ffab9 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -291,9 +291,11 @@ static void print_summary(void)
>  static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
>  {
>         pthread_attr_t thread_attr, *attrp = NULL;
> -       cpu_set_t cpuset;
> +       cpu_set_t *cpuset;
>         unsigned int i, j;
>         int ret = 0, events = EPOLLIN;
> +       int nrcpus;
> +       size_t size;
>
>         if (oneshot)
>                 events |= EPOLLONESHOT;
> @@ -306,6 +308,11 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
>         if (!noaffinity)
>                 pthread_attr_init(&thread_attr);
>
> +       nrcpus = perf_cpu_map__nr(cpu);
> +       cpuset = CPU_ALLOC(nrcpus);
> +       BUG_ON(!cpuset);
> +       size = CPU_ALLOC_SIZE(nrcpus);
> +
>         for (i = 0; i < nthreads; i++) {
>                 struct worker *w = &worker[i];
>
> @@ -341,22 +348,28 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
>                 }
>
>                 if (!noaffinity) {
> -                       CPU_ZERO(&cpuset);
> -                       CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
> +                       CPU_ZERO_S(size, cpuset);
> +                       CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu,
> +                                       size, cpuset);
>
> -                       ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
> -                       if (ret)
> +                       ret = pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
> +                       if (ret) {
> +                               CPU_FREE(cpuset);
>                                 err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
> +                       }
>
>                         attrp = &thread_attr;
>                 }
>
>                 ret = pthread_create(&w->thread, attrp, workerfn,
>                                      (void *)(struct worker *) w);
> -               if (ret)
> +               if (ret) {
> +                       CPU_FREE(cpuset);
>                         err(EXIT_FAILURE, "pthread_create");
> +               }
>         }
>
> +       CPU_FREE(cpuset);
>         if (!noaffinity)
>                 pthread_attr_destroy(&thread_attr);
>
> --
> 2.35.1
>
