Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC82C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 17:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiGORBx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiGORBv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 13:01:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0046823A8
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Jul 2022 10:01:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o8so3154861wms.2
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Jul 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsymxV+5M24pPXH3QqQTNrAk6PRXpSjbDyG398pyk64=;
        b=PaXFRqZbS2vYPwidy+gX7fEd/Iz7nWSXaBdLxtE9h5WXaFeqYEWHPyu+jRlMA4k2op
         xDpCtZ1js6OEfv4SXZtldXyXuBYP/n6dDjhT8WeaM9GeYP/HRLqm1iAuOEZk53gFAD55
         Q5CBXBBuNf0BtoIKBW+g+tz1M5yWHoxefZeqv+c7s1U55CF/Yc8hbostSdxWYhzL07J5
         zzgwLjaSlqPgNbvtMQ03GI5ONQk+aJUCgSLYJKkEs+5+CemeTIfhCpLTntSKBZPYr4Y3
         9AGbsXq6H0eV+NskTVHfa2esu4/u+L0WQIE2nnT05HEXEwUB+6jEOvyIt/n9o+A7GJ9T
         YI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsymxV+5M24pPXH3QqQTNrAk6PRXpSjbDyG398pyk64=;
        b=lLgibQODLj4TOol4SLYoODxmXX6WcP7+9+PvTYbPSR+zrs+PbTY6ocPItIF5OqoEyv
         QoYiGLKACjGJRKu6cIx+qOsgpyL6Z4Y5fJzvuGj1BhvuVueOE8iefyQy8hUg3Fqx8EK/
         rJcGqk4D7ma5RrwYpPKV5HILLXwMvh0DH3Yv2pqdDRIsHdAhLInz9FLN6ScYwLEtHATC
         Y8oVmf9YI7AC/TeWL1knD7A5EoU3/tCCw/E+PjYPjNHVH5GYrX/Zo24++G8U8jXRnec8
         oY6ncI4+bIsi80Bl5bplkrp38QwWY/R304rwdGf16hVAQE7Im6PefP3GEwhwmYt6yMhN
         2pVA==
X-Gm-Message-State: AJIora/C4qSKsU0pJBQ/7rNspgdwGcfGyEVA6YsxiusRombEayYN033W
        KHob6Z6T41BrXhxS4IrFQeS8+/EchRyDNuAYs/VRWA==
X-Google-Smtp-Source: AGRyM1tZC04VmHLDoxsvJLcToSlBUAqYu0jlNwClIZndRX/isibUmuJZVXTzMIm7vOObJfxkqbLQ5pc2YkqvR+C7ffA=
X-Received: by 2002:a05:600c:4e8f:b0:3a1:8b21:ebbc with SMTP id
 f15-20020a05600c4e8f00b003a18b21ebbcmr15406013wmq.149.1657904509095; Fri, 15
 Jul 2022 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Jul 2022 10:01:36 -0700
Message-ID: <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
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

On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
>
> A mask encoding of a cpu map is laid out as:
>   u16 nr
>   u16 long_size
>   unsigned long mask[];
> However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> after long_size. This means 32-bit and 64-bit builds see the mask as
> being at different offsets. On top of this the structure is in the byte
> data[] encoded as:
>   u16 type
>   char data[]
> This means the mask's struct isn't the required 4 or 8 byte aligned, but
> is offset by 2. Consequently the long reads and writes are causing
> undefined behavior as the alignment is broken.
>
> These changes do minor clean up with const, visibility of functions
> and using the constant time max function. It then adds 32 and 64-bit
> mask encoding variants, packed to match current alignment. Taking the
> address of a packed struct leads to unaligned data, so function
> arguments are altered to be passed the packed struct. To compact the
> mask encoding further and drop the padding, the 4-byte variant is
> preferred. Finally a new range encoding is added, that reduces the
> size of the common case of a range of CPUs to a single u64.
>
> On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> 0x9a98 [0x28]: event: 74
> .
> . ... raw event: size 40 bytes
> .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> .  0020:  00 00 00 00 00 00 00 00                          ........
>
> 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
>
> Using the 4-byte encoding it is:
> 0x9a98@pipe [0x20]: event: 74
> .
> . ... raw event: size 32 bytes
> .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
>
> 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
>
> Finally, with the range encoding it is:
> 0x9ab8@pipe [0x10]: event: 74
> .
> . ... raw event: size 16 bytes
> .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
>
> 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
>
> v2. Fixes a bug in the size computation of the update header
>     introduced by the last patch (Add range data encoding) and caught
>     by address sanitizer.
>
> Ian Rogers (6):
>   perf cpumap: Const map for max
>   perf cpumap: Synthetic events and const/static
>   perf cpumap: Compute mask size in constant time
>   perf cpumap: Fix alignment for masks in event encoding
>   perf events: Prefer union over variable length array
>   perf cpumap: Add range data encoding

Ping. There was some feedback on this change but nothing to create a
v3. Feedback/acked-by/reviewed-by appreciated.

Thanks,
Ian

>  tools/lib/perf/cpumap.c              |   2 +-
>  tools/lib/perf/include/perf/cpumap.h |   2 +-
>  tools/lib/perf/include/perf/event.h  |  61 ++++++++-
>  tools/perf/tests/cpumap.c            |  71 ++++++++---
>  tools/perf/tests/event_update.c      |  14 +--
>  tools/perf/util/cpumap.c             | 111 +++++++++++++---
>  tools/perf/util/cpumap.h             |   4 +-
>  tools/perf/util/event.h              |   4 -
>  tools/perf/util/header.c             |  24 ++--
>  tools/perf/util/session.c            |  35 +++---
>  tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
>  tools/perf/util/synthetic-events.h   |   2 +-
>  12 files changed, 327 insertions(+), 185 deletions(-)
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
