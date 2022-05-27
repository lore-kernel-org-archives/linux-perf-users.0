Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7404C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354223AbiE0P7M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353936AbiE0P6A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 11:58:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7DE36E26
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 08:57:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so2974711wmz.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nhRSW0HB0IrL3AsaUbgyELmuQlg7AADB3tpFmkYZW4=;
        b=ODsEChw49WJ2jXA7phOq9UZH0sa+uGOmARNU0dKT8ELNxeavTeP0ERYA525+wh7RW7
         9p0HVYaFdK9NPOtwfoYX/3YxuBlVrTS/PvOIFREHdr6i3F0FZXNsx0jO1emEFXlOq8jk
         UzaGW0oM2FSWqXu3ovPYxFW396ckgz81nYoroROMlRcdxD5HFF4bvmOf1FwwjwwS9E5M
         9OWKi+EmtrlVAGJDI4ujDWdfiaOGYNygBvMJh+7eICZSsg2874r1YcHaLvmgsnell5CV
         XhDsg+s/QhI5QzdQAgcnyrDgPgAhweQ+452ZY+E8TlGN2qWg3aPW1kMEF3SuGryy6ig8
         Mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nhRSW0HB0IrL3AsaUbgyELmuQlg7AADB3tpFmkYZW4=;
        b=lq2ovAOwHk4PQwLvC+pCUjMY2avsnjKJfgLmK5kK41/5eS6jnX0CyYehvJe9UknHxI
         gWRKGMNKfO/rQ0URM36pHftI0W2jTKm3FqOGETngRSWi3rn2SXq1u7OnPG6IUqdBx+ew
         yEPwikzhRQsk150540Lo6tHwgWaQI4xKLVI5hbHDLmyV395Hjw3s5iIfA/f3i0Cze/mi
         UreN8O7TzhgxoOSshZryyhumkoioasvH+OAvqkAQ+5DUnkstCr7vZQZHU1vlOdfPWfFN
         0tx0zEdOUW8X8NVaB8VDH1865bCX55C4v60iueWnkhSFQ5C2ZR9BaCTQwdXBWlZHvxM9
         YcjQ==
X-Gm-Message-State: AOAM5306PbBxyLiO4j6nrZ5j84ulqe/s15FeTXrAk4Ec7GRSE+c0r7dj
        P6aOolXakMdMx1SZdI1gAO9IJpLCSnenrA8s6Bn2Tg==
X-Google-Smtp-Source: ABdhPJxCxbqWMUiPiaxpL5cuYifbkFM3KgEr5xj/06bdSvjWoV1r4auP+JYDEsowOpR+ZxfLquMI36O6bB/NtFlBkII=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr7538356wmo.115.1653667077089; Fri, 27 May
 2022 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220527040407.4193232-1-irogers@google.com> <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
In-Reply-To: <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 May 2022 08:57:43 -0700
Message-ID: <CAP-5=fU4Anbx2R=L7VD3Pa_5e5nvkgSW2FNJg5+c5MJfcHcQgw@mail.gmail.com>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 27, 2022 at 7:54 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/27/2022 2:49 AM, Peter Zijlstra wrote:
> > On Thu, May 26, 2022 at 09:04:07PM -0700, Ian Rogers wrote:
> >> Such a literal is useful to calculate things like the average frequency
> >> [1]. The TSC frequency isn't exposed by sysfs although some experimental
> >> drivers look to add it [2]. This change computes the value using the
> >> frequency in /proc/cpuinfo which is accurate at least on Intel
> >> processors.
>
> It would be better to use CPUID if available which is far more accurate.
> Also I believe newer Intel CPUs drop the frequency in the brand string.

But on v1 you also said it was broken for certain architectures. The
point of the tests and warnings is to identify this case.

> BTW it also has the problem that if perf script is run on some other
> system to compute metrics it won't work.

Yep. We don't yet support recording then reporting metrics on a
different system. There would be a bunch to do to support this.

> >
> > This all seems bonghits inspired... and perf actually does expose the
> > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
>
>
> That's not really available to perf stat, which is the primary metrics user.

So we have 3 approaches:

1) read /proc/cpuinfo: pros: easy in comparison to other approaches.
cons: will break in the future, will need a cross system strategy
2) use cpuid: pros: can be made to work across systems cons: not
available for all Intel architectures
3) mmap: pros: more stable API than cpuinfo vendor string. cons: could
end up with new events purely to gather a TSC frequency and associated
complexity around permissions, etc.

I feel we can bike shed and go between the 3 approaches almost
endlessly. I'd rather get something in and iterate. How the approach
breaks can motivate the next steps and the tests added here will
capture when it does break, not just when a metric is first used. I
mentioned this on V1 and requested feedback, this is just implementing
what I said I'd do to V1.

Thanks,
Ian

> -Andi
>
>
>
