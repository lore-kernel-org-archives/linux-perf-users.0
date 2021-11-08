Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4536C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA16112F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhKHVjw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238291AbhKHVjv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636407426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RHWlIa6mB+gL04SC+OL5nLqboJnsxtwwNLcvgD1V1s=;
        b=JUfVgEIkkpOM5eNsVjIKbUoLTpZM+c1F1hZ5trV98k6Be+BJ77HUJZiZBGgwHUW+7tJOfa
        wMKaTSbuvi33Ys9HtwNtlVEdiFdA1jthl+oXRr+QokJzgCYu2MmGTdgehhqj4pRRSz4K2H
        S/ZO3lVuUT4CCSxgyVNzV6RAOSQLJPM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-4W8KU7f5Or6BI7Ps1-g5Mw-1; Mon, 08 Nov 2021 16:37:05 -0500
X-MC-Unique: 4W8KU7f5Or6BI7Ps1-g5Mw-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a056402281200b003e2e9ea00edso11493038ede.16
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RHWlIa6mB+gL04SC+OL5nLqboJnsxtwwNLcvgD1V1s=;
        b=pbrzYa/riniNfNIktWsOPxJpOvYYQBuytYrqTc/8aBJpTBDKbN9rJlC+Pa+efTurUF
         xMQnI5P1GQFCo6msdL3NhBfrdNxIEd2niKRs2Tf0CrwEiRsmD1NKO+LW/5Z6jqfs/YSE
         R/E3b0f+nMyDHN9GIXlqd/emysbQID1KSNRr9sRayLzSKRb1IHJ3DRL1PbCMOyozhvhr
         llUMoH4DToCUqWXhUlsnaK1C0VF9zIXfaDIF56GAzmYSM//VBvJRd0Wqr4YXomi1P5uR
         obEEQ+6Hs82wl9sPTTxZygVRm1sSJahO3T9m+m5GiHXCZAkFKQjuVCcLAUyT9vFCcIey
         /U0Q==
X-Gm-Message-State: AOAM533ZJgpKSacTDf7kVyQG5Udek3gk7zBiq1ikH4QQG21+SfKHtcDJ
        Bpwv5TCk3EEt+pE4AAqDyHIfo+SkdJ7dMilItFoto7+pZfk8eh2HKLNTMZe7cW2NElK33DHRIhf
        RM3DcXXSXW4c8LOPGlc6grQb6CZlfOw==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr3065440ejc.58.1636407424133;
        Mon, 08 Nov 2021 13:37:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwggCTHuAs6/e1qJtiY7ocyLJ1iAsRRcv0IHEVcL9Q30CSvdPNvpdwhHC7Ub5R8GN4orlTDxg==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr3065420ejc.58.1636407423908;
        Mon, 08 Nov 2021 13:37:03 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id e7sm10477460edk.3.2021.11.08.13.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:37:03 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:37:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 59/59] libperf: Add parse-events test
Message-ID: <YYmYfRICcezZwBBU@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-60-jolsa@kernel.org>
 <CAP-5=fXgNKGwiF-HnSrC6S6LKm1qQw66wjEx=0pGELLCcDcfrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXgNKGwiF-HnSrC6S6LKm1qQw66wjEx=0pGELLCcDcfrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:32:57AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding parse-events test.
> 
> Fwiw, we fuzz test this code but filter out strings containing .bpf.,
> .o or .c to avoid the fuzzer turning into an LLVM fuzzer. This
> refactoring will solve some linking issues we have. Perhaps we can set
> up fuzz testing here?

sounds good, also this could change to the kunit style you do
for perf test.. and perhaps included in 'perf test' invocation

jirka

> 
> Thanks,
> Ian
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/tests/Build               |  1 +
> >  tools/lib/perf/tests/main.c              |  1 +
> >  tools/lib/perf/tests/test-evlist.c       |  2 ++
> >  tools/lib/perf/tests/test-parse-events.c | 41 ++++++++++++++++++++++++
> >  tools/lib/perf/tests/tests.h             |  1 +
> >  5 files changed, 46 insertions(+)
> >  create mode 100644 tools/lib/perf/tests/test-parse-events.c
> >
> > diff --git a/tools/lib/perf/tests/Build b/tools/lib/perf/tests/Build
> > index 56e81378d443..f1d1133d8dae 100644
> > --- a/tools/lib/perf/tests/Build
> > +++ b/tools/lib/perf/tests/Build
> > @@ -3,3 +3,4 @@ tests-y += test-evsel.o
> >  tests-y += test-evlist.o
> >  tests-y += test-cpumap.o
> >  tests-y += test-threadmap.o
> > +tests-y += test-parse-events.o
> > diff --git a/tools/lib/perf/tests/main.c b/tools/lib/perf/tests/main.c
> > index 56423fd4db19..bfa8ba05c422 100644
> > --- a/tools/lib/perf/tests/main.c
> > +++ b/tools/lib/perf/tests/main.c
> > @@ -7,6 +7,7 @@ int tests_verbose;
> >
> >  int main(int argc, char **argv)
> >  {
> > +       __T("test parse_events", !test_parse_events(argc, argv));
> >         __T("test cpumap", !test_cpumap(argc, argv));
> >         __T("test threadmap", !test_threadmap(argc, argv));
> >         __T("test evlist", !test_evlist(argc, argv));
> > diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> > index ce91a582f0e4..199451a605a1 100644
> > --- a/tools/lib/perf/tests/test-evlist.c
> > +++ b/tools/lib/perf/tests/test-evlist.c
> > @@ -1,5 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#ifndef _GNU_SOURCE
> >  #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
> > +#endif
> >  #include <sched.h>
> >  #include <stdio.h>
> >  #include <stdarg.h>
> > diff --git a/tools/lib/perf/tests/test-parse-events.c b/tools/lib/perf/tests/test-parse-events.c
> > new file mode 100644
> > index 000000000000..5f913f82de7f
> > --- /dev/null
> > +++ b/tools/lib/perf/tests/test-parse-events.c
> > @@ -0,0 +1,41 @@
> > +#include <stdio.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/hw_breakpoint.h>
> > +#include <perf/evlist.h>
> > +#include <perf/evsel.h>
> > +#include <internal/evlist.h>
> > +#include <internal/tests.h>
> > +#include "tests.h"
> > +
> > +static int libperf_print(enum libperf_print_level level,
> > +                        const char *fmt, va_list ap)
> > +{
> > +       return vfprintf(stderr, fmt, ap);
> > +}
> > +
> > +int test_parse_events(int argc, char **argv)
> > +{
> > +       struct perf_evlist *evlist;
> > +       struct perf_evsel *evsel;
> > +       int err;
> > +
> > +       __T_START;
> > +
> > +       libperf_init(libperf_print);
> > +
> > +       evlist = perf_evlist__new();
> > +       __T("failed to create evlist", evlist);
> > +
> > +       err = libperf_parse_events(evlist, "mem:0:rw");
> > +       __T("failed to parse events", !err);
> > +
> > +       evsel = perf_evlist__first(evlist);
> > +
> > +       __T("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> > +       __T("wrong config", 0 == evsel->attr.config);
> > +       __T("wrong bp_type", (HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->attr.bp_type);
> > +       __T("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
> > +
> > +       __T_END;
> > +       return tests_failed == 0 ? 0 : -1;
> > +}
> > diff --git a/tools/lib/perf/tests/tests.h b/tools/lib/perf/tests/tests.h
> > index 604838f21b2b..b4f27fc9c46d 100644
> > --- a/tools/lib/perf/tests/tests.h
> > +++ b/tools/lib/perf/tests/tests.h
> > @@ -6,5 +6,6 @@ int test_cpumap(int argc, char **argv);
> >  int test_threadmap(int argc, char **argv);
> >  int test_evlist(int argc, char **argv);
> >  int test_evsel(int argc, char **argv);
> > +int test_parse_events(int argc, char **argv);
> >
> >  #endif /* TESTS_H */
> > --
> > 2.31.1
> >
> 

