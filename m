Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0423C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 May 2022 14:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiE1Ouz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 28 May 2022 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiE1Ouy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 May 2022 10:50:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA99D192B2
        for <linux-perf-users@vger.kernel.org>; Sat, 28 May 2022 07:50:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l188-20020a1c25c5000000b003978df8a1e2so2093234wml.1
        for <linux-perf-users@vger.kernel.org>; Sat, 28 May 2022 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87UMH55qhP/F7dWZ9iWyn0juZKRL0czGeuBEHHkp02w=;
        b=M9m1lPTfTKvLG11Iinnl/uRVdXiNC3C5HJ0y5+ViXA8hxKj1xwRcTeA9olVCFnJV4G
         gDXPkWbrL9UWtaWw+Lks/+5xWKY+ZCwtL75nZ92Yz9Ufodq62YAr+BvMHP2CAUGPkH3d
         qxGfTVdggo3HUHLhkdAhz9IeFn/ZKO+I3ANHGE0g/mCvRX7fhccPDWuvPjmE/u9whzoo
         829N4hm41WQ6OsBaFPAGinqkCCh52VpiJkFq+poS3P/8NRcIHDnti1c7HQFThlcxn3/5
         uwn5obDh2cpu7xj0Ef4I53Dc8/QHVOsNTOjmUUrim14VQLjkqgFbfk5Qn2AEYpRJSqBP
         8/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87UMH55qhP/F7dWZ9iWyn0juZKRL0czGeuBEHHkp02w=;
        b=DRULvUjO4C/srhGsEuMc34a7u1lyWd9pLcxzUA7YHoov2ReK9OP4xUoS56o25IqUqp
         pFJkb3i29PclYZI/6hI4av/qKnPSptDUstQlAbo8B3yO54oTBv4SflU5PxPyKdt2GkDO
         5n3oy0tdt+SsvvpYCKN2nkKFPTHzT6BD81k1aQhDQhHKLKAPQS7IowGBO2078WGlHDSN
         XjIYdeagpAowww/gvbDusBIadeDDZa3yM95fTe8kavL8gLLw+ZD+ZSxW4LSzbJ7UCZpf
         LSlf8dP0PDpQkRp+fMviRV/EcKVvIPLNUGu32UBPDfVqXbsRT/hTQ0GWvtwlru0mM7Ad
         TqDg==
X-Gm-Message-State: AOAM533p/KaNMbx0y9zDK1wCc6P3GDDMx97phNhp4TIZyMYXrgwahC8V
        iVz51EsQJIADDlMs0dus2n71dSpJCYJzNrmuGsY8+g==
X-Google-Smtp-Source: ABdhPJzSEwzqsO95j0XjL3L/Xm8X5uH89ZDVdeqFw90w0VN31mx0ycB4ilkIPcwx0g5cwuWKPFT5dWuqIfdMbKeh2Vw=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr11533653wmq.182.1653749452050; Sat, 28
 May 2022 07:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220527040407.4193232-1-irogers@google.com> <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com> <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
In-Reply-To: <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 28 May 2022 07:50:40 -0700
Message-ID: <CAP-5=fWwG+Gt+E7M8EYuDhgrvfUQLbP7ODn18r_axshqKxwuYA@mail.gmail.com>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
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

On Sat, May 28, 2022 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 27, 2022 at 07:54:19AM -0700, Andi Kleen wrote:
>
> > > This all seems bonghits inspired... and perf actually does expose the
> > > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
> >
> >
> > That's not really available to perf stat, which is the primary metrics user.
>
> Why not? You can mmap any perf-fd (even software events) and these
> fields should be filled out.
>
> It should work on any x86 CPU that has a TSC. The only caveat is that
> the kernel must not have marked the TSC unstable.
>
> It could even work for virt -- all you need is for virt to use
> native_sched_clock() instead of the paravirt nonsense.

It will at least fail if inherit is enabled, no?

Thanks,
Ian
