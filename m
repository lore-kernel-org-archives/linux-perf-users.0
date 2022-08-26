Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD476ECAAA6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbiHZQpQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbiHZQos (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC1E01D4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33da75a471cso33322957b3.20
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=KW1wjZhQOylJAM8dFCUuUgsNn9wynC6cGB5CBRkTkjU=;
        b=DLT7CNCPFxgWp4tw+x/BQspqZDpc1UMezv684sA8Gl8TsHyYXrhbYfV0Qr+PfXH6sE
         WyZe8OnzJaU/1Ef8NA1auGJ2hDrBVFrWmQe6C1c75RmFWI5JgK2QkInaC0PFH357sUBK
         iccm1taYoFpVQWHE0/CEbyO9NCebkdSo/fQeYsuY6lmfBq5fUmtl3rMLeYJ8QGma+I+K
         RnmZ6nmyKMDdXUQmHGCIdUIKetMz8UzgX1QFuI8iXW62hCKyDldFPgyV+eyEhCw0AA+N
         ocvsSYMFTlAfmg7rbbu/rnHYvg+mfLX25WZwKcDLZgrttSfeE/17xTn3w2Z+r4BptWl2
         C1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=KW1wjZhQOylJAM8dFCUuUgsNn9wynC6cGB5CBRkTkjU=;
        b=vCGDAzYt7J52bu1JTPRIJ9VTV4HQ7wKKmSi2gMSqiM1so+X6hz+73QSdT3nZfXVMZU
         1gVI3u2yFVzBEuY9G+3ZDSjunuSpqY/MFE1SjJorHjxL3nSflavaXugpant+MtFdFM0B
         qZYKtI8uv6DCzm0JM1boz2gLU/8xhUh7HylgycTjK4v7U368cudOBre7Gm3X0IM7X9aH
         kSS5ZzlxsTM9997flfXXi06MhCbUSDylQre1OsMNHwYT+us+ieiho5nba+YSYq3e9F9Z
         /7bBd4yFlX04rMx00vG3F9ujzHz8bScCiNh0bULMvobCfUbsxzyNL/6Qw6pIa2nIdMfW
         ICmg==
X-Gm-Message-State: ACgBeo09zsulwyHgLpmK0j+fVkQy2MNw3LEuURnIzLPxp33Mk58QJp80
        YKl8keiate/kORHUc9F71PDGiJlhUzOz
X-Google-Smtp-Source: AA6agR5ECIO+GHRI3XC9wpQWiTgzeGBhIlpvn15OMBLt2Eu4HKggVRe/TElALFWz/W+OT2LnRb3f7F9dYoKl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:670:b10b:d16e with SMTP
 id o13-20020a056902110d00b00670b10bd16emr494541ybu.259.1661532248866; Fri, 26
 Aug 2022 09:44:08 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:31 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-8-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 07/18] perf record: Update use of pthread mutex
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

Switch to the use of mutex wrappers that provide better error checking
for synth_lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..a7b7a317d81b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -21,6 +21,7 @@
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/mmap.h"
+#include "util/mutex.h"
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
@@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
+static struct mutex synth_lock;
+
 static int process_locked_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
-	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
 	int ret;
 
-	pthread_mutex_lock(&synth_lock);
+	mutex_lock(&synth_lock);
 	ret = process_synthesized_event(tool, event, sample, machine);
-	pthread_mutex_unlock(&synth_lock);
+	mutex_unlock(&synth_lock);
 	return ret;
 }
 
@@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
+		mutex_init(&synth_lock);
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
@@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
 						    rec->opts.nr_threads_synthesize);
 	}
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.nr_threads_synthesize > 1) {
 		perf_set_singlethreaded();
+		mutex_destroy(&synth_lock);
+	}
 
 out:
 	return err;
-- 
2.37.2.672.g94769d06f0-goog

