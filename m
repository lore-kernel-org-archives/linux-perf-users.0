Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E77C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4CB60F4A
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 18:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2SZJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhG2SZJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 14:25:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEDC0613C1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jul 2021 11:25:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p5so8057934wro.7
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jul 2021 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AumX38cXF00xtMIpucm+lzY/I9660Bm036WY8hFLp9U=;
        b=QhFdNty21/armeGkmZ2C3PRXaz6vcCnpsyLUnRbyHIi9lnQU2YPuxgUdNaOP6FTzWV
         0jerIkkvRsfYdBua3a/nwjZpfsznmXpvpiFZoVZMOWA0SNmYo+9zFIBcjEKKvDwl9Brm
         fB4jxT37kPUh/WBcpvP2XpzRJZsDGjv/SOzWXdAc3zRyNWRWer6XzEskPO0OHNDkUhAT
         54bWGCREFNrXAQrAp5VnVxlBvI+1ls30iswdrzm/p+PsYPvSFt6wXuHsR+HVmffT1bY+
         8KFbzW5YfQ7CWOOiDZaQ7cQQlpMc5FTsOg9Lrof6aMqUhKWaSvnbXEtZKsNQ2zc/iVVn
         eE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AumX38cXF00xtMIpucm+lzY/I9660Bm036WY8hFLp9U=;
        b=YDuB1/OlK2N1GnoBaO+w8+/s6jn1N9Dd9LKebODqTz4IzSEXjhBolLBVf4Kit5zoSX
         hRUFL8QlCJ+8is04k/kLdRw11CDZpAjepjlkq8SmgaOFCYEdV7F8r/hN3gh7mRjOjDPk
         CqW+Qcl/qZW7QALHbgKzEVyuzOrM8E2zqmrSTwOx8aeXVjGmVxN0B+oLSEaVzsp+2+Tl
         h8ah/aEfl8oDA/P8qQaqY6InnZyE8zWxVW2yrTn10LsZk2BBm+uY08LLcD1J33IL99pD
         LMswkufYc5i/tgkdFYew0XPsrdOuPwoTT2KtAKY/PUAjPXk9UsAvFFHXlvOSKuCY3fbx
         QJHg==
X-Gm-Message-State: AOAM532RqmKouVfKyZcoXIh42mE+lipsUN+MFU3Z0Sqx+lvAex4dZM9z
        6RQVBLvwcr/NBbYNN1mczETOoi3O/iAw5zG5CVx8Sg==
X-Google-Smtp-Source: ABdhPJyAmZqzPdf6+B50m6AE3DjxSVEfgWAHBy/0BM9u3lLqDWSAeRxRVD951u6m4pcVy0GK8NcIQp/G4LZpUI7/F/I=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr6478749wrn.262.1627583104156;
 Thu, 29 Jul 2021 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210729062451.1349566-1-irogers@google.com> <20210729062451.1349566-4-irogers@google.com>
 <cb2ebcbb2ea963169823ad052be8ebf9290cc97b.camel@gmail.com>
In-Reply-To: <cb2ebcbb2ea963169823ad052be8ebf9290cc97b.camel@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Jul 2021 11:24:52 -0700
Message-ID: <CAP-5=fV6E5BOSdxOBYCW3KyfgbpxMzHoUh1juxxm5s3tX9Mg-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf test: Be more consistent in use of TEST_*
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 29, 2021 at 6:41 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi Ian,
>
> On Wed, 2021-07-28 at 23:24 -0700, Ian Rogers wrote:
> > The TEST_OK, TEST_FAIL and TEST_SKIP enum values are used
> > inconsistently. Try to reduce this by swapping constants for enum values
> > to try to be more intention revealing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/tests/rdpmc.c           |   8 +-
> >  tools/perf/tests/attr.c                     |   2 +-
> >  tools/perf/tests/bitmap.c                   |   2 +-
> >  tools/perf/tests/bp_account.c               |   4 +-
> >  tools/perf/tests/bp_signal.c                |  51 +++++++--
> >  tools/perf/tests/code-reading.c             |  12 +-
> >  tools/perf/tests/cpumap.c                   |  10 +-
> >  tools/perf/tests/dso-data.c                 |   8 +-
> >  tools/perf/tests/dwarf-unwind.c             |  14 ++-
> >  tools/perf/tests/event-times.c              |   2 +-
> >  tools/perf/tests/evsel-roundtrip-name.c     |  14 +--
> >  tools/perf/tests/evsel-tp-sched.c           |  28 ++---
> >  tools/perf/tests/expr.c                     |   4 +-
> >  tools/perf/tests/fdarray.c                  |   4 +-
> >  tools/perf/tests/genelf.c                   |   2 +-
> >  tools/perf/tests/hists_cumulate.c           |   2 +-
> >  tools/perf/tests/hists_filter.c             |  12 +-
> >  tools/perf/tests/hists_link.c               |  33 +++---
> >  tools/perf/tests/keep-tracking.c            |   4 +-
> >  tools/perf/tests/kmod-path.c                |   6 +-
> >  tools/perf/tests/mem.c                      |   4 +-
> >  tools/perf/tests/mem2node.c                 |   2 +-
> >  tools/perf/tests/mmap-basic.c               |  10 +-
> >  tools/perf/tests/mmap-thread-lookup.c       |   2 +-
> >  tools/perf/tests/openat-syscall-all-cpus.c  |   4 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c |   4 +-
> >  tools/perf/tests/openat-syscall.c           |   6 +-
> >  tools/perf/tests/parse-events.c             | 118 ++++++++++----------
> >  tools/perf/tests/parse-metric.c             |  16 +--
> >  tools/perf/tests/parse-no-sample-id-all.c   |   4 +-
> >  tools/perf/tests/perf-hooks.c               |   2 +-
> >  tools/perf/tests/perf-record.c              |   2 +-
> >  tools/perf/tests/perf-time-to-tsc.c         |   4 +-
> >  tools/perf/tests/pfm.c                      |   4 +-
> >  tools/perf/tests/pmu-events.c               |  36 +++---
> >  tools/perf/tests/pmu.c                      |  16 +--
> >  tools/perf/tests/python-use.c               |   2 +-
> >  tools/perf/tests/sample-parsing.c           |  10 +-
> >  tools/perf/tests/stat.c                     |  12 +-
> >  tools/perf/tests/sw-clock.c                 |   8 +-
> >  tools/perf/tests/switch-tracking.c          |   9 +-
> >  tools/perf/tests/task-exit.c                |  12 +-
> >  tools/perf/tests/tests.h                    |   4 +-
> >  tools/perf/tests/thread-map.c               |   8 +-
> >  tools/perf/tests/thread-maps-share.c        |   2 +-
> >  tools/perf/tests/time-utils-test.c          |   2 +-
> >  tools/perf/tests/topology.c                 |   2 +-
> >  tools/perf/tests/vmlinux-kallsyms.c         |   6 +-
> >  tools/perf/tests/wp.c                       |  10 +-
> >  49 files changed, 292 insertions(+), 251 deletions(-)
> >
> <SNIP>
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> > index 9866cddebf23..70e92e074dba 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -725,20 +725,20 @@ int test__code_reading(struct test *test __maybe_unused,
> > int subtest __maybe_unu
> >
> >         switch (ret) {
> >         case TEST_CODE_READING_OK:
> > -               return 0;
> > +               return TEST_OK;
> >         case TEST_CODE_READING_NO_VMLINUX:
> >                 pr_debug("no vmlinux\n");
> > -               return 0;
> > +               return TEST_SKIP;
> >         case TEST_CODE_READING_NO_KCORE:
> >                 pr_debug("no kcore\n");
> > -               return 0;
> > +               return TEST_SKIP;
> >         case TEST_CODE_READING_NO_ACCESS:
> >                 pr_debug("no access\n");
> > -               return 0;
> > +               return TEST_SKIP;
> >         case TEST_CODE_READING_NO_KERNEL_OBJ:
> >                 pr_debug("no kernel obj\n");
> > -               return 0;
> > +               return TEST_SKIP;
> >         default:
> > -               return -1;
> > +               return TEST_FAIL;
> >         };
> >  }
>
>
> I think it's better to separate changes that do not change the current behaviour
> from these changes (0 -> TEST_SKIP) into different patches.

Ack. This is the only case of this I see as TEST_OK would contradict
the debug output. There are also cases where I've swapped things like
-ENOMEM or -EINVAL for TEST_FAIL for things that generally won't
happen like malloc failures - the test calling function doesn't handle
-ENOMEM. Separating all of these out into CLs is work I'd prefer to
avoid, but I agree it makes just eye-balling this as a substitution CL
hard.

Thanks,
Ian

> Riccardo
>
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index 0472b110fe65..bfcb85a965bb 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -42,7 +42,7 @@ static int process_event_mask(struct perf_tool *tool
> > __maybe_unused,
> >         }
> >
> >         perf_cpu_map__put(map);
> > -       return 0;
> > +       return TEST_OK;
> >  }
> >
> >  static int process_event_cpus(struct perf_tool *tool __maybe_unused,
> > @@ -71,7 +71,7 @@ static int process_event_cpus(struct perf_tool *tool
> > __maybe_unused,
> >         TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
> >         TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
> >         perf_cpu_map__put(map);
> > -       return 0;
> > +       return TEST_OK;
> >  }
> >
> >
> > @@ -94,7 +94,7 @@ int test__cpu_map_synthesize(struct test *test
> > __maybe_unused, int subtest __may
> >                 !perf_event__synthesize_cpu_map(NULL, cpus,
> > process_event_cpus, NULL));
> >
> >         perf_cpu_map__put(cpus);
> > -       return 0;
> > +       return TEST_OK;
> >  }
> >
> >  static int cpu_map_print(const char *str)
> > @@ -120,7 +120,7 @@ int test__cpu_map_print(struct test *test __maybe_unused,
> > int subtest __maybe_un
> >         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-
> > 10,24,35-37"));
> >         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-
> > 10,24,35-37"));
> >         TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-
> > 30,32-40"));
> > -       return 0;
> > +       return TEST_OK;
> >  }
> >
> >  int test__cpu_map_merge(struct test *test __maybe_unused, int subtest
> > __maybe_unused)
> > @@ -135,5 +135,5 @@ int test__cpu_map_merge(struct test *test __maybe_unused,
> > int subtest __maybe_un
> >         TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-
> > 2,4-5,7"));
> >         perf_cpu_map__put(b);
> >         perf_cpu_map__put(c);
> > -       return 0;
> > +       return TEST_OK;
> >  }
> <SNIP>
>
