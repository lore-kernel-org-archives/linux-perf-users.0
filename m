Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A18FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 06:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhL3GXI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 01:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhL3GXI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 01:23:08 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5BC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 22:23:08 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 9so1421734ill.9
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 22:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2TxMwsHZNPtq/d/P+qfXrYHTkaKdkXbSSb+eiNHpsM=;
        b=ry98a5PuCeXkwPEcdP1EW5U4BjNw1eOrXJfkkFHa0FNjJrHq+bughRPjlOt5IO2r6h
         Fb3FPAmq7HZtl+CUM+XVVRY2yiDChcB/LfrCTElnfAYDCHNjDo03dz8TxM5QojpaPpzv
         3FDdGbPEBJKpKpST1obTmTySzZXIZZOYQQeBvRqIMFjKqRxaFR2AO0AoVaRtoQlWOrDH
         PQZ8YXomA38K4LUIFMOKQuSCyBCSJUM584NQzvgtcwOVykTIPofo9Jgsyb8/TyMjZuhR
         9Ane+Ll+sJmomoTPPhthbAz5atfcMoJxlViDfD7ONRNyxrzwe1W0VTj+OoxuKP+9tDJJ
         Kspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2TxMwsHZNPtq/d/P+qfXrYHTkaKdkXbSSb+eiNHpsM=;
        b=Zi0aY3HP8Ad1bx8IhYVOnjOY8pWyCguDYJB+R5XgZs/WwL81z1YxqnQqtRn/pLSkve
         Tsrvgd6hGNn2lYAjxn2hbH442zl/47woJuYRMPcW144IkJRggEJf5zDhlqMp5kGxYQz5
         ZZbH4eLgYzVVAKS6KUuOqju1NlKcFa2H/DxtrWrK078uKi03NEVn547oVyIRtjnNeQEJ
         fVXSpnu45Gjh7LHyxfdfvL7EaT8IWMvzAV4ZPkLAObvZbyrqIVQtVGFtmMNI1Zw/NSag
         bPhF2BKBZXI0BVFaKxRXBthVz4e0NabdDik2Y49cy0Zws2kB/KACiVudDg6onSkJvfPG
         v90Q==
X-Gm-Message-State: AOAM5300J1XeUU9Y/pnpse6rzsqgxQ89OaIG6YVrqPwYrQfEuJfY8E3E
        JAzbhrKIy4C1YjZs29NMwRHUUq8K9id584LU/e7mSCV/5j1Yeg==
X-Google-Smtp-Source: ABdhPJxURa09a84uJiPmJqds9H+BFMta07IDQnqz2FabsRk3bbIShLmckiC0LD193mlmpZ9pnoKSURuy9u4EHuUBVNI=
X-Received: by 2002:a92:d8d0:: with SMTP id l16mr13238900ilo.174.1640845387187;
 Wed, 29 Dec 2021 22:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-26-irogers@google.com>
 <CAM9d7cgCoEc5UXCWm9Cstt0_QMNu4jMK1WH3WEjSBxvCnESfYg@mail.gmail.com>
In-Reply-To: <CAM9d7cgCoEc5UXCWm9Cstt0_QMNu4jMK1WH3WEjSBxvCnESfYg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Dec 2021 22:22:54 -0800
Message-ID: <CAP-5=fWu+H-n57E52JgoEnAdGoJXs_P69-URum4UATx8bfrEOw@mail.gmail.com>
Subject: Re: [PATCH v2 25/48] perf stat-display: Avoid use of core for CPU.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 28, 2021 at 4:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Dec 22, 2021 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Correct use of cpumap index in print_no_aggr_metric.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > @@ -924,29 +921,32 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
> >                                  struct evlist *evlist,
> >                                  char *prefix)
> >  {
> > -       int cpu;
> > -       int nrcpus = 0;
> > -       struct evsel *counter;
> > -       u64 ena, run, val;
> > -       double uval;
> > -       struct aggr_cpu_id id;
> > +       int cpu, nrcpus;
> >
> >         nrcpus = evlist->core.cpus->nr;
> >         for (cpu = 0; cpu < nrcpus; cpu++) {
> > +               struct evsel *counter;
> >                 bool first = true;
> >
> >                 if (prefix)
> >                         fputs(prefix, config->output);
> >                 evlist__for_each_entry(evlist, counter) {
> > -                       id = aggr_cpu_id__empty();
> > -                       id.core = cpu;
> > +                       u64 ena, run, val;
> > +                       double uval;
> > +                       struct aggr_cpu_id id;
> > +                       int idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
>
> Not sure about this.  Here the 'cpu' is an index for the
> evlist->core.cpus, not a CPU number.  But the
> perf_cpu_map__idx() requires a CPU number, right?

Thanks for the reviews! You are right, I think it makes sense two have
two indices here, evlist and counter. I will change the outer loop to
use perf_cpu_map__for_each_cpu. v3 will have the other fixes you've
pointed out too.

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> > +
> > +                       if (idx < 0)
> > +                               continue;
> > +
> > +                       id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> >                         if (first) {
> >                                 aggr_printout(config, counter, id, 0);
> >                                 first = false;
> >                         }
> > -                       val = perf_counts(counter->counts, cpu, 0)->val;
> > -                       ena = perf_counts(counter->counts, cpu, 0)->ena;
> > -                       run = perf_counts(counter->counts, cpu, 0)->run;
> > +                       val = perf_counts(counter->counts, idx, 0)->val;
> > +                       ena = perf_counts(counter->counts, idx, 0)->ena;
> > +                       run = perf_counts(counter->counts, idx, 0)->run;
> >
> >                         uval = val * counter->scale;
> >                         printout(config, id, 0, counter, uval, prefix,
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
