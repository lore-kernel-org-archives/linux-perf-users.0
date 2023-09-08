Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716FEEB562
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 17:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbjIHR5N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjIHR5N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 13:57:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE01FC9
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Sep 2023 10:57:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41513d2cca7so19611cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Sep 2023 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195828; x=1694800628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7ceqwAQUKF9MPJnQ8E2bKyiXN7P8xJkZainuxVqN14=;
        b=0HGB5GUqPzlTaTvZPqbLix8l6r7QhYe94TWh+fjtpOUIYa4V76JRH4WzV+l9uArQa/
         NXmruE7XMGCGrTiTNI6MOJ+IqHIEF/CsvaNN218iWM9eAiqzt2Fw1Ayh8bQDfE5ppLKK
         3jb7ZDob8F3qlnBknaELIiL69j7tFSrBBHZ5UmeBn7nc9+q+TzVJ9Y5KQmBaghAF8W+S
         ys1ZWatKImrry0HfVCnnt9MUjHc8EKhWKZ4KJB/Uj5xmGUWG7pN7R0mLyR1/JVzE+Rg8
         o/sAZudWMWNsix2gwfwvgbyFl4Iqj/I2sDBMF74DFFrAOjVmaqlkNUU2feyXwA491pJI
         dufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195828; x=1694800628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7ceqwAQUKF9MPJnQ8E2bKyiXN7P8xJkZainuxVqN14=;
        b=mdvSRSPNQVMK97spLaEvFOGm22Yoew1vSNCpFcvogOaveKvQ1qZlNiQGOgR9JDpV+x
         N+ZEkEerC25R3w7qMDkYxth6GOv2AtOdj+vD0It2k+AR2Tw2zTxofLW6M2vppDaIoxYk
         ECgQM2wu+FX23iGg/cL1Pw+IdK3GJRbQmw3nBHTxHIujypNNaoJ3xiiY1731I0fqMlsS
         sCbLhBfQkt26VdOQKDZkK47JtVHMSwdQ/bXI54HDdXxxmiEfRNHOeWOkLke7h9M3GE+K
         GGD8x/3VKHYodOhr9P4NX8xDQwxgYhxyvDPTjFGDo15Ua6KpgG+JprdN/vcGZDl02fR2
         m+8Q==
X-Gm-Message-State: AOJu0Yx6jc4zpoZE9hpToQhhyZmdCtAK+0X/hAQIjiAvba5CS3xnKMRG
        Z74V9F8YjuP4MMhqSj6MzWi1h6DWDKzwEp7p88GtKQ==
X-Google-Smtp-Source: AGHT+IF0PzaRtt1uWZsmloiiY/t3tw9Yx4K19RF1uXgfY7GvtDALiAUW3o+5Uksb+F4HGBeysR/KOTvNuRav2YtV50c=
X-Received: by 2002:a05:622a:4:b0:410:9855:acd with SMTP id
 x4-20020a05622a000400b0041098550acdmr282968qtw.14.1694195827660; Fri, 08 Sep
 2023 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fXSiO87=tyax4p6uVHRhpWtK4HGPoMCYUEDcJxd+O67zA@mail.gmail.com>
 <4e9f0148-61df-240d-166e-11119a2041dd@arm.com>
In-Reply-To: <4e9f0148-61df-240d-166e-11119a2041dd@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Sep 2023 10:56:56 -0700
Message-ID: <CAP-5=fWGjL9dBbEKrco7boa0G4wKpyNYj+hhYPo-HMSkCWwD8w@mail.gmail.com>
Subject: Re: Perf metrics for ARM64 Raspberry Pi
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jumana MP <jumana.mp@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Nick Forrington <Nick.Forrington@arm.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 8, 2023 at 9:51=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 07/09/2023 22:08, Ian Rogers wrote:
> > Hi,
> >
> > we have common metrics for ARM64:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/arm64/sbsa.json?h=3Dperf-tools-next
> >
> > but they don't apply on common platforms like raspberry pi 4 as
> > standard metrics still need a reference from the model metrics to the
> > standard one like:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json?h=
=3Dperf-tools-next#n3
> >
> > In the mapfile.csv a raspberry pi matches cortex-a57-a72 which has no
> > metrics. I was wondering what it would take to add these metrics?
> > However, it appears the standard metrics use events that are undefined
> > at least in json like stall_slot_frontend:
> > ```
> > $ grep -r stall_slot_frontend tools/perf/pmu-events/arch/arm64/
> > tools/perf/pmu-events/arch/arm64/sbsa.json:        "MetricExpr": "100
> > * (stall_slot_frontend / (#slots * cpu_cycles))",
> > ```
> > as they are coming from sysfs:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n233
> > and are missing on the raspberry pi:
> > ```
> > $ ls /sys/devices/armv8_cortex_a72/events/
> > br_mis_pred        cpu_cycles    l1d_cache         l1i_cache_refill  me=
m_access
> > br_pred            exc_return    l1d_cache_refill  l1i_tlb_refill
> > memory_error
> > bus_access         exc_taken     l1d_cache_wb      l2d_cache         sw=
_incr
> > bus_cycles         inst_retired  l1d_tlb_refill    l2d_cache_refill
> > ttbr_write_retired
> > cid_write_retired  inst_spec     l1i_cache         l2d_cache_wb
> > ```
> > Looking at:
> > https://documentation-service.arm.com/static/60250c7395978b529036da86?t=
oken=3D
> > It seems some of the metrics like "operations wasted" could be had
> > even on earlier revision PMUs. Are there any plans in this regard?
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> I don't think any of the sbsa metrics would work on RPi as it doesn't
> have the events needed.
>
> There are probably lots of other generic metrics like cache miss ratios
> that would work though. But unfortunately the current workflow is for
> Arm to publish per-CPU metrics and events and I'd say it's unlikely that
> we'd publish anything for a72 now because of its age. They're also not
> as interesting as the sbsa ones as they're usually just a ratio that's
> pretty easy to work out manually.
>
> I think that leaves a few options:
>
> #1 Just manually copy existing metrics and edit for a72 based on which
> events are available, and assume that the same formulae apply
>
> #2 Come up with a bigger set of 'common' metrics and instead of opting
> into them on a per-CPU basis, just show any metric where all the
> required events are available. This kind of goes against the current
> workflow where we publish per-CPU metrics, and could risk showing
> misleading data
>
> #3 Arm publishes metrics for a57/a72
>
>
> Personally I like #3, as that continues to use the system that we've
> already defined, but there is a chance it won't happen. Maybe we could
> do #1 in this case as a one off or for other older cores that never had
> metrics defined?
>
> James

Thanks James!

It'd be great to have more metrics from Arm. I wonder if there are
things we can do in jevents.py, for example if the events/metrics are
standard then let's make their addition automatic and not opt-in. For
the metrics they rely on the PMU version, but we could use
has_event(event_name) as a way to make them enabled conditionally, or
perhaps we can add some kind of test to enable/disable metrics.

Thanks again,
Ian
