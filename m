Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B5CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 23:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiFNXvp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiFNXvo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 19:51:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C523E5F8
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 16:51:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q15so13139939wrc.11
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWo9Y9cWnGX30kGBP5X/TRlRx2kF6m/fLJ37TkDptlY=;
        b=VJ5tlNOSo5HPBFmnTQBV1rFyhOLi9OcQsLIGwu7MxQ2bf2wDx38xJmuxtMO8tHnTbt
         7R6WlZqcAAGxrIR+txrLdPkKNQD2x1V4L78gi8pxIh1fA2nUV6XoSe0a2DPm2hDwGEvi
         qkjbWGfXihXPChHThHEolhmsHR0TQPCbHCczGGz81FXUIxnUT+oPaHvqrZL9Pr/3jvTg
         FekAVYl8TgPChEOcGgx37b5XcHO2tbWenwm/QTJX7ZITQxzAzXb59ufhcnaIlgkC0XbQ
         8Ita2j+UQIF7l6z4Ulas13hVaS5b3ikYEkhtZ2urmRThjFfAMKdM2vcgPC91EbmISu39
         EZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWo9Y9cWnGX30kGBP5X/TRlRx2kF6m/fLJ37TkDptlY=;
        b=gcOa6ewsurHXb/LSNqOnhFnmZ1dPWoj2f6h05q/dBRsWaoCxYacr3nmTHCtgA4z/aw
         6Han8cN7y72GFTK0qCwCMonLXDL8RAfQeUOBAjbYf2rZXbzS8BRgCAiTpagNol6ZgFH+
         Qyb64AgWxR0LUrDj8ezEkIvHU6O3u5sdPyA9WuhbUX1cJSknif7Qcf+/IJQknKI5Nff+
         2Hrthb74ck5Obf9lYbiQotRDcWhQ6lJHepPkIwnJSDkaXAUMEhQ6rkiF9NVU+Bi77Qi6
         J4mQX/3DD0DDMFL9f8NgtcXtzFlkgHxabyoAvGtgK9qSJiyy6TnBx+2FzHVgfRHW5lnJ
         2F9Q==
X-Gm-Message-State: AJIora9Poje6dHcyFEyL3dPTlzkbXIfpsF7tBiB11Jz/de6ubIsCgTv8
        3sABuqYU30WMJ7IaDSF8BoOqgYPGL/DKezbCJm4cTQ==
X-Google-Smtp-Source: AGRyM1sRMDlRAPQzfTmRbenoPYPp4MOD1fGHQnK56y08iKhsY237f97DerDlr+9X+mzLTGitFhq7DxauoD9+K0L51yg=
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id
 n14-20020a5d598e000000b00219ea165a2amr7214291wri.343.1655250701192; Tue, 14
 Jun 2022 16:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com>
 <CAM9d7chXE5rvSMfRBzy1TBZ_VNMW2Tn=bD4pkOZ9=e1gdxCKTw@mail.gmail.com>
In-Reply-To: <CAM9d7chXE5rvSMfRBzy1TBZ_VNMW2Tn=bD4pkOZ9=e1gdxCKTw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 16:51:28 -0700
Message-ID: <CAP-5=fVy1cHL62v7riv3Do8S=8NNgoger4Fx+PaX0va2+wLxog@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event encoding
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        Leo Yan <leo.yan@linaro.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 14, 2022 at 3:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Tue, Jun 14, 2022 at 7:34 AM Ian Rogers <irogers@google.com> wrote:
> >
> > A mask encoding of a cpu map is laid out as:
> >   u16 nr
> >   u16 long_size
> >   unsigned long mask[];
> > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > after long_size. This means 32-bit and 64-bit builds see the mask as
> > being at different offsets. On top of this the structure is in the byte
> > data[] encoded as:
> >   u16 type
> >   char data[]
> > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > is offset by 2. Consequently the long reads and writes are causing
> > undefined behavior as the alignment is broken.
> >
> > Fix the mask struct by creating explicit 32 and 64-bit variants, use a
> > union to avoid data[] and casts; the struct must be packed so the
> > layout matches the existing perf.data layout. Taking an address of a
> > member of a packed struct breaks alignment so pass the packed
> > perf_record_cpu_map_data to functions, so they can access variables with
> > the right alignment.
> >
> > As the 64-bit version has 4 bytes of padding, optimizing writing to only
> > write the 32-bit version.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/perf/event.h | 36 +++++++++++--
> >  tools/perf/tests/cpumap.c           | 19 ++++---
> >  tools/perf/util/cpumap.c            | 80 +++++++++++++++++++++++------
> >  tools/perf/util/cpumap.h            |  4 +-
> >  tools/perf/util/session.c           | 30 +++++------
> >  tools/perf/util/synthetic-events.c  | 34 +++++++-----
> >  6 files changed, 143 insertions(+), 60 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index e7758707cadd..d2d32589758a 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/types.h>
> >  #include <linux/limits.h>
> >  #include <linux/bpf.h>
> > +#include <linux/compiler.h>
> >  #include <sys/types.h> /* pid_t */
> >
> >  #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
> > @@ -153,20 +154,47 @@ enum {
> >         PERF_CPU_MAP__MASK = 1,
> >  };
> >
> > +/*
> > + * Array encoding of a perf_cpu_map where nr is the number of entries in cpu[]
> > + * and each entry is a value for a CPU in the map.
> > + */
> >  struct cpu_map_entries {
> >         __u16                    nr;
> >         __u16                    cpu[];
> >  };
> >
> > -struct perf_record_record_cpu_map {
> > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 32-bit. */
> > +struct perf_record_mask_cpu_map32 {
> > +       /* Number of mask values. */
> >         __u16                    nr;
> > +       /* Constant 4. */
> >         __u16                    long_size;
> > -       unsigned long            mask[];
> > +       /* Bitmap data. */
> > +       __u32                    mask[];
> >  };
> >
> > -struct perf_record_cpu_map_data {
> > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 64-bit. */
> > +struct perf_record_mask_cpu_map64 {
> > +       /* Number of mask values. */
> > +       __u16                    nr;
> > +       /* Constant 8. */
> > +       __u16                    long_size;
> > +       /* Legacy padding. */
> > +       char                     __pad[4];
> > +       /* Bitmap data. */
> > +       __u64                    mask[];
> > +};
> > +
> > +struct __packed perf_record_cpu_map_data {
> >         __u16                    type;
> > -       char                     data[];
> > +       union {
> > +               /* Used when type == PERF_CPU_MAP__CPUS. */
> > +               struct cpu_map_entries cpus_data;
> > +               /* Used when type == PERF_CPU_MAP__MASK and long_size == 4. */
> > +               struct perf_record_mask_cpu_map32 mask32_data;
> > +               /* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
> > +               struct perf_record_mask_cpu_map64 mask64_data;
> > +       };
> >  };
>
> How about moving the 'type' to the union as well?
> This way we don't need to pack the entire struct
> and can have a common struct for 32 and 64 bit..
>
> struct cpu_map_entries {
>     __u16 type;
>     __u16 nr;
>     __u16 cpu[];
> };
>
> struct perf_record_mask_cpu_map {
>     __u16 type;
>     __u16 nr;
>     __u16 long_size;  // still needed?
>     __u16 pad;
>     unsigned long mask[];
> };
>
> // changed it to union
> union perf_record_cpu_map_data {
>     __u16  type;
>     struct cpu_map_entries cpus_data;
>     struct perf_record_mask_cpu_map mask_data;
> };



Thanks Namhyung,

Unfortunately this doesn't quite work as I want to make it so that the
existing cpu map encodings work with this change - ie, an old
perf.data should be readable in a newer perf with this change (the
range encoding will require that new perf.data files are read by
versions of perf with these changes). For this to work I need the
layout to match the existing unaligned code, I either need to make
mask bytes and memcpy or use an attribute like packed. Fwiw, this is a
little more efficient than the layout above as with long_size == 4 the
pad isn't necessary saving 2 bytes. I think with the packed approach
we can also add new unpacked variants like above, although I'd be keen
not to use a type that varies in size like long. I guess at some
future date we could remove the legacy supporting packed versions so
that packed or byte copying is unnecessary.

I could use a union as you show above, unfortunately that will need
the 'struct perf_record_mask_cpu_map32' and 'struct
perf_record_mask_cpu_map64' to be packed or to use bytes. We'd lose
one use of packed just to introduce two others. Potentially it is more
of a breaking change for users of this code via libperf.

These changes are something of a bug report along with fixes. If there
is a consensus that the right way to fix the bug is to break legacy
perf.data files then I'm happy to update the code accordingly (as you
show above).

Thanks,
Ian

> Thanks,
> Namhyung
