Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042EECAAA6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbiHZQqd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbiHZQp5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:45:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1271237E2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:45:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33f8988daecso24985777b3.12
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=P+FyhU2B/YN3/TrA4dmeuxuHGACyeB5O/ib05glm4b0=;
        b=medTLeaDsm5+Opq4aXiy32t1/beJm7t0X/USeUrahXOriOH3gsk4fG41vEQW4R2/AM
         byjizPt/bfKhoaDGijCt0LUaz7PbUQVv5y9flJKZOEVELXd3TIPjdCHMSnI8DL15HUKJ
         gzieyUfBzTDegVhgcQtGOfHHdVdsLrnkDUZHYOoJP/r0RzdO/8F4Fdy0H8usgOhXVOwf
         FJf1oIRukKfZ9sOSXvqN3LazFyXSns+slySkXXUxzf/m3mPoDzd7W+PJ9nZ9WBmY//oa
         FKGGze/1yR5mZNZ6T3H5l9nStvUd/69g5wdh/alCD166DSnvVTK0Epw9AZkYcuC7JI18
         ylIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=P+FyhU2B/YN3/TrA4dmeuxuHGACyeB5O/ib05glm4b0=;
        b=Qbj/JgvZfYiJagwJS6VmKNIFwGiG8oQYmdPXDn0T9253fHU42afXFObsPfevB0JiAj
         2SDiWOXHMz4W5T72HyW20MMwrYQ0jbd+G10hrRWV6lLFb5vGoW2yWAVH7N7RtSB0N+tW
         ju6yBm6KeqEiIPyprG7X+UErHK4lADqUYcbOrNmnjd2nzsSsZkqhzfWsouJFzoPdGWMw
         cECuAo8vYkdDdnD/jD+/i2ZK9d82ho+80mFa0ac4HP4cE4cEc3Ri4xJMBT9TAb8f3z+f
         33kP+PIAw1ugHh6nCQ1SkeLqctpOtb2B0sxH5P0qsU2xEqCtxibqDBrAKSooxwFvyJqI
         w/AA==
X-Gm-Message-State: ACgBeo1a4R5FBXQuPiW5fTz6v6Y9z3Y+D37iCt4OO63qp9TPziVwyB3/
        DetSoCFEPoN/Iybk6bDfK7F1LYQKV4cG
X-Google-Smtp-Source: AA6agR4XN14X3kZFhyH9PFbRRm71ehh2clkMuysFZbGu+P2MvUHCWkzVymsk8OFWxzJ5tiSlZECqk9i1UQQc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:1442:b0:696:4962:a73 with SMTP id
 a2-20020a056902144200b0069649620a73mr513913ybv.386.1661532306375; Fri, 26 Aug
 2022 09:45:06 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:37 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-14-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 13/18] perf top: Update use of pthread mutex
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 18 +++++++++---------
 tools/perf/util/top.h    |  5 +++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b96bb9a23ac0..5af3347eedc1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -893,10 +893,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		perf_mmap__consume(&md->core);
 
 		if (top->qe.rotate) {
-			pthread_mutex_lock(&top->qe.mutex);
+			mutex_lock(&top->qe.mutex);
 			top->qe.rotate = false;
-			pthread_cond_signal(&top->qe.cond);
-			pthread_mutex_unlock(&top->qe.mutex);
+			cond_signal(&top->qe.cond);
+			mutex_unlock(&top->qe.mutex);
 		}
 	}
 
@@ -1100,10 +1100,10 @@ static void *process_thread(void *arg)
 
 		out = rotate_queues(top);
 
-		pthread_mutex_lock(&top->qe.mutex);
+		mutex_lock(&top->qe.mutex);
 		top->qe.rotate = true;
-		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
-		pthread_mutex_unlock(&top->qe.mutex);
+		cond_wait(&top->qe.cond, &top->qe.mutex);
+		mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1217,8 +1217,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.mutex, NULL);
-	pthread_cond_init(&top->qe.cond, NULL);
+	mutex_init(&top->qe.mutex);
+	cond_init(&top->qe.cond);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1349,7 +1349,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
-	pthread_cond_signal(&top->qe.cond);
+	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	return ret;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 1c2c0a838430..a8b0d79bd96c 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -5,6 +5,7 @@
 #include "tool.h"
 #include "evswitch.h"
 #include "annotate.h"
+#include "mutex.h"
 #include "ordered-events.h"
 #include "record.h"
 #include <linux/types.h>
@@ -53,8 +54,8 @@ struct perf_top {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
 		bool			 rotate;
-		pthread_mutex_t		 mutex;
-		pthread_cond_t		 cond;
+		struct mutex mutex;
+		struct cond cond;
 	} qe;
 };
 
-- 
2.37.2.672.g94769d06f0-goog

