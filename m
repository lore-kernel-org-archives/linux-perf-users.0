Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DBFA373F
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJXS5V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiJXS44 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 14:56:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC05A3BB4
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bq6-20020a056a000e0600b0056bcbc6720fso1463502pfb.22
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg26NKxObx9cPNlbM/mhAsHD/ehUnl2CM6D2kDhH0JM=;
        b=Hqqahl8ovXopQPb7uIKtwoTdJrjEL1o1/d7xnlSnlFSlQ1QzOGUv4npflfCXUCsfYQ
         AAjlIIk0BZnDAG+ImVC4wa94gcewBYm+zGwO/MaRol3lrxLdrXCJdrVn5H0hyx4Q2OW3
         2JqxUZ/TMKXdPIg1AmeE43USOIBlNhP3WN+Je7SXGkLeufqUIh3jdpK19uC+rt/5kA4A
         hIwKoPwBFPXH3YqBsWW95a4TmH9uh03H8Awp8NyeLq+03n3zMHlDMT1hW7XUXyFENy+M
         R2ONicYhaHRBoRnx0dbyeFMTdvleVg+NHwPWqZqDGBc/zpZtgZlB1gtjY1pwc3D55Bwo
         ypDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg26NKxObx9cPNlbM/mhAsHD/ehUnl2CM6D2kDhH0JM=;
        b=YSu0NOXKARnl5Qn72C85kL9GQwSibKSf+CGzgsIsLFcot3X5QsH9Vqn0vAmpSMuBCn
         diOKoiN+QWO83g0rWVXMxKiMniRDPH68XdveaXH0zfuYq3dHp0LZsGahBfdC07VP5zhT
         CR6+XDuOYddmpTVBi+tHAw53GgQRUuZzIk39KigWyFv+Vvhv6xMPO/p6NCPH+V+NWv+G
         tLP0fZb90ctwyx4G22bcHQq2uWzaiPA6n+Aymr0/mLz0JzfqOx+/cUz/raarPPGjNQva
         sb52yUHB0FYk6+zmrmZRJGxfAFQa8gQ0cfLJX+q07ydIeGbtY2IExz0wpBrsUXE39EaJ
         XZ+w==
X-Gm-Message-State: ACrzQf3gwOVyxyuXaQBibG7L2fUmj9SAxVCj3d5L8KolwFI3+QqeW5sG
        0zuum6IREx7/JkfT3jP/j9/N17fARBqt
X-Google-Smtp-Source: AMsMyM6Nj7ukGiPLGTSOHW/hTa1+LUVELv3+6oYpxx0HkdyzccLPOpfM7Y4+sdeI/VI94qUoc+GTLg8UjAf3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:cf82:b0:20b:3525:81ec with SMTP id
 i2-20020a17090acf8200b0020b352581ecmr39048692pju.42.1666632958899; Mon, 24
 Oct 2022 10:35:58 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:17 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-3-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 2/8] perf record: Use sig_atomic_t for signal handlers
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
 tools/perf/builtin-record.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e128b855ddde..5332b9c05f28 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -61,6 +61,7 @@
 #include <locale.h>
 #include <poll.h>
 #include <pthread.h>
+#include <stdatomic.h>
 #include <unistd.h>
 #ifndef HAVE_GETTID
 #include <syscall.h>
@@ -646,10 +647,10 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
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
@@ -1926,7 +1927,7 @@ static void record__read_lost_samples(struct record *rec)
 
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
-- 
2.38.0.135.g90850a2211-goog

