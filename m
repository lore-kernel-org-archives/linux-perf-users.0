Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC88AC47095
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 06:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBBC610A2
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 06:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhFIGSp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:18:45 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52893 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhFIGSp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 02:18:45 -0400
Received: by mail-wm1-f48.google.com with SMTP id f17so3257614wmf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jun 2021 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TUXdESrfWsLAB7ujMtiaWOI2wfBx49V15E9i1S/Dz4=;
        b=Box34dRXLbv4PwyoR/kYUCsIQsPyADF7ThRntyYkuOlB/4vg0VOlFp1bhTa/GFU/QX
         GmflTLqJDPbaEpoK7COWWuQaXadBmffOUud31umyLrC/6KNCdXw2B97d6gmCT3VG4PMf
         WOnSmLDGYTwBgX9mH4GM4DlXqck2lQeqpdybR+CKHNuUDdGEZD7009zD0wm8+u68AS3f
         21XtzESOb4M/Xcn/AfQzAq1x6NZaYzydbtgmUsh7b3B9Ibtz1LGPk3wWnFo8sMQqia72
         9SHw0wSf1jcI12jUHIIY8ucWKmT5rlzkGAgYmNTKJ65/EY0BZctQcb/+ua8kl/SkVszX
         I5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TUXdESrfWsLAB7ujMtiaWOI2wfBx49V15E9i1S/Dz4=;
        b=dobow3/DjaJgNbY2OOnERgR7PZwQJRnq/fHdXFl/eaEK7ge/7UGFpvBOwdjV4V/JyF
         5YF9BjysJ1ejWGY+Mk1uxN9c5MGqcw0BW67kMqbVt8SarCyCOrivd6Yo5gjEoyY7VxHF
         Gw+vmfHdALtgYc7Q0vCGKMPYoXDrDaM8it7bKTZJ9uz+/nUkvKSr6tAmumo5MSWUSvdQ
         csq9Iqw3Q3En/PExngbetlOqe56u1Uqb/kdQRjEs+fjpAG799ZaoHfrzBjDl/YCVrqGF
         TxW+y0FXOZsuG9RtEMlYP0K7QXjifFfZW7C/JMICotNFj3LYtZY0kdz4qXxswMty+tcP
         5b9w==
X-Gm-Message-State: AOAM532K7YHInSY0GWagFL250AfpYN3t+BrSiFAWwlYUZkPjIiGyK8dR
        TevKs//CM+u7gKQR3BqjjYsMdC0+aL0DMoCvYmNBvAm8SouW3yZbaVIRV5f95FCLyudF7iTSigo
        AadAAqWJtGhK4AlCF6plxVuwLXy+fA4O88/4g
X-Google-Smtp-Source: ABdhPJzHu53sGzAywCiiReHaa7F7vmfkhLb+t3Zc+RonSZw5/gfmIIKP4SIyqob+6seSN3KBc1OwxSsl0UHk4ynY4OE=
X-Received: by 2002:a1c:2015:: with SMTP id g21mr7984981wmg.87.1623219350466;
 Tue, 08 Jun 2021 23:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <ac8b10b5-820a-9542-51ab-3fcc51cb91ef@huawei.com>
In-Reply-To: <ac8b10b5-820a-9542-51ab-3fcc51cb91ef@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Jun 2021 23:15:38 -0700
Message-ID: <CAP-5=fVERioMuK=JgKr1QWXKvU0Y31efQjxh7hX32ifL9V+_EA@mail.gmail.com>
Subject: Re: perf tool: Issues with metricgroups
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 7, 2021 at 10:21 AM John Garry <john.garry@huawei.com> wrote:
>
> Hi guys,
>
> I am finding a couple of issues in metricgroup support. Firstly I have
> found a segfault (which I caused with my "fix" in commit 9c880c24cb0d),
> and a fix for that is at the bottom.
>
> Another issue is that the ordering of the metrics we supply for stat
> command causes an issue.
>
> On my broadwell, this works ok:
>
> sudo  ./perf stat -vv -M backend_bound,retiring sleep 1
> Using CPUID GenuineIntel-6-3D-4
> metric expr 1 - ( (idq_uops_not_delivered.core / (4 * cycles)) + ((
> uops_issued.any - uops_retired.retire_slots + 4 *
> int_misc.recovery_cycles ) / (4 * cycles)) + (uops_retired.retire_slots
> / (4 * cycles)) ) for Backend_Bound
> found event uops_issued.any
> found event cycles
> found event idq_uops_not_delivered.core
> found event int_misc.recovery_cycles
> found event uops_retired.retire_slots
> metric expr uops_retired.retire_slots / (4 * cycles) for Retiring
> found event cycles
> found event uops_retired.retire_slots
> adding
> {uops_issued.any,cycles,idq_uops_not_delivered.core,int_misc.recovery_cycles,uops_retired.retire_slots}:W,{cycles,uops_retired.retire_slots}:W
> uops_issued.any -> cpu/umask=0x1,(null)=0x1e8483,event=0xe/
> idq_uops_not_delivered.core -> cpu/umask=0x1,(null)=0x1e8483,event=0x9c/
> int_misc.recovery_cycles ->
> cpu/umask=0x3,(null)=0x1e8483,cmask=0x1,event=0xd/
> uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
> uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
> Control descriptor is not initialized
> uops_issued.any: 1655376 547221 547221
> cycles: 1665343 547221 547221
> idq_uops_not_delivered.core: 1983394 547221 547221
> int_misc.recovery_cycles: 69571 547221 547221
> uops_retired.retire_slots: 1311124 547221 547221
>
>   Performance counter stats for 'sleep 1':
>
>           1,655,376      uops_issued.any           #     0.41
> Backend_Bound
>           1,665,343      cycles
>
>                                                    #     0.20 Retiring
>
>           1,983,394      idq_uops_not_delivered.core
>
>              69,571      int_misc.recovery_cycles
>
>           1,311,124      uops_retired.retire_slots
>
>
>         1.000992470 seconds time elapsed
>
>         0.001031000 seconds user
>         0.000000000 seconds sys
> ----/---
>
> But when I reorder the metrics, it fails:
>
>   sudo  ./perf stat -v -M retiring,backend_bound sleep 1
> Using CPUID GenuineIntel-6-3D-4
> metric expr uops_retired.retire_slots / (4 * cycles) for Retiring
> found event cycles
> found event uops_retired.retire_slots
> metric expr 1 - ( (idq_uops_not_delivered.core / (4 * cycles)) + ((
> uops_issued.any - uops_retired.retire_slots + 4 *
> int_misc.recovery_cycles ) / (4 * cycles)) + (uops_retired.retire_slots
> / (4 * cycles)) ) for Backend_Bound
> found event uops_issued.any
> found event cycles
> found event idq_uops_not_delivered.core
> found event int_misc.recovery_cycles
> found event uops_retired.retire_slots
> adding
> {cycles,uops_retired.retire_slots}:W,{uops_issued.any,cycles,idq_uops_not_delivered.core,int_misc.recovery_cycles,uops_retired.retire_slots}:W
> uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
> uops_issued.any -> cpu/umask=0x1,(null)=0x1e8483,event=0xe/
> idq_uops_not_delivered.core -> cpu/umask=0x1,(null)=0x1e8483,event=0x9c/
> int_misc.recovery_cycles ->
> cpu/umask=0x3,(null)=0x1e8483,cmask=0x1,event=0xd/
> uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
> Control descriptor is not initialized
> cycles: 1695223 563189 563189
> uops_retired.retire_slots: 1343463 563189 563189
> uops_issued.any: 0 563189 0
> cycles: 0 563189 0
> idq_uops_not_delivered.core: 0 563189 0
> int_misc.recovery_cycles: 0 563189 0
> uops_retired.retire_slots: 0 563189 0
>
>   Performance counter stats for 'sleep 1':
>
>           1,695,223      cycles
>
>                                                    #     0.20 Retiring
>
>           1,343,463      uops_retired.retire_slots
>
>       <not counted>      uops_issued.any
>                (0.00%)
>       <not counted>      cycles
>                (0.00%)
>       <not counted>      idq_uops_not_delivered.core
>                  (0.00%)
>       <not counted>      int_misc.recovery_cycles
>                (0.00%)
>       <not counted>      uops_retired.retire_slots
>                (0.00%)
>
>         1.000980001 seconds time elapsed
>
>         0.001028000 seconds user
>         0.000000000 seconds sys
>
> ----/---
>
> I think that it may be related to changes when introducing hashmap for
> evsel (that's before I started fiddling with metricgroups).
> Specifically, it looks to be in metricgroup__setup_events() ->
> find_evsel_group(). We seem to be enabling wrong evsels.
>
> I'll continue to look at this, but any help would be appreciated.
>
> Thanks,
> John

Hi John,

The fix to avoid uncore_ events being deduplicated against each other
added complexity to the code and means that metric-no-group doesn't
really work any more. I have it on my list of things to look at. It
relates to what you are looking at as the deduplication afterward is
tricky given the funny invariants on evsel names. I think it would be
easier to deduplicate events before doing the event parse. It may also
be good to change evsels so that they own the string for their name
(this would mean uncore_imc events could have unique names and not get
deduplicated against each other). The invariants around cycles in your
change look weird, but I can see how it might workaround an issue. My
attempts to reproduce the issue weren't successful on a SkylakeX.

Thanks for reporting the issues. I planned to look at this logic to
fix metric-no-group, it'd be nice to land:
https://lore.kernel.org/lkml/20210112230434.2631593-1-irogers@google.com/
just so that I'm not making patch sets that conflict with myself.

Ian


> perf metricgroup: Fix find_evsel_group()
>
> The following command segfaults on my x86 broadwell:
>
> $ ./perf stat  -M frontend_bound,retiring,backend_bound,bad_speculation
> sleep 1
>      WARNING: grouped events cpus do not match, disabling group:
>        anon group { raw 0x10e }
>        anon group { raw 0x10e }
> perf: util/evsel.c:1596: get_group_fd: Assertion `!(!leader->core.fd)'
> failed.
> Aborted (core dumped)
>
> The issue shows itself as a use-after-free in evlist__check_cpu_maps(),
> whereby the leader of an event selector (evsel) has been deleted (yet we
> still attempt to verify for an evsel).
>
> Fundamentally the problem comes from metricgroup__setup_events() ->
> find_evsel_group(), and has developed from the previous fix attempt in
> commit 9c880c24cb0d ("perf metricgroup: Fix for metrics containing
> duration_time").
>
> The problem now is that the logic in checking if an evsel is in the same
> group is subtly broken for "cycles" event. For "cycles" event, the
> pmu_name is NULL; however the logic in find_evsel_group() may set an
> event matched against "cycles" as used, when it should not be.
>
> This leads to a condition where an evsel is set, yet its leader is not.
>
> Fix the check for evsel pmu_name by not matching evsels when either has
> a NULL pmu_name.
>
> Fixes: 9c880c24cb0d ("perf metricgroup: Fix for metrics containing
> duration_time")
> Signed-off-by: John Garry <john.garry@huawei.com>
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8336dd8e8098..c456fdeae06a 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -162,10 +162,10 @@ static bool contains_event(struct evsel
> **metric_events, int num_events,
>          return false;
>   }
>
> -static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
> +static bool evsel_same_pmu_or_none(struct evsel *ev1, struct evsel *ev2)
>   {
>          if (!ev1->pmu_name || !ev2->pmu_name)
> -               return false;
> +               return true;
>
>          return !strcmp(ev1->pmu_name, ev2->pmu_name);
>   }
> @@ -288,7 +288,7 @@ static struct evsel *find_evsel_group(struct evlist
> *perf_evlist,
>                           */
>                          if (!has_constraint &&
>                              ev->leader != metric_events[i]->leader &&
> -                           evsel_same_pmu(ev->leader,
> metric_events[i]->leader))
> +                           evsel_same_pmu_or_none(ev->leader,
> metric_events[i]->leader))
>                                  break;
>                          if (!strcmp(metric_events[i]->name, ev->name)) {
>                                  set_bit(ev->idx, evlist_used);
> lines 25-63/63 (END)
>
>
