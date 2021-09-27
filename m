Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C7C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 16:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A39C60F9B
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 16:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhI0QKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhI0QKq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 12:10:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8DC061604
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Sep 2021 09:09:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z184so3075642iof.5
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Sep 2021 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vc+zXBZcx2Ulgt6pXjf3XypqL9z/VF6lQ4TfQOQtTCY=;
        b=CRt0TwDG0+o0s1CsN33EryD3AvRgFqaJBkrH6TZZZLgrVCDMViNPDrd/oCMAgxQ4b0
         9w0UOpSH1Znd4y+oXjqKRdAGnQ7iffcFU2Tbp0xal8yD72Qdms79fPxO4vfiBFIsJpJ6
         L8v1JBvfbNR6JZiE0BekbbSXzR7JJqax1Mw1K3utQQKOna6DVPePllASQFn9aU2IQf5N
         sC4Iqp8V2T7iWUT+V2xsyVAxr3sWZryJGK0/RjDJ6ZbJmrDs4y4+VKq6eJtJZT8iV9z1
         RFkLRxp+gnqEgX4vwKaosGhPKh72BCJBJ9xpdIqZx3CW2vJnC8vVO57JMUcN2KEMCwvT
         Ox8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vc+zXBZcx2Ulgt6pXjf3XypqL9z/VF6lQ4TfQOQtTCY=;
        b=ZHt6/hsfDDYDiqoUo5X7MqgPMm48LtaIDzNFAMicGxZjxj3u3QXy0dq6vT2tjeX49A
         Uu2kQpzLu7XBke56gnpW6Oxv1EDrqUw+x+KKnu/pcD99J6A0eWCo6ee6wlWalCAN3DWK
         T1sokakaISoxoNhg7ZS0rUFY7btKBBtPEte+M0KtV36be+E/QlBDzl1OXlzeqnP1BfH0
         93LRMM6iBbEW9Cs0K/Z8MeYoSD34b3VmyF8Vi1kKG1eG6JTK0bHwrSvepMl5SjCBtT3W
         Legnf2WaV6w7hvKBoDDmx7ulV8h8McF0ZUhYxV71t1IXMkMqBfQ7pZQEkVuFAPH/njKy
         ON1Q==
X-Gm-Message-State: AOAM533SyOen+O4krUsy3D4bfimDkQfzq63xmViTsHbL3TegwRqogrH+
        EoRxkeEbZyfRpbR2TOZ3gtLjbiuYhaL571yC5poVkg==
X-Google-Smtp-Source: ABdhPJx9puvb69nErQaUTacccrt0TiZJlHPdr5bJip7+DUjuSkQYl5mvjKF93b/W+LgVteaQ1QjUwY3UyGFj9rnIcCw=
X-Received: by 2002:a05:6638:1929:: with SMTP id p41mr615306jal.21.1632758947491;
 Mon, 27 Sep 2021 09:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com> <20210922081959.390059-4-irogers@google.com>
 <YVDiMDoD2dr312KY@krava>
In-Reply-To: <YVDiMDoD2dr312KY@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Sep 2021 09:08:53 -0700
Message-ID: <CAP-5=fWONeXLa=r4uJ1TM4K+E1moBMrV29LzfbciTfVVHvorsA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] perf test: Make each test/suite its own struct.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Sep 26, 2021 at 2:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 01:19:56AM -0700, Ian Rogers wrote:
> > By switching to an array of pointers to tests (later to be suites)
> > the definition of the tests can be moved to the file containing the
> > tests.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/include/arch-tests.h     |   2 +-
> >  tools/perf/arch/arm/tests/arch-tests.c       |  21 +-
> >  tools/perf/arch/arm64/include/arch-tests.h   |   2 +-
> >  tools/perf/arch/arm64/tests/arch-tests.c     |  15 +-
> >  tools/perf/arch/powerpc/include/arch-tests.h |   2 +-
> >  tools/perf/arch/powerpc/tests/arch-tests.c   |  15 +-
> >  tools/perf/arch/x86/include/arch-tests.h     |   2 +-
> >  tools/perf/arch/x86/tests/arch-tests.c       |  47 ++--
> >  tools/perf/tests/builtin-test.c              | 273 ++++++++++++-------
> >  tools/perf/tests/tests.h                     |   6 +
> >  10 files changed, 220 insertions(+), 165 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
> > index c62538052404..37039e80f18b 100644
> > --- a/tools/perf/arch/arm/include/arch-tests.h
> > +++ b/tools/perf/arch/arm/include/arch-tests.h
> > @@ -2,6 +2,6 @@
> >  #ifndef ARCH_TESTS_H
> >  #define ARCH_TESTS_H
> >
> > -extern struct test arch_tests[];
> > +extern struct test *arch_tests[];
> >
> >  #endif
> > diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
> > index 6848101a855f..4374b0293177 100644
> > --- a/tools/perf/arch/arm/tests/arch-tests.c
> > +++ b/tools/perf/arch/arm/tests/arch-tests.c
> > @@ -3,18 +3,15 @@
> >  #include "tests/tests.h"
> >  #include "arch-tests.h"
> >
> > -struct test arch_tests[] = {
> >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > -     {
> > -             .desc = "DWARF unwind",
> > -             .func = test__dwarf_unwind,
> > -     },
> > +DEFINE_SUITE("DWARF unwind", dwarf_unwind);
>
> why not having this and other in here DEFINE_SUITE in
> tests/dwarf-unwind.c ? it seems to get compiled in only
> for supported arch

Not sure I follow. In these changes I've just tried to move things
around without changing the logic behind things. This sounds like a
sensible follow up clean up.

Thanks,
Ian

> jirka
>
> >  #endif
> > -     {
> > -             .desc = "Vectors page",
> > -             .func = test__vectors_page,
> > -     },
> > -     {
> > -             .func = NULL,
> > -     },
> > +DEFINE_SUITE("Vectors page", vectors_page);
> > +
> > +struct test *arch_tests[] = {
> > +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> > +     &dwarf_unwind,
> > +#endif
> > +     &vectors_pages,
> > +     NULL,
> >  };
>
> SNIP
>
