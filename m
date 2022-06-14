Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6955C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiFNOfR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354337AbiFNOeD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:03 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FE3A702
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2-20020aa78142000000b0051c394e5226so3923338pfn.19
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uLgPKTAPILHvwkAjilum0eevJYLnehve6UJqsf4Izi8=;
        b=XRnqaq3BBu4kcHFCaQTrzQTtJf+5mpcBO9zq30qHy5zWpHHeYVNsTI2VFd20e1M6U6
         tQjV9VqS8Rr3fWAOeYU2euWUJqganfd3ubcEzJYBMBRtbtE9N8ZkSFqNnAjq9/rc0r4U
         XZFGIIf/F28V0j78IwTCoWR2SedsaXrddkzCuH/bq2UK3SvSTJzuggepWFMmIINcCves
         bU32xlVNlCWWJlxyj59Ng7j5NheRiNp7Nu/YleJPcT6lPoW/Jk3+JevilJh71zyW2bja
         H2QaC0oF+9d5UMoCnaToQuFNF5pjBVjLcvbEWsq9tLaXRg2+jZjcEXQwErbqueA2w42F
         Jh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uLgPKTAPILHvwkAjilum0eevJYLnehve6UJqsf4Izi8=;
        b=Lfazorz3QVCqFIRXeG3SBSkrT9+/vRgB/ObiTLL66MN/jOTG4R9IL3pqprLXkcAbgF
         wxm9h8hMsH/ACTFBhYwJ/E7lIXnfMPFAIh2inuB59WsbzJLltgTbsdd6dgrw4f3ZH5lT
         eKVYsVNqsRPe2dWITzrcxdZYmZl2rE64w0w1mDry2paA/xcV1d9uo2nuy2YnM31McKj6
         Z21FacUJF1AOBawF1viTnrGKmKbKktvdXyY5I+xBI3xHgC1IjdNYBRPLX2yCkQIlPxxE
         zWJvXc7zCnLBlsjUzzwUkY8SIKC555gyq8ahpjDprlaVm6vPixfGK3nACx8mXKLrzFHq
         RTVQ==
X-Gm-Message-State: AOAM531AYN+gECeygn/aoG0asCRU9O0QJjrquxUHQ1AkyrMS+prAwG7N
        IgIyNu4QgGm6AdeY7ZmMgTlgH9fRiHib
X-Google-Smtp-Source: ABdhPJw1i1IaemZO8LjNZAGQeMjz7WgbdjdPxiegXBs6P0yQSdLvMDqGsUiAQYuM1wbP6WXsj7//r007dZqr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a63:a50c:0:b0:3fe:3f58:93be with SMTP id
 n12-20020a63a50c000000b003fe3f5893bemr4729935pgf.265.1655217239685; Tue, 14
 Jun 2022 07:33:59 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:47 -0700
Message-Id: <20220614143353.1559597-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 0/6] Corrections to cpu map event encoding
From:   Ian Rogers <irogers@google.com>
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A mask encoding of a cpu map is laid out as:
  u16 nr
  u16 long_size
  unsigned long mask[];
However, the mask may be 8-byte aligned meaning there is a 4-byte pad
after long_size. This means 32-bit and 64-bit builds see the mask as
being at different offsets. On top of this the structure is in the byte
data[] encoded as:
  u16 type
  char data[]
This means the mask's struct isn't the required 4 or 8 byte aligned, but
is offset by 2. Consequently the long reads and writes are causing
undefined behavior as the alignment is broken.

These changes do minor clean up with const, visibility of functions
and using the constant time max function. It then adds 32 and 64-bit
mask encoding variants, packed to match current alignment. Taking the
address of a packed struct leads to unaligned data, so function
arguments are altered to be passed the packed struct. To compact the
mask encoding further and drop the padding, the 4-byte variant is
preferred. Finally a new range encoding is added, that reduces the
size of the common case of a range of CPUs to a single u64.

On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
0x9a98 [0x28]: event: 74
.
. ... raw event: size 40 bytes
.  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
.  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
.  0020:  00 00 00 00 00 00 00 00                          ........        

0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP

Using the 4-byte encoding it is:
0x9a98@pipe [0x20]: event: 74
.
. ... raw event: size 32 bytes
.  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
.  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................

0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP

Finally, with the range encoding it is:
0x9ab8@pipe [0x10]: event: 74
.
. ... raw event: size 16 bytes
.  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.

0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP

v2. Fixes a bug in the size computation of the update header
    introduced by the last patch (Add range data encoding) and caught
    by address sanitizer.

Ian Rogers (6):
  perf cpumap: Const map for max
  perf cpumap: Synthetic events and const/static
  perf cpumap: Compute mask size in constant time
  perf cpumap: Fix alignment for masks in event encoding
  perf events: Prefer union over variable length array
  perf cpumap: Add range data encoding

 tools/lib/perf/cpumap.c              |   2 +-
 tools/lib/perf/include/perf/cpumap.h |   2 +-
 tools/lib/perf/include/perf/event.h  |  61 ++++++++-
 tools/perf/tests/cpumap.c            |  71 ++++++++---
 tools/perf/tests/event_update.c      |  14 +--
 tools/perf/util/cpumap.c             | 111 +++++++++++++---
 tools/perf/util/cpumap.h             |   4 +-
 tools/perf/util/event.h              |   4 -
 tools/perf/util/header.c             |  24 ++--
 tools/perf/util/session.c            |  35 +++---
 tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
 tools/perf/util/synthetic-events.h   |   2 +-
 12 files changed, 327 insertions(+), 185 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

