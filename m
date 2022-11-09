Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D26C4321E
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKISwL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKISvj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2E2CDFF
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:51:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z125-20020a25c983000000b006dc905e6ccfso28780ybf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=GPgb7yM3peSx5lbtrgAYiXyGaOh2dWb1x0APsgQSFdREbuoKUMUsu6vcx8Evw40fiY
         QAGjtLjIdv7+MYtobi6OJJlAIYqgn5nCyrkMWbGzI62qqkSAwtB7LA9ofYRpKx36RHKS
         eRIGKfs/HfJW6/ucPO/jwLYCyRgbdKepcMe3HU6W2PdzwhxhpD0KhzMoULrZw8ExJahG
         wHszHa+LZPcpl834kijyH641IEurVR85AF5yzOQuBCGOJNQLQyGotaFhmdfWCseui+Xz
         wJgRjoBihZ78jmltkEnNnE/cApoRkahbTh1TL+SAKqszC2ELjdcLziOI5MprJfzPa9fE
         K16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=Rp4iojNzDVoJeKyZKCDFKpJ0UXxdJThP7Ca3n5oK5b5t+tv7v6lmhVhuV3tFCqviyS
         wGhizSxVhxvkk5qW9bFlkgKMvlIm13gm9tX6/Vc5JzynWc9b4xvkFwVBTNBVFk7Xu7OP
         PJbgg72mJ/mp6zxn904R9ALzW2XFIXa4EdES8p+CAxvbYgnsI4ojQVlPBTDPzU5LdPZF
         p5YIsb9dVU2m6CFc7HnHKKu/FcZdc7qfsw6fJgyO/qev3zLYFvIy1aLcYoPmVv/8SRZ1
         OpLW0GE103kNfJ6hEaMT7iHWjb34DxxP3rtP+3SmmzqAaNfAyqaLkUjVS39gwqdP4+rm
         1L+A==
X-Gm-Message-State: ACrzQf2JxElsBLEPh0VyNwyBSleMKBlz7HeRzTUPwCfhu7gWGOs2m+pC
        qmaHGWzjV4krfWl9+S6OBGnzFYa2zbR9
X-Google-Smtp-Source: AMsMyM4aG/qfIRrPsZc6e0jRKlvIWUDtNj+DGVN0VGLeGwCxia/YIhlvD0BRcIpmKA7adfm9rZBzCu9ZqgpG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a0d:dd90:0:b0:36d:2005:5417 with SMTP id
 g138-20020a0ddd90000000b0036d20055417mr1097889ywe.238.1668019873667; Wed, 09
 Nov 2022 10:51:13 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:13 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-14-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 13/14] perf cpumap: Tidy libperf includes
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

