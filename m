Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C20C3F6B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Aug 2022 17:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351015AbiHSRp5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354816AbiHSRpd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Aug 2022 13:45:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9689C2F6
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Aug 2022 10:09:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u14so5863883wrq.9
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Aug 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9jGXV6irFv8tEA+MQJNoWRqDdQzGDrEVYtPdlAW1TQs=;
        b=L/XT30nIFiM56LHKBOZXY3zQ+ZPUuM9yPuPXlMYNgcfcjn11RoQE+etbYMg7NFke+b
         sttmOBp4Lp37YiQz0zuBVE5O5B8FhhYtHCQBTjxwgs4mk+hHOCEk2OyrMgtyHC46AZyM
         bb2r3ysqR61QdbeEmmJKvMt1tf4+9ThQ4xW3AhuqIo1uF3K6/q4yKsN6nOZJ5C6ZoBp9
         FGfRuZeJ2YgXD8xSvlBkY0E86T3wQ8KHye7vOkpoxR0mJqAZfkXadf0eUyTjAZ53C7JD
         hVG1rQdkdWANBqXSxphUrZi/mhtHrzOhQXUQTDJVm6zgzm6etfw+Siew+3RS2pxxjx4k
         I+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9jGXV6irFv8tEA+MQJNoWRqDdQzGDrEVYtPdlAW1TQs=;
        b=Q6mwE3lqePDB0UP7uc6KvfBadoLo+A6/qJZVNy5nJtBgqfOV2e7I8gv1yLFbU6+Sv0
         laXJIHNrVXKTT1TMal15KXrL1xDJuAev0hReD7Vo836eS5dK6Ckmzb/LNXwCvbuGe5xO
         R2SgIBCmVTS+KVOt5xPL5CbXZN6zfy/cFl8ewjfK7gATIyPT41h+d4wL93VAsjw7xG4i
         772dWh/aAokaIxIYIpe6805BYUU8PDfn4pGS5nDcYRLAX3+cH/JS7kZTQUoGRDFA08Ec
         IOrsS3KqqjQPk0XY4ZVzZeP0guOoNm6UTmUE0Oawl2AdcwhaEgE0jOA7GnALTFY/Kt/5
         IN1Q==
X-Gm-Message-State: ACgBeo1B9fTn86gGHJenM3w1T0KsRRfvF26n0DG1lXpvT5uwGSUsIHgk
        j4ejXUi92c8V57U40eO+O0Y8CsfYQPhNhYvlWEUpyw==
X-Google-Smtp-Source: AA6agR5vPFSxtmNEOb+pTiBVPFNpYpVro0zHK9u/uW6xptEGpEyLj+JknCqkTcOg0b76QOpxdvQf7ugm7u+jcYB1adI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr4633062wri.300.1660928961862; Fri, 19
 Aug 2022 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com>
 <Yv60COAP90TEiWkx@kernel.org> <Yv+zK8UxUAP83zkp@kernel.org>
In-Reply-To: <Yv+zK8UxUAP83zkp@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 19 Aug 2022 10:09:09 -0700
Message-ID: <CAP-5=fWi5KaV40jcC1ZGfTAJ+bc52ueMvd0yREUHxSYk7y1MNw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 19, 2022 at 8:58 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Aug 18, 2022 at 06:50:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers escreveu:
> > > A mask encoding of a cpu map is laid out as:
> > >   u16 nr
> > >   u16 long_size
> > >   unsigned long mask[];
> > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > being at different offsets. On top of this the structure is in the byte
> > > data[] encoded as:
> > >   u16 type
> > >   char data[]
> > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > is offset by 2. Consequently the long reads and writes are causing
> > > undefined behavior as the alignment is broken.
> > >
> > > Fix the mask struct by creating explicit 32 and 64-bit variants, use a
> > > union to avoid data[] and casts; the struct must be packed so the
> > > layout matches the existing perf.data layout. Taking an address of a
> > > member of a packed struct breaks alignment so pass the packed
> > > perf_record_cpu_map_data to functions, so they can access variables with
> > > the right alignment.
> > >
> > > As the 64-bit version has 4 bytes of padding, optimizing writing to only
> > > write the 32-bit version.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/perf/include/perf/event.h | 36 +++++++++++--
> > >  tools/perf/tests/cpumap.c           | 19 ++++---
> > >  tools/perf/util/cpumap.c            | 80 +++++++++++++++++++++++------
> > >  tools/perf/util/cpumap.h            |  4 +-
> > >  tools/perf/util/session.c           | 30 +++++------
> > >  tools/perf/util/synthetic-events.c  | 34 +++++++-----
> > >  6 files changed, 143 insertions(+), 60 deletions(-)
> > >
> > > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > > index e7758707cadd..d2d32589758a 100644
> > > --- a/tools/lib/perf/include/perf/event.h
> > > +++ b/tools/lib/perf/include/perf/event.h
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/limits.h>
> > >  #include <linux/bpf.h>
> > > +#include <linux/compiler.h>
> > >  #include <sys/types.h> /* pid_t */
> > >
> > >  #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
> > > @@ -153,20 +154,47 @@ enum {
> > >     PERF_CPU_MAP__MASK = 1,
> > >  };
> > >
> > > +/*
> > > + * Array encoding of a perf_cpu_map where nr is the number of entries in cpu[]
> > > + * and each entry is a value for a CPU in the map.
> > > + */
> > >  struct cpu_map_entries {
> > >     __u16                    nr;
> > >     __u16                    cpu[];
> > >  };
> > >
> > > -struct perf_record_record_cpu_map {
> > > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 32-bit. */
> > > +struct perf_record_mask_cpu_map32 {
> > > +   /* Number of mask values. */
> > >     __u16                    nr;
> > > +   /* Constant 4. */
> > >     __u16                    long_size;
> > > -   unsigned long            mask[];
> > > +   /* Bitmap data. */
> > > +   __u32                    mask[];
> > >  };
> > >
> > > -struct perf_record_cpu_map_data {
> > > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 64-bit. */
> > > +struct perf_record_mask_cpu_map64 {
> > > +   /* Number of mask values. */
> > > +   __u16                    nr;
> > > +   /* Constant 8. */
> > > +   __u16                    long_size;
> > > +   /* Legacy padding. */
> > > +   char                     __pad[4];
> > > +   /* Bitmap data. */
> > > +   __u64                    mask[];
> > > +};
> > > +
> > > +struct __packed perf_record_cpu_map_data {
> >
> > In various places I'm getting this:
> >
> > [perfbuilder@five x-riscv]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.0.0-rc1.tar.xz
> > [perfbuilder@five x-riscv]$ time dm .
> >    1     5.47 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-16ubuntu1)
> >     In file included from mmap.c:10:
> >     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
> >       190 |         __u16                    type;
> >           |                                  ^~~~
> >     cc1: all warnings being treated as errors
> >     In file included from util/event.h:12,
> >                      from builtin-diff.c:12:
> >     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
> >       190 |         __u16                    type;
> >           |                                  ^~~~
> >     In file included from util/events_stats.h:6,
> >                      from util/evlist.h:12,
> >                      from builtin-evlist.c:11:
> >     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
> >       190 |         __u16                    type;
> >           |                                  ^~~~
> >
> > So probably we need to disable this -Werror=attributes in some
> > architectures?
>
> Slapped this there:
>
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wpacked"
> #pragma GCC diagnostic ignored "-Wattributes"
>
> struct __packed perf_record_cpu_map_data {
>         __u16                    type;
>         union {
>                 /* Used when type == PERF_CPU_MAP__CPUS. */
>                 struct cpu_map_entries cpus_data;
>                 /* Used when type == PERF_CPU_MAP__MASK and long_size == 4. */
>                 struct perf_record_mask_cpu_map32 mask32_data;
>                 /* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
>                 struct perf_record_mask_cpu_map64 mask64_data;
>         };
> };
>
> #pragma GCC diagnostic pop

Perhaps we should also carry a comment like:
perf_record_cpu_map_data is packed as unfortunately an earlier version
had unaligned data and we wish to retain file format compatibility.

Thanks,
Ian
