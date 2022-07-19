Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 22:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiGSWjz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiGSWjy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 18:39:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF545A46B
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:39:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so4331028ybf.15
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=grEWX5Q2Gi+Bk5fMy2TN3qnUnm6uP4D8TaJUZqeNrFQ=;
        b=EUlx+ufDH2jvryOa7Veq4vfgW4aSe+2UET+OUVmBGmVBrYLKe4ZfEJmHscCRh2wBuf
         EpjZgrDm1rHE0cr7+mda7ozXidNTzHcJi2Oo7z4/C4pk4qnBuoo9dJjKD49NIkRFl40p
         I7vqPansDwjFznG3+Mu1WRRcQr+cRPUQEN9G9f1uZHGGi1qyBfHovFQKUdW3HEmacdTP
         tZNI9leU4b1pxRYSMP/twcRCFArwLBuzKvmUCFipZo0Vn44vlibv0Yw0UQ6kNwfybEdK
         TvSCvnjjTYbAjgGflv0aRDM6h1q3F4SfYe7eIofzKfddpQf6UeZUiIcAwt2f/oBQ0R5R
         DlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=grEWX5Q2Gi+Bk5fMy2TN3qnUnm6uP4D8TaJUZqeNrFQ=;
        b=eqNXDF7IXB/sUXQHComxl3QcYfjMBLH6d5PfmsPEvZ5ckXN3fdpam8h45OyIZoaihm
         CaHszxNzQNNz1OmOz0WQ965vFp4N/GW63na/9SeAzca7y5I5+r1v5O4QDju3vY7J886g
         lW85Yl2QXcQKfdHBCszlkr7USGHybN1fCk4AG+mU6CcrJPYNZLCjgTMBJd1ZN14OTzWk
         x5n5tCudTPkiTDHx+k4UlxCvPuNBFyi8QA+SjPOONtd91mPcZeblitH4mO7SKkWtll+b
         5NOum/Yth32LX40OvrXXakK+EyOHDZLnqbj5NR40VEeYVINLJoCrUQaEbGA8cRowfw/T
         B4pQ==
X-Gm-Message-State: AJIora9eBSKPjKR4ux5YpwVJ30pMEvfqcCkY/5FGwTcfueFlY3P1zmIo
        rSfaSMZwKOdZI3+vj8X7Ukcb2zQavCa4
X-Google-Smtp-Source: AGRyM1v5hWbGrE9A/W3lUU8LrmC5W59eMln76SyMiJEeUjGlgbIafLsRRWfPei/GeaQiTVaFTAPc265unHUg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1251:e27b:f589:696c])
 (user=irogers job=sendgmr) by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr32364368ybm.425.1658270392810; Tue, 19
 Jul 2022 15:39:52 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:39:43 -0700
Message-Id: <20220719223946.176299-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 0/3] Tidy user rdpmc documentation and testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libperf's perf_mmap__read_self and the addition of arm64 support mean
that the perf_event.h and the rdpmc perf test have become
stale. Refresh the documentation in perf_event.h, remove the x86 rdpmc
test and port the libperf test as a non-architecture specific test.

A comment is added to perf_event.h to avoid a divide by zero when
scaling counts if the running time is 0. This was previously discussed
in this thread:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/

v3. Incorporates fixes from Rob Herring <robh@kernel.org> to make the
    perf_event.h comments better. It drops the already merged sanitizer fix.
v2. Alters the skip in test_stat_user_read for open to always be a
    skip as perf_event_open may fail with EACCES (permissions), ENOSYS
    (not supported) and ENOENT (hypervisor). Adds Rob Herring's
    acked-by on patch 3.

Ian Rogers (3):
  perf: Align user space counter reading with code
  perf test: Remove x86 rdpmc test
  perf test: Add user space counter reading tests

 include/uapi/linux/perf_event.h        |  35 +++--
 tools/include/uapi/linux/perf_event.h  |  35 +++--
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 tools/perf/tests/mmap-basic.c          | 127 ++++++++++++++++-
 6 files changed, 170 insertions(+), 212 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

-- 
2.37.0.170.g444d1eabd0-goog

