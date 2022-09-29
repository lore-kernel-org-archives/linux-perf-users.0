Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC87EC32771
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Sep 2022 02:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiI2CXy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 22:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2CXx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 22:23:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC44123DAB
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 19:23:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so38101wmb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 19:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=885bZoAF9cATz3vxtOjRWDKiMOgQWtWGS/sIyDsnGvc=;
        b=j5blAkgzNbivA6YVD15PkyBQU0hoYVrqId7OzizI0uth5eAYft6AsJiHya90NxrNiN
         Ea3EnkUZJmr6iLkBBGK3NHfXWapei/cwLSfCOTd2Dak6NmlEPu3tYgLuqhhv1t9vHXCb
         NqlcLGknKQ+17inzmKVOEaAPQvDjz6/G/gCDZ/InxqHT4vHb4cs5hSzNrpAZ+2zJVXmQ
         3PGzWAXGuOy8dLDsPwwqSakykRIpbRNDAVyqJS8ObwKoq500CsjONv53rM6ILvRC6bdF
         rGCr52NFeSTphWjXB4+seKyq4ZXy91Gra5n+RmWCUqYm2lOMbr/d618Bbau0OI3NxsoZ
         4AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=885bZoAF9cATz3vxtOjRWDKiMOgQWtWGS/sIyDsnGvc=;
        b=FyTr0P7E5U9VE+zgVb5sfy5mVqfM+mpmTHxHAJvcYDTfWBNUvuX72DPfXCz/QjeUhh
         QYeBGh7LNFJ1Yv6QTJsRd6wjiyw4YaTFPHAgczPB2TVVhQOXoEJVCdrOKikBvjly4RD6
         8QrYhYuGcJIUJhFxi8TNEf0ODYMc7X9jb+Hu5vZtEeHN75c4Sve2VLL4RB75/nEKyGzz
         OdnwmAbryE4P9AH5VU3Dh9QTsAHnIMe5oK8iPiVsebBkRDwwrAK2p/Fi4Zb9K+jrwkWk
         rQ5E7o2QBU7NbjdUkVhhp46QifV6xASXTKNQIiRn/NgHEHVtLO/9ldX7zQlVC564Bz7o
         sN3Q==
X-Gm-Message-State: ACrzQf2IazBDI9PY9i2vS3izoPjVWY6sGOeMpqqVdrERIAdLIrVszujM
        oO7mx7tdGG0YSdIcl935BVJ3TjB8KTC+e8F9K7MiHQ==
X-Google-Smtp-Source: AMsMyM4EW3WEL/8g7SzWKMrlQzFsAoKaRVucZZV7DfGGh8BFJ5SKG/B3CTiIV24PnStGZFrapbXl5A5jPXKfM0jO3tk=
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id
 e1-20020a05600c218100b003b474e416f8mr516955wme.174.1664418230461; Wed, 28 Sep
 2022 19:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com> <20220928072204.1613330-6-irogers@google.com>
 <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com> <YzRVOD4u2SI0K29Y@kernel.org>
In-Reply-To: <YzRVOD4u2SI0K29Y@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:23:37 -0700
Message-ID: <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/22] perf vendor events: Update Intel alderlake
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 28, 2022 at 7:08 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Sep 28, 2022 at 04:22:53PM +0800, Xing Zhengjun escreveu:
> > On 9/28/2022 3:21 PM, Ian Rogers wrote:
> > > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > index 7f2d777fd97f..594c6e96f0ce 100644
> > > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > @@ -1,5 +1,5 @@
> > >   Family-model,Version,Filename,EventType
> > > -GenuineIntel-6-9[7A],v1.13,alderlake,core
> > > +GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
> >
> > The commit description should mention this change "Add more CPUID support
> > for ADL"
>
> I added this note, with that can I have your Reviewed-by or Acked-by?
>
> - Arnaldo

I think I should send a v2. I can add this then. Other things for v2 are:
- this week there will likely be an update to [1] which is implicitly
integrated here.
- the topdown metrics are all percentages but are currently values
zero to 1. It is straightforward to add a ScaleUnit of 100% to them
all.
- eyeballing topdown event metrics like:

    {
       "BriefDescription": "This category represents fraction of slots
utilized by useful work i.e. issued uops that eventually get retired",
       "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
       "MetricGroup": "TopdownL1;tma_L1_group",
       "MetricName": "tma_retiring",
...
it looks like the group will fail due to the missing slots event. This
can be fixed with:
       "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
* TOPDOWN.SLOTS",

Thanks,
Ian

[1] https://github.com/intel/perfmon-metrics

> > >   GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> > >   GenuineIntel-6-(3D|47),v26,broadwell,core
> > >   GenuineIntel-6-56,v23,broadwellde,core
> >
> > --
> > Zhengjun Xing
>
> --
>
> - Arnaldo
