Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F2C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDMNwj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjDMNwi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:52:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869D133
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:52:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso100855e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681393955; x=1683985955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyiAXWi7wI/a4BXE2JS5B0l728wDK3pRrScYY1FO7uw=;
        b=5gKTV249ZdQUcMjtng7r14BRVoCMr/7O5QnP1HvjS1/xFz/pbHBMIgw0CkNPreZ9kN
         rz/Pc+Q270TCDhNdoJ2WrMsTFpuiFzkdzZOPkwG5AtTNQ53sMq1l+z+5vLcLUPJHtD4q
         DaLYtGuiTys1VF8n47eVFQfVPu/bbjq/poQlam/w24jwR0PVMowKE42xoLikim73nLnM
         LJJpUrF+XIzAcnAyt2mefRmLCwJ8XAvKydrUlqMqohjhGiPvPpjXt6f6ZyCZPmZ4IPIf
         ex6EqIoimd5qEn5bB2PVkuqguaCQuVP4R1JitEcoGcf05asNxHyCcJWSV0WnztiJ0kYv
         wTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393955; x=1683985955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyiAXWi7wI/a4BXE2JS5B0l728wDK3pRrScYY1FO7uw=;
        b=eZ/ZnrLeDH2wJFf9+TcyVP8w9GmyKuRAAgL8EGkq14eV9wl4ppB9ZLPLV/goJAYOnA
         CE8m2ce6OC4q8reksaoMO0RB16jGuAuIWZUD/OlruatQEJBo6IVb48trSI3AfB+Fa1lU
         GBqbaEy//bpsw1qE5wxO9Q8E2Fttft8CRDRyfKlExbk1areHJQW21vp15j05kZ7fjQ1+
         5w6jy/rAKVyYB2JSWhCXDPUNJco5ENzYF1WC+V/zeMjebNEdRWTflR/kos7eNCXCi4ge
         6fajUCRdRLRJh3WZlMkbAebGt9D3ENdTaazrQ3OJB1xEu4I2Hask4cyIQXEYNuV4gLuE
         yzWg==
X-Gm-Message-State: AAQBX9eE8H48LvFNI8/J4WtFhUv8uQ0BziDFpEsWuulBfsi47GYwJ7Rp
        17EMz62UiIOYs4RCnWRd0G8N0L7ylwS2Sinjq+a/+A==
X-Google-Smtp-Source: AKy350adPkBn07FIFFq9g/pBm0gwFTeneoYFhI/cfO7JwnQJADkCBxc40tPY+7xz0t0L6eGpXmbvBVNkl0/WvZvvRuA=
X-Received: by 2002:a05:600c:3109:b0:3f0:9642:d410 with SMTP id
 g9-20020a05600c310900b003f09642d410mr535820wmo.3.1681393955150; Thu, 13 Apr
 2023 06:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230411205622.3266490-1-irogers@google.com> <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
 <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
 <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com> <CAP-5=fUELu6nT8sGjkPvzKOX2qxH-w9q5mJgsjLBoYwAQ5bP6Q@mail.gmail.com>
 <2a6f6cf3-3de1-33e4-3b51-8c702c270bda@linux.intel.com>
In-Reply-To: <2a6f6cf3-3de1-33e4-3b51-8c702c270bda@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 06:52:22 -0700
Message-ID: <CAP-5=fV_6Tjrc3PgEzHbXMvXJNerBOfTnrqb5eyZtjA4dRB0HQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 13, 2023 at 6:36=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-12 2:01 p.m., Ian Rogers wrote:
> >> - We shouldn't only rely on the event list file. We need to do runtime
> >> check on the availability of events. Either perf_event_open() or
> >> /sys/devices/cpu/events/ is fine (althourh personally I prefer sys way=
,
> >> since I think it's easier).
> > Using perf_event_open is the status quo and the sysfs approach is
> > impractical imo. I think the only thing that is needed in v2 is for
> > <not counted> to be displayed for skippable evsels.
>
> Using perf_event_open is good to check features. If the feature is not
> supported by the kernel, it will be explicitly rejected.
> But I'm not sure about the availability of events. The kernel doesn't
> check every events. For example, on ICL and later platform, we have
> event=3D0x00,umask=3D0x8X for all the topdown metrics events. If we open
> them on SKL, the perf_event_open will also success, but return 0 value.

Thanks Kan,

The behavior change in perf-tools-next is to use the TopdownL1 metric
group rather than programming the events and then having hard coded
metrics if we spot the events enabled. On SKL the TopdownL1 metric
group will give SKL top down metrics which don't use topdown events
because, as you point out, they don't exist. The only way to program
event=3D0x00,umask=3D0x8X on SKL would be through a raw event, so I don't
think there is any issue here.

Thanks,
Ian

> Thanks,
> Kan
