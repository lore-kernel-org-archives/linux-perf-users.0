Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4253C00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Aug 2022 14:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiHJO0M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiHJO0L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Aug 2022 10:26:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495621CFC8
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:26:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q30so17914028wra.11
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PxC7taMylQDUHixSMWrpX0lBX/KvvsQMV/F2vgDXG0c=;
        b=HGVm54lbjow5CHbKkhecvtoEv7Dcln74pUP4USjVFB7pMfzJbJx/OxkpzaQ/KTqCKJ
         Q4XxCbg4qes4bnKM/IPm4Oiv/M9ZhLcKH6BpN6ditlXliiApYs4ZMqOTTVuNliu+blPV
         44yoslgnbOAC/GOVFRvZAqC1RCiCORmq7HaBr9fg0ZRTcOUOt5A2tuQherdXkUI8NOR6
         TIMhNf1waB2m/vD/JoqFSNjwJi5pKZIFie7H2eE++/R9Nlf9INz9zufJ6F0aT9uRlT3C
         zMUw3rfoyXHVuesoV7LgOmUgOS/W9pL5oe6aIT4CcNxSTMAJGKF/hwlg1iBru9eBtqPN
         FKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PxC7taMylQDUHixSMWrpX0lBX/KvvsQMV/F2vgDXG0c=;
        b=YM7zYwJDbvEOBWkdAXiwDT8g7gk80LEIZTWXlBXyzm8rsEo3N7SW8FCU3IU29KOCuF
         FwQyRCMKAVv/kc1SRXxH5Bp8iS4Yx09Xkq2aKuJur77uDIL2DEt5UnwM2bxGSJLzmxBX
         0NcBmLhtLJYHQkXgGNdfF3S/tswhPlEebmE/fOUN4S/4+DhUM+Wumce8zozSKNhh8FBR
         aCgeBOsCpeGGBdvzsLq8oIWSV2twBLr9M9U1CdSc8Bxus42W3zgE6MEo3eS98lwoHmVP
         Ujn8r/bKDRaGKXWbbAf6WBJO8fapMNpaounPh7i2iobhIZTfz+Ljh1mIh2pbOQsWptd9
         hNIA==
X-Gm-Message-State: ACgBeo1F0CPdp5v2hC29CbO9wPg5gBHaRMBV8VU426wy93SHsqYZZd33
        RivgVc6mLvtK94Q2RbTVg6iqYX/aZk4OpsLstqxbJg==
X-Google-Smtp-Source: AA6agR5tn2cSIsF6oseDLw/DBgnH5iau93kiUtSyR4DVnZloPDnLHTkWOMq4ezSDrM3e8QPzWZPiIV6bLplCNTgzsuI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr17038394wri.300.1660141568603; Wed, 10
 Aug 2022 07:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com> <20220804221816.1802790-9-irogers@google.com>
 <04e1e8c1-d060-6658-141a-b7c1b7dd8400@huawei.com>
In-Reply-To: <04e1e8c1-d060-6658-141a-b7c1b7dd8400@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Aug 2022 07:25:56 -0700
Message-ID: <CAP-5=fXr=4um5nK6Jxt3xMu481k=DGu_9rE3_Y-+XX6iYMb+5Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] perf pmu-events: Hide pmu_sys_event_tables
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 5, 2022 at 4:15 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/08/2022 23:18, Ian Rogers wrote:
> > Move usage of the table to pmu-events.c so it may be hidden. By
> > abstracting the table the implementation can later be changed.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> > -     const struct pmu_event *sys_event_tables = __test_pmu_get_sys_events_table();
> > +     const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
>
> Maybe we can change to not need the "pme_" prefix or even some of the
> suffix, like "_sys"

Ack. Not done here so the change is the smallest possible.

Thanks,
Ian

> >       const struct pmu_events_map *map = __test_pmu_get_events_map();
>
