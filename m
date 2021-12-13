Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB86C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Dec 2021 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbhLMQRU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhLMQRT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Dec 2021 11:17:19 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E89C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2021 08:17:19 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m12so2536333ild.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2021 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPM6FbxijuW1dfYjxg6dbH9bQm3NIxcRZrN/l42tCuQ=;
        b=ZEl1/ovprzGp/GYpdAAmLu+DWUyD7pS05OFjLKDA7RuLxn4AXG9i0PNZwE5aZkKNAB
         vCuHmSR0dlxNer4Om3YrecdvFioWvF/sHX+yJx/GmXUxv+tTA7xrvgXJYSFZvoqBuSRz
         fcJ3HgayoVGqLnGyhrcDLNpy5JLE1fYz0xS3FTxFD1VEKWzOzCZ1R2pF6qZxFiLnxiMT
         PD7FKPle1d4Z+0kx8hDAQxAKZnC+Y9RzHPSODeCmPcNqNSDd2fF6edmGUL28f6SrXgSD
         697LmZFwKtm4rbQ2GjaLWF+AZ2n7XwgQMD3MNv82jRNq/MK6Plq2mo8Ruqn3veCTDWoH
         1SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPM6FbxijuW1dfYjxg6dbH9bQm3NIxcRZrN/l42tCuQ=;
        b=Vyrd/yT+rMv+DiEaPfVrHxOIST5AQ8kpztFZTRsqDTDyEUIe9b6iej2+nUw1KFRPuR
         +mRgG1tw45WjQ0lbWOKsqF6dP8rl0JWUao7CZde4R9omZwsIR+j8/lLh6cjR9jmHZtM9
         Jdex2RB60Z6RMYr47H01ARFawK6rMYUn5SG5WE3gd0MaFaObJjmMJtw4md6XwPBsdRtg
         N4/uyPzzSa8BqrnNzAdZ1MnGFXtoHp9BuwDPxRDf+/TZMCW66ltUuAnad8Zg09JIFNmp
         TN3Trz4bTTV/bm6LkCZ9u1Q6kvwwMRFYdtmviN/OgodT0nrbroNqLBT+0hJNcAtfFkTo
         BhcQ==
X-Gm-Message-State: AOAM530fgfqDMCgWyD3zYvBa6GuaL9ZPdxpDtm6CGY5RAUmPDTI5Umru
        l5HfXGf9UBpScm6LdzRqUFczW53KcnKAz7VbEbCslA==
X-Google-Smtp-Source: ABdhPJyKsZDVqqIu1ZdJcA0ZUVjlcTaQL/Rz4Xw8Qf3rUVwazwtxJc/6cQaxlh9cs3Hpac7Wd/NJ0hMuHcmiQOlBqWw=
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr33731744ilk.89.1639412238938;
 Mon, 13 Dec 2021 08:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com> <20211208024607.1784932-4-irogers@google.com>
 <YbT7Bg3KA/re1HAF@krava>
In-Reply-To: <YbT7Bg3KA/re1HAF@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Dec 2021 08:17:07 -0800
Message-ID: <CAP-5=fVy6LysuDLWRNgWZocfAs=khzdK_aOG7HYVs2E_a4Bpzg@mail.gmail.com>
Subject: Re: [PATCH 03/22] perf stat: Switch aggregation to use for_each loop
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Dec 11, 2021 at 11:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Dec 07, 2021 at 06:45:48PM -0800, Ian Rogers wrote:
> > Tidy up the use of cpu and index to hopefully make the code less error
> > prone. Avoid unused warnings with (void) which will be removed in a
> > later patch.
> >
> > In aggr_update_shadow, the perf_cpu_map is switched from
> > the evlist to the counter's cpu map, so the index is appropriate. This
> > addresses a problem where uncore counts, with a cpumap like:
> > $ cat /sys/devices/uncore_imc_0/cpumask
> > 0,18
> > Don't aggregate counts in CPUs based on the index of those values in the
> > cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
> > metric calculations in per-socket mode for counters with without a full
> > cpumask.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 48 +++++++++++++++++++---------------
> >  1 file changed, 27 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 588601000f3f..efab39a759ff 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -330,8 +330,8 @@ static void print_metric_header(struct perf_stat_config *config,
> >  static int first_shadow_cpu(struct perf_stat_config *config,
> >                           struct evsel *evsel, struct aggr_cpu_id id)
> >  {
> > -     struct evlist *evlist = evsel->evlist;
> > -     int i;
> > +     struct perf_cpu_map *cpus;
> > +     int cpu, idx;
> >
> >       if (config->aggr_mode == AGGR_NONE)
> >               return id.core;
> > @@ -339,14 +339,11 @@ static int first_shadow_cpu(struct perf_stat_config *config,
> >       if (!config->aggr_get_id)
> >               return 0;
> >
> > -     for (i = 0; i < evsel__nr_cpus(evsel); i++) {
> > -             int cpu2 = evsel__cpus(evsel)->map[i];
> > -
> > -             if (cpu_map__compare_aggr_cpu_id(
> > -                                     config->aggr_get_id(config, evlist->core.cpus, cpu2),
> > -                                     id)) {
> > -                     return cpu2;
> > -             }
> > +     cpus = evsel__cpus(evsel);
> > +     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > +             if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
> > +                                              id))
> > +                     return cpu;
>
> so this looks strange, you pass idx instead of cpu2 to aggr_get_id,
> which takes idx as 3rd argument, so it looks like it was broken now,
> should this be a separate fix?

Yep, I tried to cover this in the commit message, but agree a separate
patch would be clearer. The aggregation is currently broken on
anything other than CPU 0 or when the CPU mask covers every CPU - the
case for something like topdown, hence this not being spotted.

> also the original code for some reason passed evlist->core.cpus
> to aggr_get_id, which might differ rom evsel's cpus

Part of the same fix.

> same for aggr_update_shadow change

In this case the cpu is really an index and so the change is just
renaming one to the other for the sake of clarity.

Thanks,
Ian

> jirka
>
