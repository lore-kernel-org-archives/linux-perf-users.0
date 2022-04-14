Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1438BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Apr 2022 01:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiDNBtR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiDNBtP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 21:49:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAA434AE
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 18:46:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so31967857b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AJsDpOAepn2BrmySdLBFtq/huSUigooPFMS4mShVlPM=;
        b=SumvzH97au/J2UmJVb3qt2P/x7KJ8TksqCAWyYQbof7LioEX7CnBmUV3UzkUfBikwn
         fuzYNdNjHqiNaT67ZmM4d8pop7tNZ6zeRT6H2GlcQORAV4dxuJoU9mBEw1U275Snh1ht
         JsPL0YsuJ6d8Rhgw2yuahrrcoOdXhJxX0ZCI9zohz95/F6c+Vy6wqZ4njQS7cbgQiecT
         +KscAt9jzIVFHS3ipSoZeoy885/vRemCtERbGJwsBEBKkyg3Z+/Z8PWqli6FLAii4sCQ
         mx3pzIjP9c8YIhBI+ykRIY60edLohzTBf4Nf45xAOJrpD+z2L8pbKSbnjpTd1NhSBgll
         77uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AJsDpOAepn2BrmySdLBFtq/huSUigooPFMS4mShVlPM=;
        b=fPXN1PNxL8z3g5TsGmthf6wxggtcqJRyvQSiXHNNiXI+qU2VOSoU8gseolYDY8bF9j
         d+hAok7dxFzKHWTql+PR+MUqWQXnN8bOW+5f5g4AZ/5FEZ+nH9Y/d06MzYde2Vp4yY6A
         +2e6CfOofLcoV4e5GvrQZ6ACaRUL+5xD6jTXsVM9xT1zkP3XlRgdj2GKVe/8Z4MSoLC7
         7zmldwzegdNNZVeCEkeyFiBIphl/imMWyrL1VLq6toWIpi+v+pnvqz/RRTpXa+fd3/3d
         xEPjhGQZzq8EFKEbqZdSJ3CGFA1vsLL5rba7mRHgE6X0kK/KFEYjtj1KJwg7/JPn3tap
         fm9Q==
X-Gm-Message-State: AOAM5306aZkoi3euQW1Is/o48eup+6udoG7hOGtMzj+qLsH81lijo2Uc
        2u+5LkldqafiR+K7xUb/p3fgGahjoyso
X-Google-Smtp-Source: ABdhPJxN8MVizN0NlbuMFnhZNjtJBQP9pJvrghUvKzRX85V2MWOVKR1iFrzTPuByzafO/mTvScJ06/X5diBi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:641:79fc:21b2 with SMTP
 id t4-20020a056902124400b0064179fc21b2mr244410ybu.336.1649900811265; Wed, 13
 Apr 2022 18:46:51 -0700 (PDT)
Date:   Wed, 13 Apr 2022 18:46:42 -0700
In-Reply-To: <20220414014642.3308206-1-irogers@google.com>
Message-Id: <20220414014642.3308206-3-irogers@google.com>
Mime-Version: 1.0
References: <20220414014642.3308206-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 3/3] perf test: Add basic perf record tests
From:   Ian Rogers <irogers@google.com>
To:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Test the --per-thread flag.
Test Intel machine state capturing.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/perf/tests/shell/record.sh

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
new file mode 100755
index 000000000000..cd1cf14259b8
--- /dev/null
+++ b/tools/perf/tests/shell/record.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# perf record tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+test_per_thread() {
+  echo "Basic --per-thread mode test"
+  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
+    | perf report -i- -q \
+    | egrep -q true
+  echo "Basic --per-thread mode test [Success]"
+}
+
+test_register_capture() {
+  echo "Register capture test"
+  if ! perf list | egrep -q 'br_inst_retired.near_call'
+  then
+    echo "Register capture test [Skipped missing instruction]"
+    return
+  fi
+  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
+  then
+    echo "Register capture test [Skipped missing registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
+    -c 1000 --per-thread true 2> /dev/null \
+    | perf script -F ip,sym,iregs -i - 2> /dev/null \
+    | egrep -q "DI:"
+  then
+    echo "Register capture test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Register capture test [Success]"
+}
+
+test_per_thread
+test_register_capture
+exit $err
-- 
2.36.0.rc0.470.gd361397f0d-goog

