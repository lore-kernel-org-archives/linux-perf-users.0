Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4746EC38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiJXT6X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiJXT5n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:57:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD61B2B92
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so4984330pgl.8
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmFinCtLacORlQ2ewPLrfshypQ1cYZQ/PN4t0Vpngs0=;
        b=pMUlhIMRFFmttHUZkUp0YgJLF5/0k53nLgz/0+lS9Khbv9yppWgguy4wBLjw2tGr7+
         JasEHQxldAstnfGM80huRUB8zV2ptt1JYQT9k4Cf5wM7OQyaIN4p+9O4aohOx52RkuuP
         oqdmJYa0jD0N9945GZ1F2dc+ODkV33CjJ93RLJJCBi3yPIeyo+MY1oQFnT3ubwknYp0D
         qih6ED/vUhPhs9+p0HwbsTkqITNuEv/GLXRZ1XeYyHWDYwvdeIhdgC5YXXLpeuuzfuxH
         u58Xcl7CIl8deSCTwHPx0SAAYDV08BFYWIKRqTn7cvTtjIYuOZSaODpZGFOZOy7J4O76
         TbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmFinCtLacORlQ2ewPLrfshypQ1cYZQ/PN4t0Vpngs0=;
        b=tuX5nSZvXAWdIMfCvrTiAUXddulqt747P0hRv3rGEO1CqD1AuKLHMxzmV9rU63UH0Q
         felifkO3VsN01B9cqxu3V2n7a8ARYtx2o3XZ7kgwSVnTe/vB4vvLqPT6WXrI0HDuiEHj
         YeXNDrzL/Cw5r4mPoC1kN9M96Wp3KBqH+u1252z5qc2R5oCNDXyDXVvgJfvI1eNuFmTe
         0t0HRwlNkzhFk6B2gnTvP86y0MMyqznsCsHm9GD7LI4xukHclK6q8OD5nsqFYFfb6oyB
         4yT7ZoR4LdFoRAyR348XdMdLz+J7becN03TL0MljGuPGyZNt49ZWtDt4D4xuMu8eO51k
         Mphw==
X-Gm-Message-State: ACrzQf3ZPb1/I5c0xi3RVKLFF8NgpWBzXhNPL2ShP1Q+bT6JEkeHvPqH
        eOklIJmj0t7Ctgjg2xhLH053DFUV/kFG
X-Google-Smtp-Source: AMsMyM5/EfYNOGuE1j6lWt3Gqm3IuEdLA1ZQ5Ii8/3YXOZ9Ac9T+OQwvA7c6hGGfQXSOnHkvtOBxXNkR3+zZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a63:df10:0:b0:43b:e82f:e01c with SMTP id
 u16-20020a63df10000000b0043be82fe01cmr29416411pgg.19.1666635590063; Mon, 24
 Oct 2022 11:19:50 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:07 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-3-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 2/8] perf record: Use sig_atomic_t for signal handlers
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This removes undefined behavior as described in:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e128b855ddde..b8438e323002 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -646,10 +646,10 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	return record__write(rec, map, bf, size);
 }
 
-static volatile int signr = -1;
-static volatile int child_finished;
+static volatile sig_atomic_t signr = -1;
+static volatile sig_atomic_t child_finished;
 #ifdef HAVE_EVENTFD_SUPPORT
-static volatile int done_fd = -1;
+static volatile sig_atomic_t done_fd = -1;
 #endif
 
 static void sig_handler(int sig)
@@ -1926,7 +1926,7 @@ static void record__read_lost_samples(struct record *rec)
 
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
-- 
2.38.0.135.g90850a2211-goog

