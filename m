Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCCC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhLHPNM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhLHPNL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Dec 2021 10:13:11 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28EC061746
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Dec 2021 07:09:39 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id 15so2457341ilq.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Dec 2021 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+GAXE0VqreyV1r5eP+ZAlAusuf0NulXA0aP4GUThgg=;
        b=XnuiTep5KidHlpTcNb8bVogoBSUMyCQ0MAzfV81JGYQY6tkBoej5YM9ThzUluT+O8M
         zNkQfg8gXRApb0ZFSXSZf8J4f78X+bWbFm8dexQqMc/qDoc4Aci3jclCKyXrycT/ANpe
         eDgukh0rsfQtd0JY3T0IrTOAAZKn0iyQuaEB2wZVctyjqjYFKz8S6fAuvtFi0kjw3MxF
         ye2KFpKETvirGMHC4Y8r66DDRqEH9joD69jwnbI1DfiyoM4lPe60Uy+SiE3iwkCBy4zz
         L/KIkUGPFuPiNsKocYewikUlz02VEIrS/mVD/ig0mggApg7VDPVlxZdhxhtOP0qKdxfb
         lxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+GAXE0VqreyV1r5eP+ZAlAusuf0NulXA0aP4GUThgg=;
        b=RM+Eo9oktZyLojj/92DGCKC32GDEIo7hMOyBkzQhW7BLOOM9/XH2xykre1GmL+rNUw
         03t0QEHKRbPzUxDSLAI6SzyOkDbXnaZx66c2RudvVUFhubMjBMItAMnrIRZ3MHP58nt1
         SUPPnM5KU49kgoGAz75bNx21JqYNamZEmBqCd3jaf8NG08I6Qe8pLtBuuNQ2O9JmpBZJ
         YDikf5+M49kBefWK9rhV1PXa6T+6wP/ZW3F2wbqtlRYPE34PocUxNe52spWBkb+rls7q
         G1006HHoBveO+CcyY0GBUT6AVCGC5XDAx3b9mi8yWhP2C2xSnc8c/O2BB3g4UVv5AJuf
         S6Rw==
X-Gm-Message-State: AOAM533SuPgaAgSiM9sTOd1d68lMw7Lw/Lp7eSttctfFQCudqOJmSkOf
        RWkqkfpnWB31ThXykelW4jzejWPyBJ0fEX6tjBCEdA==
X-Google-Smtp-Source: ABdhPJzqPeuFB5JLQTAHNvbSIwmMLg5uD/l5Rg7r9lU0wOT8VAo4EjUZ/mLnmAl9JY4E9BjIBtYh7QHaZFtNUc7qgu0=
X-Received: by 2002:a05:6e02:931:: with SMTP id o17mr6795355ilt.174.1638976179029;
 Wed, 08 Dec 2021 07:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com> <20211208024607.1784932-2-irogers@google.com>
 <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com> <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
In-Reply-To: <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Dec 2021 07:09:26 -0800
Message-ID: <CAP-5=fUgi+Vh8SitwXTjV27NHmyaMRV0usfmVOy=0gt5sKcsFg@mail.gmail.com>
Subject: Re: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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

On Wed, Dec 8, 2021 at 6:34 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Dec 8, 2021 at 4:06 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 08/12/2021 02:45, Ian Rogers wrote:
> > > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > > index 840d4032587b..1c1726f4a04e 100644
> > > --- a/tools/lib/perf/include/internal/cpumap.h
> > > +++ b/tools/lib/perf/include/internal/cpumap.h
> > > @@ -4,9 +4,16 @@
> > >
> > >   #include <linux/refcount.h>
> > >
> > > +/**
> > > + * A sized, reference counted, sorted array of integers representing CPU
> > > + * numbers. This is commonly used to capture which CPUs a PMU is associated
> > > + * with.
> > > + */
> > >   struct perf_cpu_map {
> > >       refcount_t      refcnt;
> > > +     /** Length of the map array. */
> > >       int             nr;
> > > +     /** The CPU values. */
> > >       int             map[];
> >
> > would simply more distinct names for the variables help instead of or in
> > addition to comments?
>
> Thanks John! I agree. The phrase that is often used is intention
> revealing names. The kernel style for naming is to be brief:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming
> These names are both brief. nr is a little unusual, of course an
> integer is a number - size and length are common names in situations
> like these. In this case number makes sense as it is the number of
> CPUs in the array, and there is a certain readability in saying number
> of CPUs and not length or size of CPUs. The name map I have issue
> with, it is always a smell if you are calling a variable a data type.
> Given the convention in the context of this code I decided to leave
> it. Something like array_of_cpu_values would be more intention
> revealing but when run through the variable name shrinkifier could end
> up as just being array, which would be little better than map.
>
> The guidance on comments is that they are good and to focus on the
> what of what the code is doing:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
> refcnt was intention revealing enough and so I didn't add a comment to it.
>
> > Generally developers don't always check comments where the struct is
> > defined when the meaning could be judged intuitively
>
> Agreed. I think there could be a follow up to change to better names.
> As I was lacking a better suggestion I think for the time being, and
> in this patch set, we can keep things as they are.

A related follow up could be to switch perf_cpu_map to the more
conventional cpu_set_t:
https://man7.org/linux/man-pages/man3/CPU_SET.3.html
However, that wouldn't allow the reference count to be alongside the contents.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > John
> >
