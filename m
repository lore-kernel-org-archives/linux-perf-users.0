Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C1ECAAD1
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiHaQmb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiHaQm2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 12:42:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49721A8CDC
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 09:42:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso6730251wmq.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HUySNpM501n2rAVfT9gK679GEN9kbv0JFpKhLOodA5E=;
        b=slztvvJrzcEMh2Z7W8O0Xgfu+78UNBd3djaADbUhs2W3F1fid919Kh/L0RyJDf6WzX
         Pi1bjfh4OShp1ENuEN14XhQGjPHXZFhIyYUL735quUEIYonUQSQdA9t8+ifD2AudXW2r
         27u6dGlYldDzxopywlDNtHswh2cKWoMX5Zyyd+D/8y4vmpHSFc9J5fgQ4Tk8BjkWvYs7
         7Un0sqjdh35IUIaGyjdn7+DhvPENp9F9HNXZaQXkbeymQerD7v+f2ZbqNSL6vzEV4FRT
         YICOeH9zw9GDs3LfbpmviJhDfZnywRScFNRNqq3OtFZurJY0FQp715XReaFl8feoz7I4
         8DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HUySNpM501n2rAVfT9gK679GEN9kbv0JFpKhLOodA5E=;
        b=1WNOudeyDIkTv0YiaL/AXMYewn8wbNHKR8FIvyA2PWNziAs5Eb/rbE9+vBkYIYyJm7
         76zw3ic5QxKgeDq1CkZcV3oFadRA8dFc8l82xUUeDVcsC6C8zH6u5RqR7M+6+BuLCy4B
         DjYfAFJc4qdBOlgobLR4sfI11bj4IXPYutWIAi26VGr7o+1dZWlZrBdr6GWiOmcjepsn
         GIk4oYn5elXffpHVaBxU0FN4PoFZ+4lcWGURPgoHNHVYaKZHNN+SpM8rJaftj97tkItz
         9nIS+3fZe2SwkUY1MHtzdW7SLO6n8ELktsQys3llUxU/bqouj5sZKpfvbr5zIeF7sdxw
         BnCw==
X-Gm-Message-State: ACgBeo1oPgE19UY+HzQwX9gGFqJTFFn91IL+Dn9rfYr/bgmabkBYNtHz
        vvVkdekwVSDcoa/TLy6bafMmfN2QJFWkb8Kqm44Xyw==
X-Google-Smtp-Source: AA6agR4vLdEka8VqwQGa6kOkl+fGQwhvYVXTV291ps+7eKFdnbleFak6QsunJ83o3D2MldUpD2EwVaZ/dW96fEG+D4M=
X-Received: by 2002:a1c:7c0d:0:b0:3a6:673a:395e with SMTP id
 x13-20020a1c7c0d000000b003a6673a395emr2534356wmc.67.1661964143689; Wed, 31
 Aug 2022 09:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com> <20220830164846.401143-6-irogers@google.com>
 <Yw9y1mEW7BhNvStT@kernel.org> <CAP-5=fUxRMSJUemUEcrDuRXpUFj3qNiRFQz1S7=cQrvmfyGYew@mail.gmail.com>
 <Yw+KSp4+DTGuAsh2@kernel.org>
In-Reply-To: <Yw+KSp4+DTGuAsh2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 Aug 2022 09:42:11 -0700
Message-ID: <CAP-5=fWhSFKU7qs1Aa09RxQiE1kvnZD4Dc3GHwmB6ooGs4tnNQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf topology: Add core_wide
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 31, 2022 at 9:20 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 31, 2022 at 08:58:49AM -0700, Ian Rogers escreveu:
> > On Wed, Aug 31, 2022 at 7:40 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Aug 30, 2022 at 09:48:43AM -0700, Ian Rogers escreveu:
> > > > It is possible to optimize metrics when all SMT threads (CPUs) on a
> > > > core are measuring events in system wide mode. For example, TMA
> > > > metrics defines CORE_CLKS for Sandybrdige as:
> > > >
> > > > if SMT is disabled:
> > > >   CPU_CLK_UNHALTED.THREAD
> > > > if SMT is enabled and recording on all SMT threads:
> > > >   CPU_CLK_UNHALTED.THREAD_ANY / 2
> > > > if SMT is enabled and not recording on all SMT threads:
> > > >   (CPU_CLK_UNHALTED.THREAD/2)*
> > > >   (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
> > > >
> > > > That is two more events are necessary when not gathering counts on all
> > > > SMT threads. To distinguish all SMT threads on a core vs system wide
> > > > (all CPUs) call the new property core wide.  Add a core wide test that
> > > > determines the property from user requested CPUs, the topology and
> > > > system wide. System wide is required as other processes running on a
> > > > SMT thread will change the counts.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/cputopo.c | 46 +++++++++++++++++++++++++++++++++++++++
> > > >  tools/perf/util/cputopo.h |  3 +++
> > > >  tools/perf/util/smt.c     | 14 ++++++++++++
> > > >  tools/perf/util/smt.h     |  7 ++++++
> > > >  4 files changed, 70 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > > > index 511002e52714..1a3ff6449158 100644
> > > > --- a/tools/perf/util/cputopo.c
> > > > +++ b/tools/perf/util/cputopo.c
> > > > @@ -172,6 +172,52 @@ bool cpu_topology__smt_on(const struct cpu_topology *topology)
> > > >       return false;
> > > >  }
> > > >
> > > > +bool cpu_topology__core_wide(const struct cpu_topology *topology,
> > > > +                          const char *user_requested_cpu_list)
> > > > +{
> > > > +     struct perf_cpu_map *user_requested_cpus;
> > > > +
> > > > +     /*
> > > > +      * If user_requested_cpu_list is empty then all CPUs are recorded and so
> > > > +      * core_wide is true.
> > > > +      */
> > > > +     if (!user_requested_cpu_list)
> > > > +             return true;
> > > > +
> > > > +     user_requested_cpus = perf_cpu_map__new(user_requested_cpu_list);
> > >
> > > Don't we need a NULL test here?
>
> > No, NULL is a valid perf_cpu_map, one with no values in it. For
> > example, see here:
>
> But in this specific case, if perf_cpu_map__new() returns NULL, its
> because it failed to parse user_requested_cpu_list, so checking against
> NULL is valid, no?

What about the empty string?

Thanks,
Ian

> - Arnaldo
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n266
> > So there's no way to tell an error (ENOMEM) from an empty map. My
> > suggestion is a rewrite of perf_cpu_map, I'd like to do this in a new
> > "libperf2" which has a more permissive than GPL license like libbpf.
> > That is out-of-scope here.
>
> > Thanks,
> > Ian
> >
> > > > +     /* Check that every user requested CPU is the complete set of SMT threads on a core. */
> > > > +     for (u32 i = 0; i < topology->core_cpus_lists; i++) {
> > > > +             const char *core_cpu_list = topology->core_cpus_list[i];
> > > > +             struct perf_cpu_map *core_cpus = perf_cpu_map__new(core_cpu_list);
> > >
> > > Here too, no?
> > >
> > > > +             struct perf_cpu cpu;
> > > > +             int idx;
> > > > +             bool has_first, first = true;
> > > > +
> > > > +             perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
> > > > +                     if (first) {
> > > > +                             has_first = perf_cpu_map__has(user_requested_cpus, cpu);
> > > > +                             first = false;
> > > > +                     } else {
> > > > +                             /*
> > > > +                              * If the first core CPU is user requested then
> > > > +                              * all subsequent CPUs in the core must be user
> > > > +                              * requested too. If the first CPU isn't user
> > > > +                              * requested then none of the others must be
> > > > +                              * too.
> > > > +                              */
> > > > +                             if (perf_cpu_map__has(user_requested_cpus, cpu) != has_first) {
> > > > +                                     perf_cpu_map__put(core_cpus);
> > > > +                                     perf_cpu_map__put(user_requested_cpus);
> > > > +                                     return false;
> > > > +                             }
> > > > +                     }
> > > > +             }
> > > > +             perf_cpu_map__put(core_cpus);
> > > > +     }
> > > > +     perf_cpu_map__put(user_requested_cpus);
> > > > +     return true;
> > > > +}
> > > > +
> > > >  static bool has_die_topology(void)
> > > >  {
> > > >       char filename[MAXPATHLEN];
> > > > diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
> > > > index 469db775a13c..969e5920a00e 100644
> > > > --- a/tools/perf/util/cputopo.h
> > > > +++ b/tools/perf/util/cputopo.h
> > > > @@ -60,6 +60,9 @@ struct cpu_topology *cpu_topology__new(void);
> > > >  void cpu_topology__delete(struct cpu_topology *tp);
> > > >  /* Determine from the core list whether SMT was enabled. */
> > > >  bool cpu_topology__smt_on(const struct cpu_topology *topology);
> > > > +/* Are the sets of SMT siblings all enabled or all disabled in user_requested_cpus. */
> > > > +bool cpu_topology__core_wide(const struct cpu_topology *topology,
> > > > +                          const char *user_requested_cpu_list);
> > > >
> > > >  struct numa_topology *numa_topology__new(void);
> > > >  void numa_topology__delete(struct numa_topology *tp);
> > > > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > > > index ce90c4ee4138..994e9e418227 100644
> > > > --- a/tools/perf/util/smt.c
> > > > +++ b/tools/perf/util/smt.c
> > > > @@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
> > > >       cached = true;
> > > >       return cached_result;
> > > >  }
> > > > +
> > > > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > > > +            const struct cpu_topology *topology)
> > > > +{
> > > > +     /* If not everything running on a core is being recorded then we can't use core_wide. */
> > > > +     if (!system_wide)
> > > > +             return false;
> > > > +
> > > > +     /* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
> > > > +     if (!smt_on(topology))
> > > > +             return true;
> > > > +
> > > > +     return cpu_topology__core_wide(topology, user_requested_cpu_list);
> > > > +}
> > > > diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
> > > > index e26999c6b8d4..ae9095f2c38c 100644
> > > > --- a/tools/perf/util/smt.h
> > > > +++ b/tools/perf/util/smt.h
> > > > @@ -7,4 +7,11 @@ struct cpu_topology;
> > > >  /* Returns true if SMT (aka hyperthreading) is enabled. */
> > > >  bool smt_on(const struct cpu_topology *topology);
> > > >
> > > > +/*
> > > > + * Returns true when system wide and all SMT threads for a core are in the
> > > > + * user_requested_cpus map.
> > > > + */
> > > > +bool core_wide(bool system_wide, const char *user_requested_cpu_list,
> > > > +            const struct cpu_topology *topology);
> > > > +
> > > >  #endif /* __SMT_H */
> > > > --
> > > > 2.37.2.672.g94769d06f0-goog
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
