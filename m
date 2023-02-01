Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D6C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 17:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBARDD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBARDC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 12:03:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CC900C
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 09:02:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so17942888wrv.7
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Feb 2023 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UP/37JG8zTxRTjZFT60IaD92D0Iz+nNCYIC99KAy+Wk=;
        b=KuQvGIxIQyO8T8+GBf3DMps+ketXsQdhCCg7Sy0kcPD4hN+zcf3QYuP9AtTWFuqjZD
         o2UT354rORRsdY6c3wBdmQyZ0zSqJ8HFi/2tG3cMADNFbyPwmYjwq/SiRGCN/H08WJkQ
         K0Iq4m6LaZKhMpX9uRNI5/cu6k2Ai+kNRzskAVO95DwgVSJItyRivEcZRlXeuxwHJmib
         3BhgxeV1xUEk6Rd++XkzInXvKWJmkipi53CUuT48MJQvdZBiMcBFBGw4DvQ5POMRbMmw
         QOQbuFQfsKWPu7kpLbZtbW9xF4EIIl+nZNyw28BhIzZYWjLeI1bVhA3pm0KMj74K12Cf
         O5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UP/37JG8zTxRTjZFT60IaD92D0Iz+nNCYIC99KAy+Wk=;
        b=f+P0OhfBM6C2nOFKEgeg2FqPUfG2R+5Z/xyM2q0m+k7gIIYFuNtuXpbg7oTLvAJa5G
         JPyzEUiVnBsZB2/kVP/eV7ulEvCe5fTE7hHXkmo2zp6qlMQ40JxyUEnTDih2aTe5eC08
         MjVTG2QJCk9ytU9fRaswKy9Qds1iVHLXMPZoNJ1mlAGlAS91Yzppe4QMAWv7qLyiVINF
         k4l98jd8lls2ATQLAwwkB7oaI37UoH1/eG27JOowQ06OwSrInz7Y6UA+5P5Q/yVDvEAd
         6gJBVXBm9MNd97A+avE5ExwnM/9+FrkguD0q0YBPq6wLIBrrRpOuYqiJxmHV4OFIctJd
         V2MQ==
X-Gm-Message-State: AO0yUKXrz1WxE6NxP9XpxL/lJwpCEPOKaJJFs1ox27YZJjVm5bNj5rAb
        xLmDx8oapYbbVlEPFFa/WyhfphF5FkFfyjgL/CF45A==
X-Google-Smtp-Source: AK7set+vjE7Aq/wG/dnp7pst6PBIgibIMcGPmch/eqrNmwJvM/QcAKsH7X/onv7xaAZG3AN9E4fLxR6130MpZk0O1gI=
X-Received: by 2002:a5d:4bce:0:b0:2bd:deb8:353e with SMTP id
 l14-20020a5d4bce000000b002bddeb8353emr157231wrt.267.1675270975596; Wed, 01
 Feb 2023 09:02:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
 <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
 <CA+icZUUOZoLOFiBcYkccWPSusk9G_Rhf3DOZYWat-K+VfWFHQw@mail.gmail.com>
 <c6605d52-b9e1-e8d3-ed29-562146f64eea@arm.com> <CAP-5=fWcb8m9vkfqSC9H2Gqi2dBjbPuGb2F27Fq-ejmR25foQw@mail.gmail.com>
 <CA+icZUWKFCdhQ9XN0wLN6BF5ft3WaNrtXDb9D8ckNOPG9gUf+g@mail.gmail.com>
 <CAP-5=fUSyN5wCn5miG79cT30YruJjkAYMeR58XXgRBQw-6hHkQ@mail.gmail.com> <20b09a5b-99b3-75b8-3ec8-e978965497f2@linux.intel.com>
In-Reply-To: <20b09a5b-99b3-75b8-3ec8-e978965497f2@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Feb 2023 09:02:43 -0800
Message-ID: <CAP-5=fXHDuB5G+ujVCoe81H+-Y=J8ig6TZ-dGZHknskb7Z53ig@mail.gmail.com>
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     sedat.dilek@gmail.com, "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 1, 2023 at 7:28 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
> Hi Ian,
>
> On 2023-01-30 10:55 p.m., Ian Rogers wrote:
> >>> There's a question about what we should do in the perf test about
> >>> this? I have a few solutions:
> >>>
> >>> 1) try metric tests again with the --metric-no-group flag and don't
> >>> fail the test if this succeeds. This allows kernel bugs to hide, so
> >>> I'm not a huge fan.
> >>>
> >>> 2) add a new metric flag/constraint to say not to group, this way the
> >>> metric will automatically apply the "--metric-no-group" flag. It is a
> >>> bit of work to wire this up but this kind of failure is common enough
> >>> in PMUs that it is probably worthwhile. We also need to add the flag
> >>> to metrics and I'm not sure how to get a good list of the metrics that
> >>> currently fail and require it. This is okay but error prone.
> >>>
> >>> 3) fix the kernel bug and let the perf test fail until an adequate
> >>> kernel is installed. Probably the best option.
> >>>
> >> Hi Ian,
> >>
> >> I can confirm:
> >>
> >> $ echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
> >> /proc/sys/kernel/perf_event_paranoid
> >> 0
> >>
> >> $ ~/bin/perf stat -M tma_l3_bound --metric-no-group -a sleep 1
> >>
> >> Performance counter stats for 'system wide':
> >>
> >>         2.058.892      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      1,5 %
> >> tma_l3_bound             (99,30%)
> >>       173.254.697      CYCLE_ACTIVITY.STALLS_L2_PENDING
> >>                         (99,10%)
> >>     2.396.130.501      CPU_CLK_UNHALTED.THREAD
> >>                         (99,60%)
> >>         1.110.486      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >>                            (99,53%)
> >>
> >>       1,001989022 seconds time elapsed
> >>
> >> $ ~/bin/perf stat -M tma_dram_bound --metric-no-group -a sleep 1
> >>
> >> Performance counter stats for 'system wide':
> >>
> >>         1.729.208      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      1,2 %
> >> tma_dram_bound           (99,50%)
> >>        50.346.734      CYCLE_ACTIVITY.STALLS_L2_PENDING
> >>                         (99,50%)
> >>     2.354.963.862      CPU_CLK_UNHALTED.THREAD
> >>                         (99,80%)
> >>           306.500      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
> >>                            (99,61%)
> >>
> >>       1,001981392 seconds time elapsed
> >>
> >> Thanks!
> > Thanks, apparently it is an issue with SandyBridge/IvyBridge that some
> > counters on one hyperthread will limit what can be on the other. I
> > believe that's the comment related to EXCL access here:
> > https://github.com/torvalds/linux/blob/master/arch/x86/events/intel/core.c#L124
> > So you may have more success with the metric if you disable
> > hyperthreading, but I imagine that's not a popular option.
>
> Thanks for debugging the issue. Yes, it's caused by the HT workaround
> for SNB/IVB/HSW.
>
> The weak group check in the kernel is in validate_group(). It only does
> a sanity check. It doesn't check all the workarounds and the current
> status of counters (e.g., whether the fixed counter is occupied by NMI
> watchdog.) It's possible that a false positive is returned to the perf
> tool. I once tried to fix the NMI watchdog check in the kernel, but the
> proposal was rejected. So the metric constraint is introduced.
>
> For this issue, I think the above option2 should be a better and
> practical choice. The issue is only observed on old machines, which
> usually has a stable kernel running on it. I don't think the user wants
> to update their kernel just to workaround an issue for several metrics.
> But it should be much easier for them to update the perf tool.
>
> We know that the below events are the problematic events.
> /* MEM_UOPS_RETIRED.* */
> /* MEM_LOAD_UOPS_RETIRED.* */
> /* MEM_LOAD_UOPS_LLC_HIT_RETIRED.* */
> /* MEM_LOAD_UOPS_LLC_MISS_RETIRED.* */
> Can we update the convertor script and apply the "--metric-no-group"
> flag or add a new constraint if the above events are detected in
> SNB/IVB/HSW?
>
> Thanks,
> Kan

Thanks Kan,

We absolutely can do that! In this case should it be --metric-no-group
only when SMT is enabled? I can do some patches but would like to know
about whether we need SMT and not SMT versions of --metric-no-group.
Also, should we just have a list of metrics that need the flag or try
to automate detection? Some warts in detection are the names of the
events that vary between Ivybridge and Sandybridge, and how to
determine which events conflict. For example, the perfmon event data:

MEM_LOAD_UOPS_RETIRED.LLC_HIT
https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L5368
MEM_LOAD_UOPS_RETIRED.LLC_MISS
https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L5431
CYCLE_ACTIVITY.STALLS_L2_PENDING
https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L3541

The events list all counters, there are no errata fields.. Should the
event data be updated and then in the converter script handle that? If
I get shown an example I can modify the script accordingly.

It is also hard for me to test anything other than SMT on Ivybridge.

Thanks,
Ian
