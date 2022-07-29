Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF46C00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 02:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiG2CBZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiG2CBY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 22:01:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92A78DFA
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 19:01:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so118957wru.8
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKo8b4je0iqGq0uiZqH7zNlb83Vh1FNB/a+r4AK80T8=;
        b=qh/wY2GLSdmFq98iuNUcPy+KISCMDt6bBos/1GYLClu9zYRT/nXaP5i+OJ8hXmfVO6
         UXskbmrAJp4z/3BdcnKPVmml7oVvCQ7bXKvfMOYp9kt2psTEm3gGWndKuoWJzn4nq/Xr
         RO77QEI12dSndxUphWJJYr6AR2gmPIa4wKvB286Z92abF3FDI/bREF0n1EK7gZ20GbXk
         j+C1LiRus03zDSAWa5zspECdBRh0egOKxK4KH0/Y9Jsl5mnGCa8EOl1u2pYUJf3Tcwtt
         zzhJVyewPd6rv6b9xZvVXMMAGskp7iBeqCnx2dmhiyMaX/9z7WZyyfn9xEDHdsKfyzVu
         mURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKo8b4je0iqGq0uiZqH7zNlb83Vh1FNB/a+r4AK80T8=;
        b=lHERMzHJFgwYblRxcO7YaTmx+9ciPr7rYkI6Qt5SfUm0A6tIWESTzgWx00TtdL4OjA
         sPCjk5Pvx4NcoqbbP6TPbgdmBoTsFXiazHGXKjwR5e28fnLTunxUTaTDPK68lbXu2XRP
         J3rmA88gEfcqL31kZ7JFj8aWfO8lEPcDmIx/Cb/TQl37ontpP76C41bv4wkuc2DbVnzD
         AnZTeoAB46WecZLy6TIbzz+07NpfCHBOmkJHCz3VJIb+tBDxHsQfwFQmceyzEDlLrK/Q
         HgEpnLfRGZpojLPKQIBphzVTe1iBATeoBP9qOkzQnMxuTWhRgV8po4x3815LHPXfgCuJ
         uRvw==
X-Gm-Message-State: ACgBeo3f2r6yk55xnAnkIT3YjqE4Xz7v2KcpqqWtkdg+G6hOq4vngna7
        G3ULuIgO3pXg0cQfr5GtKJHv5z2VhAC6XaaHTSk6Ng==
X-Google-Smtp-Source: AA6agR5cPNsIfML6yyQKPbDjRDBRwyuxiIL3O1NzD4HMAqamz2pbk6MDyllQ67IBlyD/TQOOtay5gTHQrQvjOVSig1Y=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr824800wri.343.1659060081456; Thu, 28
 Jul 2022 19:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
In-Reply-To: <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 Jul 2022 19:01:09 -0700
Message-ID: <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
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
> > These changes do minor clean up with const, visibility of functions
> > and using the constant time max function. It then adds 32 and 64-bit
> > mask encoding variants, packed to match current alignment. Taking the
> > address of a packed struct leads to unaligned data, so function
> > arguments are altered to be passed the packed struct. To compact the
> > mask encoding further and drop the padding, the 4-byte variant is
> > preferred. Finally a new range encoding is added, that reduces the
> > size of the common case of a range of CPUs to a single u64.
> >
> > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > 0x9a98 [0x28]: event: 74
> > .
> > . ... raw event: size 40 bytes
> > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > .  0020:  00 00 00 00 00 00 00 00                          ........
> >
> > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> >
> > Using the 4-byte encoding it is:
> > 0x9a98@pipe [0x20]: event: 74
> > .
> > . ... raw event: size 32 bytes
> > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> >
> > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> >
> > Finally, with the range encoding it is:
> > 0x9ab8@pipe [0x10]: event: 74
> > .
> > . ... raw event: size 16 bytes
> > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> >
> > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> >
> > v2. Fixes a bug in the size computation of the update header
> >     introduced by the last patch (Add range data encoding) and caught
> >     by address sanitizer.
> >
> > Ian Rogers (6):
> >   perf cpumap: Const map for max
> >   perf cpumap: Synthetic events and const/static
> >   perf cpumap: Compute mask size in constant time
> >   perf cpumap: Fix alignment for masks in event encoding
> >   perf events: Prefer union over variable length array
> >   perf cpumap: Add range data encoding
>
> Ping. There was some feedback on this change but nothing to create a
> v3. Feedback/acked-by/reviewed-by appreciated.

Ping. Feedback appreciated.

Thanks,
Ian

> Thanks,
> Ian
>
> >  tools/lib/perf/cpumap.c              |   2 +-
> >  tools/lib/perf/include/perf/cpumap.h |   2 +-
> >  tools/lib/perf/include/perf/event.h  |  61 ++++++++-
> >  tools/perf/tests/cpumap.c            |  71 ++++++++---
> >  tools/perf/tests/event_update.c      |  14 +--
> >  tools/perf/util/cpumap.c             | 111 +++++++++++++---
> >  tools/perf/util/cpumap.h             |   4 +-
> >  tools/perf/util/event.h              |   4 -
> >  tools/perf/util/header.c             |  24 ++--
> >  tools/perf/util/session.c            |  35 +++---
> >  tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
> >  tools/perf/util/synthetic-events.h   |   2 +-
> >  12 files changed, 327 insertions(+), 185 deletions(-)
> >
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
