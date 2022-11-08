Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2069C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 07:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiKHHht (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiKHHhU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 02:37:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B673E0B8
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Nov 2022 23:37:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37342ba89dbso129167567b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Nov 2022 23:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=UK9wldQbKYz7jAyqp+y9ajL5KFs/W8dhw8WTiCKwIN0gvbMvW/zwJwry3YzoY7dfK9
         ZV2AaTazbIV9GyTPQ22svSW1O4C9JtIo/yTNaDlH/crRhHjsEOEpF9Sr+MWanyb7a6qM
         YGzUgX7/VVf2zRl1nTBL9ON8REIjnqlEE+CQ5NuIKRyT619PTBW9aNyyqdnnc4s7a0Mc
         1HNjuH/401liKQtNxjzgCHTMlnOeOycKWitfRQPqEEpunjXdP2pSPHltTsYGTRW/xGFY
         vGmTEdA3+JmX1xATUiMFTK8IpHCWZ28rXjR7/WmW4mBs4penOn+mJ/VFlopVl+SVvE+y
         IHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=VRfn75Q3VVgF99aK+pQ0ibSF81yWmKEnWYl8gMObBq5syL/rNAwGR0da/lUczK+wwf
         NAe+cUKhuigoX1pVIjxAKNXvdYl5cqhrnkBcpQQaSgpPtTGvN0vt7uNK3FPxbwc5Q6o1
         5qx0AAmkpsTA8jVGazBJ55c9eQA/mU2mW25eSJ6LOv2OchyXEmuPC6gLz0e4vZuoQeY+
         WtDxEv5XNvyTqlQAcASNgf7T2NZ8Yjhj0ZFtsuqxg/eGVRwy9Te+Zx56QXOVMmFwtr7L
         VQDIPjBb74YzZMILaUVA1GmyeWsJ0hY/njxutcszFh+xOVqGhd7Sa1d+ejGXLYz1v3ta
         mi5g==
X-Gm-Message-State: ACrzQf33CIFWgNrbJpudnvJPaIzHKuuBIb+TTfa9zbJDQZJQ9iWUvkd/
        oLFPWh5aU6c2pJNcLaJX02TLDDJ8Xza2
X-Google-Smtp-Source: AMsMyM7BidvVdfJrnNQEj701FAtK2No5xh3laeI7L2ERB+pyHS3hJJrTwfyEztoTmfd9YvoaHLj/EGtGur2Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a25:bd1:0:b0:6cb:ada3:1ca with SMTP id
 200-20020a250bd1000000b006cbada301camr51188690ybl.24.1667893036863; Mon, 07
 Nov 2022 23:37:16 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:17 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-14-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 13/14] perf cpumap: Tidy libperf includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use public API when possible, don't include internal API in header
files in evsel.h. Fix any related breakages.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpumap.c  | 2 +-
 tools/perf/util/auxtrace.h | 2 +-
 tools/perf/util/cpumap.c   | 1 +
 tools/perf/util/cpumap.h   | 2 +-
 tools/perf/util/evsel.h    | 2 --
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7c873c6ae3eb..3150fc1fed6f 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -6,7 +6,7 @@
 #include "util/synthetic-events.h"
 #include <string.h>
 #include <linux/bitops.h>
-#include <perf/cpumap.h>
+#include <internal/cpumap.h>
 #include "debug.h"
 
 struct machine;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6a0f9b98f059..2cf63d377831 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -15,7 +15,7 @@
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
-#include <internal/cpumap.h>
+#include <perf/cpumap.h>
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 6e3fcf523de9..5e564974fba4 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -12,6 +12,7 @@
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <internal/cpumap.h>
 
 static struct perf_cpu max_cpu_num;
 static struct perf_cpu max_present_cpu_num;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index da28b3146ef9..c2f5824a3a22 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -4,8 +4,8 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
+#include <linux/refcount.h>
 
 /** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aad..f5d9f6a351cd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,8 +10,6 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include <internal/cpumap.h>
-#include <perf/cpumap.h>
 
 struct bpf_object;
 struct cgroup;
-- 
2.38.1.431.g37b22c650d-goog

