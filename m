Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDC6C11F67
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F87661DE3
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 19:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhF2TbG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:31:06 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43958 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhF2TbG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 15:31:06 -0400
Received: by mail-lj1-f170.google.com with SMTP id f13so32557375ljp.10;
        Tue, 29 Jun 2021 12:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEfLuSPH6KhZZ1U4CdzxbvJWglpkxvIUaVZ0D5a3+xQ=;
        b=EGBvOWrK9VuJ+dX74B03ovdvGyMc/PJcAaDVy8QFCANonbV5C/rd1w3AEPj3qess8X
         YnDhi2ZKrFfip0a4OWD+Wy6uhbtnAcU3Ol7ZGLpOZzh9GA3MBZqN0cF6ahFgmR1WBTCi
         0AJNbNszTBPn99hAa5bIQSHVRIRSW8tphulYLhZuXh8Y4LKLPy+ea1FqS7UiuExmFPqU
         hPpCxlTbEu5bbqvWw9bf7+WfPWx/rw+TX/5nofvDLqkCFO2XtcUVk83YdhpsHnEn8c72
         bmQmrdvGrWOLd5d/bdzSL68VkBAyQLE+ys50dR9TnGH5492RFmLYU0dJLwJgYRbYcNsR
         /vKg==
X-Gm-Message-State: AOAM532J9kO03kSXfoSbfcbn9OrW+0Bbxlmg0X/6Sl9jvYpHB0RX0aDZ
        jmjeWIRigwHLo/u5qtJlCgvUHSjESbifLfw/stk=
X-Google-Smtp-Source: ABdhPJxO8/lwQBrngQA/tD/uTLOeOsWYFkQCn6JXhBP22pExYb9JXZ8EoUyiWYEW5hevznDYoDDsSapJ7OuzwXOXbHE=
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr4886886ljb.233.1624994916195;
 Tue, 29 Jun 2021 12:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210627131818.810-1-adrian.hunter@intel.com>
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Jun 2021 12:28:24 -0700
Message-ID: <CAM9d7cgoJQgTK8t+9oLPrEUg=7-zkzFefRO=XnPmLcTDdJfHKQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] perf script: Add API for filtering via
 dynamically loaded shared object
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Sun, Jun 27, 2021 at 6:18 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> In some cases, users want to filter very large amounts of data (e.g. from
> AUX area tracing like Intel PT) looking for something specific. While
> scripting such as Python can be used, Python is 10 to 20 times slower than
> C. So define a C API so that custom filters can be written and loaded.

Thanks for your work!  I guess we can use this for perf report (and others)
to have a custom filter too.

Thanks,
Namhyung

>
> This is V2.
>
> The main patch is patch 1.
>
> The other patches add more functionality, except for patch 5 which installs
> the C API header file.
>
>
> Changes in V2:
>     perf script: Move filter_cpu() earlier
>     perf script: Move filtering before scripting
>     perf script: Share addr_al between functions
>         Dropped because they have now been applied.
>
>     perf script: Add API for filtering via dynamically loaded shared object
>         Move 2 members of struct perf_dlfilter_sample
>         Add 'ctx' as an argument to 'start' and 'stop'
>         Find dlfilter .so files in current directory or exec-path/dlfilters
>
>     perf script: Add option to list dlfilters
>         New patch
>
>     perf script: Add option to pass arguments to dlfilters
>         New patch
>
>
> Adrian Hunter (10):
>       perf script: Add API for filtering via dynamically loaded shared object
>       perf script: Add dlfilter__filter_event_early()
>       perf script: Add option to list dlfilters
>       perf script: Add option to pass arguments to dlfilters
>       perf build: Install perf_dlfilter.h
>       perf dlfilter: Add resolve_address() to perf_dlfilter_fns
>       perf dlfilter: Add insn() to perf_dlfilter_fns
>       perf dlfilter: Add srcline() to perf_dlfilter_fns
>       perf dlfilter: Add attr() to perf_dlfilter_fns
>       perf dlfilter: Add object_code() to perf_dlfilter_fns
>
>  tools/perf/Documentation/perf-dlfilter.txt | 251 ++++++++++++
>  tools/perf/Documentation/perf-script.txt   |  15 +-
>  tools/perf/Makefile.config                 |   3 +
>  tools/perf/Makefile.perf                   |   4 +-
>  tools/perf/builtin-script.c                |  86 +++-
>  tools/perf/util/Build                      |   1 +
>  tools/perf/util/dlfilter.c                 | 615 +++++++++++++++++++++++++++++
>  tools/perf/util/dlfilter.h                 |  97 +++++
>  tools/perf/util/perf_dlfilter.h            | 150 +++++++
>  9 files changed, 1211 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
>  create mode 100644 tools/perf/util/dlfilter.c
>  create mode 100644 tools/perf/util/dlfilter.h
>  create mode 100644 tools/perf/util/perf_dlfilter.h
>
>
> Regards
> Adrian
