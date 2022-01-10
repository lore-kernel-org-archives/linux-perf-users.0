Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB5C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jan 2022 05:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiAJFpe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 00:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiAJFpd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jan 2022 00:45:33 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA7C061748
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jan 2022 21:45:33 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id 2so6238179ilj.4
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Jan 2022 21:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2Rp9THzxzMq/ttRbcNPqtEt7HusqSb4QCZKzlGP+9A=;
        b=juiqSHTVJOaVRhq5m+ZrXvTTrRVYb0CHU0nTSgQ5EbBBT6MbUr4A4GuiOClsTB/gdQ
         t34ORL1fAqvpdOtpu9hdVHt5yRe8CL0QMc/SFFsE2WrOtSRobmC2J0uS+w/+EJP4ySoU
         D7q84Pbg8+Ehz6bPkf5vsRmN6j9mys6WAR8oDkxPkN1u6Q15e0hWQsnld0wus+p/hqlo
         Jf5jSTlEyS6kVAY37Pa9zi8xDocpNnjuR+F1IVvqvhVE2pwFA8Xo3vXQvv2vXMNqEmuv
         K0b+L5hwH7MUOJre3i47A81eMI6K61WfeclIM8FYc824gFN3ez3zrBVu8ZIr4YBAySTw
         iOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2Rp9THzxzMq/ttRbcNPqtEt7HusqSb4QCZKzlGP+9A=;
        b=kzDTXOrhmwoPJ0ugPjNplOdraWVgUyyhy6QaP70wZVXo2z2BSwl/oJopf70d6lV0Eu
         cHnIAgqYxgpHlvSuM1KC2PZGYUpfUlwOejXYm7VvVPPmRDSHrjt8LPh/1xshYaJl9bIr
         x9cNhL6H6n87eA9YWsvPd7cai0LKKx9H7k5ZJdKv9eKiGX+p6CNS7tAg7peg+7dT2oNf
         H3Lbgl3llIi2vbU6zAD+VuZXGGXVRWk3Nf/AOqQDAhWCbxw9qCv/kQxNa1lCgPHy8Srj
         L0ouA5EnWP8iXQ0EOYORw9wTYjS81kOaxka3c2alLpVYpM3M8VKZ44AzML/r/IVwSFOr
         MGeA==
X-Gm-Message-State: AOAM532KdzNrv0N2laZP2CWdndulMhHV6enQEiL5SJH84dQyspZ3jWbT
        Ze54ytZq+vUer5vbR7fPpvxQ5L7EJ0hMNG82aUWf6Q==
X-Google-Smtp-Source: ABdhPJxyWGUAtz2QGisVN7rf6M/TgAXD97oRuJ2SmHNnR7fpvWKGhupRiQN2k/CqPMiyRGdiVhxTK3dqHhAXr2Cyq74=
X-Received: by 2002:a92:da07:: with SMTP id z7mr5541162ilm.2.1641793532644;
 Sun, 09 Jan 2022 21:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-49-irogers@google.com>
 <Ydspzl2aWpufl/yR@krava>
In-Reply-To: <Ydspzl2aWpufl/yR@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 9 Jan 2022 21:45:19 -0800
Message-ID: <CAP-5=fUQsd21cxFiXBi2pCh9rakMReiNWxbrKn+1CesCamrtdg@mail.gmail.com>
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jan 9, 2022 at 10:30 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers wrote:
> > A common problem is confusing CPU map indices with the CPU, by wrapping
> > the CPU with a struct then this is avoided. This approach is similar to
> > atomic_t.
> >
> > Suggested-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> SNIP
>
> >  tools/perf/util/stat.h                        |   2 +-
> >  tools/perf/util/svghelper.c                   |   6 +-
> >  tools/perf/util/synthetic-events.c            |  12 +-
> >  tools/perf/util/synthetic-events.h            |   3 +-
> >  tools/perf/util/util.h                        |   5 +-
> >  59 files changed, 408 insertions(+), 347 deletions(-)
>
> that's massive ;-) did it find any mis-use of the index/value?

It did. The fixes precede this patch so that we can have the fixes
without the large rename.

> how about the same for threads?

Agreed, but the patch set was already big enough.

> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 71a31ed738c9..581f9ffb4237 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -4,6 +4,11 @@
> >
> >  #include <linux/refcount.h>
> >
> > +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > +struct perf_cpu {
> > +     int cpu;
> > +};
>
> should we use 'int val' or 'int v' instead, so we don't have cpu.cpu ?

I can rename it if you have a preference.

Thanks,
Ian

> jirka
>
> SNIP
>
